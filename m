Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80622C07E85
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 13:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463E82084C
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 13:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pa5zZgws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463E82084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeLENK1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:10:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34967 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLENK0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 08:10:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so9024293pgs.2
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 05:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bwlBPVRzMS0EuEdU2s/Ly9iDEaOpfIj8Bxy6xGC7DWU=;
        b=pa5zZgws9sMpWPTusT5Q8E+3mzIdt8UaggItLYYQg2v/O/I5Bvkm8U5cHX63kZMI7W
         V6koh4M1Wv3q8EdpDpsYQKnw02Tlm/ZXAhjwijyBP9yTy69K49TUQU/k6+cm9lO7oP5l
         cBRlygz/ZyM6uyWuoYMlVSJ9HjLgjckvbK7FBIvGSdOsZIQ6nZCO1HkP8jtFm0/yloYl
         ba1DiBniGe0wT0+sinIYhMN8pGzC99HHmunmXifUYqfsPDROpOr8dmdx4KBvcjHmdOF4
         mRk0LF+ohMVJEKwd9zT08Pz5Rs2crtdr780oyspdGttPEDBJmutIy0RuWscyVva2siMB
         fMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bwlBPVRzMS0EuEdU2s/Ly9iDEaOpfIj8Bxy6xGC7DWU=;
        b=ILOnh18WO9TyXfDbq4hp4/+EYb/CU0lJAKgK7jOUH2pQhIxebG1vA05QFj4pCxzNVb
         uw6J7SNsoTVAxVz5V1NNSfldcWiH9lRDAQICfq7bOAxslIzU8UfAmpf3dBhd6C/m4WOM
         vcTrO9H8kw+o8yTisHifu/kusc7UaCxqVFsFu5LPCeQXwxP0C3oBHnslTwQrQSy/URQc
         TCv44lGj5VTQ7S6Ux1ZRsQ9Ijvdn6VhWSOz3H9OQK1uHFLJJeS+AwC8islS3Pg7ahOGb
         PEeph9hl98uZd33wfy6kPRrcpQyKgeTmeEz8ssY3X0xUc7e7tIu75eb8ETUVTxt0Sn2V
         GnEg==
X-Gm-Message-State: AA+aEWZUX2qV1xUEWjSDK//QwgVwU1E1Y3v4l+D0H/sApKx4BFcycxxa
        ab8CiOjyCdWIPXQXQbIIswi7/bJP9jo=
X-Google-Smtp-Source: AFSGD/VOKawi/Zi2j6Y6ifnMSrhJq9Z1E3UHv4JnnFvyD3xPI7QWPm9s4pngJiVAgwUBFE+245z2pA==
X-Received: by 2002:a63:6ecf:: with SMTP id j198mr20786234pgc.3.1544015425791;
        Wed, 05 Dec 2018 05:10:25 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id r12sm19988926pgv.83.2018.12.05.05.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 05:10:24 -0800 (PST)
Subject: Re: [PATCH 15/26] aio: support for IO polling
To:     Benny Halevy <bhalevy@scylladb.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com
References: <20181204233729.26776-1-axboe@kernel.dk>
 <20181204233729.26776-16-axboe@kernel.dk>
 <51ae659719c64d869cae06cdc94748f64132ba3a.camel@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a8df7d41-3a3c-370f-33be-1e2954b45362@kernel.dk>
Date:   Wed, 5 Dec 2018 06:10:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <51ae659719c64d869cae06cdc94748f64132ba3a.camel@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 2:56 AM, Benny Halevy wrote:
>> +static int aio_iopoll_getevents(struct kioctx *ctx,
>> +				struct io_event __user *event,
>> +				unsigned int *nr_events, long min, long max)
>> +{
>> +	struct aio_kiocb *iocb;
>> +	int to_poll, polled, ret;
>> +
>> +	/*
>> +	 * Check if we already have done events that satisfy what we need
>> +	 */
>> +	if (!list_empty(&ctx->poll_completing)) {
>> +		ret = aio_iopoll_reap(ctx, event, nr_events, max);
>> +		if (ret < 0)
>> +			return ret;
>> +		/* if min is zero, still go through a poll check */
> 
> A function-level comment about that would be more visible.

Yes, that might be a better idea.

>> +		if (min && *nr_events >= min)
>>
>> +			return 0;
> 
> if ((min && *nr_events >= min) || *nr_events >= max) ?
> 
> Otherwise, if poll_completing or poll_submitted are not empty,
> besides getting to the "Shouldn't happen" case in aio_iopoll_reap,
> it looks like we're gonna waste some cycles and never call f_op->iopoll

Agree, that would be a better place to catch it. I'll make those two
changes, thanks!

>> +
>> +	/*
>> +	 * Find up to 'max' worth of events to poll for, including the
>> +	 * events we already successfully polled
>> +	 */
>> +	polled = to_poll = 0;
>> +	list_for_each_entry(iocb, &ctx->poll_completing, ki_list) {
>> +		/*
>> +		 * Poll for needed events with spin == true, anything after
>> +		 * that we just check if we have more, up to max.
>> +		 */
>> +		bool spin = polled + *nr_events >= min;
> 
> I'm confused. Shouldn't spin == true if polled + *nr_events < min?

Heh, that does look off, and it is. I think the correct condition is:

bool spin = !polled || *nr_events < min;

and I'm not sure why that got broken. I just tested it, slight
performance win as expected correcting this. It ties in with the above
nr_events check - it's perfectly valid to pass min_nr == 0 and just do a
poll check. Conversely, if we already spun, just do non-spin checks on
followup poll checks.

>> +static int __aio_iopoll_check(struct kioctx *ctx, struct io_event __user *event,
>> +			      unsigned int *nr_events, long min_nr, long max_nr)
>> +{
>> +	int ret = 0;
>> +
>> +	while (!*nr_events || !need_resched()) {
>> +		int tmin = 0;
>> +
>> +		if (*nr_events < min_nr)
>> +			tmin = min_nr - *nr_events;
> 
> Otherwise, shouldn't the function just return 0?
> 
> Or perhaps you explicitly want to go through the tmin==0 case
> in aio_iopoll_getevents if *nr_events == min_nr (or min_nr==0)?

No, we need to go through poll, if min_nr == 0, but only if min_nr == 0
and !nr_events. But we only get here for nr_events != 0, so should be
fine as-is.

Thanks for your review, very useful! I'll make the above changes right
now.

-- 
Jens Axboe

