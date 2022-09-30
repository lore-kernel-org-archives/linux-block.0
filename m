Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E20CC433FE
	for <linux-block@archiver.kernel.org>; Fri, 30 Sep 2022 21:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiI3Vdl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiI3Vdc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 17:33:32 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57A11D84B6
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 14:33:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bh13so5188471pgb.4
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2/UNXuLHmDdppjatbpU11f2v62iaLDUAve6sxVmqmQM=;
        b=CFbasNKXN9gWPeyamDPSQrpVUGbuimYwbBxdejWEq0LYkrgRt3HREQOFqgw7aDTTm5
         moTLuzyLfmpwH3zObAX8YeRypLzSrRZT5iQtgrwo6/1iQk8m5Y96o/s+a95oSxNmWjBw
         8XAJ50Zsjv2WcTt/b2cHPhf64TrhaRoIFDqiKiy6YT86E9A9cuupajeorWgPG3AqBPf6
         kLGiJbuNT2bgEqigPWEnTk4crz+VASrNYSPVaCQPwc66ipkM06XNhf8jpuy9pYUKbPn/
         dhLMekXKIrVjOQvMzvTsaPkBMOwWf68WEt4n8LWvy2E8QMF5DKcVSpd4m7t7Bw3TTov6
         SrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2/UNXuLHmDdppjatbpU11f2v62iaLDUAve6sxVmqmQM=;
        b=AngenoiLrCDBbYJWD6uZ+U+09PoCV+qFc1yt/20Pv98bpQAzD9NZfSjI4KxLJ7wSvT
         zG9gnPPkojQCv7eSQFNa7SXxfawnduezMBXVXeb3nSSJv45LvXPMB5P6WQdNI/8pRHzf
         LVKsnno0RsbSF19mkt2VA+uMHrfsjzm/pjmVSQFkFSwnXAAltVsK9bzCyuQGyACx8mDy
         OZO7OeZ4V0vsqrpwc9BSSC14hUhu1WNS6qOXcw/u5QkQKa0RrUIsrYlWQ0ntfr2C8FNP
         inIPMnZIkmks7ayFoukpwXAkZu3TXFpFcVsvlRzC0z1SkiNDu7okRf7p5hF6u2B9IDqW
         n4mQ==
X-Gm-Message-State: ACrzQf3h6ieqtiQ+jN1tkdRlC8cKX7pbpqnITWCU+f3Apq/hMqxUHnG+
        nyCVMYwk0qX8ak3Yzpuq/ZYYi2gEtWj25g==
X-Google-Smtp-Source: AMsMyM7AXc4acwIHlAyUi7XijUEjywO/vXW2M3sK71mTOl5E1wn7xS6N5eHxa+jfHW/tM4f7dkHKCg==
X-Received: by 2002:a63:cd55:0:b0:43c:e24b:e45d with SMTP id a21-20020a63cd55000000b0043ce24be45dmr8926265pgj.223.1664573611279;
        Fri, 30 Sep 2022 14:33:31 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j30-20020a634a5e000000b0044394a14279sm506270pgl.23.2022.09.30.14.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 14:33:30 -0700 (PDT)
Message-ID: <5b7798a8-c9e1-530d-3926-856294f779d1@kernel.dk>
Date:   Fri, 30 Sep 2022 15:33:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] block: avoid sign extend problem with default queue flags
 mask
Content-Language: en-US
To:     Brian Foster <bfoster@redhat.com>, linux-block@vger.kernel.org
Cc:     Nico Pache <npache@redhat.com>, Joel Savitz <jsavitz@redhat.com>
References: <20220930150345.854021-1-bfoster@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220930150345.854021-1-bfoster@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/22 9:03 AM, Brian Foster wrote:
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
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
>  #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
>  
> -#define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> -				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> -				 (1 << QUEUE_FLAG_NOWAIT))
> +#define QUEUE_FLAG_MQ_DEFAULT	((1ULL << QUEUE_FLAG_IO_STAT) |		\
> +				 (1ULL << QUEUE_FLAG_SAME_COMP) |	\
> +				 (1ULL << QUEUE_FLAG_NOWAIT))

Shouldn't this just be 1UL << foo? The queue_flags are not 8-bytes,
they are unsigned long. That happens to be 8-bytes on 64-bit archs,
but it's 4-bytes on 32-bit archs.

-- 
Jens Axboe


