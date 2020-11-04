Return-Path: <SRS0=E+wN=EK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C28C388F7
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 20:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2C0207BB
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 20:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OzF0+TuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbgKDUyc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDUyc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Nov 2020 15:54:32 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219EEC0613D3
        for <linux-block@vger.kernel.org>; Wed,  4 Nov 2020 12:54:31 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id o129so18334142pfb.1
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2020 12:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1cd/xJrSTbdzPmB6Bebxm8LoVLXTFR4TrBpMKpPc50I=;
        b=OzF0+TuD/l68i8NwKWRlXZww5IetKdDiX0atNTQZffMCBVr1Tl6wsZmCeRqcKeyb+y
         mlouO5KghsCh5L9JxTzIJGSd6ccbi9YerpSlyV9W+gF7fWxoaKEusOHzd7zUVFOwyElj
         K55+pCnimLIppTOvt+AAnQ1ImitAaq3BRYqZwh24VtmMMZTlSB33MD7NK8XvCWAm35nY
         b2+OyhT/zbcP8BZ0OGcPTIKTuEwqjEtGw9fL/ekL4W+xlkZJkMGq1BxgK/t78pz+XxSO
         wHe/A6BeLZ3ZATeAnM0buxqgr4leShBxMNNo98phVtjuVjBWUsNQQDr2rSFHttZWc03q
         aIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1cd/xJrSTbdzPmB6Bebxm8LoVLXTFR4TrBpMKpPc50I=;
        b=oqedE4CCA0ZkSnX3MPseJd2ZU1nPLn73IqqLxOTZCZmnLvQXnqRLO1+bualMBdCAwt
         PdDxdFlDIzV8Kb2vNcuNB03ZJnd9h4EBSdjizoqCePhbpJJx8N3qs7rACKBaxvLc7nAm
         BoZxnmvbTc9/HFzlQ8GmMc70pkQFOr+SgK6ZPkU3eAcxbS4ysESdx81agQVHEE28mn1K
         CxfKGy2atANlH3N4eAyUTx+35bGZ4ZvBeqgZm69UZh16dfUyDM9GdqY0szUd5QOLiCcL
         LNZdk0UX6n7ZU/zopPXr6PKobYa2a3Iq2Rp8tDw+eENla2m12MDSZ4faRd4H3hpuBhYk
         5NIQ==
X-Gm-Message-State: AOAM5306aC765ZVteq6jD6AHf3rrC6JKtdGbDfaptyVf+G85YhxF7aEV
        yh3j5b9mNjt33YDb13u/5QmW5Wt+fVBTng==
X-Google-Smtp-Source: ABdhPJxpqNvPHrUHyK30bG0j5oRR2jacUFrB3hQTM7iLqi7aQPjdW63F4cb7BeTtWEIi/Dy2LE0M4Q==
X-Received: by 2002:a62:e40c:0:b029:18b:ad5:18a8 with SMTP id r12-20020a62e40c0000b029018b0ad518a8mr13031205pfh.16.1604523270455;
        Wed, 04 Nov 2020 12:54:30 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b2sm3018776pgg.2.2020.11.04.12.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 12:54:29 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e10=2e0?=
 =?UTF-8?Q?-rc2_=28block=29?=
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <cki.1EF86A56CB.4YRW9Z76J1@redhat.com>
 <803534645.17398688.1604520746475.JavaMail.zimbra@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <49725ea8-e7d0-3e9f-a2f4-1a417ad34e9f@kernel.dk>
Date:   Wed, 4 Nov 2020 13:54:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <803534645.17398688.1604520746475.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/20 1:12 PM, Veronika Kabatova wrote:
> 
> 
> ----- Original Message -----
>> From: "CKI Project" <cki-project@redhat.com>
>> To: linux-block@vger.kernel.org, axboe@kernel.dk
>> Sent: Wednesday, November 4, 2020 9:07:37 PM
>> Subject: ❌ FAIL: Test report for kernel 5.10.0-rc2 (block)
>>
>>
>> Hello,
>>
>> We ran automated tests on a recent commit from this kernel tree:
>>
>>        Kernel repo:
>>        https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>             Commit: 31823cc0ea9c - Merge branch 'for-5.11/io_uring' into
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
>>   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2020/11/04/616937
>>
>> We attempted to compile the kernel for multiple architectures, but the
>> compile
>> failed on one or more architectures:
>>
>>            ppc64le: FAILED (see build-ppc64le.log.xz attachment)
>>
> 
> Hi,
> 
> on the first look this seems to be introduced by
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=23209e3dc23c8422e670472ebdd1cc349879a64c
> 
> 
> For convenience here's a direct error from the logs:
> 
> 00:02:10 In file included from fs/io_uring.c:45:
> 00:02:10 ./include/linux/syscalls.h:238:18: error: conflicting types for ‘sys_io_uring_enter’
> 00:02:10   238 |  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
> 00:02:10       |                  ^~~
> 00:02:10 ./include/linux/syscalls.h:224:2: note: in expansion of macro ‘__SYSCALL_DEFINEx’
> 00:02:10   224 |  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> 00:02:10       |  ^~~~~~~~~~~~~~~~~
> 00:02:10 ./include/linux/syscalls.h:218:36: note: in expansion of macro ‘SYSCALL_DEFINEx’
> 00:02:10   218 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
> 00:02:10       |                                    ^~~~~~~~~~~~~~~
> 00:02:10 fs/io_uring.c:9135:1: note: in expansion of macro ‘SYSCALL_DEFINE6’
> 00:02:10  9135 | SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
> 00:02:10       | ^~~~~~~~~~~~~~~
> 00:02:10 ./include/linux/syscalls.h:318:17: note: previous declaration of ‘sys_io_uring_enter’ was here
> 00:02:10   318 | asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
> 00:02:10       |                 ^~~~~~~~~~~~~~~~~~
> 00:02:10 make[3]: *** [scripts/Makefile.build:283: fs/io_uring.o] Error 1
> 00:02:10 make[2]: *** [Makefile:1799: fs] Error 2

Yeah, the patch didn't modify the syscalls.h header... I'll get that fixed up,
thanks.

-- 
Jens Axboe

