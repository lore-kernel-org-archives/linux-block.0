Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2748FCA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE15921D71
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 15:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h5cwpQZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407929AbfJYPBU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:01:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42890 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407863AbfJYPBU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 11:01:20 -0400
Received: by mail-io1-f65.google.com with SMTP id i26so2744289iog.9
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kj0Q87zyB0a/7QLfzAgAycchwCNPhaMuUvYcmDPD4qY=;
        b=h5cwpQZ7+vwwuWTD2LhRfp4+b25WtDQ3PO3zK3Rx4C4yVWrXsEpkRK5/lb8RRk3teX
         wpFIRU+ig4CCHgVnZ9ugIGM8XOjqHJqV+B45z7uVwEVjuN5HMzuoMqUvFvGdM9APyisr
         YPhkU44gzZrQwd71VBJyqkqGgpVtAcZU154FLQd/wnHiGEVtjH3yhgrnT9XWMszT31uU
         gV9JmWtgQLJ5oHDfLJr58xBU5CWdnmTjt5MBNUwRX7UPMtikYHXtoyDY/hlTx+0iD0q0
         +i38lntd6U8xUr2aJO5kv94smH9mhACfLrotwNhx8F+JuoeEe7kwLIyeJfR/mdDpYv1r
         XQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kj0Q87zyB0a/7QLfzAgAycchwCNPhaMuUvYcmDPD4qY=;
        b=c8a8edBKMjndQnQ/DFZsuEYNCYnzlaA/5nixHp5uDqv/fgC7k/U31n0Ig4yN+e+q38
         dPCCpb0P8TZ55rrxqvvBrF18VjC/S+Q9o+WYokWxvF3faFT31bQXnjK4rnIvAOGbMTqn
         Q7yqnmnmNNOcG23zk5mcId9/SSjrgBu/5B6SStlI7yUn4CiU+KixONBPRY4EcxAp4k8v
         Y791bYhiCRhSGnDVFAJaCPPVgj2rrD8QYACfJ0Ow1hcYpzRYypSDCEP0ZjQq2zjzgy/Q
         csYQPx55MRha4FBFiZMawbI/BQLwscZnpO8dvRg8E0LP4mZzxpQVKWsz9Mkzk3Hkx1KE
         Ec2A==
X-Gm-Message-State: APjAAAWLv/L9vJUR/bKOUPHd2nU+FvI0Qg7X2ApUG2MKMNFLSLNDMe3e
        GEBS81lICKdZKYFgmorww9s11g==
X-Google-Smtp-Source: APXvYqzYQjMNPzo4l7Ej75h/9qnt7jeE0SNfKqIQDA0+djWIhVKQuQeelvR2jbFTEKqENGMdOXNKCA==
X-Received: by 2002:a6b:c809:: with SMTP id y9mr4281840iof.232.1572015679139;
        Fri, 25 Oct 2019 08:01:19 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n123sm287754iod.62.2019.10.25.08.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 08:01:17 -0700 (PDT)
Subject: Re: [PATCH 2/3] io_uring: Fix broken links with offloading
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1571991701.git.asml.silence@gmail.com>
 <bd0eaa7729e3b8b599a25167df0a4ee583da69cc.1571991701.git.asml.silence@gmail.com>
 <dd88f5be-930b-53e5-c3b6-12927d6634b1@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e6bdba3-d673-ed49-15da-51ac93af7a28@kernel.dk>
Date:   Fri, 25 Oct 2019 09:01:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dd88f5be-930b-53e5-c3b6-12927d6634b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 3:36 AM, Pavel Begunkov wrote:
> On 25/10/2019 12:31, Pavel Begunkov (Silence) wrote:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> io_sq_thread() processes sqes by 8 without considering links. As a
>> result, links will be randomely subdivided.
>>
>> The easiest way to fix it is to call io_get_sqring() inside
>> io_submit_sqes() as do io_ring_submit().
>>
>> Downsides:
>> 1. This removes optimisation of not grabbing mm_struct for fixed files
>> 2. It submitting all sqes in one go, without finer-grained sheduling
>> with cq processing.
>>
> Is this logic with not-grabbing mm and fixed files critical?
> I want to put it back later after some cleanup.

Let's revisit that on top of the 5.5 branch of io_uring changes,
as that is being reworked anyway. I'd say it's not super critical,
as the hottest path should be polled IO with fixed buffers, and
it won't really change that.


-- 
Jens Axboe

