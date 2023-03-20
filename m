Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BDAC7618A
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 18:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCTSMk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjCTSMU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 14:12:20 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5AC2F048
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 11:06:31 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s7so6895082ilv.12
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679335581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hy28s5e+5lLiy2thJ07AzA3cwAB50tsazdDOU9OI66A=;
        b=SglhudkIB0K/hSFVwxZDbRJKXH10PYJwuv4gcNXIm+ATMecwe1ww0uCGfISQeMS1Xn
         8Pn/d8vLVyDmSHst2cdAbdJRtMGTNwPgEA0raNPQ52vLpiCWAvPKFWMC6HJ8a21Xy1ak
         RJfdnGXbz30Qby1rTeC1Hz6XqxbiMAsKoj8zbYpkRzsazr6CKZzG1V3aATXu9GjwtjQ7
         nhD5qx+IT/QNDTRHm0p3rplgaBL3giiXlZtjXTpl8ycCQiMUCyMARR7NK1YG6r6RstCe
         R3B4dsfJFh7uiRFESoLG4jD8J4o6KUNSpzQ3zHSHgR9q6DUi63ryhjNhUEnAqH6ncH61
         5XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy28s5e+5lLiy2thJ07AzA3cwAB50tsazdDOU9OI66A=;
        b=NDBx5+NIziEA2KdXfMp13CR3Rc94YL19VqtXSGfSXo/vV3knWJDiL7by6504hx8Sln
         FPOmUFllQ9iYzMyiI5Q/y79GFNEr5kVPKLGUG0GB/1fcrDt+UWmFHTF4FWlhsTm1iHkc
         juiQooOaHUKBS/bueT7M3PD6aTgVdmhowa90X74S/sOSff4se+P4OtBzx3NjRwlvL+n5
         bXOR0BWjpfxLy7IDpDi6i24AkIqWsvdszUKxsX/i18MuVN+6zebm69g9CcYpy8/o/LYJ
         frpuLe3+Ac4YQ9syThC4Hr/wjflXIPeakEgCemtQO4Lnxsq64G2/MMRGdMWjF2csdRCm
         DSBA==
X-Gm-Message-State: AO0yUKWzoUhxqsQjj1bUBDkog0yb9j1ww+xok2uzndUvH5oGMLTKyz0t
        QBJsvwKRwtVexTP6PquVWrAwPg==
X-Google-Smtp-Source: AK7set8st1P0Fd3ZXsNQ7qFyRBh7YiyDddSEAmZOHavCvKCPFKLQ1QRef5Sli41k/ZRCzI+wXyvnNQ==
X-Received: by 2002:a05:6e02:16cd:b0:317:9d16:e6c7 with SMTP id 13-20020a056e0216cd00b003179d16e6c7mr263705ilx.3.1679335580914;
        Mon, 20 Mar 2023 11:06:20 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b4-20020a923404000000b0030ef8f16056sm2898753ila.72.2023.03.20.11.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:06:20 -0700 (PDT)
Message-ID: <6e37c8a6-9280-5c1f-b73e-df204242a2b7@kernel.dk>
Date:   Mon, 20 Mar 2023 12:06:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] blk-mq: remove hybrid polling
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
References: <20230320161205.1714865-1-kbusch@meta.com>
 <5aecde5b-c709-c8b3-28cd-5a361bd492b9@kernel.dk>
 <ZBiddGnl0tEbhg43@kbusch-mbp.dhcp.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZBiddGnl0tEbhg43@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/23 11:52?AM, Keith Busch wrote:
> On Mon, Mar 20, 2023 at 11:16:40AM -0600, Jens Axboe wrote:
>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>> index f1fce1c7fa44b..c6c231f3d0f10 100644
>>> --- a/block/blk-sysfs.c
>>> +++ b/block/blk-sysfs.c
>>> @@ -408,36 +408,7 @@ queue_rq_affinity_store(struct request_queue *q, const char *page, size_t count)
>>>  
>>>  static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
>>>  {
>>> -	int val;
>>> -
>>> -	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
>>> -		val = BLK_MQ_POLL_CLASSIC;
>>> -	else
>>> -		val = q->poll_nsec / 1000;
>>> -
>>> -	return sprintf(page, "%d\n", val);
>>> -}
>>> -
>>> -static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
>>> -				size_t count)
>>> -{
>>> -	int err, val;
>>> -
>>> -	if (!q->mq_ops || !q->mq_ops->poll)
>>> -		return -EINVAL;
>>> -
>>> -	err = kstrtoint(page, 10, &val);
>>> -	if (err < 0)
>>> -		return err;
>>> -
>>> -	if (val == BLK_MQ_POLL_CLASSIC)
>>> -		q->poll_nsec = BLK_MQ_POLL_CLASSIC;
>>> -	else if (val >= 0)
>>> -		q->poll_nsec = val * 1000;
>>> -	else
>>> -		return -EINVAL;
>>> -
>>> -	return count;
>>> +	return sprintf(page, "%d\n", -1);
>>>  }
>>
>> Do we want to retain the _store setting here to avoid breaking anything?
> 
> I was thinking users would want to know the kernel isn't going to
> honor the requested value. Errors can already happen if you're using a
> stacked device, so I assmued removing '_store' wouldn't break anyone
> using this interface.
> 
> But I can see it both ways though, so whichever you prefer. At the
> very least, though, I need to update Documentation's sysfs-block, so
> I'll do that in the v2.

Users knowing == things breaking. Because it isn't a person looking at
that thing, it's some script or application. So I do think it's better
to just pretend we did something, and just not do anything. Because it
won't change anything in terms of the application working. If you did
you use hybrid polling, it'll still work fine with classic.

Arguably not a high risk thing, but I'd prefer decoupling the two
changes and then we can yank the store method at some later point in
time.

-- 
Jens Axboe

