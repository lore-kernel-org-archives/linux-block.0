Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AC4C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E185520760
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6MVuC39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725271AbgGAEBP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGAEBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 00:01:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64282C061755
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 21:01:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so22233126wrj.13
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 21:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgw+eV8E3fZOFcUogcTMK7kgEYvtSuCJnMKUyrf1g6w=;
        b=U6MVuC39J/inuukMnRvUFu4sFLQOehRWZ10abIFWZlBe9zGR6xRHlPk36LyyIEWv+R
         t6CdNGEouUBss2UV6Asl+Su5Fm9lEw3p07lebUT2tkgvMh1b1IptUNbkYJB1QaIFZKDv
         Z/PFxp3j7nTaAiQBLqcWB7+cQMNHL1ixmrhlfYiFZxFsySG2e7Ud2GqHo80OJsGVN5A2
         terDJE/RZxTl3w1zsAG9lmj4k0oOygsfYEH6omeMYewolodXSIU12a4hQ0vfCib5xMpu
         fdP8r4BTiHQgh0xenl3UZmdqgwYiewFv5KJMt/BipGSD8nQHzmnwJcppsCbJR7VsR3eX
         R/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgw+eV8E3fZOFcUogcTMK7kgEYvtSuCJnMKUyrf1g6w=;
        b=QbRJeMBEQ3xVRRYPX1DAypSc6nRBzVuqp/pCMK3ezoaR/Sty5JUte3n1Fq951hVrjK
         XCbTR/gFIM+5SYM78o0ike6sTW28NbaNSJ1et6+vLqK6WE8fccCDRM6O4+bWdaG7gTWy
         57/azNxv1GuXUr1eeOFJCPAdP3BBa/vPDaGwal/WsfIEK8tNQx/BJjXUeCQLjeuz5hlB
         2HLMPDhwRHCO8qjqgPMfQDr5DkQBxj2kXVdQ/JfDu5rcqQxxVboL09iIJyVrxhQIYSfM
         bbWiM7fUU7KEZtE9n+CASABgC6ilbDfYi5WAQSIqsy0ey9J65VgaXTNLM1ULnRm9CP2W
         Uaig==
X-Gm-Message-State: AOAM5328z5WWKCdS22X0RI8AhNr/BqjuzONlpIpvh09T6gAA2eiC4XoT
        M+Xbtg5ik0BtYVk6uv0SDuCbeRYkcW9mz+e8QdA=
X-Google-Smtp-Source: ABdhPJxhQj95QhbMPMFj/B7PCQWAs5ZVyX0cDaUYUrnGJy2lLqCH+ujMbdfWWbdpm85ANU7l9zKGBu+ALuY7LIaFtGQ=
X-Received: by 2002:adf:ea06:: with SMTP id q6mr23792647wrm.69.1593576070967;
 Tue, 30 Jun 2020 21:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200427131250.13725-1-houtao1@huawei.com>
In-Reply-To: <20200427131250.13725-1-houtao1@huawei.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 1 Jul 2020 12:00:59 +0800
Message-ID: <CACVXFVMj-OtuOEHpYyGWfsRK5OAVx5PD-bSCRhwjnZLoXqGG0w@mail.gmail.com>
Subject: Re: [PATCH 1/1] blk-mq: remove the pointless call of list_entry_rq()
 in hctx_show_busy_rq()
To:     Hou Tao <houtao1@huawei.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 27, 2020 at 8:44 PM Hou Tao <houtao1@huawei.com> wrote:
>
> And use rq directly.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  block/blk-mq-debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index b3f2ba483992..7a79db81a63f 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -400,8 +400,7 @@ static bool hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>         const struct show_busy_params *params = data;
>
>         if (rq->mq_hctx == params->hctx)
> -               __blk_mq_debugfs_rq_show(params->m,
> -                                        list_entry_rq(&rq->queuelist));
> +               __blk_mq_debugfs_rq_show(params->m, rq);

Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming Lei
