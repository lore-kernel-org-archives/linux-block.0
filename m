Return-Path: <SRS0=GZIg=6R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3A9C3A5A9
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 02:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4842F2075B
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 02:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTvZLnQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgECCuv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 May 2020 22:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726699AbgECCuv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 May 2020 22:50:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A814EC061A0C
        for <linux-block@vger.kernel.org>; Sat,  2 May 2020 19:50:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y24so4812369wma.4
        for <linux-block@vger.kernel.org>; Sat, 02 May 2020 19:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CdbL6N/BPrt3eDo1ymcGCR2vxWh64ybr5uGHrPTacDU=;
        b=mTvZLnQVYk4vKdBmIpwVTNX1K+mMtOJsodUq9ZguYDuBW/t64FsC5CsIc4GKVI7McN
         XLF17OiGOPmnqORYf62gv8LA84W99RYZhoGlS1YztjjKVenf6fg860WexublqMeLwL1Y
         NrJtcNpLqEWdnhMG8dsV7eK8Xu84JdGnLunu4dDo70FzrPTt1bxgK6N58ClkN/0NIVkb
         ic2sHpJSTudlbGk7apImdhEdVcYxuypPbbo6CaKG9MrI1dI8sNg3RiYXRp42MGDWXovd
         MXW9cduDHXd/4Oyt/k2qGUX3ZWgjd1gSCdjB7MRYm2l9rfi6T6YcNN71voIR2VjlULaA
         Z5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CdbL6N/BPrt3eDo1ymcGCR2vxWh64ybr5uGHrPTacDU=;
        b=Pr6FrtCckSxrjoDIzMp53t2X/0sGYdFn9xc3qGYhlb9U9OxSmHMwYL2PAkePvBG0o3
         KlQxCLKGpMN5FIFkLEO1mfCUReCS3+b7v2Uk7ceyYgJxU2opdzCiZ4UrybFv4Q8Cd04Q
         Mqn3WlxwwgEiJ0IN6JFBhpRBTnppTl5GI5kLUY9yLLCr3kKkfGzr+aZbD5RxQfcO79Ae
         BciQQu7504yOK/J5WpeXRtU0u2O8EQrD5iIucYLyaEkZzBE65FCaWl9VVeUu4rioqRpf
         c3e81F4ZAAI2GEUBbB3vmoBn7gk74HTxYHd83YHBQw9Hz0o8eBuipINoZ0mEzqXV4uAK
         2srg==
X-Gm-Message-State: AGi0PuaRdsJSubPWm9Q/9u+ipf+82zbUPB7u/Cq0pXNo3eol+X+xcQ4y
        BcNGkEChj+qWO6XOHP3gii5c0S9buyPymwKJgKg=
X-Google-Smtp-Source: APiQypLW5ympiKdYJJHgBeArZgruWdOXzjzRCvTGYkQ85QBP+CR4VcLLY2VxDY6RA/UKr//AH3Nw8b5adiMzSVWjSOA=
X-Received: by 2002:a05:600c:14d4:: with SMTP id i20mr7597043wmh.118.1588474248248;
 Sat, 02 May 2020 19:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588080449.git.zhangweiping@didiglobal.com> <ea9f8241d420025a1e9e553d2c966fcc8b32335c.1588080449.git.zhangweiping@didiglobal.com>
In-Reply-To: <ea9f8241d420025a1e9e553d2c966fcc8b32335c.1588080449.git.zhangweiping@didiglobal.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sun, 3 May 2020 10:50:37 +0800
Message-ID: <CACVXFVPOmw8YUKM3=O53KEycHRXGg_9wpy8rnSsvHm6JwgH9-g@mail.gmail.com>
Subject: Re: [RESEND v4 2/6] block: save previous hardware queue count before udpate
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 9:29 PM Weiping Zhang
<zhangweiping@didiglobal.com> wrote:
>
> blk_mq_realloc_tag_set_tags will update set->nr_hw_queues, so
> save old set->nr_hw_queues before call this function.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f789b3e1b3ab..a79afbe60ca6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3347,11 +3347,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>                 blk_mq_sysfs_unregister(q);
>         }
>
> +       prev_nr_hw_queues = set->nr_hw_queues;
>         if (blk_mq_realloc_tag_set_tags(set, set->nr_hw_queues, nr_hw_queues) <
>             0)
>                 goto reregister;
>
> -       prev_nr_hw_queues = set->nr_hw_queues;
>         set->nr_hw_queues = nr_hw_queues;
>         blk_mq_update_queue_map(set);
>  fallback:
> --
> 2.18.1
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming Lei
