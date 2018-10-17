Return-Path: <hch@lst.de>
Date: Wed, 17 Oct 2018 09:28:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 3/3] drivers/block: Remove DAC960 driver
Message-ID: <20181017072853.GH23407@lst.de>
References: <20181012071548.129113-1-hare@suse.de> <20181012071548.129113-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181012071548.129113-4-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 12, 2018 at 09:15:48AM +0200, Hannes Reinecke wrote:
> The DAC960 driver has been obsoleted by the myrb/myrs drivers,
> so it can be dropped.

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
