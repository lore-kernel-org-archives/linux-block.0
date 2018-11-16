Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F452C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 16:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352DE2086B
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 16:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Orrwqcv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352DE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeKQDKR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:10:17 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55270 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKQDKR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 22:10:17 -0500
Received: by mail-it1-f196.google.com with SMTP id a205-v6so30117057itd.4
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 08:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1HUF0uE5rEEDjI2JFlNgniKvNjUKf08UHwpwBdj7Hbs=;
        b=Orrwqcv0rp9VjMm0eoZ6Zf1lXqESy1OnwLjY5xCaAh1k7ugPFQFcfJRGYIIPC1ujE0
         FUJYhJ3zg/jKM967pNE5+OFk87rldhMSKXZYyju3i4gT0pfMU/shaZwEt7N3Y+4E/W0N
         aRkmVlWGjJYThP7jtXZHQnIzScFxFvGGON+JpZb65VPsI7sHj4oRL6a9IrANG1PF76yT
         HYhkh0Izg4iC1lt93EmW87tA7KWzMqqRl29tpdpwt38BcAIy3Ff7lJHABgZNKmxIxU9r
         PJKgaiAiLSjDWW+kr5DKohA40+zLmsmK2Y1bRlOvixPvjWsHsirhGpdu5B3jxDyNoRQE
         TZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1HUF0uE5rEEDjI2JFlNgniKvNjUKf08UHwpwBdj7Hbs=;
        b=RyJJZctkcD1L+tKa/ZPXMo0Oe1sGy2BWtc/UiJrKadC/bRPM2avkxBTzVd1UolGcUZ
         nKDgQ1rLdcpCsJuqmLiYyQcEgAZI4Fj7t2sNSd/aP4BpvQYoTpJFORMr7rrT5jfuSPQ/
         Y4+MK+TZ4PEQegYr+zghPfuUJwxOgIDSBgFVfZUqp3CeBLa3UTzLG9pBbvHFxNIWr4I8
         zyoEmwI93NUUcvGehy65WFpvr6aJ/s+aOvyZTuXfHzenz5nfZTY5uEmBGVu4AP1WfqcR
         hM6ASaR1lsJqHVBTHWQCBQyZ2zEBAQGAgPou7YArDV22cYfCjmi8w1hPBJEPb1iXIH2H
         GNtg==
X-Gm-Message-State: AGRZ1gJTPfriJDcZ0fW/Yf7ti4cOqfq6Y0fDtevMvb9Ds7BMQCIS/tsp
        B114cxQfSZuVGNaal1AUQLvVc20umGA=
X-Google-Smtp-Source: AJdET5cBvhF0VQ4pOpbJi8OdtwjmdVqzQxz+uarSNlI0yH0tYi1bwFdVe6AKRM4aR6pf6GSyH4XoJw==
X-Received: by 2002:a02:5998:: with SMTP id v24-v6mr10622083jad.129.1542387426490;
        Fri, 16 Nov 2018 08:57:06 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s15-v6sm9597262ioe.70.2018.11.16.08.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:57:05 -0800 (PST)
Subject: Re: [PATCH 07/11] blk-mq: when polling for IO, look for any
 completion
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-8-axboe@kernel.dk>
 <20181116084351.GH9023@infradead.org>
 <9f7ae221-10f2-2b13-5d3e-c7ea291f012d@kernel.dk>
Message-ID: <3222728b-b807-ddbb-d155-a3e842a90f05@kernel.dk>
Date:   Fri, 16 Nov 2018 09:57:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9f7ae221-10f2-2b13-5d3e-c7ea291f012d@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/18 8:19 AM, Jens Axboe wrote:
> On 11/16/18 1:43 AM, Christoph Hellwig wrote:
>> On Thu, Nov 15, 2018 at 12:51:31PM -0700, Jens Axboe wrote:
>>> If we want to support async IO polling, then we have to allow
>>> finding completions that aren't just for the one we are
>>> looking for. Always pass in -1 to the mq_ops->poll() helper,
>>> and have that return how many events were found in this poll
>>> loop.
>>
>> Well, if we always put -1 in we can as well remove the argument,
>> especially given that you change the prototype in the patch before
>> this one.
>>
>> Still digesting the rest of this.
> 
> We can remove the argument for the mq_ops->poll, as long as we
> retain it for the q->poll. For the latter, we need it for
> destination lookup.

Alright, went over this. I killed the nvme-fc poll implementation,
it isn't very useful at all. I fixed up the RDMA polling to work
fine with this, and then I killed the parameter. It's all in my
mq-perf branch, I believe now it should be palatable and good to
go.

Meat of it:

http://git.kernel.dk/cgit/linux-block/commit/?h=mq-perf&id=fee7a35981777e5df508baaacebff50147aad966

and removal:

http://git.kernel.dk/cgit/linux-block/commit/?h=mq-perf&id=bec293e546c6c7b01a276998a287427ba7e8b775

-- 
Jens Axboe

