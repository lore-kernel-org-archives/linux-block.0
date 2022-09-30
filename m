Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D2FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 30 Sep 2022 18:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiI3Spb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiI3Sp3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 14:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125BEC1482
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664563525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wXxBXSQkgTD6KP8k1U/uAr13xm9GvDVXHBGSb+XgmpE=;
        b=Opsd3QgVZShdsJGOJmvxN8nBqibgN/stUyf26B9cJs8is8LosoaJzZCgtg4lUWU04UChPO
        Tb0LiyJkYdzNWQyC1e8yl+K62gBPPRat/EncU76efHMRCaSuLdKJvO1rPu4jhyJKRaKb6f
        JHjLVyj8F65AByVF8GMeAwgrSAKrby0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-J3K-jOr7MJSndq9bx58JYw-1; Fri, 30 Sep 2022 14:45:23 -0400
X-MC-Unique: J3K-jOr7MJSndq9bx58JYw-1
Received: by mail-yb1-f199.google.com with SMTP id a10-20020a5b0aca000000b006b05bfb6ab0so4497052ybr.9
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 11:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wXxBXSQkgTD6KP8k1U/uAr13xm9GvDVXHBGSb+XgmpE=;
        b=4PMfNWBPndbBxMpDiFhF0OTEaQvX+rAeVc+Lgi2RbDoaU4Tz+dutB1omc6xJ1vtgO3
         wMa/vQ+/aXKYoJ48pnRbLQ15xsFjLzE0pkplL9ZeWk3HkQSNIlJaDq/MgYHmNkCugfSR
         7b/WOmt38bu+s47A9nIh+J/NY4vy+2ak7TqOpg2yHZrmzonew0mN3Po9c8xn53r2jZww
         Y5hCkQRX2vsoMOVYk2xHRzjbRv4xYXupIESBC9ceA+jBnwnBiTlrGzI9HA1ZNtxtuiQL
         xmsnaYh1QTfqRLNt4i5VKtGh/kVQHy4GBfRICc7vcI6UhjYWWYX2WHKTE5vbHRiU19HV
         6u3Q==
X-Gm-Message-State: ACrzQf27r9fQ/iSC9hxiK2fu2zYTZ/DxcQrNcMErMJEpAxD//eXlGr8/
        lJcrQnnXrw19bPM8B30cv1rD+YjRLy+91Wk4SsqVwym+bZwmyP5iGf1papM593xJjyycZpoFN70
        zfT5B9YEZQRdsd4TFvVsDdIKmNH+5ka97i8Ur5wg=
X-Received: by 2002:a81:1904:0:b0:357:46fe:a81f with SMTP id 4-20020a811904000000b0035746fea81fmr1045527ywz.154.1664563522775;
        Fri, 30 Sep 2022 11:45:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7X9jFrHU4mAU3nhRMU5z3XQ5Zj6oz61EJjMu6wAxBF5D09W++f/2XM8p/oetCPuLfniD4vvmYekgJjLpssWwM=
X-Received: by 2002:a81:1904:0:b0:357:46fe:a81f with SMTP id
 4-20020a811904000000b0035746fea81fmr1045507ywz.154.1664563522555; Fri, 30 Sep
 2022 11:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220930150345.854021-1-bfoster@redhat.com>
In-Reply-To: <20220930150345.854021-1-bfoster@redhat.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Fri, 30 Sep 2022 21:45:06 +0300
Message-ID: <CAL1p7m48w2cFO8gVqsOvqRHzy1NDmgLx6_ib0KaxQCZ6kimryA@mail.gmail.com>
Subject: Re: [PATCH] block: avoid sign extend problem with default queue flags mask
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-block@vger.kernel.org, Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 30, 2022 at 6:03 PM Brian Foster <bfoster@redhat.com> wrote:
>
> request_queue->queue_flags is an 8-byte field. Most queue flag
> modifications occur through bit field helpers, but default flags can
> be logically OR'd via the QUEUE_FLAG_MQ_DEFAULT mask. If this mask
> happens to include bit 31, the assignment can sign extend the field
> and set all upper 32 bits.
>
> This exact problem has been observed on a downstream kernel that
> happens to use bit 31 for QUEUE_FLAG_NOWAIT. This is not an
> immediate problem for current upstream because bit 31 is not
> included in the default flag assignment (and is not used at all,
> actually). Regardless, fix up the QUEUE_FLAG_MQ_DEFAULT mask
> definition to avoid the landmine in the future.
>
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>
> Just to elaborate, I ran a quick test to change QUEUE_FLAG_NOWAIT to use
> bit 31. With that change but without this patch, I see the following
> queue state:
>
> # cat /sys/kernel/debug/block/vda/state
> SAME_COMP|IO_STAT|INIT_DONE|WC|STATS|REGISTERED|30|NOWAIT|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63
>
> And then with the patch applied:
>
> # cat /sys/kernel/debug/block/vda/state
> SAME_COMP|IO_STAT|INIT_DONE|WC|STATS|REGISTERED|30|NOWAIT
>
> Thanks.
>
> Brian
>
>  include/linux/blkdev.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 84b13fdd34a7..28c3037cb25c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -580,9 +580,9 @@ struct request_queue {
>  #define QUEUE_FLAG_NOWAIT       29     /* device supports NOWAIT */
>  #define QUEUE_FLAG_SQ_SCHED     30     /* single queue style io dispatch */
>
> -#define QUEUE_FLAG_MQ_DEFAULT  ((1 << QUEUE_FLAG_IO_STAT) |            \
> -                                (1 << QUEUE_FLAG_SAME_COMP) |          \
> -                                (1 << QUEUE_FLAG_NOWAIT))
> +#define QUEUE_FLAG_MQ_DEFAULT  ((1ULL << QUEUE_FLAG_IO_STAT) |         \
> +                                (1ULL << QUEUE_FLAG_SAME_COMP) |       \
> +                                (1ULL << QUEUE_FLAG_NOWAIT))
>
>  void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
>  void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
> --
> 2.37.2
>

Tested-by: Joel Savitz <jsavitz@redhat.com>
Reviewed-by: Joel Savitz <jsavitz@redhat.com>

