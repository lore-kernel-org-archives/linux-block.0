Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F85C73C63
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 02:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6A62073D
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 02:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nCzcmCM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfGJCzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:55:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44262 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfGJCzs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 22:55:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so432415pgl.11
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2019 19:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SpAgvw8gQVOXy+umMAlDfGRcLKrmzecQ7jvQPpPYVRA=;
        b=nCzcmCM40jmAKJc7uBrVihJUbgu8iWrFmZ1shxKMhzukMREbje1p+m6fGE8l9DIXNO
         BDwJ+8RDQt3t/bHyEAzS8l62hxOETwBi7LyTID1qLC4hTVpZMabsH21UXIJI1kHYyG52
         KtNz6R/xisBBmTuNLLWgIZPlL3F7ZszHaU6JukLCVfUCsHjBHvv4cjxWMSP8NgNMzd9s
         dkbFIQl6SzrcVFuqYTtydqJJrupSesG2LoiGNGcd6H0F3+Ddvg0iUcLHhot0CS0TsB8r
         3nf0xA8WeGn98U37lmstiSD39rp6gN7aJh2uKnErbdS5j+E84KaIlbvhypvWyTim+NAz
         m/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SpAgvw8gQVOXy+umMAlDfGRcLKrmzecQ7jvQPpPYVRA=;
        b=kaE2r6ShzXA81zClV8pCS4G1XVpebYEJBZaWkG26geAdMH49EEn90irzYHHiOAKUV7
         PxDUo3/aCd2Vv1v/MOQrOJ7IcZgh/4C/SqUUZGni7XspBLSk1pNKWLXtNxW1GvnnpZgb
         oCB8EQeGUGWb1pzbxXhvXo3+4hBGM1lWwGx2Ut4KSu54+Bqhupq0SPqa3KOcTDzt+Hr5
         ci/nfmm+5TZQBiUne0Eb+vX/3jVlxtY/xDx9cBJlHgMXUYdcOEbTmU6lSAl1gZCnx53U
         9yeuUFXhA65oJ3kh7g2Q7oDcfstrbcbynCSmW6I5zGOOrZt7o9XxGFSxRPE5zl1cCsVR
         thlw==
X-Gm-Message-State: APjAAAUkOtMXGd+aA9O24Q0JTkZ8LJ5RcSqERpoVH0HcqxOwiSa48tHC
        +MZA1QgOGOnprasWPT/Pk78=
X-Google-Smtp-Source: APXvYqxkNwHc3lhfazfhrn+wAYt/x8zZuldV0HOhggmYY6YGZ4UzkWaL9d9v9qBtXTWJutIzoN1G1A==
X-Received: by 2002:a17:90a:37ac:: with SMTP id v41mr3797435pjb.6.1562727347841;
        Tue, 09 Jul 2019 19:55:47 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id f14sm427366pfn.53.2019.07.09.19.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 19:55:46 -0700 (PDT)
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
To:     Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
 <20190709142915.GA30082@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <341defc6-128e-3b18-9468-951d311e0993@kernel.dk>
Date:   Tue, 9 Jul 2019 20:55:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709142915.GA30082@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/9/19 8:29 AM, Ming Lei wrote:
> On Tue, Jul 09, 2019 at 06:02:19PM +0900, Damien Le Moal wrote:
>> Simultaneously writing to a sequential zone of a zoned block device
>> from multiple contexts requires mutual exclusion for BIO issuing to
>> ensure that writes happen sequentially. However, even for a well
>> behaved user correctly implementing such synchronization, BIO plugging
>> may interfere and result in BIOs from the different contextx to be
>> reordered if plugging is done outside of the mutual exclusion section,
>> e.g. the plug was started by a function higher in the call chain than
>> the function issuing BIOs.
>>
>>        Context A                           Context B
>>
>>     | blk_start_plug()
>>     | ...
>>     | seq_write_zone()
>>       | mutex_lock(zone)
>>       | submit_bio(bio-0)
>>       | submit_bio(bio-1)
>>       | mutex_unlock(zone)
>>       | return
>>     | ------------------------------> | seq_write_zone()
>>    				       | mutex_lock(zone)
>> 				       | submit_bio(bio-2)
>> 				       | mutex_unlock(zone)
>>     | <------------------------------ |
>>     | blk_finish_plug()
>>
>> In the above example, despite the mutex synchronization resulting in the
>> correct BIO issuing order 0, 1, 2, context A BIOs 0 and 1 end up being
>> issued after BIO 2 when the plug is released with blk_finish_plug().
> 
> I am wondering how you guarantee that context B is always run after
> context A.
> 
>>
>> To fix this problem, introduce the internal helper function
>> blk_mq_plug() to access the current context plug, return the current
>> plug only if the target device is not a zoned block device or if the
>> BIO to be plugged not a write operation. Otherwise, ignore the plug and
>> return NULL, resulting is all writes to zoned block device to never be
>> plugged.
> 
> Another candidate approach is to run the following code before
> releasing 'zone' lock:
> 
> 	if (current->plug)
> 		blk_finish_plug(context->plug)
> 
> Then we can fix zone specific issue in zone code only, and avoid generic
> blk-core change for zone issue.

I prefer that to the existing solution as well.

-- 
Jens Axboe

