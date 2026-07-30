Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAA400992
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408091; cv=none; b=DR6wpWRvjNYkZHL+56wGV+Y8nPzU9vf9WLp3CJQh3F7bqqyKx8KrrrLimBry7QHiMJlMDUaIUmfgL6nGV/X649+CHF0BAG0ndy+7iBD6I/PZDf0SLFnMxJcF6TZDp8LqdUHXT3/tYvOIFRDQNO+SXB/ksLFx2tPvVbGoXsiU7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408091; c=relaxed/simple;
	bh=YI6ZSEJMCkmbOdXDsgw8UJSCcnirbh1OoBjegKeFXiE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hXHA6dotVZ6O5GgtI8qswojp6aNVA9jXpF5QOwOhzAoCnkzojNJif0kZVP2Wy6DiKVK5mbvoGeeZjiE4WAjvCW8XCzZXmE1IcInIfcas6Gui2nk4cCSBdAr4OZVdFoaRmtxwFsjUErnvhKCfgHf5rQA3Xs980xpiYbwClC1DZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLOgyeI6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLOgyeI6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954afac04bso21503345e9.0
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 03:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785408087; x=1786012887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IOL9N86L1OioG/3DjR3pD+pVPyZKRK8hcf21uMcbnBc=;
        b=eLOgyeI6Hih9z+coyMJwuFVxKYVRboNV/Ze8Yn+LnGQy+gjQihbkTOp6E4AQbZc+qv
         4WdaRu3k5SCwWzHUb26CxAQkL6Ecnqd3ceGDw5S5ro3mG/ouOTAcEtVpB8xIKKO3OBHc
         p+XNb7apYnOxb4vGTNuZFkrvtRAhvS2px0SZftO9wXsX/IcDXud+Ux7WiYEawi8kxudj
         Uv575oaO/NTVC8P8S+xvj9AsuCe+0fz4bmLNndO0m2X362ub2FRLiczl3jWC/DzpWy0c
         iBA84IBkgOUIw3KuryHpMF/KsWeqj7+9iekZOXHOGCazTzTMwy6vtcAEug3k980rP0FA
         0skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785408087; x=1786012887;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IOL9N86L1OioG/3DjR3pD+pVPyZKRK8hcf21uMcbnBc=;
        b=TSnjSzPVT3amA9ni0HgB9q8htw7N7cxN6TKnVRmC7SCiCcDHwm8isCVTyO3woQ9LHk
         9rw8AmIKPxudUB91fr4UEuVg5ZevyKl+jiVVwv3srszl6oXHuLedcVUY2tx44qDR7IM9
         Nz2KHCyLavAdVQr8RBVrnBTFqZRvryav3IpLg/Z9ZQsxcRdQO1JaIMXdkhGlnPx5tlu7
         wFtZTHmn6e6rGJ/ero4D2ZPAQFfNXCCt+B6KH7/isgaDww5I+jvV1ntt2NRZYXDx6dlY
         moIntaomd+wfME8cnzVEVpKDXV4TuQMlHR4fva8dKW/CgYlc0eDz//S0tB+J7HIJaqKP
         7jtQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWwtCb35tKMYfVN3htE0GxoqYBCmFI64PSgr35dxOPTrSY6Lez9zotu+pZ5efeJzWPTq+K6VV+PD+L+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSP1T594C1ddQYbLHlqx2QHuh6dj2UzFoeqKn0aHPrTDMrTr8
	unLPElRbWTufmoWEl3wU9HOhfIJBvIyogTIJ/63SAwp1ILjhGk3X9wNp
X-Gm-Gg: AR+sD12EqkgGLj4HDigqRQw/j+lY53xMPyD3SUCjsCR35wR2/JvXKTNyQiCGo8O3IvC
	DulEEQa4+ZdgKHoOewcs2Y3TMLR8Fv5ZLWRSETXxR3E4OeEAsm/K/e/I1Ct6otWwtFsNAXUqL+u
	WfvN+VCEyzq6zW3w6gabuKpiVVljXz9mYJYaSWKRtXQsmyKRAtMrb1+cuJcrZaEvp2EVtluhDee
	5eSjUw+WZeouu0bUnq/hbS35jeLBej04zPyUbVJDsvLayQZdSSEnmwsKSXAHh44w8ypXZrixFxW
	YzDVt5YxRPoZJpNOQhpOhDaRXSIm/4wmkWvblIqxTWjhe5OJO8WRuFQaEQMxXbultVX3U54KNdF
	5bPZZ8DY1AWGORFNQljeaj1dRyn8TML342EX8BLSURWU8wlOEp2ekgd8bAS5eOuPG1sMrkrFd7z
	PQbR4x16qsIaLla3QFoB5YuDjklNQL6P7wMNLq+xLzWMsvIcJOprgOZYguNKNgWmtxzRw//21AE
	7bnNUiQ+NqEqiEATWystEYbo8DOnQQ4dd7SSWu0zoUYKQNG9Oq35r8T8+M6Fx0oqc8GnmCoc5rk
	jWx2NelLtwdbdwbEe3OW
