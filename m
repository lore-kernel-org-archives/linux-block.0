Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A40C48BE5
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0624611BD
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhFUXi4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhFUXi4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 19:38:56 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87066C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 16:36:41 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z1so6928301ils.0
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 16:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R8HewhX9gzOhR/rWnpjGADioj5jaW4KgzYaVpYb0mzc=;
        b=1Yi5JgU00FSr4eSqYIHZ5k6MYcZ5mNqc7ul7gBpGnDnTUyjKf7Uo4PXOYif51xNGF8
         o3vq93Yy5J3HqVmMxR3eu3xhpvYNVYhjxcwP1REHq10hx62ReqN4h7hyx7WtuTCM4oHk
         la2auIml/xinGW4Ye8QEu1FeNQuMTaErNpYjrG266t8dFZZWnGEdkfYkAOm3zNldazJV
         /U70fvRyk1BeRMRssWmy/3zJtsFpjgFJhgsvKVFxYTbwXYJVZkGpc64CiNlYjuKi/00+
         S5WuOAo0vl8WXkm7q8e/XTHQ5iptyuyc4xDkLlWve62AVs3/nWp9weVPQqpuDdWazw+t
         EUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R8HewhX9gzOhR/rWnpjGADioj5jaW4KgzYaVpYb0mzc=;
        b=Xz5rD4P9yOWVxefWyAL68yMkHsn+oCc65bl3QqtSdoY3sXeaLoYIG7sxba+wkxlooW
         0I7loGboUvKKx7np9R8iYEIf6W9klu8fI6st+B4mTprQ0dnA5Vl6j/oDIoggqggXLa/h
         asJKUPl9m//ZsG5kjMCDG7onLgcEDEKiibKoCM+5YowpBiRdkyI6WObAoxrqKAeBMDxJ
         mY++HNV/YQorxwKNaHD8DJ9j8DP+X1lauNBso3mtJ5nLgNpR4gwxxJfCYfIH8BckzDz3
         d/t8JRNRoeKBWVA5IEbNK2rRF5GKBvYQEWd7Pq9WGU2GCzzD+NTioN8wf//ko806Qc+F
         Si3w==
X-Gm-Message-State: AOAM531CU2OmCF6piM18uGExVY0r4Y1rpB/WHmeGjgpavBuzoVU/8ohL
        csdDX8xtjcQmxN6/UUh8lKDwpdriHZrH/g==
X-Google-Smtp-Source: ABdhPJxCAxRHfUG4kLCH6mP+EkAs9PSEOAAb2/VjdVs1e6uupXrN48T7HSU7FFVjj6DZNN9/YCJwTQ==
X-Received: by 2002:a92:2a05:: with SMTP id r5mr485732ile.69.1624318599316;
        Mon, 21 Jun 2021 16:36:39 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id d10sm7099193ilc.71.2021.06.21.16.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 16:36:38 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e13=2e0?=
 =?UTF-8?Q?-rc6_=28block=2c_b0740de3=29?=
To:     Matthew Wilcox <willy@infradead.org>,
        Veronika Kabatova <vkabatov@redhat.com>
Cc:     CKI Project <cki-project@redhat.com>, linux-block@vger.kernel.org
References: <cki.3F4F097E3B.299V5OKJ7M@redhat.com>
 <CA+tGwn=+1Evv=ZZmOdXSpfUTG_dPvHfDsxbmLyHWr9-XkXA1LQ@mail.gmail.com>
 <CA+tGwnn4J2=WuPEFOwmC6ph30rHXJLhjH-iWmvkKLpacmR7wdQ@mail.gmail.com>
 <42b91718-9d70-4e4c-2716-6259321abd64@kernel.dk>
 <CA+tGwn=8KMpRi+6M-Lcs5MjKTkPd36YL5wv84Ji2dEWLjzfDmA@mail.gmail.com>
 <YNELoqls01MVLsuT@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d50f6e4-330f-cc5e-94cb-ecc957707c0e@kernel.dk>
Date:   Mon, 21 Jun 2021 17:36:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YNELoqls01MVLsuT@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 3:58 PM, Matthew Wilcox wrote:
> On Mon, Jun 21, 2021 at 11:07:16PM +0200, Veronika Kabatova wrote:
>> On Mon, Jun 21, 2021 at 11:00 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 6/21/21 2:57 PM, Veronika Kabatova wrote:
>>>> On Mon, Jun 21, 2021 at 9:20 PM Veronika Kabatova <vkabatov@redhat.com> wrote:
>>>>>
>>>>> On Mon, Jun 21, 2021 at 9:17 PM CKI Project <cki-project@redhat.com> wrote:
>>>>>>
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> We ran automated tests on a recent commit from this kernel tree:
>>>>>>
>>>>>>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>>>>             Commit: b0740de3330a - Merge branch 'for-5.14/drivers-late' into for-next
>>>>>>
>>>>>> The results of these automated tests are provided below.
>>>>>>
>>>>>>     Overall result: FAILED (see details below)
>>>>>>              Merge: OK
>>>>>>            Compile: FAILED
>>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> the failure is introduced between this commit and d142f908ebab64955eb48e.
>>>>> Currently seeing if I can bisect it closer but maybe someone already has an
>>>>> idea what went wrong.
>>>>>
>>>>
>>>> First commit failing the compilation is 7a2b0ef2a3b83733d7.
>>>
>>> Where's the log? Adding Willy...
>>>
>>
>> Logs and kernel configs for each arch are linked in the original email at
>> https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/06/21/324657779
> 
> Which aren't there by the time they get to the original commit author.
> You need to do better than this; the Intel build-bot bisects to the
> commit which actually causes the error.

If you'd actually read the email you're replying to, the commit is right
there:

First commit failing the compilation is 7a2b0ef2a3b83733d7.

-- 
Jens Axboe

