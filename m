Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750ADC43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BBB2145D
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oMdFH0qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgIOSaG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgIOSSd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 14:18:33 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0451BC061788
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 11:17:59 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id o20so1007341ook.1
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bTTRD0/irNQCd03woygzg2YIc3JV44oMGNS2xdYHnuY=;
        b=oMdFH0qeR7ktNNSHnOFu0cnxSyqibVe5Xfhe2tBaiWKuUcg1GDfeVU/qMzK149v5K+
         iK0oQoF39aDYeONrDyDjZS59ruDFyIryDGNrD04kboLa7s9/T2DfrPvNZ5mWtnsUkKVL
         wGRPpofseOHZAXio+PZGs0lAxHmN2RrQUMM55FmC4GuBfqFk6vs/rdl67En8WyxSWjxW
         3H3o+eCZ/0wMTcov8J54w+bE6IFxngx5LeFTF0V4ivTjpkp8ZfjwQtktOH8V2XBotEpH
         qQPHM+S0mkUvPlV3hkhPxbpIp5SEt/s2xbVoAaBbZYT9AHlf2HEqGHcTeYP3nfBbEY13
         w2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bTTRD0/irNQCd03woygzg2YIc3JV44oMGNS2xdYHnuY=;
        b=JUfZhzTam5/IkE2hDOv5RbHBKhlmwbKLNHX5oWJOj9xP/+PePoZ5o4rFrxVqCI3O1p
         cJUVcZrDqQeQbHYOp8Ijt5HNjcqEbXMJe1IFAiP6lbEbRC5zjw6/IBXe/u+8VEBmcIA2
         N0aceYbifNVYVe1IioS4oUkzRyS2uHhecOjk5KlFPtzVaWU1+yYS/ZgOHqBC0qcrQwOv
         y4lYJ4KL0QVxpbEAp92s5ThQg0FovJiYt+epVLSc/xFeFDLRZVwQdxoZdFlV2vOPdYO5
         WW8EjPbViw9uLWaC6/jiQVw/2HUuVXLrmFZopeTnmzXFnP32IyTVI821vP8bmSKpDhvU
         v+kg==
X-Gm-Message-State: AOAM533VBBDUNL49UK++6YZusgmbADHdnAAFGNs8uuKqg1IGVXBAaGRF
        l+ZADM+RorBsly6u70j308LU1A==
X-Google-Smtp-Source: ABdhPJyQ+e6vnFc7oLm3XND80yl17hzMcTnTiY2uZpb1xItEL9ivt+KBWm5ZF0JxQskTaOcMWGW7nA==
X-Received: by 2002:a4a:5896:: with SMTP id f144mr665883oob.49.1600193878720;
        Tue, 15 Sep 2020 11:17:58 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 9sm6876327ois.10.2020.09.15.11.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 11:17:58 -0700 (PDT)
Subject: Re: [PATCH 0/5] Some improvements for blk-throttle
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     tj@kernel.org, baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
 <822998a7-4cc7-88ee-8b3f-e8e7660a5b0a@kernel.dk>
 <20200915085926.GA122937@VM20190228-100.tbsite.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c36a1c1b-ca46-13c8-42eb-94e63ff845d1@kernel.dk>
Date:   Tue, 15 Sep 2020 12:17:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915085926.GA122937@VM20190228-100.tbsite.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/15/20 2:59 AM, Baolin Wang wrote:
> Hi Jens,
> 
> On Mon, Sep 14, 2020 at 07:37:53PM -0600, Jens Axboe wrote:
>> On 9/7/20 2:10 AM, Baolin Wang wrote:
>>> Hi All,
>>>
>>> This patch set did some clean-ups, as well as removing some unnecessary
>>> bps/iops limitation calculation when checking if can dispatch a bio or
>>> not for a tg. Please help to review. Thanks.
>>>
>>> Baolin Wang (5):
>>>   blk-throttle: Fix some comments' typos
>>>   blk-throttle: Use readable READ/WRITE macros
>>>   blk-throttle: Define readable macros instead of static variables
>>>   blk-throttle: Avoid calculating bps/iops limitation repeatedly
>>>   blk-throttle: Avoid checking bps/iops limitation if bps or iops is    
>>>     unlimited
>>>
>>>  block/blk-throttle.c | 59 ++++++++++++++++++++++++++++++++--------------------
>>>  1 file changed, 36 insertions(+), 23 deletions(-)
>>
>> Looks reasonable to me, I've applied it.
> 
> Thanks.
> 
>>
>> Out of curiosity, are you using blk-throttle in production, or are these
>> just fixes/cleanups that you came across?
> 
> Yes, we're using it in some old products, and I am trying to do some
> cleanups and optimizaiton when testing it.

Gotcha. Reason I ask is I've been considering deprecating it, but when
fixes come in for something, that always makes me think that some folks
are actually using it.

-- 
Jens Axboe

