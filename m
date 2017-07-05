Return-Path: <hch@lst.de>
Date: Thu, 6 Jul 2017 00:56:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 8/8] xen-blockfront: quiesce IO before device removal
Message-ID: <20170705225632.GB11849@lst.de>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me> <1499154912-10420-9-git-send-email-sagi@grimberg.me> <20170704221908.GA3732@ming.t460p> <77cea68f-7915-2bbf-0861-05d1ca389e6c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <77cea68f-7915-2bbf-0861-05d1ca389e6c@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 05, 2017 at 09:29:26AM +0300, Sagi Grimberg wrote:
>
>
>> Looks the above change isn't needed since this blk_mq_start_stopped_hw_queues()
>> should have been the counterpart of blk_mq_stop_hw_queue() in
>> blkif_queue_rq().
>
> Removed the patch altogether in v2 as I'm not convinced it is needed.

I've only started reading the series, but to me it seems like the
two places where xen-blkfront currently calls blk_mq_stop_hw_queues
should probably converted, as they are the same category as the other
calls converted in your series.
