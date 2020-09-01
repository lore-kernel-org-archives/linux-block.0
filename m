Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A71C433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 22:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10516206EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 22:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gMH4+Qw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIAWjN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgIAWjM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 18:39:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92C8C061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 15:39:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so1680625pfa.10
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 15:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fEzxUQPqaIv5Vac1iqqJit6ENGiiGtyy3Eg3thLXPpk=;
        b=gMH4+Qw8nRXmpYPOSgjKFCJPA9OpEDBtoNDQCNKCUgvVVF5b4o12WSfwWblOPYsPjm
         kxiRZAgk4Szbzr2by16tPKmFQ2ijR+bLmL5CW9T9v+ey+auPUZE57RsmLFVulTI3J6LK
         IMnHbhjBHhTSlVRai+9vRPczoG39WBSfqVxORLv/xDhyHOJWKpATBhbcjWHfw6yGhYig
         sUXECNJCwDehJxiSIa7Gw8DSv3zhrFB6y7KQOocVQrWV4anKGr1vecBRWs+B2Lx/6wQu
         76LBhbiFKmuFq62gn+RXLLXrpeviUtHpvVvVCh8mFpPCrT+sW3l6/p6IyxQ65wWQtgyy
         3fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fEzxUQPqaIv5Vac1iqqJit6ENGiiGtyy3Eg3thLXPpk=;
        b=lP51zvjrtIuxYjhbmh7ywjcGM9e3oAVWlQKsl6czYc2j9RrMMvDwnj7XKzGn361SB2
         78rvd78KMZOWJQJqK6Ib9wl61v2psuS9EOg0RULP6+6UuLv3uAAmqtb8B9PpIMGxBlcp
         +S2w57M3k5fKjq0cBc9Eh4OoPUCnPxVX63ZloDrUZo3OMpOMAFOVeQd++CNW8wMITGOr
         rT/Jc9Gq5P24AYeWiGU9L+7W9Fp+k2FQZwHQNrpWvRE063El+EIm6+02j8C7Rihhlu8p
         M8th8Y2lifWQsJKSzR0HnJBptq785zIo5/1SM8OT34ke6n+BNqD8YtaaYrkPzGzuSiSe
         /xAw==
X-Gm-Message-State: AOAM530xI3Vb45TgGhO7dN4rsz+XEow4XxdmATE7nNli9ZClREO9YXGA
        GW6LB1PCFrIojvQutMkqXFTkaw==
X-Google-Smtp-Source: ABdhPJyUFWwA/UumACqe2TRQ4q6nFAbXlg2mDaXl4uczUT3L8dZvthxkdeksDhRjrC5ug1l6Bmm4Eg==
X-Received: by 2002:aa7:92cb:: with SMTP id k11mr341846pfa.233.1598999951410;
        Tue, 01 Sep 2020 15:39:11 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b64sm3013470pfa.200.2020.09.01.15.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:39:10 -0700 (PDT)
Subject: Re: [PATCH] block: Fix inflight statistic for MQ submission with
 !elevator
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Ming Lei <tom.leiming@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>, kernel@collabora.com
References: <20200831153127.3561733-1-krisman@collabora.com>
 <CACVXFVM21GWTrWs=6w3OXm7vQ-gmR_3PGss+9TE=swVN-Uzn7Q@mail.gmail.com>
 <87wo1dpclt.fsf@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3dd1d80-ea30-f9df-9812-05b846a76f21@kernel.dk>
Date:   Tue, 1 Sep 2020 16:39:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87wo1dpclt.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/20 12:37 PM, Gabriel Krisman Bertazi wrote:
> Ming Lei <tom.leiming@gmail.com> writes:
> 
>> On Mon, Aug 31, 2020 at 11:37 PM Gabriel Krisman Bertazi
>> <krisman@collabora.com> wrote:
> 
>>> -       if (rq->part == mi->part)
>>> +       if (rq->part == mi->part && rq->state == MQ_RQ_IN_FLIGHT)
>>>                 mi->inflight[rq_data_dir(rq)]++;
>>
>> The fix looks fine. However, we have helper of
>> blk_mq_request_started() for this purpose.
> 
> Thanks for the review.
> 
> I was aware of blk_mq_request_started, but it forces a READ_ONCE which
> on Alpha includes a mb() for every tagged request, which doesn't seem
> necessary or desired here.  I might be wrong though, memory barriers
> are hard. :)
> 
> let's see what Jens says about the other points, so I don't spin this
> unnecessarily.

On the READ_ONCE() part, I don't really care about alpha to the extent
that I'll sacrifice readability and code unification to cater to that
specific architecture :-)

We just need to decide if this makes sense or not. I think we should
apply this for 5.10, with Ming's suggestion of using
blk_mq_request_started(). Then I guess we'll see what happens...

-- 
Jens Axboe

