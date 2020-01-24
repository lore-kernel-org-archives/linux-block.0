Return-Path: <SRS0=eyh1=3N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE67BC35240
	for <linux-block@archiver.kernel.org>; Fri, 24 Jan 2020 01:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91A12087E
	for <linux-block@archiver.kernel.org>; Fri, 24 Jan 2020 01:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fzaaW/KZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgAXBOZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:14:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40117 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbgAXBOY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 20:14:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so145627pgt.7
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2020 17:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d/C7aUYJTHQhwaao3+gD60wS4QAXQx/hM6I1wIffSJs=;
        b=fzaaW/KZ9B8G71DauBM19VGPslUtbmlIYJKyYq7ZLBp7hAgRlB8x5Nt5mAK2+ai8xZ
         ktZ2YPKJ5HoZIJVecr2xPjPLbKnpZ8ZENdvMQjXVDQect5BUXD2amTQp8Z60i5u10MGu
         Vyvqg6hqC/jgdKlZ2bubRyMekAOoUL7wBvWrwt2FHGxVhXbGa3lc58JgfEUju1u17imP
         BtZll8y4O7yvc+CtBnQn0IMnKxQKMLTMOhl4XQ7cR/bLcWpclAQiMZ07lHmAFvCeXemH
         dpdmybADm8KYCBhH/EMneVoXA7fJLK6rmPKuL3Hx+yeb/w3THHLVPKiYNCnOvml21KJT
         Khmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/C7aUYJTHQhwaao3+gD60wS4QAXQx/hM6I1wIffSJs=;
        b=UKLybPPqvEocYpfRFOcoi8/gNkdvBSLZLWxQheUKy1uiPteREbsoS9eRqDXMxgZ63J
         bgTryTwKbge8FNXDf0x2p4VQZVD/ebu7wwTxCzAEFGcC/798EpMPPwGGrXpsDCY9rCE0
         OvfZt6awe0MXxK/5UzGClCYxtfhWE7CNG7Zey0M9szVl3wrNzeUWuMvn8FMehwfu9Hi/
         sPkvh05H4HQuq6cpURG4uKFgpAZvfuNQqAOYXZMBlXORwq6QsM7DslBfapwSZxC3R2Cf
         1Cq06UaWymY8A836yjK6zq5zJeQV6e+TYhf4tWIMxeI/wxwJvXZOuOksSyn9oVcmQL0E
         /SKQ==
X-Gm-Message-State: APjAAAXw++b+Q3qH5mHIOCB8D7l3JyrKJPZK9d1XwN19GybNVZS9FG60
        7lXiRYwEdPNp3UIc8CGXmfKhwA==
X-Google-Smtp-Source: APXvYqx720e+PGy1MaQyQL/p07/L46E8myHpIewE7Rg1kzPHTOVVKdsC8DRLM0DeGQr+4z7FsjUojw==
X-Received: by 2002:aa7:9d87:: with SMTP id f7mr978368pfq.138.1579828463979;
        Thu, 23 Jan 2020 17:14:23 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id q6sm3770589pfh.127.2020.01.23.17.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 17:14:23 -0800 (PST)
Subject: Re: [PATCH 14/17] bcache: back to cache all readahead I/Os
To:     Coly Li <colyli@suse.de>
Cc:     Michael Lyle <mlyle@lyle.org>,
        linux-bcache <linux-bcache@vger.kernel.org>,
        linux-block@vger.kernel.org, stable <stable@vger.kernel.org>
References: <20200123170142.98974-1-colyli@suse.de>
 <20200123170142.98974-15-colyli@suse.de>
 <CAJ+L6qckUd+Kw8_jKov0dNnSiGxxvXSgc=2dPai+1ANaEdfWPQ@mail.gmail.com>
 <efdfdd2b-b22e-42d1-c642-6c398db6864c@suse.de>
 <31f7f6b4-98ea-3cf6-44cc-a9ba67484eb0@kernel.dk>
 <6373da22-9dc1-9525-4048-2c533407c917@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6d72473b-db79-d32a-055c-05a34f2d2b12@kernel.dk>
Date:   Thu, 23 Jan 2020 18:14:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6373da22-9dc1-9525-4048-2c533407c917@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/23/20 5:49 PM, Coly Li wrote:
> On 2020/1/24 2:31 上午, Jens Axboe wrote:
>> On 1/23/20 10:27 AM, Coly Li wrote:
>>> On 2020/1/24 1:19 上午, Michael Lyle wrote:
>>>> Hi Coly and Jens--
>>>>
>>>> One concern I have with this is that it's going to wear out
>>>> limited-lifetime SSDs a -lot- faster.  Was any thought given to making
>>>> this a tunable instead of just changing the behavior?  Even if we have
>>>> an anecdote or two that it seems to have increased performance for
>>>> some workloads, I don't expect it will have increased performance in
>>>> general and it may even be costly for some workloads (it all comes
>>>> down to what is more useful in the cache-- somewhat-recently readahead
>>>> data, or the data that it is displacing).
>>>
>>> Hi Mike,
>>>
>>> Copied. This is good suggestion, I will do it after I back from Lunar
>>> New Year vacation, and submit it with other tested patches in following
>>> v5.6-rc versions.
>>
>> Do you want me to just drop this patch for now from the series?
>>
> Hi Jens,
> 
> OK, please drop this patch from this series. I will re-submit the patch
> with sysfs interface later with other patches.

Sounds good, I queued up the rest for 5.6.

-- 
Jens Axboe

