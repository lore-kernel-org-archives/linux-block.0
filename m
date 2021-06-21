Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7ACC48BE5
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 15:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D196113E
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 15:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFUP3a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhFUP33 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 11:29:29 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79027C061756
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 08:27:14 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id z1so5712813ils.0
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8MsMwreI693eD5gNSmDYbmS+b6b+rovuZ4aY3kOfDRI=;
        b=ixRTT9jeggvOgk3bUvBPWhoQ3EEOsxOIFnAJg+eff+mAIKbyS6qga50TDSzWSz2vNs
         rbPTh74IMiqLGAlzHzPu8sq816CreKlI5CCCcWoLO/8Mtc0hRjibYt/1XRN4aEsSW9kk
         QAyLmW3waB9jvbyx8My585dSI9td3fWZR5JhxFHLvmnU/80OTEYOAyXWmJV7fEt46SHC
         bFEoi/SH6G49VqNmcgPaAZi41jZsE2BkhTEJ6waCXWELX0JyHiCJUaj3WaWt8QweLWn2
         COLUF/6HpRQTZPwrkGu92RCb1w8S1hB8f8ncJuBDC45KY5NIA4cRhmYNffWbxcNMpKFk
         uKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8MsMwreI693eD5gNSmDYbmS+b6b+rovuZ4aY3kOfDRI=;
        b=fViMotZR4qvSpgki8xgXJjAPl+HzvIIY4+ze9GoNZo1AIJmQUy68MjCFGLGEBYklA5
         YIWevOGee5eApZ8ur4IzPUpmFBo4xRBqXJXDWXmiK61+y1tzVFBQBoixONDVMQVjX+ZE
         w7hAefaUt9FoPBcebNpQBvzcEy0abzFnv4PSfQMwcHzao9+OoZZFDV2TLRZBn16Yt9UI
         ZCKayIgMH86ynnrVtnSsYC2TeKRG9K5GpRyIb4d2jmJKLXHKv9hfoQKhmtAmkgAAk5pi
         wGQhArorRJ/TijnPRq90g78hKeaqkybUrjdGBCHCrmAoHSiicdUt5z4DP8BW7z5R9xk0
         8WUA==
X-Gm-Message-State: AOAM53372VoCwpw8fHJVpJmQ3PSdxbdeWQL+Br7+a70GvjRBFovq6nuY
        8UiVZMs5RjdxyccUI0UwhsPR6USCpGAIyQ==
X-Google-Smtp-Source: ABdhPJyYaCjd+F9CzL3X6EKhyC0mllZtYHV6vfXR7MOD2yr1QQEKY7GuliQsJwBgHV6PpYFWsWfS/Q==
X-Received: by 2002:a05:6e02:972:: with SMTP id q18mr587023ilt.88.1624289233601;
        Mon, 21 Jun 2021 08:27:13 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 14sm6355650ilx.61.2021.06.21.08.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:27:13 -0700 (PDT)
Subject: Re: [PATCH 00/14] bcache patches for Linux v5.14
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20210615054921.101421-1-colyli@suse.de>
 <cb427b5f-8e55-bed2-1e3d-7382a092d4a0@kernel.dk>
 <02e126b9-f4a8-8034-8c78-d06a3dc41acf@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c05dd81e-0222-62c9-8e52-aee02fa9abb9@kernel.dk>
Date:   Mon, 21 Jun 2021 09:27:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <02e126b9-f4a8-8034-8c78-d06a3dc41acf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 9:25 AM, Coly Li wrote:
> On 6/21/21 11:14 PM, Jens Axboe wrote:
>> On 6/14/21 11:49 PM, Coly Li wrote:
>>> Hi Jens,
>>>
>>> Here are the bcache patches for Linux v5.14.
>>>
>>> The patches from Chao Yu and Ding Senjie are useful code cleanup. The
>>> rested patches for the NVDIMM support to bcache journaling.
>>>
>>> For the series to support NVDIMM to bache journaling, all reported
>>> issue since last merge window are all fixed. And no more issue detected
>>> during our testing or by the kernel test robot. If there is any issue
>>> reported during they stay in linux-next, I, Jianpang and Qiaowei will
>>> response and fix immediately.
>>>
>>> Please take them for Linux v5.14.
>> I'd really like the user api bits to have some wider review. Maybe
>> I'm missing something, but there's a lot of weird stuff in the uapi
>> header that includes things like pointers etc.
>>
> 
> Hi Jens,
> 
> As I explained 2 merge windows before, we use nvdimm as non-volatiled
> memory, that is, the
> memory objects are stored on nvdimm as memory object which are
> non-volatiled. This is why
> you see the pointers in the data structure, e.g. the list is stored on
> NVDIMM area, and the code
> goes through the list directly on the NVDIMM, we don't load them into
> memory.
> 
> This is not block device interface.

Right, and I'm not oblivious to those emails. What I'm saying is that
we need more review of that, so far it seems to stand unreviewed.

> I try to ask Dan Williams, Jan Kara, Christoph Hellwig and Hannes
> Reineicke to help to review,
> hope there are some experts may help to take a look.

That'd be great.

-- 
Jens Axboe

