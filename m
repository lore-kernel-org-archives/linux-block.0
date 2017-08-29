Return-Path: <guanjunxiong@huawei.com>
Subject: Re: [PATCH 07/10] nvme: track shared namespaces
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        "Jens
 Axboe" <axboe@kernel.dk>
CC: Keith Busch <keith.busch@intel.com>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>,
        "Shenhong (C)" <shenhong09@huawei.com>,
        niuhaoxin <niuhaoxin@huawei.com>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-8-hch@lst.de>
 <bee7c6c3-bf6b-8f7e-ad8f-fd5e238a94ef@grimberg.me>
From: Guan Junxiong <guanjunxiong@huawei.com>
Message-ID: <19cc45b0-1f84-d115-6ae6-2349613c2ca2@huawei.com>
Date: Tue, 29 Aug 2017 14:54:56 +0800
MIME-Version: 1.0
In-Reply-To: <bee7c6c3-bf6b-8f7e-ad8f-fd5e238a94ef@grimberg.me>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>



On 2017/8/28 14:51, Sagi Grimberg wrote:
> +static int __nvme_check_ids(struct nvme_subsystem *subsys,
> +        struct nvme_ns_head *new)
> +{
> +    struct nvme_ns_head *h;
> +
> +    lockdep_assert_held(&subsys->lock);
> +
> +    list_for_each_entry(h, &subsys->nsheads, entry) {
> +        if ((!uuid_is_null(&new->uuid) &&
> +             uuid_equal(&new->uuid, &h->uuid)) ||
> +            (memchr_inv(new->nguid, 0, sizeof(new->nguid)) &&
> +             memcmp(&new->nguid, &h->nguid, sizeof(new->nguid))) ||

memcmp() -> !memcmp

> +            (memchr_inv(new->eui64, 0, sizeof(new->eui64)) &&
> +             memcmp(&new->eui64, &h->eui64, sizeof(new->eui64))))

memcmp() -> !memcmp

Otherwise in this patch, looks good.
Reviewed-by: Guan Junxiong <guanjunxiong@huawei.com>
