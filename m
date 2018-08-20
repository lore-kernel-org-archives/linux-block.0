Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2 2/2] blk-mq: sync the update nr_hw_queues with
 part_in_flight
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534478043-7170-3-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVMBFwGngLWjf=oT+2=57xWgF38ozf0D3hc_RKOTXbRWVA@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <75c13c79-efc6-c41f-c349-9dae094f50be@oracle.com>
Date: Mon, 20 Aug 2018 09:32:23 +0800
MIME-Version: 1.0
In-Reply-To: <CACVXFVMBFwGngLWjf=oT+2=57xWgF38ozf0D3hc_RKOTXbRWVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 08/17/2018 05:36 PM, Ming Lei wrote:
> I'd suggest to put the rcu_* and percpu_ref_is_zero() into
> blk_mq_queue_tag_busy_iter().

Yes, it's fine for me. :)
I will change it in next version.

Thanks
Jianchao
