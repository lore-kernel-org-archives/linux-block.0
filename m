Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF73CB55F
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354249; cv=pass; b=mhexXBo2Qf2+0nrq0BnUnrG//WudbCtVzwyq7sHmt96dBkGDq9lwH3fKWszSNSmU4Ue9Xm16F79dUxsBNChSWxtobeXWMyZRl2kIOtXd47iU4TfumMuSdMtIdn/8iECJMHj2NCq5FBifFLOHxvQw3F5Gg5tGuKHAoh8c9UxRlKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354249; c=relaxed/simple;
	bh=z5prSsmGreU+ARDbc2TiWvp5IrCc0YZDiE0i+rJkl44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRu4DZJqZWfmuJw/aeOD+z/q69s+X8uMaF2QnJhk+S2IbhKYPoSWc/rV4qoMHwErxhr2jy8onw+d6EQpboN3NREMK1/LNTCGxIkOoTWd05a6XXQwW7GKYi9RO3aRcErz5Rn6ORbY+4ubuiajhluA82y+1jLD6pfwNrlRCBvkgz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MWhXcue/; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MWhXcue/"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4a453848173so66481b6e.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 12:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785354241; cv=none;
        d=google.com; s=arc-20260327;
        b=Zj/WHbZXEVwg13J8H4OEWENb6N/VyMEEKgV2ZR9F49PscXmz0OnXpTbT1j4gbe3CJw
         WkY6drA0vFXK+KQ2miN1SI/BeoNpZOyuF3j2eSMZr2JQ2QX82kFzb3Yhia+JeMv3N0B2
         3/QbfMTxOvLrBrEqFYW2Gg0AWYlZH5xTx5/aCXiUUwXaRjFBXKTG1FMtDoIZxSTDKEC7
         VdjDseR8VJ6FpEMKC1dnZk+Hqn4yTvElaJ1oSfv6zNNd2m9APTHEu36WLCchIbwiNIbV
         C33hT0eywlj1ZFt+GRJ5Q9aQZ+6xjlbkLoW8lHpgXm9t6CzQlc4gSG6/VdGjMdClMZDi
         nakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LnSKdBsI5P4yNxKlVDAgX6ZRyHfaTBwJq6vRswotV/I=;
        fh=9nLAvGfG2tKIv4nAB1+v6E6DP4Xzc9x2EDLr8fKk8kQ=;
        b=pMJWzk/XQbr7ONF8Ycls9riGzOogHFxbLCRHqr+g/vFaitFjw17txjiW8YPB3Zwsab
         QaPtSppuOZzLjLYfCRw44BJwN8n78Ck67ScbWr13yPgrYbCt0h/FVscp1CHvIug8rFCf
         BRJChpF2R+Dh05OAGNKLqDLbC4jd3cqpqcER80ygDGsDYq3OvBLWvG5EMWRHYgdKUyZV
         foc7/cLZ13XpFzfon7XR5BKfByc0tqXkCs8/kuSo8K8cMt3esoIbsMQN3AgbNcYIRyMa
         W9A1SgbQGo7Y8cmJy0HiApvLANkygjW3QOfk79PqmDdqsXdIfLyBAMHNOeZHodlTy2aD
         y/ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785354241; x=1785959041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LnSKdBsI5P4yNxKlVDAgX6ZRyHfaTBwJq6vRswotV/I=;
        b=MWhXcue/jyhaTyE8tOr+KrWqEpc5F2I6XZ7MAmCkZzRtkwwn6pmZRjvShvwCSOVpoO
         UeiwfkFb3FfInD+hzCnjV4UZlY3rermvNynofkgmHm8Jomdusfe/HTU/FJtmCWg5ytQM
         Mq9FPbKo2fQjXl4YD3MafP5M1v8UHzRI5Tt1A9H+pJ2HpTou/9W2iJiwOSgmQQk6E3Jh
         jGVhz/F5B9NTKVzEi1KpowjqwfwHwcT+qmGWwOODbnAlYKmlsx61mvPRsnSU90tBrCQc
         yw6Gr0WDBNoyRN4sUCeNkO9gk+lVls9jaPmmBxmIKUIMbkX+/jIfKqHCqSBwqNGXaIJk
         GrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785354241; x=1785959041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnSKdBsI5P4yNxKlVDAgX6ZRyHfaTBwJq6vRswotV/I=;
        b=Bs0DU2GNNh7dtlBL9/UdG+YsSZ9XXyVlPwy46USWr0oewAELblx1wDe94EzyUp078o
         +9AXwjyChO/ULPQjumu/Ao26kFKA6DxHlN4ZM4EY3nB7qtyUtjCHCauVwY4c0MQA162M
         LtWpVaZduxJ/v6muiMf7dIojX2+g48lHbB45PbX0eqTBT8UKYwA5Ln5WSR+AEzWQWHdH
         Njy5OvOP2H1Q6ckF+d8ELFmWjBezRkimYrsdSWQXQBH+DY74nGj8hflYkoITYCvNtfcc
         LN12y/9yajY/pRIiqEwhS9R/3+XgVJ6fdrI7gamw6VuhurPz5/lkkQDvRCr+hVJsyMVu
         FS2g==
