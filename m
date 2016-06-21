Return-Path: <mchristi@redhat.com>
Subject: Re: [PATCH 1/3] block: get rid of bio_rw and READA
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
References: <1465829315-23137-1-git-send-email-hch@lst.de>
 <1465829315-23137-2-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Mike Christie <mchristi@redhat.com>
Message-ID: <05f0ea82-c0b0-79a3-5204-cd600e575471@redhat.com>
Date: Mon, 20 Jun 2016 19:34:13 -0500
MIME-Version: 1.0
In-Reply-To: <1465829315-23137-2-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2016 09:48 AM, Christoph Hellwig wrote:
> These two are confusing leftover of the old world order, combining
> values of the REQ_OP_ and REQ_ namespaces.  For callers that don't
> special case we mostly just replace bi_rw with bio_data_dir or
> op_is_write, except for the few cases where a switch over the REQ_OP_
> values makes more sense.  Any check for READA is replaced with an
> explicit check for REQ_RAHEAD.  Also remove the READA alias for
> REQ_RAHEAD.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice. Sorry for the delay. I was moving. Looks ok to me.

Reviewed-by: Mike Christie <mchristi@redhat.com>
