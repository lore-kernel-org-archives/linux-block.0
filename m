Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F50C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE372082D
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MJ4a3//j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE372082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeLEPPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:15:17 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:50491 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbeLEPPR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 10:15:17 -0500
Received: by mail-it1-f173.google.com with SMTP id z7so21832456iti.0
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 07:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/mP7/ZLn/q209y+k6fP706G2b9UmRHCddcqP7dP39Io=;
        b=MJ4a3//j4JhdnWCkOcXYnRBv0vp54FPsiMZEaJw1mImO1VkwwIQAZFMhnOspdTWaRb
         DRVuzls+qUgYN73J9I8jpBg/4TcIKPgde3cm7yqiQbH6JwkpNgiFdGWND92o13l0TbqC
         3i8JzHL7H6v96ylv4XdKO/WJIsjE+Lvy2DFHVYMkVJdGySXATPlg4fQiXw2AhUysGufV
         v2MtSFKMrx/MAy4HA2DKuReN1vrROdJnDuSBPtP2tCltQY9ILEnOt4mDkqJohRgGXNtd
         yh42H04RG64VzIZMacXrBzxKuHVcdU1OhDKRYSbZvs4A8ufMKWVfyBCP1RAKeTKvLcJr
         6EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/mP7/ZLn/q209y+k6fP706G2b9UmRHCddcqP7dP39Io=;
        b=ZDe8waLdwvFipV7QOKx/qO933t3AiTiuuvr1h1ioIn1g5Zob1p2NU7KNFEgo+vzji1
         zSUA0HkFb3IkVK0gXusb6Wscs2qKKaFjLmboobjfsxbIYc9KQaGOPzQI7a7VymECq7sE
         AjIn6e4O91tWKxb6efz/18TJEmUkz7XVzK4IPEon5thP92M8ynSZEGcOZbUgIJDkRSoI
         PNH3M7Qju8jCTxZGTRzJUKTah2FyfV+jD0gKKX0fe6IV/3UZTme2PGnp9YA1lQQgmbP2
         kT4CFPRLUH9S/zog4yDcX/ZUWIfVtbmyBdCJYqgC7478k0/yMReDpxSS25ZTfo9FnjTq
         SWKg==
X-Gm-Message-State: AA+aEWYXpu55iwMa4WA106xrWn1zLJ76XdPOSV/33SHuElLqyve1zBP+
        BeMf1IO1TgkD0WHs3Hd1rQfCfA==
X-Google-Smtp-Source: AFSGD/UfBr/Ap09egI2ARO0QkAsC1wh4LuxEwVTRQVV4gEPxqlIsBpRRToP7JgjvSXJi6e8R30nr0Q==
X-Received: by 2002:a24:4648:: with SMTP id j69mr15802369itb.56.1544022916284;
        Wed, 05 Dec 2018 07:15:16 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o74sm6457989itc.44.2018.12.05.07.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:15:15 -0800 (PST)
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205144117.GB18123@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1251a863-5269-a766-4cef-2bb403b167b8@kernel.dk>
Date:   Wed, 5 Dec 2018 08:15:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205144117.GB18123@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 7:41 AM, Christoph Hellwig wrote:
> On Tue, Dec 04, 2018 at 03:47:46PM -0700, Jens Axboe wrote:
>> If we attempt a direct issue to a SCSI device, and it returns BUSY, then
>> we queue the request up normally. However, the SCSI layer may have
>> already setup SG tables etc for this particular command. If we later
>> merge with this request, then the old tables are no longer valid. Once
>> we issue the IO, we only read/write the original part of the request,
>> not the new state of it.
>>
>> This causes data corruption, and is most often noticed with the file
>> system complaining about the just read data being invalid:
> 
> Looks good as the first quick fix:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But as we discussed I think we need to be even more careful. including
> the only read and write check below in the thread or some higher level
> approach.

I agree, I'm reviewing the patches from Jianchao now and will do
something cleaner on top of that.

-- 
Jens Axboe