X-Forwarded-Encrypted: i=1; AHgh+RqS0eV0uRumnT4oWJlC5Ide9atvagr6gUbdAzApZUX87BYnHh9R9pgDCvUz+ihzqVPsp6kPK1OKvv+m6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmvcg/axqclLWDgfmaZQVGbNxhqDrz7ikvpgSjosDZO4/pll3r
	KduTkCwinoMf66WLbi/g1JT3/oTXZBRxZXHO/YUus5vHJhyVOOAmiaKecOY3jh1jO/Sc9N1zeO1
	e6jzBAG05T5vpI24h+R/7p5Rw3E53ohEnTufbFr9ucA==
X-Gm-Gg: AR+sD130PPztwDGYMKddRnZjf2kt3DQNN1KRcbVCQypH2b5rpLCrx1YYKdsM27Z4v04
	xm8reTTDaHITTH5M8YtHkG+gPqzd/kkYQ3OZtGoQyjLzAOC6COwwkqV9dcSwsDsyD83dTq9EJi1
	jXO9xExD9BtQIru3TxUUeecIyUU0vXp5CLYRJ+H4Xt4+kB44BW+HQj6ZQbX8Do4unUMkE5rYgAf
	u7HRBmk9C62CReR7yyT7sBsBd2OPcUR+tdAUU6mwRHGlAf9npv52EQczU2zGkeg0zxxaC6D20Fa
	PAAxQ3hZYAltJv23b80MNIpCP6UR4rFYgrR4Lcxgv/6n
X-Received: by 2002:a05:6871:441:b0:457:9007:a35f with SMTP id
 586e51a60fabf-458bc1eaa28mr97408fac.1.1785354241430; Wed, 29 Jul 2026
 12:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785274111.git.asml.silence@gmail.com> <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
In-Reply-To: <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 29 Jul 2026 12:43:50 -0700
X-Gm-Features: AUfX_mzj7jaY2dlfE4GHJvNcQHfDZNxuFZTdOCDHOZZK5KuWQBBj743IB8eIF1Q
Message-ID: <CADUfDZpwF0jp2e=+c3w_NjWPbnQ858bkSD731M6+x27jzgcJiw@mail.gmail.com>
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
	William Power <william.power@intel.com>, Phil Cayton <phil.cayton@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, 
	nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 2:35=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
