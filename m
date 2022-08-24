Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05BBC00140
	for <linux-block@archiver.kernel.org>; Wed, 24 Aug 2022 14:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiHXOav (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiHXOav (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Aug 2022 10:30:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F5E0B5
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 07:30:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kk26so4190428ejc.11
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L3nhJ1oXEm66RN5YJpQxUjYOJUVJImLsdXQEym3JVNE=;
        b=JknGb3YsYH4h74OZgzf06J8m47ndvTj3jgsEk0rjExh7+xILbqdCRyR3KJTRo+duLR
         hA53EAUmakg+IufPqNIoL6KWa3OqcL4hQ69tCuysPX8XjWwj/jzIecMvLaWcrmCw91+2
         DFzU5c0PchnPoJl0qbWieoCGz0skfMDvvX7GQFZY1IJ/YzRMBqJWG8fPu7tNYScujZV6
         490SVTH8k41vKxRoEYvdxVesrC2gc1KQaPsY8qqc1d7htSN9iXEx/KKGobTM/s3iKP0s
         veZl7MtzPqRa+N8zTtaZ/xX/lX0auzQXObqigTpv2GhnKRHii0LMSaKr4z5VZw+XK8Pc
         SkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L3nhJ1oXEm66RN5YJpQxUjYOJUVJImLsdXQEym3JVNE=;
        b=63ItKkOMBs48zbS9ARrccjoVCoXHCfaR9vgy7rYNgXrFWoDPL8Lb2HTN5HDrkixcL5
         0saRp14sGLCjE6td/RA44naS8Z8stD6OOzOFhfZZfTbAv+4azI2eBqBXgCg52zCMuysH
         XNgL0P4TsW4xcpoMWBRqbCsZbaOyUykh/+7q33ociERrkmi2XvHNwMig9YK0JBBPHbP+
         KCmcPmvkTGD3LfHMh1RVH+EkyeXBZQqH730O1or28jOqK0zndzA57pEeb/yq1NmIarm/
         RHqBrOXRDSKkcMp+rawDrwRQBYBLpHqZ3U7I+enb+yRFFx/H+xYXnaurGI2UpZMpMLSh
         ReMw==
X-Gm-Message-State: ACgBeo05bVdZVkfHrisGqmQEudvVKqx08iBSEQmWYWOx+hxC0VdZU694
        BGHJpIAgXpYNIDQ9/3rwV1EKMeMkrN/t58waB2DGow==
X-Google-Smtp-Source: AA6agR5NSfYqi4aiOyXY9NpkX/lrFYOyG2xevy89Tqs7/R3UIxulmNH7LSzKVDzuc7IdiZ6U+faz2D2VvV5PDq9QSvM=
X-Received: by 2002:a17:906:5d07:b0:73d:a136:760c with SMTP id
 g7-20020a1709065d0700b0073da136760cmr3000625ejt.435.1661351447121; Wed, 24
 Aug 2022 07:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220824075213.221397-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220824075213.221397-1-ye.xingchen@zte.com.cn>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 24 Aug 2022 16:30:36 +0200
Message-ID: <CAMGffEm=Ss1=Qvg_pd3MUT=XsKr+tvKn4bVaLUu4GEpDxHoC_g@mail.gmail.com>
Subject: Re: [PATCH linux-next] block/rnbd-clt: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     axboe@kernel.dk, haris.iqbal@ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 24, 2022 at 9:52 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value from rtrs_clt_rdma_cq_direct() directly instead of
> storing it in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn
Acked-by: Jack Wang <jinpu.wang@ionos.com>
thx!
> ---
>  drivers/block/rnbd/rnbd-clt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 9d01e7ab33e4..78334da74d8b 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1159,10 +1159,8 @@ static int rnbd_rdma_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>  {
>         struct rnbd_queue *q = hctx->driver_data;
>         struct rnbd_clt_dev *dev = q->dev;
> -       int cnt;
>
> -       cnt = rtrs_clt_rdma_cq_direct(dev->sess->rtrs, hctx->queue_num);
> -       return cnt;
> +       return rtrs_clt_rdma_cq_direct(dev->sess->rtrs, hctx->queue_num);
>  }
>
>  static void rnbd_rdma_map_queues(struct blk_mq_tag_set *set)
> --
> 2.25.1
