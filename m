Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EEBC433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D96613D3
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhKQPoh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbhKQPog (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 10:44:36 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF1C061570
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:41:37 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i12so3163983ila.12
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HVSg0FPvROK1Etfi0dL1o5PTWoEjRYmKfOMh8wB6E3Y=;
        b=JfDAP5DSBM45Yb/oLEa6wPvd1X2UVo3FwuMgUYn+F4dn5IBwddLaJfzF2ROVZfH9Fq
         9RdvAy9ibkylszoVmNqRvVEqB8qO0XbAzkVy8VfaqzNMQuzumeCjNZHhkdCrfcfp40FO
         qcxtD6Zoit/Mfq3W0vMq8POxFBoyNXi+lXaWjz7o1uDpUMfGL4b9M3YNez5X+v3k2Epb
         12if3S6PISI8WhjqJezrLzlwxdcvzvdRlC0fi2NfwrTR30FimA99hMojwh+RytEwGrtz
         STPAawW+wdEplzLebO2xsAzU9Gz8A8Raa8Wpc9WX7wvtFFlf04TGNVOmKqq3T4cHn0lp
         Tqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HVSg0FPvROK1Etfi0dL1o5PTWoEjRYmKfOMh8wB6E3Y=;
        b=8R6TlqJGQYA48WxLbjXhrjLnBVzLz0Fb4W07kjeBQPrx3Kr9a2QQFaWMd/UdmN3qHe
         MUj5CuGpauYGYJn+KoSRwgRvTos7Y9BzbcvxeYoXeA4k2TB7cB4U6JS1DQQYXvuitOzE
         9RWGsSESxB6eXLLfKkl3w1xyD82DQbrgm4AlO42h+2SaV7r0kw/0bxX0OW8Wqe5u0pwr
         ZqRlaJdDn8krnhAxhYZidD8GnQViPVO7315acHnynxfv52MpYhxn4+q8PFB2U9GbSSVl
         WZ9H8izzhSQH2xLSwEVRtDyVM0deSe9slq3bVohTk2viMWRlecQEkheL+GyGOmsqtLri
         wBHg==
X-Gm-Message-State: AOAM532h28VteYOga/4ShsykOAb6Uj6bDUAUh8Ko48Xg9pqOMdOo5NG8
        EcfL/6KJDNztTkLLHpYrIflKExbJnQ0idqNt
X-Google-Smtp-Source: ABdhPJxIzuc9DEjqIV0AV0i7rpgN6RL7c4KYkVhe6Yc8fIpESVMYp424RodHZfdvyrdAj531xCmZyQ==
X-Received: by 2002:a05:6e02:1d02:: with SMTP id i2mr11186594ila.248.1637163696959;
        Wed, 17 Nov 2021 07:41:36 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u7sm103046ill.84.2021.11.17.07.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:41:36 -0800 (PST)
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-2-axboe@kernel.dk> <YZSgXbsbTZXaKtNC@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <afb0bd32-fe86-f9c3-9686-f62127f823f2@kernel.dk>
Date:   Wed, 17 Nov 2021 08:41:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZSgXbsbTZXaKtNC@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/21 11:25 PM, Christoph Hellwig wrote:
>> @@ -2208,6 +2208,19 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
>>  	int queued = 0;
>>  	int errors = 0;
>>  
>> +	/*
>> +	 * Peek first request and see if we have a ->queue_rqs() hook. If we
>> +	 * do, we can dispatch the whole plug list in one go. We already know
>> +	 * at this point that all requests belong to the same queue, caller
>> +	 * must ensure that's the case.
>> +	 */
>> +	rq = rq_list_peek(&plug->mq_list);
>> +	if (rq->q->mq_ops->queue_rqs) {
>> +		rq->q->mq_ops->queue_rqs(&plug->mq_list);
>> +		if (rq_list_empty(plug->mq_list))
>> +			return;
>> +	}
> 
> I'd move this straight into the caller to simplify the follow, something
> like the patch below.  Also I wonder if the slow path might want to
> be moved from blk_mq_flush_plug_list into a separate helper to keep
> the fast path as straight as possible?

Yes, I think that's better. I'll fold that in.

-- 
Jens Axboe