> dmabuf when it's mapped, which is then used to initialise requests.
>
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  drivers/nvme/host/core.c |  12 ++
>  drivers/nvme/host/nvme.h |   2 +
>  drivers/nvme/host/pci.c  | 259 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 273 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 453c1f0b2dd0..ce66a1843bec 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2676,6 +2676,17 @@ static int nvme_report_zones(struct gendisk *disk,=
 sector_t sector,
>  #define nvme_report_zones      NULL
>  #endif /* CONFIG_BLK_DEV_ZONED */
>
> +static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
> +                                   struct dma_buf_io_ctx *ctx)
> +{
> +       struct nvme_ns *ns =3D bdev->bd_disk->private_data;
> +       struct nvme_ctrl *ctrl =3D ns->ctrl;
> +
> +       if (!ctrl->ops->init_dma_buf_io_ctx)
> +               return -EINVAL;
> +       return ctrl->ops->init_dma_buf_io_ctx(ctrl, ctx);
> +}
> +
>  const struct block_device_operations nvme_bdev_ops =3D {
>         .owner          =3D THIS_MODULE,
>         .ioctl          =3D nvme_ioctl,
> @@ -2686,6 +2697,7 @@ const struct block_device_operations nvme_bdev_ops =
=3D {
>         .get_unique_id  =3D nvme_get_unique_id,
>         .report_zones   =3D nvme_report_zones,
>         .pr_ops         =3D &nvme_pr_ops,
> +       .init_dma_buf_io_ctx =3D nvme_init_dma_buf_io_ctx,
>  };
>
>  static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 824651cc898d..034c31af8fec 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -652,6 +652,8 @@ struct nvme_ctrl_ops {
>         int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>         void (*print_device_info)(struct nvme_ctrl *ctrl);
>         bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
> +       int (*init_dma_buf_io_ctx)(struct nvme_ctrl *ctrl,
> +                                  struct dma_buf_io_ctx *ctx);
>         unsigned long (*get_virt_boundary)(struct nvme_ctrl *ctrl, bool i=
s_admin);
>  };
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 69932d640b53..f1b67c191892 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -27,6 +27,8 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/io-64-nonatomic-hi-lo.h>
>  #include <linux/sed-opal.h>
> +#include <linux/dma-buf-io.h>
> +#include <linux/dma-resv.h>
>
>  #include "trace.h"
>  #include "nvme.h"
> @@ -393,6 +395,13 @@ struct nvme_queue {
>         struct completion delete_done;
>  };
>
> +struct nvme_dmabuf_map {
> +       struct dma_buf_io_map base;
> +       struct sg_table *sgt;
> +       unsigned nr_entries;
> +       dma_addr_t dma_list[];
> +};
> +
>  /* bits for iod->flags */
>  enum nvme_iod_flags {
>         /* this command has been aborted by the timeout handler */
> @@ -859,6 +868,138 @@ static void nvme_free_descriptors(struct request *r=
eq)
>         }
>  }
>
> +static inline struct nvme_dmabuf_map *
> +to_nvme_dmabuf_map(struct dma_buf_io_map *map)
> +{
> +       return container_of(map, struct nvme_dmabuf_map, base);
> +}
> +
> +static void nvme_dmabuf_map_sync_for_cpu(struct nvme_dev *nvme_dev,
> +                                        struct request *req)
> +{
> +       struct device *dev =3D nvme_dev->dev;
> +       enum dma_data_direction dma_dir;
> +       struct bio *bio =3D req->bio;
> +       struct nvme_dmabuf_map *map =3D to_nvme_dmabuf_map(bio->bi_dmabuf=
_map);
> +       dma_addr_t *dma_list =3D map->dma_list;
> +       unsigned offset =3D bio->bi_iter.bi_offset;
> +       unsigned map_idx =3D offset / NVME_CTRL_PAGE_SIZE;
> +       int length =3D blk_rq_payload_bytes(req) +
> +                    (offset & (NVME_CTRL_PAGE_SIZE - 1));
> +
> +       dma_dir =3D rq_data_dir(req) =3D=3D READ ? DMA_FROM_DEVICE : DMA_=
TO_DEVICE;
> +
> +       while (length > 0) {
> +               dma_sync_single_for_cpu(dev, dma_list[map_idx++],
> +                                       NVME_CTRL_PAGE_SIZE, dma_dir);
> +               length -=3D NVME_CTRL_PAGE_SIZE;
> +       }
> +}
> +
> +static void nvme_dmabuf_map_sync_for_device(struct nvme_dev *nvme_dev,
> +                                           struct request *req)
> +{
> +       struct device *dev =3D nvme_dev->dev;
> +       enum dma_data_direction dma_dir;
> +       struct bio *bio =3D req->bio;
> +       struct nvme_dmabuf_map *map =3D to_nvme_dmabuf_map(bio->bi_dmabuf=
_map);
> +       dma_addr_t *dma_list =3D map->dma_list;
> +       unsigned offset =3D bio->bi_iter.bi_offset;
> +       unsigned map_idx =3D offset / NVME_CTRL_PAGE_SIZE;
> +       int length =3D blk_rq_payload_bytes(req) +
> +                    (offset & (NVME_CTRL_PAGE_SIZE - 1));
> +
> +       dma_dir =3D rq_data_dir(req) =3D=3D READ ? DMA_FROM_DEVICE : DMA_=
TO_DEVICE;
> +
> +       while (length > 0) {
> +               dma_sync_single_for_device(dev, dma_list[map_idx++],
> +                                          NVME_CTRL_PAGE_SIZE, dma_dir);
> +               length -=3D NVME_CTRL_PAGE_SIZE;
> +       }
> +}
> +
> +static void nvme_rq_clean_dmabuf_map(struct nvme_dev *dev,
> +                                     struct request *req)
> +{
> +       struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> +
> +       nvme_dmabuf_map_sync_for_cpu(dev, req);
> +
> +       if (!(iod->flags & IOD_SINGLE_SEGMENT))
> +               nvme_free_descriptors(req);
> +}
> +
> +static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
> +                                            struct nvme_queue *nvmeq)
> +{
> +       struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> +       struct bio *bio =3D req->bio;
> +       struct nvme_dmabuf_map *map =3D to_nvme_dmabuf_map(bio->bi_dmabuf=
_map);
> +       unsigned bvec_done =3D bio->bi_iter.bi_offset;
> +       unsigned map_idx =3D bvec_done / NVME_CTRL_PAGE_SIZE;
> +       unsigned offset =3D bvec_done & (NVME_CTRL_PAGE_SIZE - 1);
> +       int length =3D blk_rq_payload_bytes(req) - (NVME_CTRL_PAGE_SIZE -=
 offset);
> +       dma_addr_t *dma_list =3D map->dma_list;
> +       u64 prp1_dma =3D dma_list[map_idx++] + offset;
> +       u64 dma_addr, prp2_dma;
> +       dma_addr_t prp_dma;
> +       __le64 *prp_list;
> +       unsigned i;
> +
> +       nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
> +
> +       if (length <=3D 0) {
> +               prp2_dma =3D 0;
> +               goto done;
> +       }
> +
> +       if (length <=3D NVME_CTRL_PAGE_SIZE) {
> +               prp2_dma =3D dma_list[map_idx];
> +               goto done;
> +       }
> +
> +       if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=3D
> +           NVME_SMALL_POOL_SIZE / sizeof(__le64))
> +               iod->flags |=3D IOD_SMALL_DESCRIPTOR;
> +
> +       prp_list =3D dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC=
,
> +                       &prp_dma);

