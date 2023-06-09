Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCE4C7EE2E
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 17:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFIRPE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 13:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjFIRPD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 13:15:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EEFE4A
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 10:14:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30c55d2b9f3so1476260f8f.2
        for <linux-block@vger.kernel.org>; Fri, 09 Jun 2023 10:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686330895; x=1688922895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpGQKNTp4HHYXqStDIHEl+JHfYYf6Y8AnNTs3RYEGE4=;
        b=ZOZi0IBa+r1x5fujcS5B+sG0xA8quHxRgZ4CigMqrNODtN3LV9/n8yv/64SaCRe4Qf
         VaBgRGFJZ9TEG0I2zrQoflivCiPDjAXDk9EHpyW9o4BugmdxU19+lOB3RZ1Ihudy/Pn8
         1S6pMdxd36H2fxRdkdzffEvRO9YgmM27BDGI7yWEXCJ9y6R/SCnPDXCJPX/3JgjCI8mn
         QiFhYcu+7Y2/WMPsbgXkAWnjfaTe4nvMS4P6itI3qDXc8hfCt0tg02J0cLvKhCMV3hcg
         RK8Ec/+FDsTkFYKTUr/NV/YAEc8eEZWMnNbILgz92z9dIyDfgeMQcNZYowPPpR4cA63V
         2wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686330895; x=1688922895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpGQKNTp4HHYXqStDIHEl+JHfYYf6Y8AnNTs3RYEGE4=;
        b=hquPdOMlQVTfennNzCHgNzXBNnRJRGU1M3Sw5ceU9IWifS/4p21ICWgADCrwhazOGr
         Ah0m17Md+ZSvx1mpwhE+G4KFEFVOgb2/C+ipm8GZPCNTeW8cOyFM11A9GQL6UHkb5b6+
         Z3gDHo5NHECZMjSgTKBsaX/tU+Ewk1y2A+Ps86+EJEABu06BH6+8gMNSWJZg2pZIj/DC
         nY0eCok0fm4P+VLPv9XW0xxu5ue9ITVPMOD1Ka9J4LIxThB7TgtbbyApUe53Ft733c7q
         Fdet6WQHFfFJUYC4Uj/qQ933QNUEiW71d2dIDNZ7bR7blUtS+U7zQMeoY4eD1bBz2w7f
         bP9g==
X-Gm-Message-State: AC+VfDwbRc6z6zgFTdC8NQbuiQg1918bxqQNIaA9qRJWjAAMoKkVygfZ
        vR5YChfi09sHPQ5j6GR7NkMrwFNOl6B4iN8jZBfzrg==
X-Google-Smtp-Source: ACHHUZ4fDpA88P6aAitsvSa80rs0qE8f3PsIuxUjL2BC/1U+zsi2G3r7I2P5pbmqfg2CkzmPNStAgdtwHjekVaY3x18=
X-Received: by 2002:a05:6000:368:b0:30a:f038:6113 with SMTP id
 f8-20020a056000036800b0030af0386113mr1153794wrf.40.1686330895007; Fri, 09 Jun
 2023 10:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230522222554.525229-1-bvanassche@acm.org>
In-Reply-To: <20230522222554.525229-1-bvanassche@acm.org>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Fri, 9 Jun 2023 10:14:43 -0700
Message-ID: <CAB=BE-SGR8xc9JOF2g4vGVYp0MRmV1pG2WLjoWo3YwAGL1LKJg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Support limits below the page size
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 3:25=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> Hi Jens,
>
> We want to improve Android performance by increasing the page size from 4=
 KiB
> to 16 KiB. However, some of the storage controllers we care about do not =
support
> DMA segments larger than 4 KiB. Hence the need support for DMA segments t=
hat are
> smaller than the size of one virtual memory page. This patch series imple=
ments
> that support. Please consider this patch series for the next merge window=
.
>
> Thanks,
>
> Bart.
>
> Changes compared to v4:
> - Fixed the debugfs patch such that the behavior for creating the block
>   debugfs directory is retained.
> - Made the description of patch "Support configuring limits below the pag=
e
>   size" more detailed. Split that patch into two patches.
> - Added patch "Use pr_info() instead of printk(KERN_INFO ...)".
>
> Changes compared to v3:
> - Removed CONFIG_BLK_SUB_PAGE_SEGMENTS and QUEUE_FLAG_SUB_PAGE_SEGMENTS.
>   Replaced these by a new member in struct queue_limits and a static bran=
ch.
> - The static branch that controls whether or not sub-page limits are enab=
led
>   is set by the block layer core instead of by block drivers.
> - Dropped the patches that are no longer needed (SCSI core and UFS Exynos
>   driver).
>
> Changes compared to v2:
> - For SCSI drivers, only set flag QUEUE_FLAG_SUB_PAGE_SEGMENTS if necessa=
ry.
> - In the scsi_debug patch, sorted kernel module parameters alphabetically=
.
>   Only set flag QUEUE_FLAG_SUB_PAGE_SEGMENTS if necessary.
> - Added a patch for the UFS Exynos driver that enables
>   CONFIG_BLK_SUB_PAGE_SEGMENTS if the page size exceeds 4 KiB.
>
> Changes compared to v1:
> - Added a CONFIG variable that controls whether or not small segment supp=
ort
>   is enabled.
> - Improved patch descriptions.
>
> Bart Van Assche (9):
>   block: Use pr_info() instead of printk(KERN_INFO ...)
>   block: Prepare for supporting sub-page limits
>   block: Support configuring limits below the page size
>   block: Make sub_page_limit_queues available in debugfs
>   block: Support submitting passthrough requests with small segments
>   block: Add support for filesystem requests and small segments
>   block: Add support for small segments in blk_rq_map_user_iov()
>   scsi_debug: Support configuring the maximum segment size
>   null_blk: Support configuring the maximum segment size
>
>  block/blk-core.c                  |  4 ++
>  block/blk-map.c                   | 29 +++++++---
>  block/blk-merge.c                 |  8 ++-
>  block/blk-mq-debugfs.c            |  9 ++++
>  block/blk-mq-debugfs.h            |  6 +++
>  block/blk-mq.c                    |  2 +
>  block/blk-settings.c              | 88 ++++++++++++++++++++++++++-----
>  block/blk.h                       | 39 +++++++++++---
>  drivers/block/null_blk/main.c     | 19 +++++--
>  drivers/block/null_blk/null_blk.h |  1 +
>  drivers/scsi/scsi_debug.c         |  4 ++
>  include/linux/blkdev.h            |  2 +
>  12 files changed, 182 insertions(+), 29 deletions(-)
>
>
We have tested this series on Pixel 6 by applying to android common
kernel at [0] successfully with 16K page size.

Feel free to add
Tested-by: Sandeep Dhavale <dhavale@google.com>

-Sandeep.

[0] https://android.googlesource.com/kernel/common/+/refs/heads/android14-6=
.1
