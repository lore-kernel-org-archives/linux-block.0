Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v6] blk-mq: Avoid that a completion can be ignored for
 BLK_EH_RESET_TIMER
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
References: <20180419164353.13561-1-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <18cd85bb-ee41-ce6f-e8c8-dcf6e7fd0504@oracle.com>
Date: Fri, 20 Apr 2018 14:55:02 +0800
MIME-Version: 1.0
In-Reply-To: <20180419164353.13561-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 04/20/2018 12:43 AM, Bart Van Assche wrote:
> Use the deadline instead of the request generation to detect whether
>   or not a request timer fired after reinitialization of a request

Maybe use deadline to do this is not suitable.

Let's think of the following scenario.

T1/T2 times in nano seconds
J1/J2 times in jiffies

rq is started at T1,J1
blk_mq_timeout_work
  -> blk_mq_check_expired
    -> save rq->__deadline (J1 + MQ_RQ_IN_FLIGHT)

                                             rq is completed and freed 
                                             rq is allocated and started again on T2
                                             rq->__deadline = J2 + MQ_RQ_IN_FLIGHT
  -> synchronize srcu/rcu
  -> blk_mq_terminate_expired
    -> rq->__deadline (J2 + MQ_RQ_IN_FLIGHT)

1. deadline = rq->__deadline & ~RQ_STATE_MASK (0x3)
   if J2-J1 < 4 jiffies, we will get the same deadline value.

2. even if we do some bit shift when save and get deadline
   if T2 - T1 < time of 1 jiffies, we sill get the same deadline.

Thanks
Jianchao
