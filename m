Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1791BC43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 16:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16A922419
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 16:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OAUyrok8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16A922419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeKNC6B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:58:01 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51648 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeKNC6B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 21:58:01 -0500
Received: by mail-it1-f193.google.com with SMTP id m34-v6so19298696iti.1
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HjHcq6+0x+tmwM8mNX0CTBpJ7rdlQDgiGUdpWB/Ln+E=;
        b=OAUyrok82+mHYODjMqPZhLLcHS/m7jY/FS5kAbp2B4vg6KMJt8VX+b7tk8mKshW9QH
         hPgiSF5omz1QSAhbgHE8HGeADhvilELTwL378IkKSys1HW1KgJ5AhesOViRNHDhZXN51
         0pDwehEfV6o9iUxWLVj9K6Vtw3uyP3tn4Yl7544Oz5Ev+mGYAEoXP1dsNjigmLpJz4ob
         NZKtiXtdkw4xqJrZaAhms4wVwqvqdH8uiMyGMftoLXKeKj0B0zwbu0Xuymlww4gMpa0D
         nGMJDt6M7RyZ3R55zGblIHWalhsvTHozvneg4cuXkl3cTLSxpHA7fY80KlWpjF0xb107
         smnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HjHcq6+0x+tmwM8mNX0CTBpJ7rdlQDgiGUdpWB/Ln+E=;
        b=WRJ+P47b1EG83/Xoa0d4HDGI3QoOS8iIb10zmWAKAeF0Yf9xGmvygtt0i1oWL9ZfSm
         3mMyx7u+myAq7V+Z+Wll7ufi5+5ZRn4W/pmdkwsJFvSwcbW0YHiPdZLdF76s+2B/8vx9
         qONpWmJzogtm7LuTUBTgPbKvwUAboIwaqGQUlhuX/p4tcyp66jax/JlD70FpF61nKuU5
         QUa1q+vdUj5Rqc6rw0ibvlzPp46XMzuuQtPsSJsgJ1qbDmVZptrNX8hNbrGtGK4FS2LA
         SQSiaDQZ2Kip9O6Xdb7Y6yH5rWOZjavmgRvk1dP7fSXaMsyUFTxhy+/ZgrclcLKlPmsG
         DL7Q==
X-Gm-Message-State: AGRZ1gKMZGWltIFNhTajxPAUxkOF8O2m7yh2xyRu6OCGeDHUjuszcr4Z
        FXIQu+99sBKZZWJuvXiYvx1GnNnCQFU=
X-Google-Smtp-Source: AJdET5dsDN6gh9DyipXScMuc/QL3FHhY5GwjZxREpShD8xAzX0KbudOT7PNPoypP/9ZuBGwEPTEvtw==
X-Received: by 2002:a24:2190:: with SMTP id e138-v6mr4433684ita.71.1542128344160;
        Tue, 13 Nov 2018 08:59:04 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x25-v6sm6442104iob.84.2018.11.13.08.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 08:59:02 -0800 (PST)
Subject: Re: [PATCH 06/11] block: add polled wakeup task helper
From:   Jens Axboe <axboe@kernel.dk>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-block@vger.kernel.org
References: <20181113154233.15256-1-axboe@kernel.dk>
 <20181113154233.15256-7-axboe@kernel.dk>
 <20181113155255.GB9827@localhost.localdomain>
 <a811ef9b-c72d-73ba-93aa-27c6a4b2f112@kernel.dk>
Message-ID: <7fa09eed-d7ff-ee8c-6644-552d1f7f5607@kernel.dk>
Date:   Tue, 13 Nov 2018 09:59:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a811ef9b-c72d-73ba-93aa-27c6a4b2f112@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/13/18 8:58 AM, Jens Axboe wrote:
> On 11/13/18 8:52 AM, Keith Busch wrote:
>> On Tue, Nov 13, 2018 at 08:42:28AM -0700, Jens Axboe wrote:
>>> If we're polling for IO on a device that doesn't use interrupts, then
>>> IO completion loop (and wake of task) is done by submitting task itself.
>>> If that is the case, then we don't need to enter the wake_up_process()
>>> function, we can simply mark ourselves as TASK_RUNNING.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>  fs/block_dev.c         |  6 ++----
>>>  fs/iomap.c             |  3 +--
>>>  include/linux/blkdev.h | 19 +++++++++++++++++++
>>>  3 files changed, 22 insertions(+), 6 deletions(-)
>>
>> One more for swap read:
>>
>> ---
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index d4d1c89bcddd..57572ff46016 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -140,7 +140,7 @@ static void end_swap_bio_read(struct bio *bio)
>>  	unlock_page(page);
>>  	WRITE_ONCE(bio->bi_private, NULL);
>>  	bio_put(bio);
>> -	wake_up_process(waiter);
>> +	blk_wake_io_task(waiter);
>>  	put_task_struct(waiter);
>>  }
>>  
> 
> Indeed, thanks Keith! I'll fold it in.

Ditto for the patch 5 changes, jfyi.

-- 
Jens Axboe

