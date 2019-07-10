Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEF6C74A23
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 13:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2E82087F
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 13:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T7fVyTm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfGJN73 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:59:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39013 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJN72 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 09:59:28 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so4907113ioh.6
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QkqI+dju4Yd13uE+jp1IzcZ8UNP91n3hxHu2NEoWbmg=;
        b=T7fVyTm/qQ7516vMka4gQE1sPmuL6ay/20jgbaXm22TaTNDdiPZ3+w7GF/Z+Ui6ygv
         3R0YiLABe6bZQl4ed/MlVccWpWqkuylXhjgFyH7uJWQfoifbD2UHbL7ooe6hlWG2CEde
         jInhI9DLqam6AQe8HWMyH9FDfFfnHI5vlrVVVACyt/ehYAK18n8/JLf0LxND0ZkUW1Ol
         I644oBfKSF69t1i8gMsNFShTPsQiOD3yC/ydWC2mw0Fm2eUNUEoF7IfnEIy4/e0Ypfon
         yCMTTtef25s/lfMG6N1VCqAWrsDW5SfNqdJjvas+G4hzf3lMIQfO7bjy5rs0NiY409WF
         6XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QkqI+dju4Yd13uE+jp1IzcZ8UNP91n3hxHu2NEoWbmg=;
        b=c78KOrHT8Lys6uoi46RtyYezohUBjHXka/n8oN8sfE/R2lHa5rcj4rKRrS7UhxlGzj
         UrVGeQgi2KmpbdxHHoat+o71ZrqBJQ1+5wRuYt1WlKhibhEFeHTa/0faqGJZ+PRtRHIE
         b3H3gixD3kd7BguQYsKaWeFQveBbm7v3TPwiJPLdLR58Uq2FNAztEE/hFxQltrvA7TFI
         3Mw8QMhydQq7ywzNJp7d2O32dUUd73iqtfLtzs3ipdffYeBiU3CeLGSYmofiuNubxww5
         8P67UyTcG9Uf44iZ0UXOn+SBcSJapnVk7xq/1HaEQEgD0lh+tohjSWj0VXdoo8bRwR/E
         y8xg==
X-Gm-Message-State: APjAAAWyjuOZ0279aVyzjwH3CFF9MVeUboAxPvCRgFryVjXFD9hKMl27
        NDFCfGbcZub28GN1kMGrSEwE9G4aaxF+SA==
X-Google-Smtp-Source: APXvYqzgUIq3nn3LZx3NijS5Pnkvbs/j2viQFDXh/tR810dMkQFZVvidMHFLxJOSyn16ZZlUhKJdNQ==
X-Received: by 2002:a6b:7311:: with SMTP id e17mr33685573ioh.112.1562767167957;
        Wed, 10 Jul 2019 06:59:27 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m10sm3884977ioj.75.2019.07.10.06.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 06:59:27 -0700 (PDT)
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
 <20190709142915.GA30082@ming.t460p>
 <341defc6-128e-3b18-9468-951d311e0993@kernel.dk>
 <BYAPR04MB5816B43AEAACBCBCEE27588AE7F00@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d386a51-52b3-12ab-736d-e3195b150c5d@kernel.dk>
Date:   Wed, 10 Jul 2019 07:59:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816B43AEAACBCBCEE27588AE7F00@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/9/19 8:59 PM, Damien Le Moal wrote:
> On 7/10/19 11:55 AM, Jens Axboe wrote:
>> On 7/9/19 8:29 AM, Ming Lei wrote:
>>> On Tue, Jul 09, 2019 at 06:02:19PM +0900, Damien Le Moal wrote:
>>>> Simultaneously writing to a sequential zone of a zoned block device
>>>> from multiple contexts requires mutual exclusion for BIO issuing to
>>>> ensure that writes happen sequentially. However, even for a well
>>>> behaved user correctly implementing such synchronization, BIO plugging
>>>> may interfere and result in BIOs from the different contextx to be
>>>> reordered if plugging is done outside of the mutual exclusion section,
>>>> e.g. the plug was started by a function higher in the call chain than
>>>> the function issuing BIOs.
>>>>
>>>>         Context A                           Context B
>>>>
>>>>      | blk_start_plug()
>>>>      | ...
>>>>      | seq_write_zone()
>>>>        | mutex_lock(zone)
>>>>        | submit_bio(bio-0)
>>>>        | submit_bio(bio-1)
>>>>        | mutex_unlock(zone)
>>>>        | return
>>>>      | ------------------------------> | seq_write_zone()
>>>>     				       | mutex_lock(zone)
>>>> 				       | submit_bio(bio-2)
>>>> 				       | mutex_unlock(zone)
>>>>      | <------------------------------ |
>>>>      | blk_finish_plug()
>>>>
>>>> In the above example, despite the mutex synchronization resulting in the
>>>> correct BIO issuing order 0, 1, 2, context A BIOs 0 and 1 end up being
>>>> issued after BIO 2 when the plug is released with blk_finish_plug().
>>>
>>> I am wondering how you guarantee that context B is always run after
>>> context A.
>>>
>>>>
>>>> To fix this problem, introduce the internal helper function
>>>> blk_mq_plug() to access the current context plug, return the current
>>>> plug only if the target device is not a zoned block device or if the
>>>> BIO to be plugged not a write operation. Otherwise, ignore the plug and
>>>> return NULL, resulting is all writes to zoned block device to never be
>>>> plugged.
>>>
>>> Another candidate approach is to run the following code before
>>> releasing 'zone' lock:
>>>
>>> 	if (current->plug)
>>> 		blk_finish_plug(context->plug)
>>>
>>> Then we can fix zone specific issue in zone code only, and avoid generic
>>> blk-core change for zone issue.
>>
>> I prefer that to the existing solution as well.
> 
> My apologies, you lost me: do you mean that you prefer Ming's suggestion
> and force FS or dm users to manually unplug in the case of zoned block
> devices ?

I take that back, I thought we could do it manually in the zoned code
while dealing with the locking, but I don't think that is feasible.

-- 
Jens Axboe

