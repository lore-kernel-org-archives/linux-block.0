Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC46CC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895CE2081C
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DogNkerg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895CE2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbeLDSNh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:13:37 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55894 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDSNh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:13:37 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so16929263itg.5
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 10:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bob2PeY6enAJ2qt87TENCghO5L/ZUGUN4V2wHith8f8=;
        b=DogNkerg0sEph4VcEkTZxtMiP8i3qCVqlDvh5ByeTpi2heuCZqASf3gCt/pBwHOJgK
         FDeHxQM4kYNT0OqTIGO/K17wPTaFiPl9mp6MQVGXuodvjfGimCDBddzPESa62tJbIC6J
         EEvU+5PGahr4T8OIXaLtkN7d8M7pucYmXEbPyNYdF2m+wjKGuoNax7c6b7FTMy5cvtJA
         FvaxwfE5SonkjVkuwNk618XwB2LmCGSrPw9W+cM5JKmAjlE08TriYaiD+S3yKfP3V4Qa
         AS2zaphTdhbePd/8tGbKN1UqIBdzxblYt2Gi5NMgfLju5Kr795afVMz06VdN40MxhBKg
         zDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bob2PeY6enAJ2qt87TENCghO5L/ZUGUN4V2wHith8f8=;
        b=pnVpwQrfCjOBLEqzxZIZ7MfIrkFqeaRU/o6U8sJRllOEz87wSkotjgtpyOwwADlr6W
         yPjszBlV/G0+o0vyX06x/pGL8lgDM1R2w1ZjulqcVZQZoWw+xesQaNjWfC3K3QyDShcA
         IhEHCPsHf4TXaTmPZYcq81ehW1PaooqGyFrPDzejBSF5cjrinY4sVVrZ4/Peq2fdWZub
         en//FAUUJN7y/GhnZA5dipjudZfCTFH5VFSIQbGsmsYUSCpS97b5Za9e224lEtSeu4Iz
         kpF4zhzTEDKWi1lhjnc2GIDO/0NbVIERFFcOiTzxjvGnTKfE601A4BtGs62iLJLEh7Pj
         EKBQ==
X-Gm-Message-State: AA+aEWY7/940bU75ErQpnHwys8xxkrlfccXYxPSGEb6VESiEfZW+XNve
        VmMAVcXDnHvO5uGHHprYQyq/zw==
X-Google-Smtp-Source: AFSGD/VI7/htrDpCZbe8aZRckdhLM0vlHjr/h9xPnmnk1553Okc98cNv8a7pnJlaJk9YeMtChoAh3A==
X-Received: by 2002:a24:7ac8:: with SMTP id a191mr12485281itc.176.1543947216812;
        Tue, 04 Dec 2018 10:13:36 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o18sm2704735ioh.31.2018.12.04.10.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 10:13:32 -0800 (PST)
Subject: Re: [PATCH 05/27] block: ensure that async polled IO is marked
 REQ_NOWAIT
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-6-axboe@kernel.dk> <1543597960.4347.3.camel@acm.org>
 <6044f9e1-0175-823b-b923-998094bdca72@kernel.dk>
 <20181204144820.GC3180@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2e06ca6d-61c2-3a29-992e-70818819b9b4@kernel.dk>
Date:   Tue, 4 Dec 2018 11:13:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204144820.GC3180@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/18 7:48 AM, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018 at 10:17:49AM -0700, Jens Axboe wrote:
>>> Setting REQ_NOWAIT from inside the block layer will make the code that
>>> submits requests harder to review. Have you considered to make this code
>>> fail I/O if REQ_NOWAIT has not been set and to require that the context
>>> that submits I/O sets REQ_NOWAIT?
>>
>> It's technically still feasible to do for sync polled IO, it's only
>> the async case that makes it a potential deadlock.
> 
> I wonder if we want a REQ_ASYNC_POLL compound flag #define that sets
> REQ_POLL and REQ_NOWAIT to make this blindly obvious.

Yeah that might make sense, all the async cases should certainly use it,
and sync can keep using REQ_POLL. I'll add that and fold where I can.

-- 
Jens Axboe

