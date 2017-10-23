Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 16/17] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-17-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <68df1af0-7cc8-febc-e2f6-85251f120a76@grimberg.me>
Date: Mon, 23 Oct 2017 18:32:47 +0300
MIME-Version: 1.0
In-Reply-To: <20171023145126.2471-17-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7735571ffc9a..bbece5edabff 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1050,6 +1050,8 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
>   {
>   	struct nvme_queue *nvmeq = hctx->driver_data;
>   
> +	printk_ratelimited("%s: called\n", __func__);
> +

This must be a left-over...
