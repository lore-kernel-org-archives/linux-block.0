Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A3C63777
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 21:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A45A20857
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 21:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KZ5COwAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgK3Vo3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 16:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730238AbgK3Vo2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 16:44:28 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92331C0613CF
        for <linux-block@vger.kernel.org>; Mon, 30 Nov 2020 13:43:42 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b63so11272175pfg.12
        for <linux-block@vger.kernel.org>; Mon, 30 Nov 2020 13:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QYKyD+mX4oh/OFfRWY8Y0OVNQZYNR7xfZGkF6RPVes4=;
        b=KZ5COwAXLSD/1LRbXb38EeI9c0h3B9WZyYqKeavVG3h91Km6H+UAdbtgb6Sh9lMEcN
         TKcSSvatHMAwJNP8pEXF1TUtS3v7T2kDwbBENJ1Dzo2vpvoKUr3y614Gaywsoei4wjHU
         cf0bpeqND/rciyMy7oS5BfIgpKx0isVeikrHXlPgmQkLCflpuDCy7J7wWmM61vPy6Wp+
         HJv5Kq8kiMfg4ZDYF3uEBHL5P3znXTEUrOPcUqXCrivxn/tBEeMK2xQytGJzyQQRx/i1
         VcMzRGet2Hn2LiKt9aTW2B9VATeFhaFDIo39IB/VMb0YjS6RAsVpTVRzRPzYwdrsXtQZ
         sBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QYKyD+mX4oh/OFfRWY8Y0OVNQZYNR7xfZGkF6RPVes4=;
        b=Xc07KzdfmbP1Nn0IbHXbmUj5iKzTFKo4ESFWbRtNxi9hMhPHE5g8tezMu65nzQVoGF
         AYFd6m1IjkoF2Cb0I34pN25D22Z0pumTr3mucaQ3pf3HWg43LjmhmDZinY6ogcrVApjN
         8wpzVOXBpTMMvz2Y5V5oSMp8AktaCgK1nAVeizITOsf7ZItZDkD4avCPK0Ty8mE/B5Tl
         7YaAkoQl+gjTBRa4/kDfQXKVxnwnoiUqd5dGe0J1rWbtnPgqag9qQ/MobSYGc86fGLLN
         kjGk4ovvO2nEuNNyam4ZJkjhHku/TnOcOz27vPay1KkEhBhwuPXhFw+8w97td4f2Ab7O
         DLsw==
X-Gm-Message-State: AOAM532hMAmdwTjtlyqLzIavjEljyiuVKOd5+OndH50zWrvQNV6kjfml
        5N14UD9mbXh/KxUyPvDfeKXnCGIDl5X0Qg==
X-Google-Smtp-Source: ABdhPJxJ9dqiIbb7LSWmqMTV9YCDGHnQOZsFwWZIidxL93PdvNbB/kc5JNct391jyTomO8AOByK8fg==
X-Received: by 2002:a05:6a00:1506:b029:18b:5a31:ed87 with SMTP id q6-20020a056a001506b029018b5a31ed87mr20463733pfu.55.1606772621685;
        Mon, 30 Nov 2020 13:43:41 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j10sm415616pji.29.2020.11.30.13.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:43:41 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e10=2e0?=
 =?UTF-8?Q?-rc5_=28block=29?=
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <cki.DBF986CEF7.1DN2XEHOVP@redhat.com>
 <1212579999.19835613.1606764592454.JavaMail.zimbra@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d4ac316e-728a-f048-7b9c-96afc4dba9c3@kernel.dk>
Date:   Mon, 30 Nov 2020 14:43:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1212579999.19835613.1606764592454.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/20 12:29 PM, Veronika Kabatova wrote:
> 
> 
> ----- Original Message -----
>> From: "CKI Project" <cki-project@redhat.com>
>> To: linux-block@vger.kernel.org, axboe@kernel.dk
>> Sent: Monday, November 30, 2020 8:27:49 PM
>> Subject: ❌ FAIL: Test report for kernel 5.10.0-rc5 (block)
>>
>>
>> Hello,
>>
>> We ran automated tests on a recent commit from this kernel tree:
>>
>>        Kernel repo:
>>        https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>             Commit: cd8ae268840e - Merge branch 'for-5.11/block' into
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
>>   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2020/11/30/618887
>>
>> We attempted to compile the kernel for multiple architectures, but the
>> compile
>> failed on one or more architectures:
>>
>>            aarch64: FAILED (see build-aarch64.log.xz attachment)
>>            ppc64le: FAILED (see build-ppc64le.log.xz attachment)
>>              s390x: FAILED (see build-s390x.log.xz attachment)
>>             x86_64: FAILED (see build-x86_64.log.xz attachment)
>>
> 
> Hi,
> 
> looks to be introduced by
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=1076736138841d8516555f352ae0426a99ae9f92

I also ran into this:

block/genhd.c: In function ‘part_fail_show’:
block/genhd.c:1250:48: error: ‘struct block_device’ has no member named ‘make_it_fail’; did you mean ‘bd_make_it_fail’?
 1250 |  return sprintf(buf, "%d\n", dev_to_bdev(dev)->make_it_fail);
      |                                                ^~~~~~~~~~~~
      |                                                bd_make_it_fail
block/genhd.c: In function ‘part_fail_store’:
block/genhd.c:1261:4: error: ‘struct block_device’ has no member named ‘pdev’
 1261 |   p->pdev->bd_make_it_fail = (i == 0) ? 0 : 1;
      |    ^~
block/genhd.c: In function ‘part_fail_show’:
block/genhd.c:1251:1: error: control reaches end of non-void function [-Werror=return-type]
 1251 | }
      | ^

Christoph, I've dropped this series.

-- 
Jens Axboe

