Return-Path: <swise@opengridcomputing.com>
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Christoph Hellwig'" <hch@lst.de>,
	<axboe@kernel.dk>,
	<keith.busch@intel.com>
Cc: <linux-block@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>,
	"'Sagi Grimberg'" <sagi@grimberg.me>
References: <1467809752-31320-1-git-send-email-hch@lst.de> <1467809752-31320-2-git-send-email-hch@lst.de>
In-Reply-To: <1467809752-31320-2-git-send-email-hch@lst.de>
Subject: RE: [PATCH 1/5] blk-mq: Introduce blk_mq_reinit_tagset
Date: Fri, 8 Jul 2016 08:46:41 -0500
Message-ID: <003401d1d91f$28a153d0$79e3fb70$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

> From: Sagi Grimberg <sagi@grimberg.me>
> 
> The new nvme-rdma driver will need to reinitialize all the tags as part of
> the error recovery procedure (realloc the tag memory region). Add a helper
> in blk-mq for it that can iterate over all requests in a tagset to make
> this easier.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Tested-by: Ming Lin <ming.l@ssi.samsung.com>
> Reviewed-by: Stephen Bates <Stephen.Bates@pmcs.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine.

Reviewed-by: Steve Wise <swise@opengridcomputing.com>
