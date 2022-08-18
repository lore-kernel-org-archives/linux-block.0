Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FDEC25B08
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 03:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbiHRDc7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 23:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbiHRDc6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 23:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EC29018A
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 20:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660793576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CnSkXgG5vlVmmHn7RVnWUaE/zfht4AYlOxzHk7kfQng=;
        b=BYQIaQtIELUwdP/0meZMOByCfqB0S+gU+E5LHH4bwcEqx1h1H1J6ZzGuWMh6DLwdsUS5lE
        rTvdaiugJb/P0RNlYTngVO+9RfU8LB7gxIFYRscOVjr2nSmOtq1cuTTahRsjUTSYfhEgQt
        qXYC+dcKJreF9ZD/vHFMRU+fcAj7cWc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-377-cMqkLvSvPKGic5oFADErkw-1; Wed, 17 Aug 2022 23:32:55 -0400
X-MC-Unique: cMqkLvSvPKGic5oFADErkw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-334ab1f0247so7141967b3.7
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 20:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CnSkXgG5vlVmmHn7RVnWUaE/zfht4AYlOxzHk7kfQng=;
        b=SELsrf4QrymsXxO8cURobqh6hpXerI+r7Ikqdce+V+e64NlF8X2LsF/hhVWHqTdYJ4
         54RxMpX92qa7EXL7fSbhSdWL7UBzGEN/5bQfxFDmjAxR7YfTfXztVEwuQVUOWCVcPmk/
         rhClhUv5qsrXewL2Hb2b9ABmhyAh5vUFG9/WoFgQiK7TPoc79hF3GBYoyOupqWPVtDLD
         ey55gtUGyrOPAVVOrl5C9zwX5GbbXlc/SdXTtqIWepfkK0ym7KqhbSWWgURuhVCuAhDn
         28PAX6j3cX2sOIypOrhal/Ozs9tyuRg5ujJ51laTbPTiGt/taf/Zkazu696xKLQXpK8+
         DAJQ==
X-Gm-Message-State: ACgBeo1r4MUJy/pZYJbI2j37PJopUvJuk2+KoHDDXuY9zd9hlR/aEpdX
        I5ILXg48QsGiRQHsdGmHNITUoDQGe7xkcYaWiYHXvP7f110SqVgDaantl39gfayOxTd3LJ+HeRX
        ZQlCHSX1ysRr7iGBI8+aJmlCAlti7Q7CE56y1Tlk=
X-Received: by 2002:a81:5716:0:b0:335:41fc:feea with SMTP id l22-20020a815716000000b0033541fcfeeamr1081117ywb.305.1660793574898;
        Wed, 17 Aug 2022 20:32:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR58Bdj0aI1r+5X89YYZ7cHcFvRu0jChH2boC2bti4hBzyVirPHL2aaj3NMT0cCcm11wzzdg4+hXaLIBCdIcgU8=
X-Received: by 2002:a81:5716:0:b0:335:41fc:feea with SMTP id
 l22-20020a815716000000b0033541fcfeeamr1081109ywb.305.1660793574704; Wed, 17
 Aug 2022 20:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220803023355.3687360-1-yuyufen@huaweicloud.com>
In-Reply-To: <20220803023355.3687360-1-yuyufen@huaweicloud.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 18 Aug 2022 11:32:43 +0800
Message-ID: <CAFj5m9J71n_ZJk4NgXWqd8Wf1ELDWyMLTEHDKnMiJqOdkd+Xbg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] blk-mq: run queue no matter whether the request
 is the last request
To:     Yufen Yu <yuyufen@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, yukuai3@huawei.com,
        yuyufen@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 3, 2022 at 10:22 AM Yufen Yu <yuyufen@huaweicloud.com> wrote:
>
> From: Yufen Yu <yuyufen@huawei.com>
>
> We do test on a virtio scsi device (/dev/sda) and the default mq
> scheduler is 'none'. We found a IO hung as following:
>
> blk_finish_plug
>   blk_mq_plug_issue_direct
>       scsi_mq_get_budget
>       //get budget_token fail and sdev->restarts=1
>
>                                  scsi_end_request
>                                    scsi_run_queue_async
>                                    //sdev->restart=0 and run queue
>
>      blk_mq_request_bypass_insert
>         //add request to hctx->dispatch list
>
>   //continue to dispath plug list
>   blk_mq_dispatch_plug_list
>       blk_mq_try_issue_list_directly
>         //success issue all requests from plug list
>
> After .get_budget fail, scsi_mq_get_budget will increase 'restarts'.
> Normally, it will run hw queue when io complete and set 'restarts'
> as 0. But if we run queue before adding request to the dispatch list
> and blk_mq_dispatch_plug_list also success issue all requests, then
> on one will run queue, and the request will be stall in the dispatch
> list and cannot complete forever.
>
> It is wrong to use last request of plug list to decide if run queue is
> needed since all the remained requests in plug list may be from other
> hctxs. To fix the bug, pass run_queue as true always to
> blk_mq_request_bypass_insert().
>
> Fix-suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 93d9d60980fb..1eb13d57a946 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2568,7 +2568,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
>                         break;
>                 case BLK_STS_RESOURCE:
>                 case BLK_STS_DEV_RESOURCE:
> -                       blk_mq_request_bypass_insert(rq, false, last);
> +                       blk_mq_request_bypass_insert(rq, false, true);
>                         blk_mq_commit_rqs(hctx, &queued, from_schedule);
>                         return;
>                 default:

Fixes: dc5fc361d891 ("block: attempt direct issue of plug list")

Thanks,
Ming

