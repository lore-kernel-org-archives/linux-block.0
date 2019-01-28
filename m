Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6262C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A470C2148E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Nx5sBQGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfA1V4b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:56:31 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46022 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfA1V4b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:56:31 -0500
Received: by mail-io1-f66.google.com with SMTP id c2so14816617iom.12
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8eRwrHQiaqcz8o2YBseAPqCa+0UCAA7BflEoGnKjaTQ=;
        b=Nx5sBQGIQ+tiMS4BuY0t0SzgNDmTSFHRCvWDb3nidZh9+DNmF2UYayz6iCmkMOZmXs
         lqQvjrig36WwWlh4xePbN1zMZcwYPPUu6zZXCoIQXOhcicqvDxwQiIyO9oDhPejndzLI
         3fx6icS/z+0n8QInYM1hUINdBcOZZXKVSgOtC7jJe/+JxU2Z/yPOxuklI5bTWVMU0/jo
         VJp3ubUepLE9UFGQ/dce+4umM9OZF5fWfX7vKlPJclu/thPxhXE6BVjf4DJedQM5uxk7
         0RwTZyWdqWwXoErX6sSs9aHuJvZ/38/nKraqv2T0opF/Sq7vVn0L8zlpLrj203o1E6xv
         J1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8eRwrHQiaqcz8o2YBseAPqCa+0UCAA7BflEoGnKjaTQ=;
        b=NKCAfAwoktRKcJnGMEGhKDG98l+S7lSGvJHgRn+9Jf5uU3hjElMFqLxj7bXOggfPOE
         hnQqo3j5QgpsbdzBNYVkOcyw/NXOFo+5VF9N4MluYkqjZAOJItpuY2oEVILjA402Ch+C
         OBVAKkw6uUlgnrj5LKqjP5kTZV7XYinjYo11zQGDZ/q8hRoChQo8eefVmNOLkH/gTYOq
         6jQzT1zkuFbJue6YGeoV/NNKcW0u1+CHAs2CJKnc1V2nIAG1CqTxTOaFQjYvxPoVNWzk
         52AfA1JkzQ2O4dn8HAFcPRhgRXti929QPuST4TuVjYHLpScmvDz5RZYs/J0A/1vmAxgx
         iieA==
X-Gm-Message-State: AJcUukfMGlkoO1I5Uh0m5B8mPecIwg/4Wp53w6pWXoL2Uw5suCw+1P4w
        tCRGnjyg45uCr9xMSNXcog7kzA==
X-Google-Smtp-Source: AHgI3IZLlzwHKo0fM3+el76q0IopY40PiohFG0qmmbMdu9aGcGNI8VfVLcxlyH2Jc8AvjWR6C8iBkg==
X-Received: by 2002:a6b:c386:: with SMTP id t128mr14002981iof.304.1548712590414;
        Mon, 28 Jan 2019 13:56:30 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t64sm451326itb.5.2019.01.28.13.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:56:28 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
        avi@scylladb.com
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <x498sz4wisd.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <71018780-ac32-4ea8-b4c8-dd6c8bb3cbe1@kernel.dk>
Date:   Mon, 28 Jan 2019 14:56:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <x498sz4wisd.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 2:53 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> +static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
>> +			    unsigned min_complete, unsigned flags,
>> +			    const sigset_t __user *sig, size_t sigsz)
>> +{
>> +	int submitted, ret;
>> +
>> +	submitted = ret = 0;
>> +	if (to_submit) {
>> +		submitted = io_ring_submit(ctx, to_submit);
>> +		if (submitted < 0)
>> +			return submitted;
>> +	}
>> +	if (flags & IORING_ENTER_GETEVENTS) {
> 
> Do we want to disallow any unsupported flags?

Yes good point, we do that in other spots. Fixed.

-- 
Jens Axboe

