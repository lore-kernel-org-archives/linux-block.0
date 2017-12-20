Return-Path: <peterz@infradead.org>
Date: Wed, 20 Dec 2017 21:18:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Huang Ying <ying.huang@intel.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: random call_single_data alignment
Message-ID: <20171220201846.7pbwf5vq57luzg5q@hirez.programming.kicks-ass.net>
References: <a9beb452-7344-9e2d-fc80-094d8f5a0394@kernel.dk>
 <3875cde5-a193-6aa6-1f9e-561cc66110f2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3875cde5-a193-6aa6-1f9e-561cc66110f2@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Dec 20, 2017 at 12:40:25PM -0700, Jens Axboe wrote:
> On 12/20/17 12:10 PM, Jens Axboe wrote:
> > For some reason, commit 966a967116e6 was added to the tree without
> > CC'ing relevant maintainers, even though it's touching random subsystems.
> > One example is struct request, a core structure in the block layer.
> > After this change, struct request grows from 296 to 320 bytes on my
> > setup.

> https://marc.info/?l=linux-block&m=151379793913822&w=2

Does that actually matter though?, kmalloc is likely to over-allocate in
any case. Sure it introduces a weird hole in the data structure, but
that can be easily fixed by rearranging the thing.

struct request {
        struct list_head {
                struct list_head * next;                                                 /*     0     8 */
                struct list_head * prev;                                                 /*     8     8 */
        } queuelist; /*     0    16 */

        /* XXX 16 bytes hole, try to pack */

        union {
                /* typedef call_single_data_t */ struct __call_single_data {
                        struct llist_node {
                                struct llist_node * next;                                /*    32     8 */
                        } llist; /*    32     8 */
                        /* typedef smp_call_func_t */ void       (*func)(void *);        /*    40     8 */
                        void *     info;                                                 /*    48     8 */
                        unsigned int flags;                                              /*    56     4 */
                } csd; /*          32 */
                /* typedef u64 */ long long unsigned int fifo_time;                      /*           8 */
        };                                                                               /*    32    32 */
        /* --- cacheline 1 boundary (64 bytes) --- */
	....
}


diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8089ca17db9a..9d6fb6d59268 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -133,11 +133,11 @@ typedef __u32 __bitwise req_flags_t;
  * especially blk_mq_rq_ctx_init() to take care of the added fields.
  */
 struct request {
-       struct list_head queuelist;
        union {
                call_single_data_t csd;
                u64 fifo_time;
        };
+       struct list_head queuelist;
 
        struct request_queue *q;
        struct blk_mq_ctx *mq_ctx;


> > Why are we blindly aligning to 32 bytes? The comment says to avoid
> > it spanning two cache lines - but if that's the case, look at the
> > actual use case and see if that's actually a problem. For struct
> > request, it is not.
> > 
> > Seems to me, this should have been applied in the specific area
> > where it was needed. Keep struct call_single_data (instead of some
> > __ version), and just manually align it where it matters.

Without enforcement of some kind, its too easy to get wrong.

> https://marc.info/?l=linux-block&m=151379849914002&w=2

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index ccb9975a97fa..e0c44e4efa44 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -33,9 +33,9 @@ static inline u64 mb_per_tick(int mbps)
 }
 
 struct nullb_cmd {
+	call_single_data_t csd;
 	struct list_head list;
 	struct llist_node ll_list;
-	call_single_data_t csd;
 	struct request *rq;
 	struct bio *bio;
 	unsigned int tag;


Gets you the exact same size back.

> In the future, please CC the relevant folks before making (and
> committing) changes like that.

Yeah, I usually do, sorry about that :/
