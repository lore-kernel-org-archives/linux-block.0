Return-Path: <garsilva@embeddedor.com>
Date: Tue, 23 May 2017 16:52:13 -0500
Message-ID: <20170523165213.Horde.iQQotBClh5pVkt5Jp5EHltF@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [block] question about potential null pointer dereference
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>


Hello everybody,

While looking into Coverity ID 1408828 I ran into the following piece  
of code at block/bfq-wf2q.c:542:

542static struct rb_node *bfq_find_deepest(struct rb_node *node)
543{
544        struct rb_node *deepest;
545
546        if (!node->rb_right && !node->rb_left)
547                deepest = rb_parent(node);
548        else if (!node->rb_right)
549                deepest = node->rb_left;
550        else if (!node->rb_left)
551                deepest = node->rb_right;
552        else {
553                deepest = rb_next(node);
554                if (deepest->rb_right)
555                        deepest = deepest->rb_right;
556                else if (rb_parent(deepest) != node)
557                        deepest = rb_parent(deepest);
558        }
559
560        return deepest;
561}

The issue here is that there is a potential NULL pointer dereference  
at line 554, in case function rb_next() returns NULL.

Maybe a patch like the following could be applied in order to avoid  
any chance of a NULL pointer dereference:

index 8726ede..28d8b90 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -551,6 +551,8 @@ static struct rb_node *bfq_find_deepest(struct  
rb_node *node)
                 deepest = node->rb_right;
         else {
                 deepest = rb_next(node);
+               if (!deepest)
+                       return NULL;
                 if (deepest->rb_right)
                         deepest = deepest->rb_right;
                 else if (rb_parent(deepest) != node)

What do you think?

I'd really appreciate any comment on this.

Thank you!
--
Gustavo A. R. Silva
