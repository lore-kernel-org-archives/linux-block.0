Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7DFC433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 19:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0FF64E7A
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 19:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhBWTAP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhBWTAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 14:00:15 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48952C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 10:59:35 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id c10so4501063ilo.8
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HHkRV/Wgh7fayVlTIL0MFvIm+Er9szeil9uguqpBAyE=;
        b=lYhkqYIIcIinXxHad1MSuiMgRsyDju7Px8JCfveQaLb83OA5cU7tEOyqbPsbPvzuBb
         gg0BAnKKn5K5ntCluw1mnScL6emRt34VLGpVCCmDKmmMNgnEH9yRFVW5wMmSNrjFyKlE
         /dxgg97TpXv9h1myfl0wPuAge4jsCNWXjfZ8Izjvd1o4iud+gVdiApALg+UOqs36gcjx
         XUsE5TOqylcav5CRyVZQbdOVG477qHWcW84OFm84vFXCLm8di02hJ5f2nyT1OOBzTA1t
         fJ1ukhcLL8PVutlrMmGOqkMvXIKrSnKpYITqXQb3UGv81YVGPxjDgW84VGv+OpIl0WY3
         neiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HHkRV/Wgh7fayVlTIL0MFvIm+Er9szeil9uguqpBAyE=;
        b=K5rtvoJkWy/FBEWR00HHWgBbzqmpt7uDmjQIohu0we7LhIGoRDj2TUPMtcstT+y/TM
         yvPGO3nOVryW/3ZJ6g6Wv5qGuvDhVIeK1zeyrpd7KBp7uoBod6DpxoiWVavSnXHPSpQn
         fOpam3/i6cx+e5IN0593BBIKgcwR7Qnz0/WDcuOn5N76kgyEH5VfYXwsE08Hpgg4qWEw
         2l6tctGdESrV3Rqf15fONLXzyHzI7nKTNNCOPciwFIq4UsroQK/fR1FOufTgYJnkf8iP
         cVA7/KsqK9PGSC9bysI0smMdtIowLuXUKhvfMvPwAHX+1irwRdagDhVW7O/0Zu7YOLDm
         nJiA==
X-Gm-Message-State: AOAM532wPH1fqrZRZGjq8C8gktzeHRPjw9YEJ61LJ4Pook/vv9UuJd6H
        r7GQcTLOyGl1w9aYNlIXHZNEjQ==
X-Google-Smtp-Source: ABdhPJwusIJrWkcuUhVUTXapfg7qR9ME2iMtSe+VLW5/8YbEuNNLOb2etgETWNqWlsGK6S8EzRsotg==
X-Received: by 2002:a92:de4c:: with SMTP id e12mr13193456ilr.63.1614106774638;
        Tue, 23 Feb 2021 10:59:34 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q16sm15140139iod.34.2021.02.23.10.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 10:59:34 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e11=2e0?=
 =?UTF-8?Q?_=28block=29?=
To:     Bruno Goncalves <bgoncalv@redhat.com>,
        CKI Project <cki-project@redhat.com>
Cc:     skt-results-master@redhat.com, linux-block@vger.kernel.org,
        Guangwu Zhang <guazhang@redhat.com>, Lin Li <lilin@redhat.com>,
        Xiong Zhou <xzhou@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Zorro Lang <zlang@redhat.com>,
        Marco Patalano <mpatalan@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>, Al Stone <ahs3@redhat.com>,
        Fine Fan <ffan@redhat.com>, Jeff Bastian <jbastian@redhat.com>,
        Yi Zhang <yizhan@redhat.com>, Jan Stancek <jstancek@redhat.com>
References: <cki.1891A5313F.9U2FASPBG7@redhat.com>
 <CA+QYu4qihd=wkrknUjaLtGFa4AGpweMWL4Wg=ZPyn=_Mdsx_jg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e0146f1-fdf4-0727-87f2-dd057e8496a1@kernel.dk>
Date:   Tue, 23 Feb 2021 11:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+QYu4qihd=wkrknUjaLtGFa4AGpweMWL4Wg=ZPyn=_Mdsx_jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/21 6:36 AM, Bruno Goncalves wrote:
> Hello,
> 
> In this run a lot of tests failed due to a known issue with SELinux policy, but 1 failure reported on LTP io_uring01 test when running on ppc64le might be a kernel bug [1].
> Note the sefgault (io_uring01[138555]: User access of kernel address (c0000000005a0258) - exploit attempt? (uid: 0)) on console log [2] when executing the test. The test logs are [3].
> 
> [1] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/02/23/624525/build_ppc64le_redhat%3A1110530/tests/LTP/9600734_ppc64le_1_syscalls.fail.log
> [2] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/02/23/624525/build_ppc64le_redhat%3A1110530/tests/9600734_ppc64le_1_console.log
> [3] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/02/23/624525/build_ppc64le_redhat%3A1110530/tests/LTP/

That's my fault, for some reason I totally overlooked parisc and powerpc
in the PF_IO_WORKER change. Current for-next should work for you, this
is the change that fixes it:

https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-worker.v3&id=e4595c30ec3053a15d12615195b7a8726f9bee79

-- 
Jens Axboe

