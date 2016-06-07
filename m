Return-Path: <sagi@lightbitslabs.com>
Return-Path: <sagi@lightbitslabs.com>
Subject: Re: [PATCH 3/5] nvme-rdma.h: Add includes for nvme rdma_cm
 negotiation
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, keith.busch@intel.com
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <1465248215-18186-4-git-send-email-hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jay Freyensee <james.p.freyensee@intel.com>,
 Ming Lin <ming.l@ssi.samsung.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From: Sagi Grimberg <sagi@lightbits.io>
Message-ID: <5756B73E.4050907@lightbits.io>
Date: Tue, 7 Jun 2016 14:59:58 +0300
MIME-Version: 1.0
In-Reply-To: <1465248215-18186-4-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

We forgot to CC Linux-rdma, CC'ing...

On 07/06/16 00:23, Christoph Hellwig wrote:
> From: Sagi Grimberg <sagi@grimberg.me>
>
> NVMe over Fabrics RDMA transport defines a connection establishment
> protocol over the RDMA connection manager. This header will be used by
> both the host and target drivers to negotiate the connection
> establishment parameters.
>
> Signed-off-by: Jay Freyensee <james.p.freyensee@intel.com>
> Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/nvme-rdma.h | 71 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 71 insertions(+)
>   create mode 100644 include/linux/nvme-rdma.h
>
> diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
> new file mode 100644
> index 0000000..bf240a3
> --- /dev/null
> +++ b/include/linux/nvme-rdma.h
> @@ -0,0 +1,71 @@
> +/*
> + * Copyright (c) 2015 Mellanox Technologies. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#ifndef _LINUX_NVME_RDMA_H
> +#define _LINUX_NVME_RDMA_H
> +
> +enum nvme_rdma_cm_fmt {
> +	NVME_RDMA_CM_FMT_1_0 = 0x0,
> +};
> +
> +enum nvme_rdma_cm_status {
> +	NVME_RDMA_CM_INVALID_LEN	= 0x01,
> +	NVME_RDMA_CM_INVALID_RECFMT	= 0x02,
> +	NVME_RDMA_CM_INVALID_QID	= 0x03,
> +	NVME_RDMA_CM_INVALID_HSQSIZE	= 0x04,
> +	NVME_RDMA_CM_INVALID_HRQSIZE	= 0x05,
> +	NVME_RDMA_CM_NO_RSC		= 0x06,
> +	NVME_RDMA_CM_INVALID_IRD	= 0x07,
> +	NVME_RDMA_CM_INVALID_ORD	= 0x08,
> +};
> +
> +/**
> + * struct nvme_rdma_cm_req - rdma connect request
> + *
> + * @recfmt:        format of the RDMA Private Data
> + * @qid:           queue Identifier for the Admin or I/O Queue
> + * @hrqsize:       host receive queue size to be created
> + * @hsqsize:       host send queue size to be created
> + */
> +struct nvme_rdma_cm_req {
> +	__le16		recfmt;
> +	__le16		qid;
> +	__le16		hrqsize;
> +	__le16		hsqsize;
> +	u8		rsvd[24];
> +};
> +
> +/**
> + * struct nvme_rdma_cm_rep - rdma connect reply
> + *
> + * @recfmt:        format of the RDMA Private Data
> + * @crqsize:       controller receive queue size
> + */
> +struct nvme_rdma_cm_rep {
> +	__le16		recfmt;
> +	__le16		crqsize;
> +	u8		rsvd[28];
> +};
> +
> +/**
> + * struct nvme_rdma_cm_rej - rdma connect reject
> + *
> + * @recfmt:        format of the RDMA Private Data
> + * @fsts:          error status for the associated connect request
> + */
> +struct nvme_rdma_cm_rej {
> +	__le16		recfmt;
> +	__le16		sts;
> +};
> +
> +#endif /* _LINUX_NVME_RDMA_H */
>
