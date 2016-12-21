Return-Path: <BATV+23fc57bdedeac6dd9ded+4868+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 20 Dec 2016 23:50:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] genhd: remove dead and duplicated scsi code
Message-ID: <20161221075036.GA32675@infradead.org>
References: <1482269894-14034-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482269894-14034-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Dec 20, 2016 at 02:38:14PM -0700, Jon Derrick wrote:
> blk_scsi_cmd_filter use was deprecated by 4beab5c6 and the SCSI macros
> are duplicated in blkdev.h, both likely reintroduced by a bad merge from
> 540eed56.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
