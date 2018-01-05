Return-Path: <james.smart@broadcom.com>
Return-Path: <james.smart@broadcom.com>
Subject: Re: [PATCH v4 3/5] nvmet/fc: Use sgl_alloc() and sgl_free()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20180105162650.31083-1-bart.vanassche@wdc.com>
 <20180105162650.31083-4-bart.vanassche@wdc.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <b456f605-76e4-d47a-d525-7176a78103e6@broadcom.com>
Date: Fri, 5 Jan 2018 08:33:35 -0800
MIME-Version: 1.0
In-Reply-To: <20180105162650.31083-4-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 1/5/2018 8:26 AM, Bart Van Assche wrote:
> Use the sgl_alloc() and sgl_free() functions instead of open coding
> these functions.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/target/Kconfig |  1 +
>   drivers/nvme/target/fc.c    | 36 ++----------------------------------
>   2 files changed, 3 insertions(+), 34 deletions(-)

Reviewed-by:  James Smart <james.smart@broadcom.com>

-- james