X-Received: by 2002:a05:600c:c494:b0:495:745e:7430 with SMTP id 5b1f17b1804b1-49800ea99fdmr23256155e9.20.1785408086793;
        Thu, 30 Jul 2026 03:41:26 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:2f22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89347bfsm4376944f8f.28.2026.07.30.03.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:41:25 -0700 (PDT)
Message-ID: <de4ec386-42ba-41c3-bcbe-1fe8b2f71ba9@gmail.com>
Date: Thu, 30 Jul 2026 11:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
 <CADUfDZpwF0jp2e=+c3w_NjWPbnQ858bkSD731M6+x27jzgcJiw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADUfDZpwF0jp2e=+c3w_NjWPbnQ858bkSD731M6+x27jzgcJiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/26 20:43, Caleb Sander Mateos wrote:
> On Tue, Jul 28, 2026 at 2:35 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
>> dmabuf when it's mapped, which is then used to initialise requests.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   drivers/nvme/host/core.c |  12 ++
>>   drivers/nvme/host/nvme.h |   2 +
>>   drivers/nvme/host/pci.c  | 259 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 273 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 453c1f0b2dd0..ce66a1843bec 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2676,6 +2676,17 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
>>   #define nvme_report_zones      NULL
>>   #endif /* CONFIG_BLK_DEV_ZONED */
>>
>> +static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
>> +                                   struct dma_buf_io_ctx *ctx)
>> +{
>> +       struct nvme_ns *ns = bdev->bd_disk->private_data;
>> +       struct nvme_ctrl *ctrl = ns->ctrl;
>> +
>> +       if (!ctrl->ops->init_dma_buf_io_ctx)
>> +               return -EINVAL;
>> +       return ctrl->ops->init_dma_buf_io_ctx(ctrl, ctx);
>> +}
>> +
>>   const struct block_device_operations nvme_bdev_ops = {
>>          .owner          = THIS_MODULE,
>>          .ioctl          = nvme_ioctl,
>> @@ -2686,6 +2697,7 @@ const struct block_device_operations nvme_bdev_ops = {
>>          .get_unique_id  = nvme_get_unique_id,
>>          .report_zones   = nvme_report_zones,
>>          .pr_ops         = &nvme_pr_ops,
>> +       .init_dma_buf_io_ctx = nvme_init_dma_buf_io_ctx,
>>   };
>>
>>   static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 824651cc898d..034c31af8fec 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -652,6 +652,8 @@ struct nvme_ctrl_ops {
>>          int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>>          void (*print_device_info)(struct nvme_ctrl *ctrl);
>>          bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
>> +       int (*init_dma_buf_io_ctx)(struct nvme_ctrl *ctrl,
>> +                                  struct dma_buf_io_ctx *ctx);
>>          unsigned long (*get_virt_boundary)(struct nvme_ctrl *ctrl, bool is_admin);
>>   };
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 69932d640b53..f1b67c191892 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -27,6 +27,8 @@
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/io-64-nonatomic-hi-lo.h>
>>   #include <linux/sed-opal.h>
>> +#include <linux/dma-buf-io.h>
>> +#include <linux/dma-resv.h>
>>
>>   #include "trace.h"
>>   #include "nvme.h"
>> @@ -393,6 +395,13 @@ struct nvme_queue {
>>          struct completion delete_done;
>>   };
>>
>> +struct nvme_dmabuf_map {
>> +       struct dma_buf_io_map base;
>> +       struct sg_table *sgt;
>> +       unsigned nr_entries;
>> +       dma_addr_t dma_list[];
>> +};
>> +
>>   /* bits for iod->flags */
>>   enum nvme_iod_flags {
>>          /* this command has been aborted by the timeout handler */
>> @@ -859,6 +868,138 @@ static void nvme_free_descriptors(struct request *req)
>>          }
>>   }
>>
>> +static inline struct nvme_dmabuf_map *
>> +to_nvme_dmabuf_map(struct dma_buf_io_map *map)
>> +{
>> +       return container_of(map, struct nvme_dmabuf_map, base);
>> +}
>> +
>> +static void nvme_dmabuf_map_sync_for_cpu(struct nvme_dev *nvme_dev,
>> +                                        struct request *req)
>> +{
>> +       struct device *dev = nvme_dev->dev;
>> +       enum dma_data_direction dma_dir;
>> +       struct bio *bio = req->bio;
>> +       struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
>> +       dma_addr_t *dma_list = map->dma_list;
>> +       unsigned offset = bio->bi_iter.bi_offset;
>> +       unsigned map_idx = offset / NVME_CTRL_PAGE_SIZE;
>> +       int length = blk_rq_payload_bytes(req) +
>> +                    (offset & (NVME_CTRL_PAGE_SIZE - 1));
>> +
>> +       dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
>> +
>> +       while (length > 0) {
>> +               dma_sync_single_for_cpu(dev, dma_list[map_idx++],
>> +                                       NVME_CTRL_PAGE_SIZE, dma_dir);
>> +               length -= NVME_CTRL_PAGE_SIZE;
>> +       }
>> +}
>> +
>> +static void nvme_dmabuf_map_sync_for_device(struct nvme_dev *nvme_dev,
>> +                                           struct request *req)
>> +{
>> +       struct device *dev = nvme_dev->dev;
>> +       enum dma_data_direction dma_dir;
>> +       struct bio *bio = req->bio;
>> +       struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
>> +       dma_addr_t *dma_list = map->dma_list;
>> +       unsigned offset = bio->bi_iter.bi_offset;
>> +       unsigned map_idx = offset / NVME_CTRL_PAGE_SIZE;
>> +       int length = blk_rq_payload_bytes(req) +
>> +                    (offset & (NVME_CTRL_PAGE_SIZE - 1));
>> +
>> +       dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
>> +
>> +       while (length > 0) {
>> +               dma_sync_single_for_device(dev, dma_list[map_idx++],
>> +                                          NVME_CTRL_PAGE_SIZE, dma_dir);
>> +               length -= NVME_CTRL_PAGE_SIZE;
>> +       }
>> +}
>> +
>> +static void nvme_rq_clean_dmabuf_map(struct nvme_dev *dev,
>> +                                     struct request *req)
>> +{
>> +       struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +
>> +       nvme_dmabuf_map_sync_for_cpu(dev, req);
>> +
>> +       if (!(iod->flags & IOD_SINGLE_SEGMENT))
>> +               nvme_free_descriptors(req);
>> +}
>> +
>> +static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
>> +                                            struct nvme_queue *nvmeq)
>> +{
>> +       struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +       struct bio *bio = req->bio;
>> +       struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
>> +       unsigned bvec_done = bio->bi_iter.bi_offset;
>> +       unsigned map_idx = bvec_done / NVME_CTRL_PAGE_SIZE;
>> +       unsigned offset = bvec_done & (NVME_CTRL_PAGE_SIZE - 1);
>> +       int length = blk_rq_payload_bytes(req) - (NVME_CTRL_PAGE_SIZE - offset);
>> +       dma_addr_t *dma_list = map->dma_list;
>> +       u64 prp1_dma = dma_list[map_idx++] + offset;
>> +       u64 dma_addr, prp2_dma;
>> +       dma_addr_t prp_dma;
>> +       __le64 *prp_list;
>> +       unsigned i;
>> +
>> +       nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
>> +
>> +       if (length <= 0) {
>> +               prp2_dma = 0;
>> +               goto done;
>> +       }
>> +
>> +       if (length <= NVME_CTRL_PAGE_SIZE) {
>> +               prp2_dma = dma_list[map_idx];
>> +               goto done;
>> +       }
>> +
>> +       if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
>> +           NVME_SMALL_POOL_SIZE / sizeof(__le64))
>> +               iod->flags |= IOD_SMALL_DESCRIPTOR;
>> +
>> +       prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
>> +                       &prp_dma);
> 
> I wonder if it's possible to perform the PRP list page allocations and
> initialization in nvme_dma_buf_io_map() instead of the I/O path. The
> NVMe dma_pools are per-NUMA-node linked lists protected by spinlocks,
> making them significant CPU hotspots. If the dmabuf registration set
> up a contiguous DMA-coherent list of PRP entries for the pages of the
> registered buffer, any command using the dmabuf and requiring at most
> 1 PRP list page (i.e. length <= 2 MB) could just set its PRP list
> pointer to an offset into the dmabuf's PRP list.

Possible to an extent, predecessor patches tried that, I left it for
later to keep the series simpler. I guess chaining won't work in
general case.
I mentioned this to Kanchan, Anuj and Nitesh before, they were up to
playing with nvme optimisations in general, and since sgl from Anuj
is ready, maybe they already have a prototype somewhere for that.

-- 
Pavel Begunkov

