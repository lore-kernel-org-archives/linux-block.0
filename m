Return-Path: <jthumshirn@suse.de>
Date: Wed, 26 Sep 2018 17:06:34 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v10 7/8] block: Make blk_get_request() block for non-PM
 requests while suspended
Message-ID: <20180926150634.GD13588@linux-x5ow.site>
References: <20180921203122.49743-1-bvanassche@acm.org>
 <20180921203122.49743-8-bvanassche@acm.org>
 <20180926142740.GE8604@lst.de>
 <20180926144357.GC13588@linux-x5ow.site>
 <20180926145732.GA9446@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180926145732.GA9446@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 26, 2018 at 04:57:32PM +0200, Christoph Hellwig wrote:
> I don't think this actually works given that rpm_status only exists
> if CONFIG_PM is set.

I think it'll work as GCC does constant propagation. There are
actually some places in the kernel that follow this pattern.

	 Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
