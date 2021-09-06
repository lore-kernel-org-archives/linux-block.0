Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC35C433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 17:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 178AF60FBF
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 17:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbhIFRLy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243985AbhIFRLx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Sep 2021 13:11:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0436C06175F
        for <linux-block@vger.kernel.org>; Mon,  6 Sep 2021 10:10:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j12so12288367ljg.10
        for <linux-block@vger.kernel.org>; Mon, 06 Sep 2021 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBV6xJO0OJaH8jzRZsLqKsR9gePhFCKXaYbJlTL1SK0=;
        b=LFms5S3j0LvWEYimyPf3cb4Aisdn+Fk0RcpOrMN+ZdxUItBFt03MZgAJyCUWWC62gA
         xL6pVj/R4056hMSTJXWaAAW0XJxWY95ANL2inlfc7gjmf6BFW8UdEkjBN6OfL9igtewV
         2JgY9QMy4BbUAgVA1jm1THz+5T5uS585jDOW2nVtjNTStboUZCsKHDlx3pvPga5s2Aea
         dvtTuh0M4AIM0YiFHE2rv2jMoWzeXBDMGduAbcmjYKzTNfr7wM1AzhSBU6ieiQ9XTDvy
         XQyK9QeN2IRddAghms+zRMV1up63wzN38bLJRWblvnD5e2vOcie3vnIumG6eir16lfbi
         jm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBV6xJO0OJaH8jzRZsLqKsR9gePhFCKXaYbJlTL1SK0=;
        b=YVkCrXxim9R4bE6fLR49lKv5GreQw92tQbruY1RVVzm1pHpg/yXemJNES/S+hmetDc
         FnJ+igR8tNlKAQJZGAadvGKS2xEE+Q2/Rw6wp95Qujj3RIvN0/LcdQgBEtJyhSWwsTT6
         rQuKp0dDVewpVySHNp87TvJtUOLaa3xnvKCE/zOfnUdTsPRRG6F/reY9NXcjvXOLTesw
         P3blZmwNidP+/hcptpzsleo7qBSDPhSGq8D6GmrbW8lbZZisYtd7RW6pypPtd00cj70Y
         2eaaQF/Ddc+/BRV53pM70w3xKKmlRnio2aJXr7Y56nRlv8La6TsYAGl8ICCHMmlLD5Al
         deng==
X-Gm-Message-State: AOAM532sivo3A3xQrQreX4JbQrWBFh08h+6U+zAb1lmE6oEBAUaEY5M6
        LBvEIBR9S6hUWAvjjVbxqMK3Nz6mybe0f/3bb8ZvUw==
X-Google-Smtp-Source: ABdhPJxhSEFI8wMN4u5XHazx2hzbbCQEPxdsCfALNn+wlwsdQueMDsoHtriqduJghpS67u2M98pG6gst9sXWJqwHE5o=
X-Received: by 2002:a05:651c:1b3:: with SMTP id c19mr11757010ljn.16.1630948247165;
 Mon, 06 Sep 2021 10:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210830212538.148729-1-mcgrof@kernel.org> <20210830212538.148729-5-mcgrof@kernel.org>
In-Reply-To: <20210830212538.148729-5-mcgrof@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:10:10 +0200
Message-ID: <CAPDyKFp9HTjQ_6c2tHuPhhixfcnFa8XQBrPO2PqoB113BszLJw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] mmc/core/block: add error handling support for add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, kbusch@kernel.org,
        sagi@grimberg.me, Adrian Hunter <adrian.hunter@intel.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Avri Altman <avri.altman@wdc.com>,
        Stephen Boyd <swboyd@chromium.org>, agk@redhat.com,
        Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>, dm-devel@redhat.com,
        nbd@other.debian.org, linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 30 Aug 2021 at 23:26, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
>
> The caller only cleanups the disk if we pass on an allocated md
> but on error we return return ERR_PTR(ret), and so we must do all
> the unwinding ourselves.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Queued for v5.16 on the temporary devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 6a15fdf6e5f2..9b2856aa6231 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2453,9 +2453,14 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         /* used in ->open, must be set before add_disk: */
>         if (area_type == MMC_BLK_DATA_AREA_MAIN)
>                 dev_set_drvdata(&card->dev, md);
> -       device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
> +       ret = device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
> +       if (ret)
> +               goto err_cleanup_queue;
>         return md;
>
> + err_cleanup_queue:
> +       blk_cleanup_queue(md->disk->queue);
> +       blk_mq_free_tag_set(&md->queue.tag_set);
>   err_kfree:
>         kfree(md);
>   out:
> --
> 2.30.2
>
