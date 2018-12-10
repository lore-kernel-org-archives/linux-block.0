Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37774C04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 22:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5F120821
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 22:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m0w09EVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5F120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeLJWJz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:09:55 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:37862 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeLJWJy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 17:09:54 -0500
Received: by mail-pl1-f171.google.com with SMTP id b5so5897238plr.4
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 14:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zj9x5nVwnJTtwkTlaUaXBgMO76UMvWgXNMN82MIqyw4=;
        b=m0w09EVgA+1ZTmNaj5aXnbzpVm5qlpWgIUD9H5YJsxrVtIhRZq8FLhisVj0XTv66HE
         ycq0KjV6ILK/XGc3/puP7FXvsXYU9ljjch9NZYP15Lr+Enf21Pp2XfNRWHuj4CNqxnjr
         TSd5vBULx2GGJXKxZsVMd/pIpEOPkbLx5sq14BPz7+cL4Gv7nABwn/I2VD8Dx663YPAx
         3vlussb12ssbm+MjxdNcNV/N983+G2pvHBEobV1DMEyJyPzkaMom+DZ6ePRGDR+JvAG6
         ET2G1E3HDUArj48qMN4BkuUCvjxn84kebMZ8VDE2yIH1HLUA9fcx8pdqfK498gq1tV6u
         YMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zj9x5nVwnJTtwkTlaUaXBgMO76UMvWgXNMN82MIqyw4=;
        b=jdn+YDsWyDzEHUig3BGfXlwN1gGgS6H2J7HWmC21vfO6CueHayT88ybfyHHIcgrxrS
         YrxU8duFFdbPHgQYZzjq6kRx0Ri6DyYPQyH08D0axL5hiblWthHdfRoedG1r36+bVG+n
         za26+Vak/AzIPNqlJEubCr4c6ecYcAkD5s3ATGWOHfCrrDEZ6FyEA8lwukdMhL5TWJAo
         fpaSKrj5d1ld8pZtgGimtLhTq5sfOtQdk53MlRiUbMyuoOAH2Q/mf+ph3mTOgyRBrRoW
         7xSxVcDzBakqJLcnX+a2RKqN3W7w+pIUPW+qm0FIBuqSJ6ktx6Y7/5QenGgXvHvU4rik
         DZ4w==
X-Gm-Message-State: AA+aEWYdH2HSSoZlzPV2MtL7nZ+1/z/UVljjjBNRrGpk6NYkawdrU6E8
        J4RzIzmZk0h/0Xo73mjoIZxOzA==
X-Google-Smtp-Source: AFSGD/UYO8hmsE09P337mETCFTTcxKUKoNN/VBlbzKREooxn54bMXPAlr6Sw4PvE04bJCf3/lV7VCg==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr13621447plq.84.1544479794285;
        Mon, 10 Dec 2018 14:09:54 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s190sm16736876pfb.103.2018.12.10.14.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 14:09:53 -0800 (PST)
Subject: Re: xfstests generic/347 seems unhappy on todays block for-next tree
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     snitzer@redhat.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <20181210213724.GA27905@infradead.org>
 <f7854d23-cba0-d5ce-e136-6cacd052a6da@kernel.dk>
 <20181210215356.GA20174@infradead.org>
 <695940bb-3783-c8f6-6747-dfd548df7ca7@kernel.dk>
Message-ID: <d3939eed-d2cc-d247-ffbc-117fbae74118@kernel.dk>
Date:   Mon, 10 Dec 2018 15:09:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <695940bb-3783-c8f6-6747-dfd548df7ca7@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/18 3:00 PM, Jens Axboe wrote:
> On 12/10/18 2:53 PM, Christoph Hellwig wrote:
>> On Mon, Dec 10, 2018 at 02:39:39PM -0700, Jens Axboe wrote:
>>> On 12/10/18 2:37 PM, Christoph Hellwig wrote:
>>>> This test is described as:
>>>>
>>>> # Test very basic thin device usage, exhaustion, and growth
>>>
>>> Does that tree have:
>>>
>>> commit c616cbee97aed4bc6178f148a7240206dcdb85a6
>>> Author: Jens Axboe <axboe@kernel.dk>
>>> Date:   Thu Dec 6 22:17:44 2018 -0700
>>>
>>>     blk-mq: punt failed direct issue to dispatch list
>>>
>>> ?
>>
>> yes.
>>
>> The latest commit is 6f75723190d88e1319bea623bfe0292bf3917965
> 
> Reproduces here, guessing it's the inflight counters... Trying without.

Yep, works without the inflight changes. Deferring to Mike to sort
this one out.

-- 
Jens Axboe

