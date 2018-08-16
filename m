Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1534317915-5041-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com> <1534317915-5041-3-git-send-email-jianchao.w.wang@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 16 Aug 2018 12:50:31 +0800
Message-ID: <CACVXFVO+g2ACx9XYx4XtwRkpSC9bCYeSFEj07Z==6r7nT-HxkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] blk-mq: sync the update nr_hw_queues with part_in_flight
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@linux.intel.com>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 15, 2018 at 3:25 PM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
> account the inflight requests. It will access the queue_hw_ctx and
> nr_hw_queues w/o any protection. When updating nr_hw_queues and
> blk_mq_in_flight/rw occur concurrently, panic comes up.

When updating nr_hw_queues, all queues are frozen, and there shouldn't
be any inflight requests, so there shouldn't be such issue.


Thanks,
Ming Lei
