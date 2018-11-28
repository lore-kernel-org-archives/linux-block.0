Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A308BC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 15:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4225821019
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 15:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w6zdnt2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4225821019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeK2DAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:00:11 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:39905 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeK2DAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 22:00:10 -0500
Received: by mail-io1-f44.google.com with SMTP id k7so10484233iob.6
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y46RHwlXXKmdTTu8PC5xt7OFC6OzfucMFDwO9/cbM7U=;
        b=w6zdnt2Pn2q0TfDhvtZWSBpbwY2aP1NPdnx+e3YtXQ+zWTMG+QyQnUU7GuRoIiMqLH
         xOtajfLdWVT2/OSFZJg5pYHpS8a7TVRiwkCWrFeHXGiCFQL+dy56zdHTnv/8v46X6hba
         8MBM93J6BBexkUFA1zNZlvMLK/+PA/kPQ7Lt7aMEbrfsfPX1gU80iFLJr4eB9j7IXlpJ
         qQNRXeCui/f+LCBGXo/e2ljHG8tKtm2ZrZTkybLuxfpdPJwYlY3VpoZcLQjys8Ea7WRH
         QXODG0anDh0toBy64WbXB/GiXmElrcR/2D/x6v50stbeuz0ThOqazeg/edrDfFml4roJ
         XRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y46RHwlXXKmdTTu8PC5xt7OFC6OzfucMFDwO9/cbM7U=;
        b=A8Um4o89ishmL/qi26abSRQA0x3HJBBIDHmSBA4FRecdue0C81Sk6Pfsf/UsDMfGF9
         tWP+CehYRl2DeLucfZXSP9Bj24lOfmdlQxHBwp6I4cT282MqiddMh7fULJH6EJD83kWZ
         WlrkDVQ+dCD5v6tpawg3yDCnLTQnqOqrJqd8P8crVWltHlHfjcMaqtrVGTCTsNtkNPaQ
         caFWXVyRa/1LlqjyZkdD5sxLv80noJIE0CUyy8HRlcdJu83LLUpZdkcaMfbalyyPITqo
         k9H/Luof9z4TBitNJ3K/lQIvOrcaF3Xep6rh0a/Tk+ggbCLns1oSeouL7+idw77OHcSt
         V6qw==
X-Gm-Message-State: AA+aEWYnWLSxSXESxlP715eoAUtOJt4AmhBXZAiy1OvbNcs4O6EQ0tdU
        b7SZv3a9348Qy0T7xm0QfQkChg==
X-Google-Smtp-Source: AFSGD/UNLY7Ga1J9n5mA4nTcM6/4Cql9ssJPogtNTnOIoxkxEWLlD4yH4pIc3CEDcxpEAQP2Px7ytg==
X-Received: by 2002:a5e:c802:: with SMTP id y2mr27824219iol.198.1543420682321;
        Wed, 28 Nov 2018 07:58:02 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 137sm1344185itm.21.2018.11.28.07.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 07:58:01 -0800 (PST)
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
To:     Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20181126165430.4519-1-keith.busch@intel.com>
 <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk>
 <20181128021959.GG11128@ming.t460p> <20181128070010.GA20369@lst.de>
 <20181128100659.GA16495@ming.t460p> <20181128100848.GA23567@lst.de>
 <20181128154927.GE6401@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ddc31c4c-5d5f-c5ca-67bf-33acdd03ed54@kernel.dk>
Date:   Wed, 28 Nov 2018 08:58:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128154927.GE6401@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 8:49 AM, Keith Busch wrote:
> On Wed, Nov 28, 2018 at 11:08:48AM +0100, Christoph Hellwig wrote:
>> On Wed, Nov 28, 2018 at 06:07:01PM +0800, Ming Lei wrote:
>>>> Is this the nvme target on top of null_blk?
>>>
>>> Yes.
>>
>> And it goes away if you revert just the last patch?
> 
> It looks like a problem existed before that last patch. Reverting it
> helps only if the request happened to have not been reallocated. If it
> had been reallocated, the NULL_IRQ_TIMER would have completed the wrong
> request out-of-order. If this were a real device, that'd probably result
> in data corruption.

null_blk just needs updating for this.

-- 
Jens Axboe

