Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0EC43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A91B2183F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Hzrd13p4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfC2OKl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:10:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38193 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfC2OKl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:10:41 -0400
Received: by mail-io1-f68.google.com with SMTP id v4so1844477ioj.5
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=InFNj43Ew+zCZHSNgM4rGAqFiRaGJhlAqF5jIgxZqrQ=;
        b=Hzrd13p4BfDoZijAoBqMNkX/RL1AjjiYrqxr6RxGIuH2eYPg1YHh5EgmMNsXp2KSvt
         QX7zak8YntPOEH/F3XtCxTts+ZoarAGlTh/V8scjWKGr93u81ztKWMO+6zGL//dznWOe
         jxic1068pnpG52O4giIvypSvVpPashLRsYLvCE9whD2/VXzuOvT08wPwc1E304pV3SG2
         K4ZIoFNX13aQWZXu8hzB275LWNSzBsp4DTmp8KjzvIMgCTkwfIH/kM1PSLf+5/hQHAbU
         G8wOUYuwyDRAmLtx1rrVh9IS+ldca4RIdZhpYDMIXvfPoonmfMtnvgePvoZ1bR8E2hhM
         /fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=InFNj43Ew+zCZHSNgM4rGAqFiRaGJhlAqF5jIgxZqrQ=;
        b=rNwJj90uePHX3y1FI58HvJ/T2JCWqV1DxgEt3dGfLrkUcCk1rn6Q4PHt9GUN/8l4h8
         SPEFHGYBYlQ0B5nuCchM9brZ7LTT66H8XDXmQKKhJjUc5tPNxEDT6plS/xgRgL4L/gga
         AXE53PWwPeph8JXaD7IxHLrh1BjTUloYjSn/RVgYlo9GCD+TZkFK0uBz/cp4e+xsLYar
         WUQ05Hq6bkcpvRfRQS5RYWaaMvAo+ZyrQMsR3RB/2uatcDg4dnETfmSGQh3mUdktJxoj
         vp4DaopQ/SXChXc3x0Ke9HixlPBccvQNbrMFDcGnsZ3tj9cz/oPrP9S/K7A7yWRmgPqJ
         SZ8g==
X-Gm-Message-State: APjAAAXhMSU72fovKF7vjr2Dd1Pr6cCqlQi6AbxQQxVrIFU28myt0jvw
        dmmA4MkSxCr3gswafh06UKUegBXEJ8LY7A==
X-Google-Smtp-Source: APXvYqx0F5SUC3ltQ3YKga9JM9tVZEzbQrIBCj0jmkkJ2owsxSdbL6R6hx2SVMn8jioOgkN1yEH6yQ==
X-Received: by 2002:a5e:8a07:: with SMTP id d7mr35777563iok.194.1553868640406;
        Fri, 29 Mar 2019 07:10:40 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m6sm812672ioj.36.2019.03.29.07.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 07:10:39 -0700 (PDT)
Subject: Re: Bisected GFP in bfq_bfqq_expire on v5.1-rc1
To:     Dmitrii Tcvetkov <demfloro@demfloro.ru>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20190329160227.7d55c8dd@fire.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e203a26-b941-cef4-dff1-013999d4b041@kernel.dk>
Date:   Fri, 29 Mar 2019 08:10:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329160227.7d55c8dd@fire.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 7:02 AM, Dmitrii Tcvetkov wrote:
> Hi,
> 
> I got kernel panic since v5.1-rc1 when working with files on block
> device with BFQ scheduler assigned. I didn't find trivial way to
> reproduce the panic but "git checkout origin/linux-5.0.y"
> on linux-stable-rc[1] git repo on btrfs filesystem reproduces the
> problem 100% of the time on my bare-metal machine and in a VM.
> 
> Bisect led me to commit 9dee8b3b057e1 (block, bfq: fix queue removal
> from weights tree). After reverting this commit on top of current
> mainline master(9936328b41ce) I can't reproduce the problem.
> 
> dmesg with the panic and bisect log attached.
> 
> [1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable-rc.git

Paolo, can you please take a look at this?


-- 
Jens Axboe

