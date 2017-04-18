Return-Path: <prvs=274ddec60=roger.pau@citrix.com>
Date: Tue, 18 Apr 2017 16:00:51 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>, James Smart
	<james.smart@broadcom.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<linux-scsi@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <dm-devel@redhat.com>
Subject: Re: [PATCH 16/25] xen-blkfront: don't use req->errors
Message-ID: <20170418150051.muglaxwfydaxypd6@dhcp-3-128.uk.xensource.com>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20170406153944.10058-17-hch@lst.de>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 06, 2017 at 05:39:35PM +0200, Christoph Hellwig wrote:
> xen-blkfron is the last users using rq->errros for passing back error to
> blk-mq, and I'd like to get rid of that.  In the longer run the driver
> should be moving more of the completion processing into .complete, but
> this is the minimal change to move forward for now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Roger Pau Monn� <roger.pau@citrix.com>
