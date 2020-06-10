Return-Path: <SRS0=qLys=7X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64971C433E1
	for <linux-block@archiver.kernel.org>; Wed, 10 Jun 2020 07:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8AD207ED
	for <linux-block@archiver.kernel.org>; Wed, 10 Jun 2020 07:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="lafpKDCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFJH0p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgFJH0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jun 2020 03:26:45 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F30C03E96F
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 00:26:44 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v13so957102otp.4
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=icQyLe1x0JtVbH2h0JIR6glxOffDGiETwl2nJBOJkMA=;
        b=lafpKDCMm3DeuM+OTgu5T8Qf2tkuZ7c6gSdQPGBucRUhmFKAPhdSvHixRj+8KjzjVh
         2MCDGdz9s2gyNzI/i/dH4crrvq3m86yN6v0HoLO7vO2uFk3xiBAsafLpjo39IJkocDNn
         OXke9WuiSjA6rE4wgV+JvZudHH+syCPya85k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=icQyLe1x0JtVbH2h0JIR6glxOffDGiETwl2nJBOJkMA=;
        b=iV83VhLwnFbKzD2EnXYJ7oVmqg6CDIquKskOksfK4vF8ojVBKJAiiXD/Ab91Q5jkVy
         N3kghbqImUlaHb+WeY/fx/3kgtZTbHd7YEgUydG7Ls3L2GYOopESCG2oXPJ3whrjLsO/
         z8jz/AdmDaA7CUXnTqDp+MDamC7zd8PEvbePwqpQiPuUZcseIn+acZ084tHtpVGoI8f0
         e5Act2SjbWR/Lc2KAzerAk4fYeLppB7xanOb3e0Kja/ojhbNwoIb5p6xV0BkNTZHltO+
         CFut0FaoQl6fsUsUU4PdVnrlQZSHLvpwdk5OkBxs9H4rRLYW7Uo5RcfCh9MhGXpY1ZPY
         GJnA==
X-Gm-Message-State: AOAM530Vm9ZE9zeMOWYzx3lkScNLsajwWnh8i6bZ4oqcMX9uzWSXGQuN
        kDdun+jiydynGeZN4hnzkh2lhQ==
X-Google-Smtp-Source: ABdhPJxsXjBzzM+sQpS1NYnAHvWZyutMSD6PvDWTeaoQuEw0H6Rq4sAmQXqP4w1JR1byoQ8VGS2dFA==
X-Received: by 2002:a9d:6546:: with SMTP id q6mr1528551otl.365.1591774002683;
        Wed, 10 Jun 2020 00:26:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:3ec3:2450:25ca:3996:acb2:84a6? ([2600:1700:3ec3:2450:25ca:3996:acb2:84a6])
        by smtp.gmail.com with ESMTPSA id 13sm3732094ois.44.2020.06.10.00.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 00:26:41 -0700 (PDT)
Subject: Re: [RFC 1/2] Eliminate over- and under-counting of io_ticks
To:     Hou Tao <houtao1@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Snyder <josh@code406.com>, Ming Lei <ming.lei@redhat.com>
References: <20200609040724.448519-1-joshs@netflix.com>
 <20200609040724.448519-2-joshs@netflix.com>
 <0b7e623e-2146-5e44-f486-ba9e1657f2a3@huawei.com>
From:   Josh Snyder <joshs@netflix.com>
Message-ID: <a026a60f-e319-de35-8274-fb14ada29eff@netflix.com>
Date:   Wed, 10 Jun 2020 00:26:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0b7e623e-2146-5e44-f486-ba9e1657f2a3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

On 6/9/20 6:41 PM, Hou Tao wrote:
> Hi,
> 
> For the following case, the under-counting is still possible if io2 wins cmpxchg():
> 
>   t          0123456
>   io1        |-----|
>   io2           |--|
>   stamp      0     6
>   io_ticks   0     3

I hadn't noticed that bug. It looks like it can produce an unbounded quantity of undercount.

> However considering patch 2 tries to improve sampling rate to 1 us, the problem will gone.

Now that you mention it, the below case is also poorly handled, and will be incorrect
regardless of sampling frequency. It experiences issues both under this patch (labeled
io_ticks) and the current implementation (labeled io_ticks~):

   t          0123456
   io1        |-----|
   io2           |-|
   stamp      0    56
   io_ticks        28

   stamp~     0  3 56
   io_ticks~     1 34

I am beginning to doubt whether it is even possible to produce an algorithm that is
simultaneously unbiased and synchronization-lite. At the same time, Ming's comment on
patch 2 was leading me to wonder about the value of being synchronization-lite in the
first place. At the proposed sampling rate of 1M/s, it is unlikely that we'd ever exercise
the synchronization-free code path (and, as your case shows, incorrect). And for every
block device that I'm aware of (even the ones that return in 10us), the cost of a disk
access still completely dominates the cost of a locked CPU operation by three orders of
magnitude.

Josh
