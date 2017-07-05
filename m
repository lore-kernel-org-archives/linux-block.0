Return-Path: <ming.lei@redhat.com>
Date: Thu, 6 Jul 2017 07:23:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@intel.com>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v3 5/8] nvme: kick requeue list when requeueing a request
 instead of when starting the queues
Message-ID: <20170705232357.GF2332@ming.t460p>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
 <1499274037-17438-6-git-send-email-sagi@grimberg.me>
 <20170705230621.GA12043@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170705230621.GA12043@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 06, 2017 at 01:06:21AM +0200, Christoph Hellwig wrote:
> I wonder if we should simply always kick the list and remove the
> parameter and blk_mq_kick_requeue_list.  It seems like this split
> has caused a lot more harm then good, and the other drivers using
> it that way are probably having issues as well.

It is only NVMe and DM which use blk_mq_kick_requeue_list() in this way,
other drivers passes either ture or false to blk_mq_kick_requeue_list().

Yeah, looks DM need to switch to this way too.

Drivers may want to schedule at batch especially in fast path, so maybe
they should be allowed to use in splitting way.

-- 
Ming
