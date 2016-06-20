Return-Path: <jthumshirn@suse.de>
Date: Mon, 20 Jun 2016 15:29:41 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, mchristi@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: shrink bio size again
Message-ID: <20160620132941.hk7ua35vk7mgg44l@c203.arch.suse.de>
References: <1465829315-23137-1-git-send-email-hch@lst.de>
 <1465829315-23137-4-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1465829315-23137-4-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 13, 2016 at 04:48:35PM +0200, Christoph Hellwig wrote:
> The recent ops split grew the bio by adding the new ioprio field.
> Shrink it again by using a 16-bit field for the bi_flags value and
> filling the holes near the beginning of the structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
