Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8105EC432C0
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 18:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C25C2080F
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 18:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfKZS7v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:59:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43005 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfKZS7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 13:59:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so9614106pfh.9
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 10:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yFfg1lSnsBMrAM142U0AFqiJ8elrPRBqPjzpw9fVEhY=;
        b=WBWDJSJot7iNs4MUvDZmMQl8BSBHf6bqhqsUBawZ58C4QVNonlv7hoZ9Pufho6szRe
         pJy647aCuqPjgzwrE2YRPd7+fFtND0TK8MDlOH72e9VMzvx6fPdw0tOq9jKU/wILaQIB
         /nrwKOJJ+CFwckauqrlXxJXpm0B/Mk5TVYYgdeDmH8PXUZhxI+rsuP5TnNQC1xVERzSl
         zBYfJjQuTKOuTPkCtdVPuAncQOP63uyNH0cmfsuFzyZuSbaQXXL8uo8pEtGXXW0pExd1
         MJrbD8q8uFY1ogjmodyNGIPD28raVLPpOxqn9anHo/D8f9T3QY+eR0iSjwJBEAavSRY5
         ymSQ==
X-Gm-Message-State: APjAAAW6zZQr9i8sXDIvNY6tWC+kx4fnnYpnSdNyI7+p0Kmx3CDMlutY
        u5lYu6pskBpr9hFCw0L5GX7S0yT8
X-Google-Smtp-Source: APXvYqyrCjyp2ogj7f9BEuSrYoomvBVWEP4NAs7w9p/caRs/wFYze5Kl9niM8Oxy5kwGbLaZUU3v0g==
X-Received: by 2002:a62:34c2:: with SMTP id b185mr43314399pfa.215.1574794790348;
        Tue, 26 Nov 2019 10:59:50 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id q13sm2684733pjc.4.2019.11.26.10.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 10:59:49 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2] loop: avoid EAGAIN, if offset or block_size are
 changed
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20190518004751.18962-1-jaegeuk@kernel.org>
 <20190518005304.GA19446@jaegeuk-macbookpro.roam.corp.google.com>
 <1e1aae74-bd6b-dddb-0c88-660aac33872c@acm.org>
 <20191125175913.GC71634@jaegeuk-macbookpro.roam.corp.google.com>
 <a4e5d6bd-3685-379a-c388-cd2871827b21@acm.org>
 <20191125192251.GA76721@jaegeuk-macbookpro.roam.corp.google.com>
 <baaf9725-09b4-3f2d-1408-ead415f5c20d@acm.org>
 <4ab43c9d-8b95-7265-2b55-b6d526938b32@acm.org>
 <20191126182907.GA5510@jaegeuk-macbookpro.roam.corp.google.com>
Message-ID: <73eb7776-6f13-8dce-28ae-270a90dda229@acm.org>
Date:   Tue, 26 Nov 2019 10:59:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126182907.GA5510@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/19 10:29 AM, Jaegeuk Kim wrote:
> On 11/25, Bart Van Assche wrote:
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 739b372a5112..84bdb3a6f6d0 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -1264,14 +1264,17 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>>   		goto out_unlock;
>>   	}
>>
>> -	if (lo->lo_offset != info->lo_offset ||
>> -	    lo->lo_sizelimit != info->lo_sizelimit) {
>> -		sync_blockdev(lo->lo_device);
>> -		kill_bdev(lo->lo_device);
>> -	}
>> +	/*
>> +	 * Drain the page cache and the request queue. Set the "dying" flag to
>> +	 * prevent that kill_bdev() locks up.
>> +	 */
>> +	sync_blockdev(lo->lo_device);
>>
>> -	/* I/O need to be drained during transfer transition */
>> -	blk_mq_freeze_queue(lo->lo_queue);
>> +	blk_set_queue_dying(lo->lo_queue);
>> +	blk_mq_freeze_queue_wait(lo->lo_queue);
>> +
>> +	/* Kill buffers that got dirtied after the sync_blockdev() call. */
> 
> Any race condition where we can truncate any dirty pages written between
> sync_blockdev() and kill_bdev()?
> 
> Thanks,
> 
>> +	kill_bdev(lo->lo_device);

Hi Jaegeuk,

As you know sync_blockdev() triggers a call to filemap_write_and_wait(). 
That function in turn calls mapping->a_ops->writepages() with sync_mode 
== WB_SYNC_ALL. I think that causes sync_blockdev() to wait until all 
dirty pages have been written so we don't have to worry about pages 
dirtied before the sync_blockdev() call started.

Should we try to handle read and write requests that are submitted to a 
loop device while the loop device block size, offset and/or size are 
being modified or is it OK to fail such requests? The 
blk_set_queue_dying() and blk_mq_freeze_queue_wait() calls set the DYING 
queue flag and also wait for all ongoing block layer requests submitted 
to the loop device to finish. All later submit_bio(), 
generic_make_request(), direct_make_request() and blk_get_request() 
calls will fail with BLK_STS_IOERR or -ENODEV, including those triggered 
by kill_bdev(). In other words, the above patch causes I/O to fail that 
is submitted concurrently with kill_bdev(). Do you agree with failing 
I/O requests submitted to a loop device while the loop device block 
size, offset and/or size are being modified?

Thanks,

Bart.
