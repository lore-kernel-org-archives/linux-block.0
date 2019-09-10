Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACA3C49ED9
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 18:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A6D2082C
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 18:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xqDdzksC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfIJSVW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:21:22 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:36178 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfIJSVV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 14:21:21 -0400
Received: by mail-pf1-f178.google.com with SMTP id y22so12044660pfr.3
        for <linux-block@vger.kernel.org>; Tue, 10 Sep 2019 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=He18b5RVxxpe8smLyrpLpEIbfLqZ+paKB0vO+pHwR0g=;
        b=xqDdzksClH+VzDniz0I3kbc4+dbzzazVKzgT6Ff4DZMABzndDy97UPPfDYpirqRCml
         PFu9R4FCQtPyGcxX/uYeajB/GMRFM0mZUbiZDKp83Aky9HTCz45hCcdFFkDt+V2HvzYI
         TfNIAcMWT4/Z38wIcFGpNBTsAjEeuCKY5GHcu/2ZO9zytYqipZbjE6Pr1OmE2xFFJNpK
         jGApnEkDxlX0I2fd6Kv4CSpKDI5HI1r7tfX8JMs0XYpDeZRO2KhFEAeTVCP8v/l80S7J
         haD3WvPie8GxrBV3FQyZcasYkmMDtrDImkPwXs4nib/c5wR/YXhvjZfcP7BG5/yvZREU
         obew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=He18b5RVxxpe8smLyrpLpEIbfLqZ+paKB0vO+pHwR0g=;
        b=mW4npkW4V98nwA/ZCXCiunTQ1Xk6BT+WGwM9bDvDtGEGnOqwPC4zOZvsClXfURF+jM
         dWEgKETS1MCIzNvgzKNe0YkzgycC/NIKE9p7hbbgScaJ31v5rDWrGc1PG4KnVOQmVZmI
         m7/xwpEtFE4owknwFvwKQT48ZqOk5ey44s5UzOyUmREAN4Uq7ayl92li6srdx/YKpeRO
         qVW6Ur7L0XWobXdXANlUdhWJbrIdKM1ZW4/oENeTxIqkq35/Ljh73SL5+4dvwnDwk+JV
         lIJ3zyQbepqeRx5tCx7w1MJJcTrQetjBMwzDOGE8bm9tmGEftIWvMfMEEMYavGeaENWL
         pEtg==
X-Gm-Message-State: APjAAAXMELrK30T/7G9Cx6mx0/nXU0/WzR8vWTLgUFOK4ao3Jsiya4DN
        rXhVXcRgr9IVRFsNwRGbKJXjhA==
X-Google-Smtp-Source: APXvYqxEGGAanfl9SlthPWRKT+GwrUUtorAPx3HUFq4hKMuGjQSTQz95q8I0tLNAn4ATjGR8vVobqw==
X-Received: by 2002:a62:3893:: with SMTP id f141mr21107527pfa.221.1568139679352;
        Tue, 10 Sep 2019 11:21:19 -0700 (PDT)
Received: from ?IPv6:2600:380:b456:5481:e4d0:d8e2:e397:e69f? ([2600:380:b456:5481:e4d0:d8e2:e397:e69f])
        by smtp.gmail.com with ESMTPSA id g2sm20935834pfm.32.2019.09.10.11.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 11:21:17 -0700 (PDT)
Subject: Re: [block/for-next] iocost: Fix incorrect operation order during
 iocg free
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@fb.com,
        Dave Jones <davej@codemonkey.org.uk>
References: <20190910161525.GT2263813@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2222732f-09f7-1434-31a6-b591630d2efb@kernel.dk>
Date:   Tue, 10 Sep 2019 12:21:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910161525.GT2263813@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/10/19 10:15 AM, Tejun Heo wrote:
> ioc_pd_free() first cancels the hrtimers and then deactivates the
> iocg.  However, the iocg timer can run inbetween and reschedule the
> hrtimers which will end up running after the iocg is freed leading to
> crashes like the following.
> 
>    general protection fault: 0000 [#1] SMP
>    ...
>    RIP: 0010:iocg_kick_delay+0xbe/0x1b0
>    RSP: 0018:ffffc90003598ea0 EFLAGS: 00010046
>    RAX: 1cee00fd69512b54 RBX: ffff8881bba48400 RCX: 00000000000003e8
>    RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8881bba48400
>    RBP: 0000000000004e20 R08: 0000000000000002 R09: 00000000000003e8
>    R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90003598ef0
>    R13: 00979f3810ad461f R14: ffff8881bba4b400 R15: 25439f950d26e1d1
>    FS:  0000000000000000(0000) GS:ffff88885f800000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00007f64328c7e40 CR3: 0000000002409005 CR4: 00000000003606e0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    Call Trace:
>     <IRQ>
>     iocg_delay_timer_fn+0x3d/0x60
>     __hrtimer_run_queues+0xfe/0x270
>     hrtimer_interrupt+0xf4/0x210
>     smp_apic_timer_interrupt+0x5e/0x120
>     apic_timer_interrupt+0xf/0x20
>     </IRQ>
> 
> Fix it by canceling hrtimers after deactivating the iocg.

Applied, thanks.

-- 
Jens Axboe

