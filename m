Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236CAC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 21:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DAF61350
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 21:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFUVP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUVP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 17:15:29 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB73C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 14:13:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a6so8878640ioe.0
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsePuKo4uH3x80SuzBhd6TEer+mGxacb4vKxlc6AQc8=;
        b=Wp4s/VFublRaEv/BIXJOj99JZuVySmzRHnN4iyXo8djxs0LQe+BV6ZbyrChmeH8lE8
         VxRpybFzzId+FIz4ZR91L46DJ2XUt3TsGZynheifDmPtrQZ6d+IAPMgqpeA4cXaEYMv9
         VEFdMbCkifzBWtpq0R7C9Rv+zW6wUFEiqgtBK3WjDSqrMDbw8UrWQwmno6fFeDgLGaT9
         w4N1QfyFg1dD6wGBaGxBYBOzTH6W47fZBNYpGAxrLflJ4WkminHzeYZF4YH8Ych+vqL1
         e20NLdkpd/1ci5pQOZ1dqUesK2WY4qc95rLRSzqLRYGf7a0Q8GhU7w2TWYgZItdmrAD5
         FG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsePuKo4uH3x80SuzBhd6TEer+mGxacb4vKxlc6AQc8=;
        b=eZ1X7K/gpFR/+rXW6brrckkpXMFwU0xPNyzIENB8WX3eVrQLvReJ9CYhzSdnbiAen9
         YtJ10Dqbsfoad262cpr5MPj+Qfr5P+FfIMGmpFSTNNfRosZYWb4G35vYL8IGWCvkthb8
         1JWk6lVBHyMlTCzIzEiKoToXLzaZir2nHK1OxRkUPIgoO1Otrx6AvCkNSS5QfoGeyXAB
         GKsAS261DLgJSzaY4CGobSgVbAWxySL/ZoVKz5OdKrl6B3lMhVQZbZ1V7LJV3+Nh9BtA
         z6+oqE0ppVp8BeWh3QMhHQsRuEW5P6nOZx6szhqSU4B4h7OvJOjiG0rAZFcruSpRSNgO
         Sw8A==
X-Gm-Message-State: AOAM531W+MzBZTkmLPyJvbJQF2ttDzSsE3xqyZ9UKZE+meW5CZJvwU4h
        zOTohUbz3885NFztxt/IOGHCgQ==
X-Google-Smtp-Source: ABdhPJxqMqnkXc+XkR+vZjvI98v2WwmOtZPDK63nnx5g9cLFY/g5JzL0+2/z1KFMXkq4vDBnmGZVug==
X-Received: by 2002:a05:6602:2587:: with SMTP id p7mr67012ioo.12.1624309994057;
        Mon, 21 Jun 2021 14:13:14 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id p9sm286666iln.38.2021.06.21.14.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 14:13:13 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e13=2e0?=
 =?UTF-8?Q?-rc6_=28block=2c_b0740de3=29?=
To:     Keith Busch <kbusch@kernel.org>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <cki.3F4F097E3B.299V5OKJ7M@redhat.com>
 <CA+tGwn=+1Evv=ZZmOdXSpfUTG_dPvHfDsxbmLyHWr9-XkXA1LQ@mail.gmail.com>
 <CA+tGwnn4J2=WuPEFOwmC6ph30rHXJLhjH-iWmvkKLpacmR7wdQ@mail.gmail.com>
 <42b91718-9d70-4e4c-2716-6259321abd64@kernel.dk>
 <20210621211030.GD1268033@dhcp-10-100-145-180.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fbce48d4-54c1-383f-0948-0c467a9500ab@kernel.dk>
Date:   Mon, 21 Jun 2021 15:13:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210621211030.GD1268033@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 3:10 PM, Keith Busch wrote:
> On Mon, Jun 21, 2021 at 03:00:48PM -0600, Jens Axboe wrote:
>> On 6/21/21 2:57 PM, Veronika Kabatova wrote:
>>> On Mon, Jun 21, 2021 at 9:20 PM Veronika Kabatova <vkabatov@redhat.com> wrote:
>>>>
>>>> On Mon, Jun 21, 2021 at 9:17 PM CKI Project <cki-project@redhat.com> wrote:
>>>>>
>>>>>
>>>>> Hello,
>>>>>
>>>>> We ran automated tests on a recent commit from this kernel tree:
>>>>>
>>>>>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>>>             Commit: b0740de3330a - Merge branch 'for-5.14/drivers-late' into for-next
>>>>>
>>>>> The results of these automated tests are provided below.
>>>>>
>>>>>     Overall result: FAILED (see details below)
>>>>>              Merge: OK
>>>>>            Compile: FAILED
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> the failure is introduced between this commit and d142f908ebab64955eb48e.
>>>> Currently seeing if I can bisect it closer but maybe someone already has an
>>>> idea what went wrong.
>>>>
>>>
>>> First commit failing the compilation is 7a2b0ef2a3b83733d7.
>>
>> Where's the log? Adding Willy...
> 
> I think the result was from 1f26b0627b461. There's an implied header
> inclusion order such that linux/fs.h must be included before
> linux/fileattr.h. The reported error for fs/orangefs/inode.c had been
> getting the inclusion correct by chance through:
> 
>   linux/bvec.h
>    linux/mm.h
>     linux/huge_mm.h
>      linux/fs.h
> 
> 7a2b0ef2a3b83733d7 replaced bvec.h's mm.h inclusion with mm_types.h, so
> now orangefs.h doesn't have the inclusion order correct anymore.
> 
> But we usually don't like inlcusion order dependencies in kernel, so I
> think linux/fileattr.h needs to directly include the files it depends
> on.
> 
> ---
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index 9e37e063ac69..34e153172a85 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -3,6 +3,8 @@
>  #ifndef _LINUX_FILEATTR_H
>  #define _LINUX_FILEATTR_H
>  
> +#include <linux/fs.h>
> +
>  /* Flags shared betwen flags/xflags */
>  #define FS_COMMON_FL \
>  	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
> --

I found the error and came to the same conclusion as you. That's always
the worry with patches like this, that some unrelated implicit include
gets broken.

FWIW, I just dropped the bvec patch. We can try again when the orangefs
-> fileattr.h dependency is fixed.

-- 
Jens Axboe

