Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 1/2] blk-mq: adjust debugfs and sysfs register when
 updating nr_hw_queues
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
 <1538044984-2147-2-git-send-email-jianchao.w.wang@oracle.com>
 <20180929024902.GA27170@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <bea8e6e0-f9fb-d70b-d8c8-d4b53bf8828c@oracle.com>
Date: Sat, 29 Sep 2018 11:02:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180929024902.GA27170@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 09/29/2018 10:49 AM, Ming Lei wrote:
> Looks both blk_mq_sysfs_register() and blk_mq_debugfs_register_hctx()
> are removed from the path of blk_mq_init_allocated_queue(), so where are
> the two registered for a freshly new queue?

Initially, both of them are registered by following path.
__device_add_disk
  -> blk_register_queue

	if (q->mq_ops) {
		__blk_mq_register_dev(dev, q);
		blk_mq_debugfs_register(q);
	}

blk_mq_init_allocated_queue won't do any thing.

Thanks
Jianchao
