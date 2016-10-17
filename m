Return-Path: <hch@lst.de>
Date: Mon, 17 Oct 2016 09:44:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com,
	don.brace@microsemi.com, axboe@kernel.dk,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] scsi: allow LLDDs to expose the queue mapping to
	blk-mq
Message-ID: <20161017074425.GA8624@lst.de>
References: <1476521241-32765-1-git-send-email-hch@lst.de> <1476521241-32765-3-git-send-email-hch@lst.de> <20161017072703.jql7gbmbnsfed4n3@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161017072703.jql7gbmbnsfed4n3@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 17, 2016 at 09:27:03AM +0200, Johannes Thumshirn wrote:
> Shouldn't this hunk go into the previous patch?

Yes, it should, thanks.
