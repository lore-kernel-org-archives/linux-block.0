Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8419DC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 14:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD1120652
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 14:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bJUpjyDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfAQOBL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:01:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42937 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfAQOBL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 09:01:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so4784522plp.9
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 06:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6DURJBU2LPktSmQs0avBnVbSqSha42w+cjRSumzK+kg=;
        b=bJUpjyDpJ4bjW/6Rhh0mFQyeGebjTlIoH6TaMCBjLGQFoMEocZARjZ2vFn9z5nsjnF
         9H7ePinfDIDeAtzgPd2tnLVIAHOTW/k7lsNW0Qme+OPqS4Abi1ZSf3hZDSI0LC8EDiIC
         hyJ1f+pd9wbqGLiQxP0+9a5n8MMd12UZ/9T1onXFoNsN9Kls1mPPczpbOlswUvxzBtHb
         MRyioV01LsrFpsY1KMnoyuvvavdB3gUCLW4LIbAjGhtjJmuSALCCKJ32rCghmdf+2Z/y
         JlVKMaZOvo1KkF2IFp/Aplegh9Q5EWVomd5ktqrb7bOw66esCz9eWcxsdXkDDQCFQdbS
         EXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6DURJBU2LPktSmQs0avBnVbSqSha42w+cjRSumzK+kg=;
        b=ZFy4ki3dU6pqj7pIeT72igYaaE9pS4Fvx338xMeF19bS3CxY5rm6KL6qim8ssFmyzC
         hcYYKHEp9Bkur/GfEWAPSNazrZ4fUZ3gU0D/6QT46BuDpE3deUlCRVcIEJIfnkQqxFLe
         hwr1zwY2b1KVjk+uREe4LOjBF8LSubjYvwzTzkEnT7vYodroDnzvAbk3Yx1zbQbK1aTn
         TKGSqbFa532hENdFIKlKUmAfuL7BDc4h8AkDmqOyBw4meLfAHsq4eQnAaRyn1sRoOVjd
         I8Uwa1p987dgBh6boGlKPdp0YD3qr7Pi/ZLLwT39oFGxyztBWFKmNCt4L6i36n6g2mua
         Mvrw==
X-Gm-Message-State: AJcUukcjToQwiAHsl1f7qaOC8CAfKsMMb15edteOCFCvuyDwO9QL6HmA
        8/oHpYDpN9E3havDPOCS30a0/Q==
X-Google-Smtp-Source: ALg8bN7p1Qq19Il1e6GkCii0Pv2sePwKv7xeNwvRT6377OZ3U+QxcmwlRTAD6O/09fZNjexrPsl1fg==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6mr15113770plb.217.1547733670951;
        Thu, 17 Jan 2019 06:01:10 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id r4sm5288400pgn.54.2019.01.17.06.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 06:01:09 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
Date:   Thu, 17 Jan 2019 07:01:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 5:48 AM, Roman Penyaev wrote:
> On 2019-01-16 18:49, Jens Axboe wrote:
> 
> [...]
> 
>> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
>> +				  struct io_uring_params *p)
>> +{
>> +	struct io_sq_ring *sq_ring;
>> +	struct io_cq_ring *cq_ring;
>> +	size_t size;
>> +	int ret;
>> +
>> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
> 
> It seems that sq_entries, cq_entries are not limited at all.  Can nasty
> app consume a lot of kernel pages calling io_setup_uring() from a loop
> passing random entries number? (or even better: decreasing entries 
> number,
> in order to consume all pages orders with min number of loops).

Yes, that's an oversight, we should have a limit in place. I'll add that.

-- 
Jens Axboe

