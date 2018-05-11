Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: Rework blk-mq timeout handling again
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Sebastian Ott <sebott@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
        Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20180510175607.27937-1-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <73f77c62-25ca-0915-6f5b-452d60258f05@oracle.com>
Date: Fri, 11 May 2018 20:06:29 +0800
MIME-Version: 1.0
In-Reply-To: <20180510175607.27937-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi bart

I add debug log in blk_mq_add_timer as following

void blk_mq_add_timer(struct request *req, enum mq_rq_state old,
                     enum mq_rq_state new)
{
       struct request_queue *q = req->q;

       if (!req->timeout)
               req->timeout = q->rq_timeout;
       if (!blk_mq_rq_set_deadline(req, jiffies + req->timeout, old, new))
               WARN_ON_ONCE(true);

       trace_printk("jiffies %lx to %x ldl %lx gen %u dl %x\n",
                       jiffies,
                       req->timeout,
                       blk_rq_deadline(req),
                       req->das.generation,
                       req->das.deadline);
 
       return __blk_add_timer(req);
 }

And get log below:

     jbd2/sda2-8-320   [000] ...1    95.030824: blk_mq_add_timer: jiffies ffff37c0 to 1d4c ldl ffff550c40000000 gen 0 dl ffff550c
    kworker/0:1H-136   [000] ...1    95.031822: blk_mq_add_timer: jiffies ffff37c0 to 1d4c ldl ffff550c40000000 gen 0 dl ffff550c
    kworker/6:1H-244   [006] ...1    95.041695: blk_mq_add_timer: jiffies ffff37c3 to 1d4c ldl ffff550f40000000 gen 0 dl ffff550f
    kworker/6:1H-244   [006] ...1    95.041954: blk_mq_add_timer: jiffies ffff37c3 to 1d4c ldl ffff550f40000000 gen 0 dl ffff550f

The blk_rq_deadline return ffff550c40000000 which looks really crazy.
It should be due to union blk_deadline_and_state. 
+union blk_deadline_and_state {
+	struct {
+		uint32_t generation:30;
+		uint32_t state:2;
+		uint32_t deadline;
+	};
+	unsigned long legacy_deadline;
+	uint64_t das;
+};

And generation never change. 

Thanks
Jianchao
