Return-Path: <jthumshirn@suse.de>
Date: Thu, 6 Apr 2017 20:38:10 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
	James Smart <james.smart@broadcom.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 02/25] block: remove the blk_execute_rq return value
Message-ID: <20170406183808.GA8673@linux-x5ow.site>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170406153944.10058-3-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 06, 2017 at 05:39:21PM +0200, Christoph Hellwig wrote:
> The function only returns -EIO if rq->errors is non-zero, which is not
> very useful and lets a large number of callers ignore the return value.
> 
> Just let the callers figure out their error themselves.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
