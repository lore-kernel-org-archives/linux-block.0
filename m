Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046D5EB64D8
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 08:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFVIgB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 04:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjFVIf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 04:35:56 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419C0EA
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 01:35:45 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bd77424c886so6875751276.0
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 01:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687422944; x=1690014944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ml/gLb06BnApHnxHlA0l9KKOIGUf2TY1ELv59h6NJA=;
        b=IKA0XTp46XrrBlVqCSvjK6iItAugZKKTisGkLIz5Dl7uQO5SHEjhKIhx2eh+7Mj7kv
         4CI73ItXa2ihD9KYKaOdexpK6nsiSf/pOagQQRcZMOGXx6xW965e+dpidDwH1ZF5q0Pm
         c9edwYN7sAvkKkD5CiWcyJ1ITVoRM2sr6w3DikfIkiLwBufp9CpDJsFZidMaOwOWDI95
         Illnnwv7cD9PJ3HTkrKpELHeLDZsp8YAXN/2YVkoHHk7WN38c9TpOGJNrXCSyiKr5IjE
         PaTB2WfZVNUELRJRY0dvWxS0XL2WAbSay4ph5y2pmSMJJ7RG/WX94+e9Ql3OYtUT6Cz2
         Tu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422944; x=1690014944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Ml/gLb06BnApHnxHlA0l9KKOIGUf2TY1ELv59h6NJA=;
        b=l5HNKvSKHQikQd700/Z04RSKxPUqRM8e6GDEjW8WqNQ7Xp6wmSriSEPIHa/QptWNZM
         QgwyvUyqSA5kl50VrGAOcu4W4Cez0K3LiSBu52I+nvbFozy06j62wT3SAFCHWzOB6WO6
         C39TzaL0sYODc+FtEe95VMqxpbfro/VO19cxxz0yaw9SifSGim8L17Txe02MhIFHio7I
         QLQQfo4eFPhtjBgEM7Q/nN8T+lSJQOn/MhiTnwZQogPOvmp7bktfnGmfT5pYQfpWkR1A
         ftj/+t3L4XW6SRf2mFxxdykUhRT4AT1V68QvDFS6V8M1IuqxlbIwKzjgWLWFGPGh2dNK
         vEgQ==
X-Gm-Message-State: AC+VfDzJ04NCJNQQ2sKoID7idb9ZWAOBUZDERzEQFdihYQUgis5spISE
        YHesykkn7AKa4L1xBhP9l1Ix7e9tpjfKFkQ47Rs=
X-Google-Smtp-Source: ACHHUZ5K/tdOf9g2jqlyhMD05CNG8iL0mdd9NIDMe8ANR3AC5fIjH62WgtnvncBE2rAGeDA7pzEzqROVWIEQcgmb4rA=
X-Received: by 2002:a25:da94:0:b0:bc7:d7ba:4e8b with SMTP id
 n142-20020a25da94000000b00bc7d7ba4e8bmr18303109ybf.13.1687422944349; Thu, 22
 Jun 2023 01:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <ZJLpYMC8FgtZ0k2k@infradead.org> <20230621134340.878461-1-houtao@huaweicloud.com>
In-Reply-To: <20230621134340.878461-1-houtao@huaweicloud.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 22 Jun 2023 10:35:32 +0200
Message-ID: <CAM9Jb+j8-DWdRMsXJNiHm_UK5Nx6L2=a2PnRL=m3sMyQz4cXLw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_pmem: add the missing REQ_OP_WRITE for flush bio
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        virtualization@lists.linux-foundation.org, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The following warning was reported when doing fsync on a pmem device:
>
>  ------------[ cut here ]------------
>  WARNING: CPU: 2 PID: 384 at block/blk-core.c:751 submit_bio_noacct+0x340/0x520
>  Modules linked in:
>  CPU: 2 PID: 384 Comm: mkfs.xfs Not tainted 6.4.0-rc7+ #154
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>  RIP: 0010:submit_bio_noacct+0x340/0x520
>  ......
>  Call Trace:
>   <TASK>
>   ? asm_exc_invalid_op+0x1b/0x20
>   ? submit_bio_noacct+0x340/0x520
>   ? submit_bio_noacct+0xd5/0x520
>   submit_bio+0x37/0x60
>   async_pmem_flush+0x79/0xa0
>   nvdimm_flush+0x17/0x40
>   pmem_submit_bio+0x370/0x390
>   __submit_bio+0xbc/0x190
>   submit_bio_noacct_nocheck+0x14d/0x370
>   submit_bio_noacct+0x1ef/0x520
>   submit_bio+0x55/0x60
>   submit_bio_wait+0x5a/0xc0
>   blkdev_issue_flush+0x44/0x60
>
> The root cause is that submit_bio_noacct() needs bio_op() is either
> WRITE or ZONE_APPEND for flush bio and async_pmem_flush() doesn't assign
> REQ_OP_WRITE when allocating flush bio, so submit_bio_noacct just fail
> the flush bio.
>
> Simply fix it by adding the missing REQ_OP_WRITE for flush bio. And we
> could fix the flush order issue and do flush optimization later.
>
> Fixes: b4a6bb3a67aa ("block: add a sanity check for non-write flush/fua bios")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> v2:
>   * do a minimal fix first (Suggested by Christoph)
> v1: https://lore.kernel.org/linux-block/ZJLpYMC8FgtZ0k2k@infradead.org/T/#t
>
> Hi Jens & Dan,
>
> I found Pankaj was working on the fix and optimization of virtio-pmem
> flush bio [0], but considering the last status update was 1/12/2022, so
> could you please pick the patch up for v6.4 and we can do the flush fix
> and optimization later ?
>
> [0]: https://lore.kernel.org/lkml/20220111161937.56272-1-pankaj.gupta.linux@gmail.com/T/
>
>  drivers/nvdimm/nd_virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index c6a648fd8744..97098099f8a3 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -105,7 +105,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>          * parent bio. Otherwise directly call nd_region flush.
>          */
>         if (bio && bio->bi_iter.bi_sector != -1) {
> -               struct bio *child = bio_alloc(bio->bi_bdev, 0, REQ_PREFLUSH,
> +               struct bio *child = bio_alloc(bio->bi_bdev, 0, REQ_OP_WRITE | REQ_PREFLUSH,
>                                               GFP_ATOMIC);
>
>                 if (!child)

Fix looks good to me. Will give a run soon.

Yes, [0] needs to be completed. Curious to know if you guys using
virtio-pmem device?

Thanks,
Pankaj
