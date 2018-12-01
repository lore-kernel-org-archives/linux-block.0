Return-Path: <SRS0=alrN=OK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ADAC65BAE
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 18:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF46B20834
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 18:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF46B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbeLBFps (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:45:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36662 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBFpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 00:45:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so3921977pgm.3
        for <linux-block@vger.kernel.org>; Sat, 01 Dec 2018 10:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1FAKTKCDSqFR+F1fOGpwnW6PjNh1GRlTdlGjE1Icg2A=;
        b=QEbL5JAjBC9rJsLOG2nFzH4xOEFElxmcZt3ayAD/i8DAbOKpjen92i+S3dkDaJc5y8
         xW0GdQe1uGsun8sez7mhGcVsJCYhplYcmO8V36P+KvWzKQ0EENndTDqOan2yVGVEDjww
         CMhTqH00G28E0xDhUKh++tpzlrzshhmd3HGwy1JPWH2/5ZmLX5mF7SR71X3AydrR/hVS
         kuwy6rS/Au7/hZNZz2GVFSJspJyofrT+84m6LKInUSvwnzI8OISHafW0ZhuskFco+pUZ
         sygcXpe7tljTMeobX/Yuaz//BLIcXQUe9xfVLGAcvrZDqpr3+u8viDlfguHlcPlMsXy0
         EAAA==
X-Gm-Message-State: AA+aEWbj07Gk7+0xNme/pRwjq2NAYECz9RkFpgdhvphbhAMYxyKfReby
        J2CH2ea7pPR7v0kmnQE/rDE=
X-Google-Smtp-Source: AFSGD/X8xHkgQ2WovVc0uSSKfTYyw8GG2VyrX29DCz9EhMbNgHVjOoxoftUN9YYGuIRe4NL9fUrxBg==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr8629477pgj.410.1543689160363;
        Sat, 01 Dec 2018 10:32:40 -0800 (PST)
Received: from asus.site (c-107-3-158-240.hsd1.ca.comcast.net. [107.3.158.240])
        by smtp.gmail.com with ESMTPSA id u123sm8721165pfb.1.2018.12.01.10.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 10:32:39 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0dbbafd4-8b40-5a95-1ea5-30e2cd61826b@acm.org>
Date:   Sat, 1 Dec 2018 10:32:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/18 9:11 AM, Hannes Reinecke wrote:
> On 12/1/18 5:48 PM, Christoph Hellwig wrote:
>> On Fri, Nov 30, 2018 at 01:36:09PM -0700, Jens Axboe wrote:
>>> On 11/30/18 1:26 PM, Keith Busch wrote:
>>>> A driver may wish to iterate every tagged request, not just ones that
>>>> satisfy blk_mq_request_started(). The intended use is so a driver may
>>>> terminate entered requests on quiesced queues.
>>>
>>> How about we just move the started check into the handler passed in for
>>> those that care about it? Much saner to make the interface iterate
>>> everything, and leave whatever state check to the callback.
>>
>> So we used to do that, and I changed it back in May to test for
>> MQ_RQ_IN_FLIGHT, and then Ming changed it to check
>> blk_mq_request_started.  So this is clearly a minefield of sorts..
>>
>> Note that at least mtip32xx, nbd, skd and the various nvme transports
>> want to use the function to terminate all requests in the error
>> path, and it would be great to have one single understood, documented
>> and debugged helper for that in the core, so this is a vote for moving
>> more of the logic in your second helper into the core code.  skd
>> will need actually use ->complete to release resources for that, though
>> and mtip plays some odd abort bits.  If it weren't for the interesting
>> abort behavior in nvme-fc that means we could even unexport the
>> low-level interface.
>>
> Yes, I'm very much in favour of this, too.
> We always have this IMO slightly weird notion of stopping the queue, set 
> some error flags in the driver, then _restarting_ the queue, just so 
> that the driver then sees the error flag and terminates the requests.
> Which I always found quite counter-intuitive.
> So having a common helper for terminating requests for queue errors 
> would be very welcomed here.
> 
> But when we have that we really should audit all drivers to ensure they 
> do the right thin (tm).

Would calling blk_abort_request() for all outstanding requests be 
sufficient to avoid that the queue has to be stopped and restarted in 
the nvme-fc driver?

Bart.
