Return-Path: <hare@suse.de>
Subject: Re: [PATCH 5/6] pd: replace ->special use with private data in the
 request
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20181109183208.19879-1-hch@lst.de>
 <20181109183208.19879-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a84750e4-5c7e-3926-3e42-5cd40d79d5ee@suse.de>
Date: Sat, 10 Nov 2018 13:58:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181109183208.19879-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 7:32 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/paride/pd.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
