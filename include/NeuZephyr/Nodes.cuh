//
// Created by Administrator on 24-11-11.
//

#ifndef NODES_CUH
#define NODES_CUH

#include "Tensor.cuh"

namespace NeuZephyr::Nodes {
    using namespace data;
    using namespace Operator;
    class DL_API Node {
    public:
        Node() = default;
        virtual ~Node() = default;
        std::vector<Node*> inputs;
        std::shared_ptr<Tensor> output;
        virtual void forward() = 0;
        virtual void backward() = 0;
    };

    class DL_API InputNode: public Node {
    public:
        explicit InputNode(const Tensor::shape_type &shape, bool requires_grad = false);

        explicit InputNode(const Tensor& tensor);

        explicit InputNode(const std::initializer_list<int>& shape, bool requires_grad = false);

        void forward() override;
        void backward() override;
    };

    class DL_API OutputNode: public Node {
    public:
        explicit OutputNode(Node* input);

        void forward() override;
        void backward() override;
    };

    class DL_API AddNode: public Node {
    public:
        AddNode(Node* input_left, Node* input_right);

        void forward() override;
        void backward() override;
    };

    class DL_API MatMulNode: public Node {
    public:
        MatMulNode(Node* input_left, Node* input_right);

        void forward() override;
        void backward() override;
    };

    class DL_API ScalarMulNode: public Node {
        Tensor::value_type scalar;
    public:
        ScalarMulNode(Node* input, Tensor::value_type scalar);

        void forward() override;
        void backward() override;
    };

    class DL_API ScalarDivNode: public Node {
        Tensor::value_type scalar;
    public:
        ScalarDivNode(Node* input, Tensor::value_type scalar);

        void forward() override;
        void backward() override;
    };

    class DL_API ScalarAddNode: public Node {
        Tensor::value_type scalar;
    public:
        ScalarAddNode(Node* input, Tensor::value_type scalar);

        void forward() override;
        void backward() override;
    };

    class DL_API ScalarSubNode: public Node {
        Tensor::value_type scalar;
    public:
        ScalarSubNode(Node* input, Tensor::value_type scalar);

        void forward() override;
        void backward() override;
    };

    class DL_API SubNode: public Node {
    public:
        SubNode(Node* input_left, Node* input_right);

        void forward() override;
        void backward() override;
    };

    class DL_API ReLUNode: public Node {
    public:
        explicit ReLUNode(Node* input);

        void forward() override;
        void backward() override;
    };
}

#endif //NODES_CUH
