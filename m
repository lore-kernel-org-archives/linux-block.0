Return-Path: <jthumshirn@suse.de>
Date: Mon, 20 Jun 2016 15:27:28 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, mchristi@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: get rid of bio_rw and READA
Message-ID: <20160620132728.o676wgydxe6d6vfa@c203.arch.suse.de>
References: <1465829315-23137-1-git-send-email-hch@lst.de>
 <1465829315-23137-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1465829315-23137-2-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 13, 2016 at 04:48:33PM +0200, Christoph Hellwig wrote:
> These two are confusing leftover of the old world order, combining
> values of the REQ_OP_ and REQ_ namespaces.  For callers that don't
> special case we mostly just replace bi_rw with bio_data_dir or
> op_is_write, except for the few cases where a switch over the REQ_OP_
> values makes more sense.  Any check for READA is replaced with an
> explicit check for REQ_RAHEAD.  Also remove the READA alias for
> REQ_RAHEAD.
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
