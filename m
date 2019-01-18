Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7580C07EBF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BD820823
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RzNmViVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfARRgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:36:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33425 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfARRgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 12:36:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so6944989pfb.0
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 09:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bKSIFPBF+v78PFDhVKvKQmlvYTfQ3KGZScyZBkJNyYA=;
        b=RzNmViVDZ6s3sPiW8khVjfgCqssaD0LbgUC01YUT3P/a5TMHIQLq1XwbMo3ZEK6WF7
         2M22D963crPSZ4FkSFUru+ipDN4+35hNKFrsyLc2Ltj+uFQK1l8kcqlWiW6DzALSt5EZ
         zkYinm3hCpxdpHZQPq3Bku9PHFk4TOmaL/796JKq+XMGmk3sAz29njyLxW5LvWlxQkvU
         FoPWN8n5Hv7Hd3CpzyX9+RY0UzDY7nlzXyZsPZF6XOQSTyHJfStic+bt6PbRMjoPPUs8
         49L0Byrx+TxF2liUSRbG8HPRAQLnNESWuVJKKPUbVP2PieDNKO26+HaW+ktOseYLpbHa
         3uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bKSIFPBF+v78PFDhVKvKQmlvYTfQ3KGZScyZBkJNyYA=;
        b=BOB24z8rxnhwAKscPd2M+4w1Yv6aIt//SbWgSCBZb1o7oHnQSVPn3ymY45z8+4spC8
         kC+WlAAF1geHQy8YIJPTiNPFwq8lEypn5CiTHbya5FUIv8iQ8mEHjpNwNwDGHOJsXOxW
         t2USgvgerDW66pwMWtLIx9QsWg0B9EQT7DVMjKiWgRnqhOXGQmDf98ik8WFVlVxuFC0O
         hwwelNa/Ci4fraZqxAh6f285+NMhW6+dlKvN2xXSpn0enZfYkeVJbsA51dFbxlvtimv6
         Dx7iPfLSh/LG8zMh7N1HBy8XyTkP5EGUHuJj4uSiAhN50vIbGAQW51otopTZrWfQ1jgS
         2ozA==
X-Gm-Message-State: AJcUukdBCHc4lFtZ2rOXocgT+eUJQFlxPLCHUcrSGSUkjKlQQ573cGcx
        dhrNh/SF2oDy2/+AorsyQUBMNg==
X-Google-Smtp-Source: ALg8bN6WJQUSS1F/PUYr83VMHwRnUptYxZkVBOWfekzvKPsLmqP7Xd+GZcnQUZ0//hz7KeuGEspUVQ==
X-Received: by 2002:a63:6b05:: with SMTP id g5mr18113653pgc.15.1547832970989;
        Fri, 18 Jan 2019 09:36:10 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z191sm6069460pgd.74.2019.01.18.09.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:36:10 -0800 (PST)
Subject: Re: [PATCH BUGFIX RFC 0/2] reverting two commits causing freezes
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        hurikhan77+bko@gmail.com
References: <20190118115219.63576-1-paolo.valente@linaro.org>
 <c3b182a2-7f82-2860-436b-c1d59d6661ff@kernel.dk>
 <D212BCED-49BD-47F0-AF7F-0CCDBC82D131@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c71255da-c142-8ea1-2dc4-840a6581689b@kernel.dk>
Date:   Fri, 18 Jan 2019 10:36:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <D212BCED-49BD-47F0-AF7F-0CCDBC82D131@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/19 10:24 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 18 gen 2019, alle ore 14:35, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 1/18/19 4:52 AM, Paolo Valente wrote:
>>> Hi Jens,
>>> a user reported a warning, followed by freezes, in case he increases
>>> nr_requests to more than 64 [1]. After reproducing the issues, I
>>> reverted the commit f0635b8a416e ("bfq: calculate shallow depths at
>>> init time"), plus the related commit bd7d4ef6a4c9 ("bfq-iosched:
>>> remove unused variable"). The problem went away.
>>
>> For reverts, please put the justification into the actual revert
>> commit. With this series, if applied as-is, we'd have two patches
>> in the tree that just says "revert X" without any hint as to why
>> that was done.
>>
> 
> I forget to say explicitly that these patches were meant only to give
> you and anybody else something concrete to test and check.
> 
> With me you're as safe as houses, in terms of amount of comments in
> final patches :)

It's almost an example of the classic case of "if you want a real
solution to a problem, post a knowingly bad and half assed solution".
That always gets people out of the woodwork :-)

>>> Maybe the assumption in commit f0635b8a416e ("bfq: calculate shallow
>>> depths at init time") does not hold true?
>>
>> It apparently doesn't! But let's try and figure this out instead of
>> blindly reverting it.
> 
> Totally agree.
> 
>> OK, I think I see it. For the sched_tags
>> case, when we grow the requests, we allocate a new set. Hence any
>> old cache would be stale at that point.
>>
> 
> ok
> 
>> How about something like this? It still keeps the code of having
>> to update this out of the hot IO path, and only calls it when we
>> actually change the depths.
>>
> 
> Looks rather clean and efficient.
> 
>> Totally untested...
>>
> 
> It seems to work here too.

OK good, I've posted it "officially" now.
 
-- 
Jens Axboe

