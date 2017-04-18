Return-Path: <prvs=274ddec60=roger.pau@citrix.com>
Date: Tue, 18 Apr 2017 16:03:21 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>, James Smart
	<james.smart@broadcom.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<linux-scsi@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <dm-devel@redhat.com>
Subject: Re: [PATCH 17/25] blk-mq: remove the error argument to
 blk_mq_complete_request
Message-ID: <20170418150321.s7yqpt63reutbs24@dhcp-3-128.uk.xensource.com>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20170406153944.10058-18-hch@lst.de>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 06, 2017 at 05:39:36PM +0200, Christoph Hellwig wrote:
> Now that we always have a ->complete callback we can remove the direct
> call to blk_mq_end_request, as well as the error argument to
> blk_mq_complete_request.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For blkfront:

Acked-by: Roger Pau Monn� <roger.pau@citrix.com>
