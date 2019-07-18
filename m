Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B3C76191
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 13:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F89F20880
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 13:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X9ITcyWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRNWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:22:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38232 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRNWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 09:22:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so13880499plb.5
        for <linux-block@vger.kernel.org>; Thu, 18 Jul 2019 06:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aiWng9qMoZ80kqXI3bNmAzxB86h7OKfzjpJGuHMwHqk=;
        b=X9ITcyWIv/rrbplkWLuc+Arh4MPJbLgE3uEHSVBm+NNe52TFYP9hoKB/jXVmwdoiXW
         eaLeSQBv0+wpog9RTyVsGpzKr8He1/zkDQyga2Yvhs0odjRTDLr0dUcJzzD3SiNnpKLz
         m1/7ZaLXVJo7gbthtAuXZGbXrQaR/EwS+IAtJt9VWILYvlwgbH1xEpFgdNGajOXDKfWU
         sC2za7AdRuzTt5adxASQ7Xiv9oK4uLINXXe5t11PqDmgedweaZPQj+jxAXWGX+xXfopM
         RcvDWniy10VIKRNnwK+8stzD+ELHX3FUGQY4e6RnfeID1hKqpoLcRodEA2wGteyAkx9k
         TP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aiWng9qMoZ80kqXI3bNmAzxB86h7OKfzjpJGuHMwHqk=;
        b=TbPmLEhHNAXAa29kbenX01ahTzxHwu08DSuvM6WuGjgLEwEt9cxTjw5zpNqm5ITRrI
         wNI24tStgyd1336RW++O0MmYPUHikLZs2K6aotXuC8igETeyfYJFdqPnxGG2qF4MraRp
         6vAly2Xj9FvTBoDp+qMeR3d/M+RgYhUzj3I7Y3kYi1Mf2xnquPIoUGez3K2QMQ03q0w9
         IMeTZakCkGXu6kLEmsYiutzdm6tLeX4TCnrn9ubL3CR4uVAzo3HNXVI5qDhrGbv+cxcs
         dFjzZvCHyKYqMhQmfg8yKoJRY/g2EgyYNe3oYMjLtHdrwTdq9A9xkOrA+bJKaLogEQH7
         ryuQ==
X-Gm-Message-State: APjAAAWikl3NDrh30jgi6ae+aYIQh86zrD2leRKE12c27xm3E5bgx2K+
        zPej6nri3IuG4PIvXGhSVFI=
X-Google-Smtp-Source: APXvYqz5fSqIlQ4aNJLg4zcd9JNP3y8ho6Ip9w5jGHp1atPuQ0hJMgOoIrexRP2iqFPlHVgHy49QkA==
X-Received: by 2002:a17:902:ea:: with SMTP id a97mr49646446pla.182.1563456130714;
        Thu, 18 Jul 2019 06:22:10 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id v185sm31518783pfb.14.2019.07.18.06.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:22:09 -0700 (PDT)
Subject: Re: [PATCH BUGFIX IMPROVEMENT V3 1/1] block, bfq: check also
 in-flight I/O in dispatch plugging
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu
References: <20190718070852.34568-1-paolo.valente@linaro.org>
 <20190718070852.34568-2-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8ee30620-44e4-c1a8-5cfe-6f658aa58a85@kernel.dk>
Date:   Thu, 18 Jul 2019 07:22:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718070852.34568-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/18/19 1:08 AM, Paolo Valente wrote:
> Consider a sync bfq_queue Q that remains empty while in service, and
> suppose that, when this happens, there is a fair amount of already
> in-flight I/O not belonging to Q. In such a situation, I/O dispatching
> may need to be plugged (until new I/O arrives for Q), for the
> following reason.
> 
> The drive may decide to serve in-flight non-Q's I/O requests before
> Q's ones, thereby delaying the arrival of new I/O requests for Q
> (recall that Q is sync). If I/O-dispatching is not plugged, then,
> while Q remains empty, a basically uncontrolled amount of I/O from
> other queues may be dispatched too, possibly causing the service of
> Q's I/O to be delayed even longer in the drive. This problem gets more
> and more serious as the speed and the queue depth of the drive grow,
> because, as these two quantities grow, the probability to find no
> queue busy but many requests in flight grows too.
> 
> If Q has the same weight and priority as the other queues, then the
> above delay is unlikely to cause any issue, because all queues tend to
> undergo the same treatment. So, since not plugging I/O dispatching is
> convenient for throughput, it is better not to plug. Things change in
> case Q has a higher weight or priority than some other queue, because
> Q's service guarantees may simply be violated. For this reason,
> commit 1de0c4cd9ea6 ("block, bfq: reduce idling only in symmetric
> scenarios") does plug I/O in such an asymmetric scenario. Plugging
> minimizes the delay induced by already in-flight I/O, and enables Q to
> recover the bandwidth it may lose because of this delay.
> 
> Yet the above commit does not cover the case of weight-raised queues,
> for efficiency concerns. For weight-raised queues, I/O-dispatch
> plugging is activated simply if not all bfq_queues are
> weight-raised. But this check does not handle the case of in-flight
> requests, because a bfq_queue may become non busy *before* all its
> in-flight requests are completed.
> 
> This commit performs I/O-dispatch plugging for weight-raised queues if
> there are some in-flight requests.
> 
> As a practical example of the resulting recover of control, under
> write load on a Samsung SSD 970 PRO, gnome-terminal starts in 1.5
> seconds after this fix, against 15 seconds before the fix (as a
> reference, gnome-terminal takes about 35 seconds to start with any of
> the other I/O schedulers).
> 
> Fixes: commit 1de0c4cd9ea6 ("block, bfq: reduce idling only in symmetric scenarios")

Applied, but fixed up this line. The format is:

Fixes: 1de0c4cd9ea6 ("block, bfq: reduce idling only in symmetric scenarios")   

-- 
Jens Axboe