I wonder if it's possible to perform the PRP list page allocations and
initialization in nvme_dma_buf_io_map() instead of the I/O path. The
NVMe dma_pools are per-NUMA-node linked lists protected by spinlocks,
making them significant CPU hotspots. If the dmabuf registration set
up a contiguous DMA-coherent list of PRP entries for the pages of the
registered buffer, any command using the dmabuf and requiring at most
1 PRP list page (i.e. length <=3D 2 MB) could just set its PRP list
pointer to an offset into the dmabuf's PRP list.

Best,
Caleb


> +       if (!prp_list)
> +               return BLK_STS_RESOURCE;
> +
> +       iod->descriptors[iod->nr_descriptors++] =3D prp_list;
> +       prp2_dma =3D prp_dma;
> +       i =3D 0;
> +       for (;;) {
> +               if (i =3D=3D NVME_CTRL_PAGE_SIZE >> 3) {
> +                       __le64 *old_prp_list =3D prp_list;
> +
> +                       prp_list =3D dma_pool_alloc(nvmeq->descriptor_poo=
ls.large,
> +                                       GFP_ATOMIC, &prp_dma);
> +                       if (!prp_list)
> +                               goto free_prps;
> +                       iod->descriptors[iod->nr_descriptors++] =3D prp_l=
ist;
> +                       prp_list[0] =3D old_prp_list[i - 1];
> +                       old_prp_list[i - 1] =3D cpu_to_le64(prp_dma);
> +                       i =3D 1;
> +               }
> +
> +               dma_addr =3D dma_list[map_idx++];
> +               prp_list[i++] =3D cpu_to_le64(dma_addr);
> +
> +               length -=3D NVME_CTRL_PAGE_SIZE;
> +               if (length <=3D 0)
> +                       break;
> +       }
> +done:
> +       iod->cmd.common.dptr.prp1 =3D cpu_to_le64(prp1_dma);
> +       iod->cmd.common.dptr.prp2 =3D cpu_to_le64(prp2_dma);
> +       return BLK_STS_OK;
> +free_prps:
> +       nvme_free_descriptors(req);
> +       return BLK_STS_RESOURCE;
> +}
> +
>  static void nvme_free_prps(struct request *req, unsigned int attrs)
>  {
>         struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> @@ -937,6 +1078,11 @@ static void nvme_unmap_data(struct request *req)
>         struct device *dma_dev =3D nvmeq->dev->dev;
>         unsigned int attrs =3D 0;
>
> +       if (blk_mq_rq_is_dmabuf(req)) {
> +               nvme_rq_clean_dmabuf_map(nvmeq->dev, req);
> +               return;
> +       }
> +
>         if (iod->flags & IOD_SINGLE_SEGMENT) {
>                 static_assert(offsetof(union nvme_data_ptr, prp1) =3D=3D
>                                 offsetof(union nvme_data_ptr, sgl.addr));
> @@ -1251,6 +1397,9 @@ static blk_status_t nvme_map_data(struct request *r=
eq)
>         struct blk_dma_iter iter;
>         blk_status_t ret;
>
> +       if (blk_mq_rq_is_dmabuf(req))
> +               return nvme_rq_setup_dmabuf_map(req, nvmeq);
> +
>         /*
>          * Try to skip the DMA iterator for single segment requests, as t=
hat
>          * significantly improves performances for small I/O sizes.
> @@ -2269,6 +2418,112 @@ static int nvme_create_queue(struct nvme_queue *n=
vmeq, int qid, bool polled)
>         return result;
>  }
>
> +#if defined(CONFIG_DMA_SHARED_BUFFER)
> +static void nvme_dmabuf_invalidate_mappings(struct dma_buf_attachment *a=
ttach)
> +{
> +       struct dma_buf_io_ctx *ctx =3D attach->importer_priv;
> +
> +       dma_buf_io_invalidate_mappings(ctx);
> +}
> +
> +const struct dma_buf_attach_ops nvme_dmabuf_importer_ops =3D {
> +       .invalidate_mappings    =3D nvme_dmabuf_invalidate_mappings,
> +       .allow_peer2peer        =3D true,
> +};
> +
> +static struct dma_buf_io_map *nvme_dma_buf_io_map(struct dma_buf_io_ctx =
*ctx)
> +{
> +       unsigned nr_entries =3D ctx->dmabuf->size / NVME_CTRL_PAGE_SIZE;
> +       struct dma_buf_attachment *attach =3D ctx->dev_priv;
> +       unsigned long tmp, i =3D 0;
> +       struct nvme_dmabuf_map *map;
> +       struct scatterlist *sg;
> +       struct sg_table *sgt;
> +       int ret;
> +
> +       dma_resv_assert_held(ctx->dmabuf->resv);
> +
> +       map =3D kmalloc_flex(*map, dma_list, nr_entries);
> +       if (!map)
> +               return ERR_PTR(-ENOMEM);
> +
> +       sgt =3D dma_buf_map_attachment(attach, ctx->dir);
> +       if (IS_ERR(sgt)) {
> +               ret =3D PTR_ERR(sgt);
> +               sgt =3D NULL;
> +               goto err;
> +       }
> +
> +       for_each_sgtable_dma_sg(sgt, sg, tmp) {
> +               dma_addr_t dma_addr =3D sg_dma_address(sg);
> +               unsigned long sg_len =3D sg_dma_len(sg);
> +
> +               if (sg_len % NVME_CTRL_PAGE_SIZE) {
> +                       ret =3D -EINVAL;
> +                       goto err;
> +               }
> +
> +               while (sg_len) {
> +                       map->dma_list[i++] =3D dma_addr;
> +                       dma_addr +=3D NVME_CTRL_PAGE_SIZE;
> +                       sg_len -=3D NVME_CTRL_PAGE_SIZE;
> +               }
> +       }
> +
> +       ret =3D dma_buf_io_init_map(ctx, &map->base);
> +       if (ret)
> +               goto err;
> +       map->nr_entries =3D nr_entries;
> +       map->sgt =3D sgt;
> +       return &map->base;
> +err:
> +       if (sgt)
> +               dma_buf_unmap_attachment(attach, sgt, ctx->dir);
> +       kfree(map);
> +       return ERR_PTR(ret);
> +}
> +
> +static void nvme_dma_buf_io_unmap(struct dma_buf_io_ctx *ctx,
> +                                 struct dma_buf_io_map *map_base)
> +{
> +       struct dma_buf_attachment *attach =3D ctx->dev_priv;
> +       struct nvme_dmabuf_map *map =3D to_nvme_dmabuf_map(map_base);
> +
> +       dma_resv_assert_held(ctx->dmabuf->resv);
> +
> +       dma_buf_unmap_attachment(attach, map->sgt, ctx->dir);
> +}
> +
> +static void nvme_dma_buf_io_release(struct dma_buf_io_ctx *ctx)
> +{
> +       struct dma_buf_attachment *attach =3D ctx->dev_priv;
> +
> +       dma_buf_detach(ctx->dmabuf, attach);
> +}
> +
> +const struct dma_buf_io_ops nvme_dma_buf_io_ops =3D {
> +       .map            =3D nvme_dma_buf_io_map,
> +       .unmap          =3D nvme_dma_buf_io_unmap,
> +       .release        =3D nvme_dma_buf_io_release,
> +};
> +
> +static int nvme_pci_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
> +                                       struct dma_buf_io_ctx *ctx)
> +{
> +       struct dma_buf_attachment *attach;
> +       struct nvme_dev *dev =3D to_nvme_dev(ctrl);
> +
> +       attach =3D dma_buf_dynamic_attach(ctx->dmabuf, dev->dev,
> +                                       &nvme_dmabuf_importer_ops, ctx);
> +       if (IS_ERR(attach))
> +               return PTR_ERR(attach);
> +
> +       ctx->dev_priv =3D attach;
> +       ctx->dev_ops =3D &nvme_dma_buf_io_ops;
> +       return 0;
> +}
> +#endif
> +
>  static const struct blk_mq_ops nvme_mq_admin_ops =3D {
>         .queue_rq       =3D nvme_queue_rq,
>         .complete       =3D nvme_pci_complete_rq,
> @@ -3563,6 +3818,9 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops=
 =3D {
>         .print_device_info      =3D nvme_pci_print_device_info,
>         .supports_pci_p2pdma    =3D nvme_pci_supports_pci_p2pdma,
>         .get_virt_boundary      =3D nvme_pci_get_virt_boundary,
> +#if defined(CONFIG_DMA_SHARED_BUFFER)
> +       .init_dma_buf_io_ctx    =3D nvme_pci_init_dma_buf_io_ctx,
> +#endif
>  };
>
>  static int nvme_dev_map(struct nvme_dev *dev)
> @@ -4327,5 +4585,6 @@ MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.co=
m>");
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION("1.0");
>  MODULE_DESCRIPTION("NVMe host PCIe transport driver");
> +MODULE_IMPORT_NS("DMA_BUF");
>  module_init(nvme_init);
>  module_exit(nvme_exit);
> --
> 2.54.0
>
>
