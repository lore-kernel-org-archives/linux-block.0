Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93EAC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66DB214DA
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DGT9HP4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66DB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLFT0B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:26:01 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43925 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFT0A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 14:26:00 -0500
Received: by mail-io1-f67.google.com with SMTP id f10so1285554iop.10
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 11:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z77hVNS4QibmSYGPwD98p8fzqk3Zh6m0RTO77f6anCk=;
        b=DGT9HP4uq+DSRNRaoH7RRFScFYjBAoDcS2umuHoYUkwkf513AP2Y7HJrx4BXECExnG
         wWR5xJe6hW5M/iW1H1I0Ff0Ji7XAhGTujZ4XIZW2LMAqz47pU/mcoYNlegpEGMPFQ8cu
         fEkk+bvlEXnM8aAyE8KSaaOPZyd1yvtfkgD+eL3oMQZIGjtnJZ3R7nY81hBVDGvyvZpg
         IpBbMeks2kSQGHdGFe8vnHS+e9IPd/SiJEr2+GXIwkutR7sDcEPuLcUKBW0SfMeIPvxt
         ZSqhtX1dluZlzM8bdNXUEHVMoFLsO/+KRZzKM0ML/Hd+t3QbibBSXarFG6wFWNkNEVzI
         f3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z77hVNS4QibmSYGPwD98p8fzqk3Zh6m0RTO77f6anCk=;
        b=gJRJRmEYZBQDiD13kUydvmJn66WDhh8060VUQEKoCib+96GVrlnkZ7COdl5nxdtuFq
         KdDE4oa5WTvWEHXnrnA3uDf2dfXiG3qQ/J7xatUMJINHim8+MkDNX46wmTz0IB3ZHG5f
         IzevSC2mHClZavCADDewITrqi5RXthKXgILYq2cR2dDA2L5EkhZnuDUqEB1JwEUCMorC
         Vf58Wctpzn4ZSl8LL3BbetY4jKwv+C5RGVJyp+PyI/hz9uKwHCKnxQprejtrx4lDQoyJ
         Mf/lFH0aqJuUcTFPhsbUw6yqGbYe+YFmYpUANSTXNy2PEo30ZWZ3qcZ9kXIr5dTK2BQB
         UXPA==
X-Gm-Message-State: AA+aEWYGYZklTdE8tROLRwvm7bDN0UGGbGSKgWelzrnbJAJhWjd2DmM/
        HKEsFHZzht0nLQhQxHju6To/XA==
X-Google-Smtp-Source: AFSGD/WnwnME4qgJJi5kiVMH8HuxXsbaDz9OzbIXgDZ4rAA4V7mzFgGac4K0jaTFQo85vfMLOmX9KA==
X-Received: by 2002:a6b:8b4e:: with SMTP id n75mr23024111iod.184.1544124359644;
        Thu, 06 Dec 2018 11:25:59 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x21sm459564iob.84.2018.12.06.11.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:25:58 -0800 (PST)
Subject: Re: [PATCH 03/26] block: wire up block device iopoll method
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
References: <20181204233729.26776-1-axboe@kernel.dk>
 <20181204233729.26776-4-axboe@kernel.dk>
 <x49a7lih3n4.fsf@segfault.boston.devel.redhat.com>
 <72b6acc7-5017-a72c-3fb0-90e5ad95ebb7@kernel.dk>
 <20181206191527.GA30806@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0392bbd7-690f-c561-8091-f6494a348fbd@kernel.dk>
Date:   Thu, 6 Dec 2018 12:25:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206191527.GA30806@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 12:15 PM, Christoph Hellwig wrote:
> On Thu, Dec 06, 2018 at 12:14:29PM -0700, Jens Axboe wrote:
>> On 12/6/18 12:11 PM, Jeff Moyer wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> From: Christoph Hellwig <hch@lst.de>
>>>>
>>>> Just call blk_poll on the iocb cookie, we can derive the block device
>>>> from the inode trivially.
>>>
>>> Does this work for multi-device file systems?
>>
>> It should, that's the whole purpose of having fops->iopoll. You should
>> be able to derive it from inode + cookie.
> 
> It still assumes the whole I/O will got to a single device.  For
> XFS this is always tree, but for btrfs this might mean I/O could
> need splitting if ->iopoll was to be supported there.

Right, we can only support one target for one particular piece of IO,
but multi-device works fine in general.

-- 
Jens Axboe

