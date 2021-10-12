Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2C6C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A4B60EDF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhJLSaw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhJLSav (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:30:51 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8EFC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:28:50 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p68so24762394iof.6
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jl6QqHUaTcpCpMqRmMMvjEQrga2X0pDjOJpFwkDO/uE=;
        b=Q/ywDkfD+etlXODme3dEw/WUzQPGBqyEkP6kdxx/pNVgnLCnLIejjfOCURlPB/5m7i
         sZa2XZqbiaH9veAi3ZwAfAyqKr8gjJ4INDJGd2QO6XHWILbK/troHxd9d/VhrL9snCxC
         do41BsG8fmOhOOjwJlc8Rk8tjBh/3+Ii6yXsRfDMn09irT3e4GHmcWP3jUZz7GzNLXJm
         RvRa/gGR3ZdLC7ZWIx0YOTBzVbxIb39HaVtZ/d4RK5AUxyCPuGxqecj6s9x8hrzxA6E+
         mNMEMFxxrFVRyo9rDIgXa80V5AcBuGEv4rBBHiBYlPDtIzzvDQq+iHOdV9NCmqGj9RDd
         SbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jl6QqHUaTcpCpMqRmMMvjEQrga2X0pDjOJpFwkDO/uE=;
        b=1EngtJMYVeXPmHckfzEq0+FUHiFDSkPHWTf1Wh81n+1FhcIyzij3E0rrwfki1q5bQC
         BeusrIDKd03pXzWeNFLoqdmh5PfApIs8PHJRQEljNkuIKnTXNwMyir53ZA0+4pHGHz+P
         fivY154eNn9ZL2aYiHp/7ItJLKn6I1uIDyV8EMsi6mGm3SoGMoETaww4WByr7dq/Y+zh
         FTz4IA67iAXa/SqWKYjkZGMDfb0/anHxL7sCYOYuFEE1dM5uzaPVs6vqvEoH16rgJpl7
         wgGjzyqF4ha3rcrKZOeBFRbYWm2Mwji+IXBu4HlvRhyEQSdUzy7IOnxeit78mmxQMk32
         nMeA==
X-Gm-Message-State: AOAM533E1J/dSou+CHXhACaRECsJIAp+7TQVpGaa4ImJsWT9Bl9iS9lI
        5RnI2wb4by1OroPrxs7kDkEGE9P6+7Ea/w==
X-Google-Smtp-Source: ABdhPJz3IR0K+/BsAQZuJr985ysi1SIXwo7pxXOsAknR7SEunS29sW7mp03Ufj0Jzq6Bow/hCZGzQg==
X-Received: by 2002:a05:6638:3809:: with SMTP id i9mr11237657jav.115.1634063328884;
        Tue, 12 Oct 2021 11:28:48 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k4sm5876464ilc.10.2021.10.12.11.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:28:48 -0700 (PDT)
Subject: Re: [PATCH 1/9] block: add a struct io_batch argument to
 fops->iopoll()
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-2-axboe@kernel.dk>
 <e98ae0de-1e0b-7b69-09c5-ce1cc54866a8@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b49cc5c1-cea0-bd91-7df5-4de254604891@kernel.dk>
Date:   Tue, 12 Oct 2021 12:28:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e98ae0de-1e0b-7b69-09c5-ce1cc54866a8@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 12:25 PM, Bart Van Assche wrote:
> On 10/12/21 11:17 AM, Jens Axboe wrote:
>> -int bio_poll(struct bio *bio, unsigned int flags)
>> +int bio_poll(struct bio *bio, struct io_batch *ib, unsigned int flags)
>>   {
> 
> How about using the name 'iob' instead of 'ib' for the io_batch 
> argument? When I saw the 'ib' argument name that name made me wonder for 
> a second whether it is perhaps related to InfiniBand.

Sure, I don't care too much about that, I can make it iob instead.

>> +struct io_batch {
>> +	struct request *req_list;
>> +	void (*complete)(struct io_batch *);
>> +};
> 
> Function pointers are not ideal in high-performance code. Is there 
> another solution than introducing a new function pointer?

You're going to end up with an indirect call at some point anyway, as
the completion part would be driver specific. So I don't think that's
avoidable, it's just a question of where you do it.

-- 
Jens Axboe

