Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA12C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE03C20659
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AE5vflTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE03C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeK2DUd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:20:33 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53977 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbeK2DUc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 22:20:32 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so5231163ita.3
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 08:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zRoLLApu3nnQvwZDw+a7agf2oJjGKPgL+NX9g+NXT6Q=;
        b=AE5vflTTvK4112hrUTYyWnSAgH7SxcUzsTEP6vc6AIUllP3Rot/FZa0GU9VKfJIQEk
         CpqOYEmUVZ0IEBZeoYSQkfHZlSweaT/EKtno8mqd8tbJlg7Y/gCAnfi5ysNkKliNyjA9
         bs5UYSrqzfCGCoe1j1DGFav0MZKdG981K67kNPdeYAFr3jBqkn7GWCo3gnDYQw1VpGOh
         bRFw9MQCKAgBubrM1Cq0V1Z4kxs1Wt26wm8GpZJaKEpXIJ6sjpA6QlTCe4xOzHbLKBsC
         8GWT2AjTSoUsYZWCPAkO+zsWUUFy8aMlYAqTzLQUVwMZTPUJaVdcXgKSfrzxOP7vtbhY
         t56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zRoLLApu3nnQvwZDw+a7agf2oJjGKPgL+NX9g+NXT6Q=;
        b=c6mV/Je+sh94YoSCUSfSPPcjGwMzR9CNRgZME7lVRtBqedZE9iWJXxrX8ldNWzrSTm
         fLDcGH3cRxjpUxuipSWol+jTHDjGQN5kU7/NJAp4QrgEbdtd4kx61GS7rlHUhEyLDmGr
         Bqes+wqU61f85Tezg3adAGcNmXnZZmCA6e3UXf/vdiOpjqC/nF5bTZTbv+W0raPf5zb6
         f4frfFOGDAZzBqwKlsY5jG/6Czd3qoEmxVw6LNAIVrcMYy38PQoW4TcUzTsrTiUBo+t/
         SzwLZpxbwuQZK8TvjG5UmbbLe+rMeYfbpWqyhSwUqEaDcJ0C8Z7AL9S6YoI7Zw1PGkGF
         liiw==
X-Gm-Message-State: AA+aEWavU25Ou203j6FE6qBY7rtXnENdH/DoUtIi0LbDKNXZvARvwy2M
        LhGFsb7d27YmLK31re/2EyifnEaQ1bU=
X-Google-Smtp-Source: AFSGD/Wrxp/opyvX+Wd1IsLUhxgMkq/3riWgqJ30JrUTH/9MdoDc6StOIyrrN/BhpjZsITk4a4DE1w==
X-Received: by 2002:a24:5e4e:: with SMTP id h75mr3570829itb.39.1543421900339;
        Wed, 28 Nov 2018 08:18:20 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l18sm1326849itb.32.2018.11.28.08.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 08:18:19 -0800 (PST)
Subject: Re: [RFC PATCH v2] block: add io timeout to sysfs
To:     Bart Van Assche <bvanassche@acm.org>,
        Weiping Zhang <zhangweiping@didiglobal.com>
Cc:     linux-block@vger.kernel.org
References: <20181119141145.GA25638@192.168.3.9>
 <1543421621.185366.101.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a552c7c6-a6a6-1ced-2754-8045d651eec6@kernel.dk>
Date:   Wed, 28 Nov 2018 09:18:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543421621.185366.101.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 9:13 AM, Bart Van Assche wrote:
> On Mon, 2018-11-19 at 22:11 +0800, Weiping Zhang wrote:
>> Give a interface to adjust io timeout by device.
>>
>> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
>> ---
>>
>> Changes since v1:
>> * make sure timeout > 0
>>
>>  block/blk-sysfs.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
> 
> Documentation for new block layer sysfs attributes should be added in
> Documentation/ABI/testing/sysfs-block and also in Documentation/block/queue-sysfs.txt.
> Please add such documentation for this new attribute.

Yes, please send a followup patch to add the documentation.

>> +static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
>> +				  size_t count)
>> +{
>> +	unsigned int val;
>> +	int err;
>> +
>> +	err = kstrtou32(page, 10, &val);
>> +	if (err || val == 0)
>> +		return -EINVAL;
>> +
>> +	blk_queue_rq_timeout(q, val);
>> +
>> +	return count;
>> +}
> 
> Setting the block layer timeout to a very high value (e.g. hours) may make it look
> like a request got stuck without users having an easy way of figuring out what is
> going on. I'm wondering whether this function should restrict the upper bound for
> block layer timeouts. How about limiting timeout values to ten minutes?

This is no different than folks using SG_IO/bsg and putting a high timeout
in their commands. I don't think we should impose a limit, if you set it
high, you get exactly what you asked for.

-- 
Jens Axboe

