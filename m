Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20915C76191
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 13:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6D420C01
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 13:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cUndtAoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfGONwy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:52:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33921 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731752AbfGONwy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 09:52:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so7460069pfo.1
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0V2mBu6FYx4cMtcSGcye6x8Ut9HBWrXqdo4bnPYOIBs=;
        b=cUndtAoSclRDbi4ERxPslBm1nkQDppOdNGhxE981ZEXGpiKVSRFJIlaLXECLEL3Ubh
         ohJ3Pf8kbht/nNWEqDXT7y1gF6R9XXj2kE6RX8fWIms/RLLlGV1xLY69G8yHgRILa2aE
         CBuGwwQ45KhvV1xZUSyRN/d1l3yBNOTqvzjgV5wm1f+i00TFNzxE1ogSBj9l7P1poNpS
         klRO0VZsemeXeOPNTR8emPzZCHvqsCDzvLyFD2vaIePsD5J6EevnRgs2rM/i1UJVlA7l
         +Vw0+821CZhGHIpPZAY8oUak1vbyhi/liTNOdm8nlDyIJ/UN97bt73kEf2ByeSaO/IT9
         JpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0V2mBu6FYx4cMtcSGcye6x8Ut9HBWrXqdo4bnPYOIBs=;
        b=KTxMzYzG57UiBDiRzM2H85FTCf4tgR4fNJZlAjyrfUQh3NhUGiPDd/8nTwmryhW+L1
         UinYNt+iAzFYJj1DdSVJbkj6r730ygoknRNFmYW7Xbf4OYPUEnHb5CT25EE+yD+WAhgE
         qBSMQlNW4NnM9d5314Yy3MOjIUO12ZxMyq0tyvbCzCNIvEkf/6a5BUW+EPxjH+P22MEy
         /2PD7UBIkUjbPlGPAfBJhZVjAetp8pmaXWLz1hLUvkgriqSdWHgDNuPPvgXnijxTeTcr
         JtulZlo+oX5ROB/oh9cePL4qImRkBA8WSqFSgSOwiTy09tY1i2cRVX4tPGKzP82Yiptr
         rfKQ==
X-Gm-Message-State: APjAAAXOoZp1V5QdzlHtmCu0Sx03lshaKd8HMLuCfijqS+DORVOxl4LC
        4kyM4Bxecpfcdq2TfK5jktFx0JjNzGk=
X-Google-Smtp-Source: APXvYqyLNq4KfSGcXgpn7eFfD+z+OJ2JwfO3jE4cBLjuHsjPwZ1D3gXdq/76icRxJMChD7z5x6g//w==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr27167050pgm.21.1563198773049;
        Mon, 15 Jul 2019 06:52:53 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id v22sm16379992pgk.69.2019.07.15.06.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 06:52:52 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: use kmem_cache to alloc sqe
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20190713045454.2929-1-liuzhengyuan@kylinos.cn>
 <1f56dacc-6f69-35ff-dfb9-0b3e91696e36@kernel.dk>
 <5d2bf52d.1c69fb81.af3a2.b57fSMTPIN_ADDED_BROKEN@mx.google.com>
 <BD843851-A62C-4368-A78B-F863A72E589C@kernel.dk>
 <5d2c1314.1c69fb81.ecfb1.bf96SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6059ea46-b87f-e8e9-5e41-47b77f4c4c60@kernel.dk>
Date:   Mon, 15 Jul 2019 07:52:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5d2c1314.1c69fb81.ecfb1.bf96SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/19 11:45 PM, Zhengyuan Liu wrote:
> 
> On 7/15/19 11:51 AM, Jens Axboe wrote:
>> On Jul 14, 2019, at 9:38 PM, Zhengyuan Liu <liuzhengyuan@kylinos.cn> wrote:
>>>
>>>> On 7/14/19 5:44 AM, Jens Axboe wrote:
>>>>> On 7/12/19 10:54 PM, Zhengyuan Liu wrote:
>>>>> As we introduced three lists(async, defer, link), there could been
>>>>> many sqe allocation. A natural idea is using kmem_cache to satisfy
>>>>> the allocation just like io_kiocb does.
>>>> A change like this needs to come with some performance numbers
>>>> or utilization numbers showing the benefit. I have considered
>>>> doing this before, but just never got around to testing if it's
>>>> worth while or not.
>>>> Have you?
>>> I only did some simple testing with fio. The benefit was deeply depend on the IO  scenarios. For random and direct IO , it appears to be nearly no seq copying, but for buffered sequential rw, it appears to be more than 60% copying compared to original submition.
>> Right, which is great as it’s then working as designed! But my
>> question was, for that sequential case, what kind of speed up (or
>> reduction in overhead) do you see from allocating the unit out of
>> slab vs kmalloc? There has to be a win there for the change to be
>> worthwhile.
>
> Thanks for your comments  Jens. No speed up indeed in overhead from my
> testing.

Then I suggest we just drop this change, it only makes sense if there's
a win.

-- 
Jens Axboe

