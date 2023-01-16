Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93052C46467
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 23:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjAPXfC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 18:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjAPXek (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 18:34:40 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33392CC56
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:29:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso4363026pjg.2
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpwxE8KOKo7vs8TiNgi5SF3L44fg9BagOWF/T6JqWgM=;
        b=CFRupfU+1ibvmseGdYxQckdYDvJ68yCcjmuAM06E163LalPfBI39nu5E8vDHJ2nz89
         +YhIKU1CS0Xhd5PPv2h44hwWShWimSo/P01RrGnIZKRoCzPz64oZsoWBtI1QoVYb+k8L
         wdVN8/LKen4NuJklYU8pUCP0SH4kD0WjT/SV31Mj10naqA1XSR6dypphJivFZjR4VhDJ
         ZIS4ryeMpUqyZbP95ugCeIsdMUMGJAWcpRrBs4XrAcQ8aAhyy8HeKHLnwYbD5GcbSNpg
         TtJiBKYpIspPa0LbcGlDw6VXzScolnq+KCovA6aoiAcU+2W6t61yyUb7sK1KzJ12c/5U
         nXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpwxE8KOKo7vs8TiNgi5SF3L44fg9BagOWF/T6JqWgM=;
        b=4OtYU3VgsdIx2Wzq4q9ReCZe6pSswfJdbEf1aUddZd/s0RrQaWtWfrQGOQvPUSEG8I
         YQABLeC5w3EmeVY4Xe8KG8kQio4xoOtpFcjHrP+15LYJueTeRDlWJZKZolMCRygI2uhm
         j4Yi6kmJ/JxZndn8p5D68G1SHWEipgGo4aOn+kmadjrtN8QjTMsFGeEbEp0DaFkJp9W1
         oNFmTDyIQX2W4rHUeZNIE+8W+AnVabteXthvSMLDw28k+BKN5ufd/HDvYdKxLDzBv3bZ
         keUvBSf/8uyPDRr6IzN97IUnQ/6surphNQSB+q1i/E97QuVVYEgCJo4RCf4pEhN+LS8z
         JPEQ==
X-Gm-Message-State: AFqh2ko+iT5gm9xAyjUv7qQEwFMp0fOpAihDTSNWEvzs35StDDbH5uMe
        di1KTzq3XR3F2VLmqSibpAz2pX+gztWG/8qD
X-Google-Smtp-Source: AMrXdXvpUrdLTKB1TN1/c4hhUvynD6j58laptg2XGGRToYzHT53d2Hqibs9JfHnI4mJwoG4/f3sT1w==
X-Received: by 2002:a05:6a20:a682:b0:b1:d045:2818 with SMTP id ba2-20020a056a20a68200b000b1d0452818mr232027pzb.2.1673911782288;
        Mon, 16 Jan 2023 15:29:42 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d21-20020a630e15000000b0047781f8ac17sm16111023pgl.77.2023.01.16.15.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 15:29:41 -0800 (PST)
Message-ID: <1e2c9225-4d29-051e-e1f5-e0948d7889e3@kernel.dk>
Date:   Mon, 16 Jan 2023 16:29:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Michael Kelley <mikelley@microsoft.com>
References: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
 <7c69e3b5-c81b-a3ba-9588-9a59c32c45b7@opensource.wdc.com>
 <4ed4090b-7bff-dd43-da23-915f269bd759@kernel.dk>
In-Reply-To: <4ed4090b-7bff-dd43-da23-915f269bd759@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/23 4:28?PM, Jens Axboe wrote:
> On 1/16/23 4:20?PM, Damien Le Moal wrote:
>> On 1/17/23 06:06, Jens Axboe wrote:
>>> If we're doing a large IO request which needs to be split into multiple
>>> bios for issue, then we can run into the same situation as the below
>>> marked commit fixes - parts will complete just fine, one or more parts
>>> will fail to allocate a request. This will result in a partially
>>> completed read or write request, where the caller gets EAGAIN even though
>>> parts of the IO completed just fine.
>>>
>>> Do the same for large bios as we do for splits - fail a NOWAIT request
>>> with EAGAIN. This isn't technically fixing an issue in the below marked
>>> patch, but for stable purposes, we should have either none of them or
>>> both.
>>>
>>> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")
>>>
>>> Cc: stable@vger.kernel.org # 5.15+
>>> Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
>>> Link: https://github.com/axboe/liburing/issues/766
>>> Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> ---
>>>
>>> Since v1: catch this at submit time instead, since we can have various
>>> valid cases where the number of single page segments will not take a
>>> bio segment (page merging, huge pages).
>>>
>>> diff --git a/block/fops.c b/block/fops.c
>>> index 50d245e8c913..d2e6be4e3d1c 100644
>>> --- a/block/fops.c
>>> +++ b/block/fops.c
>>> @@ -221,6 +221,24 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>>  			bio_endio(bio);
>>>  			break;
>>>  		}
>>> +		if (iocb->ki_flags & IOCB_NOWAIT) {
>>> +			/*
>>> +			 * This is nonblocking IO, and we need to allocate
>>> +			 * another bio if we have data left to map. As we
>>> +			 * cannot guarantee that one of the sub bios will not
>>> +			 * fail getting issued FOR NOWAIT and as error results
>>> +			 * are coalesced across all of them, be safe and ask for
>>> +			 * a retry of this from blocking context.
>>> +			 */
>>> +			if (unlikely(iov_iter_count(iter))) {
>>> +				bio_release_pages(bio, false);
>>> +				bio_clear_flag(bio, BIO_REFFED);
>>> +				bio_put(bio);
>>> +				blk_finish_plug(&plug);
>>> +				return -EAGAIN;
>>
>> Doesn't this mean that for a really very large IO request that has 100%
>> chance of being split, the user will always get -EAGAIN ? Not that I mind,
>> doing super large IOs with NOWAIT is not a smart thing to do in the first
>> place... But as a user interface, it seems that this will prevent any
>> forward progress for such really large NOWAIT IOs. Is that OK ?
> 
> Right, if you asked for NOWAIT, then it would not necessarily succeed if
> it:
> 
> 1) Needs multiple bios
> 2) Needs splitting
> 
> You're expected to attempt blocking issue at that point. Reasoning is
> explained in this (and the previous commit related to the issue),
> otherwise you end up with potentially various amounts of the request
> being written to disk or read from disk, but EAGAIN being returned for
> the request as a whole.

BTW, this is no different than eg doing a buffered read and needing to
read in the data. You'd get EAGAIN, and no amount of repeated retries
would change that. You need to either block for the IO at that point, or
otherwise start it so it will become available directly at some later
point (eg readahead).

-- 
Jens Axboe

