Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F85C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 23:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC822611BD
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 23:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbhI0XQ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbhI0XQ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 19:16:27 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50733C061575
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 16:14:49 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id q6so7214555ilm.3
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 16:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LVFw6UOGAe/V4xSvrcgomVT53CI8IgdhP9sDtgQHDSs=;
        b=aEQtLnDX9hMHxOYnwCBVVumoXYUbsc0CUMALNjT6qucGpGEozkxTYMM54fEyWl5HwY
         jv9J3YEyKKUH20zlahusGHWiB8P/CRYpmkPaSm+surBrxk8XdSIRuuF6NXjIS/DmdROr
         hwZb/lh1cqDv5v//sBkf1/nmi73lwFpAc2qXarJC6zNEayvN0LuhNAYjZ4IYQJHQxvdL
         GvW0vKmOC7EQoyetIy0BgbaeYEi3EpDuXTioC5MtMytl5MCJGfHHwRflfUKhQMlYEG3n
         7dYi3Rv9toOtCNEt9I32MqLF8TTFXlqu5XFskucrk+eYjIJS3emavSHwNjKTnzWqPjly
         TIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LVFw6UOGAe/V4xSvrcgomVT53CI8IgdhP9sDtgQHDSs=;
        b=N3McYEzhHughVHd3EqpmN1dm4cuKHWhS23/ZMacrSWwJIiL0uXw8Jm680He04aeooP
         bHl8BdvhdWnkzSh/8E503uay0vRm/0wPP4g5YEJ33ZeSbL6QtM/aFM9wYla1RV8tYdjc
         jmhMIAwc23tOn6p6HRkuBke11NyfMESdThLJ3DqyfRkc19z4RHsIcxA/SoR/bzY8ghSg
         p6C9CiJ8UtT1WUPchg9dojjXsQ41ulQ21/w422fn5nQeRKcOt4xTbAdwkjal53KZYCq5
         h3tX7YXTbbiOnluAj06ZINBAiIscCIalAQjuj5uuqeRU/Iz0+5Y6OwjjH3jWguxd906S
         rapA==
X-Gm-Message-State: AOAM533wW/+cQ/zAIJd9CAUCqvS53MpkfaC+Ks9SNLcsm/Whqw3ES/IX
        xNCT4l9wIhqbfZHHW1cJamnq4w==
X-Google-Smtp-Source: ABdhPJw8eLqTSCNtUIqa2Ik9HTuXup66xMKifqQILBnAd0obDMm05IwRiBRAxiv1x03I5dIwdXXhQA==
X-Received: by 2002:a05:6e02:ef4:: with SMTP id j20mr2027103ilk.294.1632784488703;
        Mon, 27 Sep 2021 16:14:48 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s18sm9801652iov.53.2021.09.27.16.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 16:14:48 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Restore I/O priority support in the mq-deadline
 scheduler
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210927220328.1410161-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <70faf604-182d-2dab-2a8f-5d30f890335d@kernel.dk>
Date:   Mon, 27 Sep 2021 17:14:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927220328.1410161-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/21 4:03 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> This patch series includes the following changes compared to the v5.14-r7
> implementation:
> - Fix request accounting by counting requeued requests once.
> - Test correctness of the request accounting code by triggering a kernel
>   warning from inside dd_exit_sched() if an inconsistency has been detected.
> - Switch from per-CPU counters to individual counters.
> - Restore I/O priority support in the mq-deadline scheduler. The performance
>   measurements in the description of patch 4/4 show that the peformance
>   regressions in the previous version of this patch have been fixed. This has
>   been achieved by using 'jiffies' instead of ktime_get() and also by skipping
>   the aging mechanism if all queued requests have the same I/O priority.
> 
> Please consider this patch series for kernel v5.16.

Applied, thanks.

-- 
Jens Axboe

