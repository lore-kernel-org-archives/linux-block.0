Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480D2C54EBE
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 23:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjAPXes (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 18:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjAPXd5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 18:33:57 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEDD22DDF
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:28:20 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id d10so20658062pgm.13
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkyBdgW69ol57DjsnI6SIctj24fvoNsLsoYaQc1Y3vg=;
        b=ICIl3I18Ark0TX/vS+igIGekezOyWIzJC0LkZOvn/WBDzfx9G0tjn03awCkRuy8I1H
         iQRYqhvctRydnuSMRxpzTQWB4UwLKQSh/GIFQjP4xVX410E0dZr74EGVYtqX6mN8eN+p
         dXV6aGAYRNbWWvH8cyN+HRNB9tGkmJwnymjGhl2MfMeMHF+FrlN8KDHtjH4hWq/cZgC1
         5PZpFXSTTaHQRAbsgrrJCJ/mGaNRR3uNYik94JU8Toj7jhDRUMz9ziDYFtgMUEVZrtLC
         nUm+QJfwOtzkIxn4Zbi5jmJI9H1sFAJ5olazkqkbx/Z65oZ9NrOBuOm0GvlSgmIAcVEw
         666g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkyBdgW69ol57DjsnI6SIctj24fvoNsLsoYaQc1Y3vg=;
        b=DjlXgFUpIfyjz/xvS9fWnQIZk/Qfrfo2fvPHWgpgqaVNDOXfo+9CFrcQgD8riXStkd
         KwysLSho1mLNs7cPzoO2mGGTsbVa4WKf1VnExCx7pYW30hd2viuXGplDHNfU34buHjOw
         ojM20NKbxN7tD8ESRVjwHdpoJFYhJt8FOb8Jy/YDKuIrE/KysVKjR0syn4HQBwBWHHiS
         tdJKSpS5iuvq7Im6DRzeieEPChqir3AmIE/1K0z/aRZ8Fe2A5RjCEd1WTYHP0xlZzgok
         +zAoy2/dqT/lGpgbHd2hfdCaL33Zv/cJJMZIf3tk1oa/nEZrSTCvw9+GqkvZTM9ddQ59
         kpHA==
X-Gm-Message-State: AFqh2kqN6vFo5ukaVRilryFdN5tA32dU2vKzeMBlT4wliWO0TqziRMRy
        BSb1Edh3zaMHf08O41weqibXAhRJz2EnqTYr
X-Google-Smtp-Source: AMrXdXudh8TxlFJknDBJGvE1yMw1Ejo4tRk9Zrz6DWFJkRfTUBNSGWaGMc5vMm1V5tvbgOuD/Lp3hg==
X-Received: by 2002:a05:6a00:2a5:b0:587:9e50:3af9 with SMTP id q5-20020a056a0002a500b005879e503af9mr300432pfs.0.1673911699846;
        Mon, 16 Jan 2023 15:28:19 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k185-20020a6284c2000000b00586a59b4b01sm17528283pfd.12.2023.01.16.15.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 15:28:19 -0800 (PST)
Message-ID: <4ed4090b-7bff-dd43-da23-915f269bd759@kernel.dk>
Date:   Mon, 16 Jan 2023 16:28:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Michael Kelley <mikelley@microsoft.com>
References: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
 <7c69e3b5-c81b-a3ba-9588-9a59c32c45b7@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7c69e3b5-c81b-a3ba-9588-9a59c32c45b7@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/23 4:20?PM, Damien Le Moal wrote:
> On 1/17/23 06:06, Jens Axboe wrote:
>> If we're doing a large IO request which needs to be split into multiple
>> bios for issue, then we can run into the same situation as the below
>> marked commit fixes - parts will complete just fine, one or more parts
>> will fail to allocate a request. This will result in a partially
>> completed read or write request, where the caller gets EAGAIN even though
>> parts of the IO completed just fine.
>>
>> Do the same for large bios as we do for splits - fail a NOWAIT request
>> with EAGAIN. This isn't technically fixing an issue in the below marked
>> patch, but for stable purposes, we should have either none of them or
>> both.
>>
>> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")
>>
>> Cc: stable@vger.kernel.org # 5.15+
>> Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
>> Link: https://github.com/axboe/liburing/issues/766
>> Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> Since v1: catch this at submit time instead, since we can have various
>> valid cases where the number of single page segments will not take a
>> bio segment (page merging, huge pages).
>>
>> diff --git a/block/fops.c b/block/fops.c
>> index 50d245e8c913..d2e6be4e3d1c 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -221,6 +221,24 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>  			bio_endio(bio);
>>  			break;
>>  		}
>> +		if (iocb->ki_flags & IOCB_NOWAIT) {
>> +			/*
>> +			 * This is nonblocking IO, and we need to allocate
>> +			 * another bio if we have data left to map. As we
>> +			 * cannot guarantee that one of the sub bios will not
>> +			 * fail getting issued FOR NOWAIT and as error results
>> +			 * are coalesced across all of them, be safe and ask for
>> +			 * a retry of this from blocking context.
>> +			 */
>> +			if (unlikely(iov_iter_count(iter))) {
>> +				bio_release_pages(bio, false);
>> +				bio_clear_flag(bio, BIO_REFFED);
>> +				bio_put(bio);
>> +				blk_finish_plug(&plug);
>> +				return -EAGAIN;
> 
> Doesn't this mean that for a really very large IO request that has 100%
> chance of being split, the user will always get -EAGAIN ? Not that I mind,
> doing super large IOs with NOWAIT is not a smart thing to do in the first
> place... But as a user interface, it seems that this will prevent any
> forward progress for such really large NOWAIT IOs. Is that OK ?

Right, if you asked for NOWAIT, then it would not necessarily succeed if
it:

1) Needs multiple bios
2) Needs splitting

You're expected to attempt blocking issue at that point. Reasoning is
explained in this (and the previous commit related to the issue),
otherwise you end up with potentially various amounts of the request
being written to disk or read from disk, but EAGAIN being returned for
the request as a whole.

-- 
Jens Axboe

