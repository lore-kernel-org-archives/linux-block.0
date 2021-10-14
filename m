Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DFFC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 13:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DD5610E7
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 13:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhJNNFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJNNFs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 09:05:48 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E2C06174E
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 06:03:43 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id s3so3470784ild.0
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PGg6tIfmHttRoxHW4Q2JJNlX4U1geAKtKCI9yt5+TGI=;
        b=YipiAHZ5JwnuqzzjnFzAjxw9nVZJ3bYXyCnhdWoTKY3BTrMqFKxPWgjBLjljougNUG
         +gxI/QeTnxOeBtHcFzPs+8jKKToyB0P2RFTKIyI1AhwIx+5oeN2tNBb1fxK5ClhEX7Ko
         f7JAydjWDZsgH0JVKyN5CuaLhV6lhx330bu28N9Bz2XU6ha6Z1Rz5UT27QlBcZ+g/KCE
         Hq23QGE8B63ctbOBfdwaDxpN1EGErVjPYAERKi3Jlszv2MXc/skcyArE5s2lCe4JVuqc
         px6UFf6ZStTHncPyBAZQ0HvSLsrSMOYRhd5zpTVAFsI4XsvqqPUwdJ53EbqWD++odubo
         TqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PGg6tIfmHttRoxHW4Q2JJNlX4U1geAKtKCI9yt5+TGI=;
        b=KizfCFIpRJrA7f/9ibRMFYRyu1krqcpY4LKuNG3/CaidU8BauRK0CNCGKYWx2tjJ3x
         GtS22hOS9CC7Aw49JKsodxFrhjWV7eZ7Nyxktaxd/MMLMlj+RrmZKJCy81tB7fkmnqR3
         vYb0spYcok9I/8SM3GPQnfwdm4Sap5LfIJLooMFQekfVdyix4TtNS7tKF7wPcz6kjtVu
         OWfpfqurTUHAC3kmXOfcQmC0xjULvRSFvJMBuNxxiOu8P31DhvIHxS0ts6J4dyGQOzje
         sLRjedsY3+eZKtsDHavtLeglL3dZ3rJk20Ywe/C8+Y/YrLySRXxBporfEa0rGsSfjymR
         U4lA==
X-Gm-Message-State: AOAM533h0WHBpEKQaNxlViUocFn9JsmrBfcwbXGWewgMQXQd7xaIUwib
        NDeHHQ07Es4n07YPPaQ6cvc3XBwwm8PXjQ==
X-Google-Smtp-Source: ABdhPJw5CAqv1Kq67W0gNA6UKqSa24YELNJJIrrNemXqej1X4Y2m9u13uWriNSa6/3kFd9Q7xquKwg==
X-Received: by 2002:a92:2001:: with SMTP id j1mr2314015ile.84.1634216623200;
        Thu, 14 Oct 2021 06:03:43 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id v15sm1226971ilg.87.2021.10.14.06.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 06:03:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] block: improve batched tag allocation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211012171525.665644-1-axboe@kernel.dk>
 <20211012171525.665644-3-axboe@kernel.dk> <YWe9e+4V5Cw325uA@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <67852402-6217-f537-2c30-274903923fea@kernel.dk>
Date:   Thu, 14 Oct 2021 07:03:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWe9e+4V5Cw325uA@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 11:17 PM, Christoph Hellwig wrote:
> On Tue, Oct 12, 2021 at 11:15:25AM -0600, Jens Axboe wrote:
>>  
>> +unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
>> +			      unsigned int *offset)
>> +{
>> +	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
>> +	struct sbitmap_queue *bt = &tags->bitmap_tags;
>> +	unsigned long ret;
>> +
>> +	if (data->shallow_depth ||data->flags & BLK_MQ_REQ_RESERVED ||
> 
> Missing whitespace after the first ||.

Fixed.

>> +	if (data->nr_tags > 1) {
>> +		unsigned long tags;
>> +		unsigned int tag_offset;
>> +		int i, nr = 0;
>> +
>> +		tags = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
>> +		if (unlikely(!tags)) {
>> +			data->nr_tags = 1;
>> +			goto retry;
> 
> Unless I'm missing something we don't want the retry case that maps
> the contexts against and calls blk_mq_tag_busy again.

Yes and no, we could've been preempted and we're now on a different CPU.
It's not a huge deal or likely outcome, and it'll only hurt efficiency a
bit if that's the case. Can be skipped.

>> +		}
>> +		for (i = 0; tags; i++) {
>> +			if (!(tags & (1UL << i)))
>> +				continue;
>> +			tag = tag_offset + i;
>> +			tags &= ~(1UL << i);
>> +			rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
>> +			rq->rq_next = *data->cached_rq;
>> +			*data->cached_rq = rq;
>> +		}
>> +		data->nr_tags -= nr;
> 
> And keeping all this batch logic in a helper (even if inlined) would
> simplify the code a lot.  Something like this untested patch:

Yeah, I did go back and forth on that, it's small enough that I didn't
care too much about it, but an inline helper is fine too. I can fold
this in.

-- 
Jens Axboe

