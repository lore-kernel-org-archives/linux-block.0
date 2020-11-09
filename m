Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD5FC4741F
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEF820789
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YPFikwaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgKIQPH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgKIQPH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 11:15:07 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A223C0613CF
        for <linux-block@vger.kernel.org>; Mon,  9 Nov 2020 08:15:06 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id t13so8800407ilp.2
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2020 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=czUMYa1lHXDUWtQzzxSzwqKh95tj/THhiMyAvkBiag8=;
        b=YPFikwazpCmKxgRC1W+7l+U80M/Rp61hTHyC7v5qrPM/mM8sp/2vxm8WdkFaw7k8ii
         DKD07u5mqjL2AXegbersa9xPFaJehST9jOql+cIsDcCxKrIZ9gGjS3pjl8UwgZaRmcmX
         bIvB6c2KtoJnI2Oix398N/b7davPkbmC8gxprmMD/a6Jk2x1T2MilHGQfpWhrXwpJv+E
         bx8dM4YcOkzoMSZ/MnC9bHJFyOtK9mOVqME2H0CFzAcnhlPYHwK1qPTdd+2PjkS/K4ee
         IYy9zdMaM+0H36gGQNfC0sSRCbQ+IiBv/6ncVyWf6H9crvPFTmuCnSp/pDcNqTfN+qsL
         d6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=czUMYa1lHXDUWtQzzxSzwqKh95tj/THhiMyAvkBiag8=;
        b=i8MX6pN8hay6foo//ZEAIi0MfTyo5g/wa+d9+c9ZOAXn96gIxhLXv4mx/bMxmmOZwM
         Aly8FU4kBJ9u4wim80/oghyiUpvoNzJ+kX3f3kZi5AUmpqB3CDGAo3pptZaRGDhSRgeu
         5xcnLmaf/ffGP4fgTbc9lI9SRFmekvxx1kd0Y2ORgISYanus8Ht0WsHYL6zdfFp9V126
         iYT4lhlr+yOHF7hwWMyuqoyZUVtLtVNU3GTe9099zK5p793RHzCmrI2aV6UWcguxJK+H
         BCQRE3aVFxwABDfTJosDYdqe9gzoWLd1gHQ7GBll/R5MD+mvlJkSd02B9vpbH5fAIYAt
         +dxQ==
X-Gm-Message-State: AOAM533EuhJR4Q6fE6e6vZJ98wsTwvCcCHZgraqf5oR59GQzAudWbQwK
        HSpXUKx+6ur61iQCIO9Es2m6wIH3e/YmTg==
X-Google-Smtp-Source: ABdhPJyJB5lZO6JsfBojPX/CiH1K7yacikeo8cXMEEqXDebChl0v5oOk3ZT9tw8xCMEi6dUdBz4YRA==
X-Received: by 2002:a92:cc52:: with SMTP id t18mr1637488ilq.124.1604938505380;
        Mon, 09 Nov 2020 08:15:05 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y19sm7295292ilk.79.2020.11.09.08.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 08:15:04 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e10=2e0?=
 =?UTF-8?Q?-rc3_=28block=29?=
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <cki.F35EC3202F.1TPV9ZC6SF@redhat.com>
 <449460775.17920557.1604938423946.JavaMail.zimbra@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4795330a-cd9c-a5cb-a256-35281fde5142@kernel.dk>
Date:   Mon, 9 Nov 2020 09:15:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <449460775.17920557.1604938423946.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/20 9:13 AM, Veronika Kabatova wrote:
> 
> 
> ----- Original Message -----
>> From: "CKI Project" <cki-project@redhat.com>
>> To: linux-block@vger.kernel.org, axboe@kernel.dk
>> Sent: Monday, November 9, 2020 5:11:45 PM
>> Subject: ❌ FAIL: Test report for kernel 5.10.0-rc3 (block)
>>
>>
>> Hello,
>>
>> We ran automated tests on a recent commit from this kernel tree:
>>
>>        Kernel repo:
>>        https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>             Commit: c91882ba0790 - Merge branch 'tif-task_work.arch' into
>>             for-next
>>
>> The results of these automated tests are provided below.
>>
>>     Overall result: FAILED (see details below)
>>              Merge: OK
>>            Compile: FAILED
>>
>> All kernel binaries, config files, and logs are available for download here:
>>
>>   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2020/11/09/617345
>>
>> We attempted to compile the kernel for multiple architectures, but the
>> compile
>> failed on one or more architectures:
>>
>>             x86_64: FAILED (see build-x86_64.log.xz attachment)
>>
> 
> Hi, we're seeing the following errors with the last two git pushes
> (the other one being commit dd8da1a825a9ba9ad3c7d0e707db9441c9182349):
> 
> 00:00:10 In file included from ./arch/x86/include/asm/atomic.h:5,
> 00:00:10                  from ./include/linux/atomic.h:7,
> 00:00:10                  from ./include/linux/crypto.h:15,
> 00:00:10                  from arch/x86/kernel/asm-offsets.c:9:
> 00:00:10 ./include/linux/sched/signal.h: In function ‘signal_pending’:
> 00:00:10 ./include/linux/sched/signal.h:368:39: error: ‘TIF_NOTIFY_SIGNAL’ undeclared (first use in this function)
> 00:00:10   368 |  if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
> 00:00:10       |                                       ^~~~~~~~~~~~~~~~~
> 00:00:10 ./include/linux/compiler.h:78:42: note: in definition of macro ‘unlikely’
> 00:00:10    78 | # define unlikely(x) __builtin_expect(!!(x), 0)
> 00:00:10       |                                          ^
> 00:00:10 ./include/linux/sched/signal.h:368:39: note: each undeclared identifier is reported only once for each function it appears in
> 00:00:10   368 |  if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
> 00:00:10       |                                       ^~~~~~~~~~~~~~~~~
> 00:00:10 ./include/linux/compiler.h:78:42: note: in definition of macro ‘unlikely’
> 00:00:10    78 | # define unlikely(x) __builtin_expect(!!(x), 0)
> 00:00:10       |                                          ^
> 00:00:10   HDRINST usr/include/linux/thermal.h
> 00:00:10   HDRINST usr/include/linux/time.h
> 00:00:10 make[3]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
> 00:00:10   HDRINST usr/include/linux/time_types.h
> 00:00:10   HDRINST usr/include/linux/timerfd.h
> 00:00:10 make[2]: *** [Makefile:1200: prepare0] Error 2

Missed branch on my part, it should be fine now.

-- 
Jens Axboe

