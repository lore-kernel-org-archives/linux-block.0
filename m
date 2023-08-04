Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7FAC001DF
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 18:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjHDSkM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjHDSkC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 14:40:02 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A22F1734
        for <linux-block@vger.kernel.org>; Fri,  4 Aug 2023 11:39:56 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56cca35d8c3so1431975eaf.3
        for <linux-block@vger.kernel.org>; Fri, 04 Aug 2023 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691174395; x=1691779195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pdb4S4jUFam2YhjI6Vvc54gNq3pasG3XtD6ctU3NAjQ=;
        b=I9VG2TN71UFCBaFTm9LK2L3jfysGIhtbcHeQeGMXQhKiCwA8vNMUZ9SDkSksNhDXJ+
         LX4B7GQ+s0aK3kq9PWy7gyjkh0rZtHOQu30z6vmNzh+siHQIRY+IhDpgEDe2sEkBku7a
         Js8NncabV7a5emcw4d9BZQ0igQSWdDxlB/Yny4EaC8R7ShhRZz/+e9RT33uExgguhpUp
         GpjE8INpjgUlKGzyXTsN1HVMMI2DKNJtW1GT3ccO8G2eYim1o1FxDa1R0eKPYMOW3SNr
         91tU8sDp1PtkKwmylBJ9ULtCt7T8vkXn02tSL1xLiGbSWW9dtMlG6pOuw9vcTOIrzMrX
         2qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174395; x=1691779195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdb4S4jUFam2YhjI6Vvc54gNq3pasG3XtD6ctU3NAjQ=;
        b=jqvlTq73GXN2fVuWkiJbec5bTysJVn2SGS92kndqV0U9gUhDAw09qjwCykrcda1Ec2
         7T3lB0AK44ZSuMJmzHPP/SkENeFxsiVYfBBkrHMStkvOyO5Hx5nM4q9vUEKsbgAH6B5y
         xXkxTDhXrVC+yq1dl3aHu4e70VhjkjJ4VPr32a7EYJ68yJIzff8QIbKYegUF02C+ClJG
         Rl8N+fVojEXncm3iWpuvdMSuauHNi7jBxNw2SnCGuJb7T0QviyfP5m1XsvPkpNr0gXJM
         BOoa6QLfhkFf+5zqxSUxHaJE6o6cV99eAt+Y351DnQqKIFm/lAOkNgcvqHp9NPR+Hiap
         dh/g==
X-Gm-Message-State: AOJu0YxnP7Q64D9mHqtsOwavoVFAIci7VayWWnClQp4t1PI1S0ViuVo5
        mqHKTBaYki/AN9ZbF4gQcKOYNbtcto3EVm8HAN0=
X-Google-Smtp-Source: AGHT+IFs0h5DxXct9osM1RKApWLE5ecrqHLo2TdX1nYTIkTpD4DVEulpSxL0E8JXXS0yK6ZEJUwW+q0wDKazTDwfQuQ=
X-Received: by 2002:a05:6358:99a8:b0:139:5a46:ea7d with SMTP id
 j40-20020a05635899a800b001395a46ea7dmr1260451rwb.7.1691174395225; Fri, 04 Aug
 2023 11:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9Jb+g5rrvmw8xCcwe3REK4x=RymrcqQ8cZavwWoWu7BH+8wA@mail.gmail.com>
 <20230713135413.2946622-1-houtao@huaweicloud.com>
In-Reply-To: <20230713135413.2946622-1-houtao@huaweicloud.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Fri, 4 Aug 2023 20:39:43 +0200
Message-ID: <CAM9Jb+jjg_By+A2F+HVBsHCMsVz1AEVWbBPtLTRTfOmtFao5hA@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_pmem: add the missing REQ_OP_WRITE for flush bio
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        virtualization@lists.linux-foundation.org, houtao1@huawei.com,
        "Michael S . Tsirkin" <mst@redhat.com>, pankaj.gupta@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Gentle ping!

Dan, Vishal for suggestion/review on this patch and request for merging.
+Cc Michael for awareness, as virtio-pmem device is currently broken.

Thanks,
Pankaj

> From: Hou Tao <houtao1@huawei.com>
>
> When doing mkfs.xfs on a pmem device, the following warning was
> reported:
>
>  ------------[ cut here ]------------
>  WARNING: CPU: 2 PID: 384 at block/blk-core.c:751 submit_bio_noacct
>  Modules linked in:
>  CPU: 2 PID: 384 Comm: mkfs.xfs Not tainted 6.4.0-rc7+ #154
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>  RIP: 0010:submit_bio_noacct+0x340/0x520
>  ......
>  Call Trace:
>   <TASK>
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
> Cc: stable@vger.kernel.org # 6.3+
> Fixes: b4a6bb3a67aa ("block: add a sanity check for non-write flush/fua bios")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> v4:
>  * add stable Cc
>  * collect Rvb and Tested-by tags
>
> v3: https://lore.kernel.org/linux-block/20230625022633.2753877-1-houtao@huaweicloud.com
>  * adjust the overly long lines in both commit message and code
>
> v2: https://lore.kernel.org/linux-block/20230621134340.878461-1-houtao@huaweicloud.com
>  * do a minimal fix first (Suggested by Christoph)
>
> v1: https://lore.kernel.org/linux-block/ZJLpYMC8FgtZ0k2k@infradead.org/T/#t
>
>  drivers/nvdimm/nd_virtio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index c6a648fd8744..1f8c667c6f1e 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -105,7 +105,8 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>          * parent bio. Otherwise directly call nd_region flush.
>          */
>         if (bio && bio->bi_iter.bi_sector != -1) {
> -               struct bio *child = bio_alloc(bio->bi_bdev, 0, REQ_PREFLUSH,
> +               struct bio *child = bio_alloc(bio->bi_bdev, 0,
> +                                             REQ_OP_WRITE | REQ_PREFLUSH,
>                                               GFP_ATOMIC);
>
>                 if (!child)
> --
> 2.29.2
>
