
#include <vector>
#include <iostream>
#include <chrono>
#include <random>
#include <numeric>
#include <algorithm>

std::vector<int>
genLargeVector() {
    constexpr std::size_t sz = 1'000'000'000;

    std::vector<int> v;
    v.reserve(sz);

    constexpr int range_from  = -100;
    constexpr int range_to    =  100;
    std::random_device                  rand_dev;
    std::mt19937                        generator(rand_dev());
    std::uniform_int_distribution<int>  distr(range_from, range_to);

    for (std::size_t i = 0; i < sz; ++i) {
        v.push_back(distr(generator));
    }

    return v;
}

static inline
int
sum_vector_index(const std::vector<int>& v) {
    int sum = 0;
    for (std::size_t i = 0; i < v.size(); ++i) {
        sum += v[i];
    }
    return sum;
}

static inline
int
sum_vector_at(const std::vector<int>& v) {
    int sum = 0;
    for (std::size_t i = 0; i < v.size(); ++i) {
        sum += v.at(i);
    }
    return sum;
}

static inline
int
sum_vector_iterator(const std::vector<int>& v) {
    int sum = 0;
    for (std::vector<int>::const_iterator it = v.cbegin(), last = v.cend(); it < last; ++it) {
        sum += *it;
    }
    return sum;
}

static inline
int
sum_vector_rangefor(const std::vector<int>& v) {
    int sum = 0;
    for (auto val : v) {
        sum += val;
    }
    return sum;
}


static inline
int
sum_array_index(const std::vector<int>& v) {
    int sum = 0;
    const int* p = v.data();
    const std::size_t max = v.size();
    for (std::size_t i = 0; i < max; ++i) {
        sum += p[i];
    }
    return sum;
}

static inline
int
sum_array_pointer(const std::vector<int>& v) {
    int sum = 0;
    const int* start = v.data();
    const int* end = start + v.size();
    for (const int* p = start; p < end; ++p) {
        sum += *p;
    }
    return sum;
}


static inline
int
sum_vector_stdaccumulate(const std::vector<int>& v) {
    return std::accumulate(std::begin(v), std::end(v), 0);
}

static inline
int
sum_vector_stdforeach(const std::vector<int>& v) {
    int sum = 0;
    std::for_each(std::begin(v), std::end(v), [&sum](auto i) { sum += i;});
    return sum;
}

template <class SumMethod>
void
timed_sum(std::vector<int> v, SumMethod sum_method) {

    const auto start = std::chrono::steady_clock::now();

    const int sum = sum_method(v);

    const auto end = std::chrono::steady_clock::now();
    const auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();
    std::cout << "Duration: " << duration << " ms  (sum = " << sum << ")\n";
}



int
main() {

    const std::vector<int> v = genLargeVector();

    std::cout << "Vector index: \n";
    timed_sum(v, sum_vector_index);

    std::cout << "Vector at: \n";
    timed_sum(v, sum_vector_at);

    std::cout << "Vector iterator: \n";
    timed_sum(v, sum_vector_iterator);

    std::cout << "Vector range for loop: \n";
    timed_sum(v, sum_vector_rangefor);

    std::cout << "Array index: \n";
    timed_sum(v, sum_array_index);

    std::cout << "Array pointer: \n";
    timed_sum(v, sum_array_pointer);

    std::cout << "Vector std::accumulate(): \n";
    timed_sum(v, sum_vector_stdaccumulate);

    std::cout << "Vector std::for_each(): \n";
    timed_sum(v, sum_vector_stdforeach);

    return 0;
}
