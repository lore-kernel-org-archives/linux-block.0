Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D7BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 16:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E229860E73
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 16:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhJ0Qab (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbhJ0Qaa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 12:30:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9A6C061570
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 09:28:05 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d63so4419826iof.4
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=EB7mkYDf4hL38MpQZa8MopstIqM8xpKi32VuDT6XNQA=;
        b=nEUUQ7LWswnSkIbzAunivg4V0Y+9MsSnfXgA1CIc4p/Pru6deVGS0s02XzLHjpTxJi
         pZaxbMmlPYyM7JcaQ/oS2Mh0pRNdEK2mM0VKl0j+mDv3Txq3dWfCLlzeIU+4d4J7k9Fr
         LbVmacJtwfXTMaR1YbBDy57nLB2GQ2+qvzJJgZTRk4NnnekazBUhZKoaq2jFKHqzo381
         stg+p6qPzV3h6jDicTbcZldosbxAvshPbychslxyzhSbVyqW6wn4E3rD7d9bu8z4BcQi
         w1FfGEHnMVUgMq87WxmlktZfIMhl8xSgZQXgK39DTUaWL/VJSCaGe8AhM7PuOJS80642
         jX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=EB7mkYDf4hL38MpQZa8MopstIqM8xpKi32VuDT6XNQA=;
        b=Noe5DmVNIbFle3BLRyVz8TTL5QucWggsVNFW+oGk2n97ppfBW7dtUiY4z0dsi0nxej
         SeIUvSJFOe5f6Nz7oF+KtwnbzRRSMP4zaXWsFBH8We9l7V1H2/H8bmv1G7LIszwOFdir
         Eu5ja6pjBle9fIIwKAHJIt/JAnzK007/fIyDUPhhP3L2hcvKcuGOMRlwCYfuYNUBMWLF
         IEmmT6OEHVDHl5hiWEzzfypSE1iea5QjTWm5436LH8eA2v8mjtqztdRQ8YOBoCuz8SCs
         p3+WfA/9E56NIQcUbqXcK1SUfDYnfN94VARVcBe6OoPtPEjm4TijUkFlwXfhocRcnaxU
         LqRw==
X-Gm-Message-State: AOAM532y+Hxng7kqlAN0Y2Zqnwn8d9hmBlBvklFQ5AfV0cU3q7K0IHOl
        xoY+kz9uRSIrWrbfAbc+FH45zLwu82uHXQ==
X-Google-Smtp-Source: ABdhPJyr0PBG3+HgtgTF61SXNMF4IMlEvHYy9NLdvR19NwZAw5Qwl9vu1hO7EyDAifIoiPgp6RAphQ==
X-Received: by 2002:a02:880a:: with SMTP id r10mr11990988jai.40.1635352084730;
        Wed, 27 Oct 2021 09:28:04 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v4sm177871ilq.57.2021.10.27.09.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 09:28:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>
In-Reply-To: <cover.1635337135.git.asml.silence@gmail.com>
References: <cover.1635337135.git.asml.silence@gmail.com>
Subject: Re: [PATCH v2 0/4] block optimisations
Message-Id: <163535208421.17299.9039457090187780470.b4-ty@kernel.dk>
Date:   Wed, 27 Oct 2021 10:28:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 27 Oct 2021 13:21:06 +0100, Pavel Begunkov wrote:
> optimisations for async direct path of fops.c, and extra cleanups based
> on it. First two patches from v1 were applied, so not included here.
> 
> v2: add another __blkdev_direct_IO() cleanup, 3/4
>     rearrange branches in 1/4 (Cristoph Hellwig)
>     inline bio_set_polled_async(), 4/4 (Cristoph Hellwig)
> 
> [...]

Applied, thanks!

[1/4] block: avoid extra iter advance with async iocb
      commit: 1bb6b81029456f4e2e6727c5167f43bdfc34bee5
[2/4] block: kill unused polling bits in __blkdev_direct_IO()
      commit: 25d207dc22271c2232df2d610ce4be6e125d1de8
[3/4] block: kill DIO_MULTI_BIO
      commit: e71aa913e26543768d5acaef50abe14913c6c496
[4/4] block: add async version of bio_set_polled
      commit: 842e39b013465a279fb60348427b9309427a29de

Best regards,
-- 
Jens Axboe


