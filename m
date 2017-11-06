Return-Path: <hare@suse.de>
Subject: Re: [PATCH v3 5/8] target: Use sgl_alloc_order() and sgl_free()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "Nicholas A . Bellinger" <nab@linux-iscsi.org>,
 Hannes Reinecke <hare@suse.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20171103222339.26540-1-bart.vanassche@wdc.com>
 <20171103222339.26540-6-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b8cd6935-2f42-6b43-f252-0f7d00e6fb71@suse.de>
Date: Mon, 6 Nov 2017 08:10:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171103222339.26540-6-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/03/2017 11:23 PM, Bart Van Assche wrote:
> Use the sgl_alloc_order() and sgl_free() functions instead of open
> coding these functions.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Nicholas A. Bellinger <nab@linux-iscsi.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/target/Kconfig                 |  1 +
>  drivers/target/target_core_transport.c | 46 +++-------------------------------
>  2 files changed, 5 insertions(+), 42 deletions(-)
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
