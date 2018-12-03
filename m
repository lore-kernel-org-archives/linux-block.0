Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC65C04EBF
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 18:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA26208A3
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 18:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bTZJ00g8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA26208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLCS5o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:57:44 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:45401 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeLCS5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 13:57:44 -0500
Received: by mail-pl1-f181.google.com with SMTP id a14so6911335plm.12
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2d/gJnVLoLtlTisUqT8Dy71CWwPnyVGjWkZfAyew+JI=;
        b=bTZJ00g8haQGdUUeuxe3hYH1ztsjAI4FnqrZ+a6MmBk7/OHMdR6Fdkz1d8aX9w4D0N
         ZuGnvN3z5R4lBYwzOhoqblBBWsbwrXPf/DZsk8i2AjSu/I6PTkh5CMrvn5bMpvYSiLz5
         zqZQY4W78BMcvOatmMzQrsrX3360+ihR4Z6XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2d/gJnVLoLtlTisUqT8Dy71CWwPnyVGjWkZfAyew+JI=;
        b=jZ1j7N1NB4NmNtSgo70JvyCqGx3qmHoVSHWJw5wpgKiNtp0nBwAbZ5PVBCmL2ieR51
         sn5344LEJe7qaTIcMeHdz3mao80SXZJ7Grb5C+JQdUhok8WvcN3SsN3XROBhr5QUIoOx
         h6JsosYBZ9Qvb6jl4xw0a+ftjVnvKGaM7mV88+lyGhcr+pPeE3SNRPi7Pit83GeJmerO
         /wEwS31fGzILIqqRKlVw3AgMon9mZCdzN8JkqZGd4xmMI7sdY6PrOzL7ZNk5OPRnQMYZ
         Cw/c+B8iz5u7LGC+qtsGanorqQ2REIZqefEwjDZrkNHrFD0aSoZ33nmQdCGFt2beIeTd
         S7+w==
X-Gm-Message-State: AA+aEWbzx6YemEtFm1R9picPLu2pRLgEkTWki9SfJeo4hWWRqJgMjQiZ
        awEdpUV/VXkU4BA/JRoCNigiIQ==
X-Google-Smtp-Source: AFSGD/XjbfiL0vyElfGTg5JyXgnmulzG8PrWMbgt581EuX5b3RVuh+3Z/jLIQHXTNTnJZyLw1rKfuA==
X-Received: by 2002:a17:902:7481:: with SMTP id h1mr17264940pll.341.1543863461416;
        Mon, 03 Dec 2018 10:57:41 -0800 (PST)
Received: from [10.69.52.190] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id p7sm18306016pfa.22.2018.12.03.10.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:57:40 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <0dbbafd4-8b40-5a95-1ea5-30e2cd61826b@acm.org>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <2945fa16-3326-7ee8-bb0f-b953ac75b22b@broadcom.com>
Date:   Mon, 3 Dec 2018 10:57:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <0dbbafd4-8b40-5a95-1ea5-30e2cd61826b@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/1/2018 10:32 AM, Bart Van Assche wrote:
> On 12/1/18 9:11 AM, Hannes Reinecke wrote:
>>
>> Yes, I'm very much in favour of this, too.
>> We always have this IMO slightly weird notion of stopping the queue, 
>> set some error flags in the driver, then _restarting_ the queue, just 
>> so that the driver then sees the error flag and terminates the requests.
>> Which I always found quite counter-intuitive.
>> So having a common helper for terminating requests for queue errors 
>> would be very welcomed here.
>>
>> But when we have that we really should audit all drivers to ensure 
>> they do the right thin (tm).
>
> Would calling blk_abort_request() for all outstanding requests be 
> sufficient to avoid that the queue has to be stopped and restarted in 
> the nvme-fc driver?

what nvme-fc does is the same as what is done in all the other 
transports - for the same reasons.  If we're eliminating those 
synchronization reasons, and now that we've plugged the request_queue 
path into the transports to check state appropriately, I don' t think 
there are reasons to block the queue.  In some respects, it is nice to 
stop new io while the work to terminate everything else happens, but I 
don't know that it's required.  I would hope that the bounced work due 
to the controller state (returned BLK_STAT_RESOURCE) is actually pausing 
for a short while. I've seen some circumstances where it didn't and was 
infinitely polling. Which would be a change in behavior vs the queue stops.

-- james

