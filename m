Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0C8C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0681721773
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 15:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iEvJAW0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfDXPiF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:38:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37045 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfDXPiF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 11:38:05 -0400
Received: by mail-it1-f194.google.com with SMTP id u65so6952958itc.2
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2019 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4BDVI/3mTt+j+OdEMy0orBtpK6m2aWL29Q5GuFofx+U=;
        b=iEvJAW0M2fDuuLJsYzUGsBTvdXsUarzdHdVJ5YOe5bzgNv4wgiBEwfpiYGt+i5YS6q
         hmypid5+TWOA68XDoI7sf4AuTmyFlcqAX5iK9aw6LBHUBuJgwEZbjNabJujBxvuQZSgu
         Em91R8w0zRWvf3GRDGb1q7pFMxPSrJFKstyXPY8SAU0kUnpZ7tQQV6xCnacC7MW7FKch
         paMz+ebE0up4+Ufj/IzTi124AvD+qRzrv6f4Xi5dqBXonTDK/yXxS7Hkj/BIc78r5HbP
         gJRhVSVwqHc1OoGkpFznovdqhhOCU8M3trHawS+pc6A/UhdI+/UZ9/zykY7EqDklTcFp
         7y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4BDVI/3mTt+j+OdEMy0orBtpK6m2aWL29Q5GuFofx+U=;
        b=ElgF0H0YaxIomHEQ0LvbElJuA7v+3IOVpOqIcK5omC74BIH7+iWC69cpm/W0O667Tu
         NLSHxTAsy8wvOgYGJEcmPw0cYSTi20EuK/9tX1CG7t0Vb67jQq3B3dWHZQL2n1ZNUl3k
         Z94tG9z3kUyIvhY6jI1N/BrhtB06dxo8PLzQ5ZEQYPx3J3zvLX97yK1NkRNVjKRbX/KC
         iq7R4GP3j+n27RgtbMyJA8widCgj05uWnu6cc4KHyDVOJUuweT4xy/xS63gRi1qS88PC
         ZN77VKi7cWnG/tvkMMdfcu9iOPGoFtbMaTRpjjsfjHVGf1xJgrB9h2O4hyDv5+fuhRhs
         W0eg==
X-Gm-Message-State: APjAAAXnI2o41e4VV4nPcIrQrxm1kKstgDEmp4/eeMK+Lt1plKmnAvLg
        pBL4RswgUmwUukkXP7FosWmrbw==
X-Google-Smtp-Source: APXvYqyT/9TVnz6he+ogB70SgTs+/94pXVtZEKFiuaDa6vcEwuVJ64jDl6RVkpS51EwMfzyLM615Ew==
X-Received: by 2002:a24:64d2:: with SMTP id t201mr6569618itc.39.1556120284352;
        Wed, 24 Apr 2019 08:38:04 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f17sm8218207itb.13.2019.04.24.08.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:37:59 -0700 (PDT)
Subject: Re: [PATCH 2/2] scsi: core: avoid to pre-allocate big chunk for sg
 list
To:     Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
References: <20190423103240.29864-1-ming.lei@redhat.com>
 <20190423103240.29864-3-ming.lei@redhat.com>
 <1556033835.161891.123.camel@acm.org> <20190424075233.GA32345@ming.t460p>
 <1556119450.3043.8.camel@HansenPartnership.com>
 <1556119951.161891.126.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <89ff42b8-6b6c-d840-3290-2ecb5e471d2c@kernel.dk>
Date:   Wed, 24 Apr 2019 09:37:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556119951.161891.126.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/19 9:32 AM, Bart Van Assche wrote:
> On Wed, 2019-04-24 at 08:24 -0700, James Bottomley wrote:
>> On Wed, 2019-04-24 at 15:52 +0800, Ming Lei wrote:
>>> On Tue, Apr 23, 2019 at 08:37:15AM -0700, Bart Van Assche wrote:
>>>> On Tue, 2019-04-23 at 18:32 +0800, Ming Lei wrote:
>>>>>  #define  SCSI_INLINE_PROT_SG_CNT  1
>>>>>  
>>>>> +#define  SCSI_INLINE_SG_CNT  2
>>>>
>>>> So this patch inserts one kmalloc() and one kfree() call in the hot
>>>> path for every SCSI request with more than two elements in its
>>>> scatterlist? Isn't
>>>
>>> Slab or its variants are designed for fast path, and NVMe PCI uses
>>> slab for allocating sg list in fast path too.
>>
>> Actually, that's not really true  base kmalloc can do all sorts of
>> things including kick off reclaim so it's not really something we like
>> using in the fast path.  The only fast and safe kmalloc you can rely on
>>  in the fast path is GFP_ATOMIC which will fail quickly if no memory
>> can easily be found.  *However* the sg_table allocation functions are
>> all pool backed (lib/sg_pool.c), so they use the lightweight GFP_ATOMIC
>> mechanism for kmalloc initially coupled with a backing pool in case of
>> failure to ensure forward progress.
>>
>> So, I think you're both right: you shouldn't simply use kmalloc, but
>> this implementation doesn't, it uses the sg_table allocation functions
>> which correctly control kmalloc to be lightweight and efficient and
>> able to make forward progress.
> 
> Another concern is whether this change can cause a livelock. If the system
> is running out of memory and the page cache submits a write request with
> a scatterlist with more than two elements, if the kmalloc() for the
> scatterlist fails, will that prevent the page cache from making any progress
> with writeback?

The mempool prevents that - as long as we have at least one reserved unit
of the given size, we know we'll always make progress (eventually). The
finite life times of the sg pool allocations guarantee that.

-- 
Jens Axboe

