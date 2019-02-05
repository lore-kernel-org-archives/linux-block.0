Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8F6C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 16:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4A5217D6
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 16:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gcBErgtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfBEQ7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:59:05 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50640 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbfBEQ7F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Feb 2019 11:59:05 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so10146475iti.0
        for <linux-block@vger.kernel.org>; Tue, 05 Feb 2019 08:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nkSe1LfVROw3w1IkfpQvvLOYZlo3qH6gt9xogpXm8a0=;
        b=gcBErgtu3OnC0H9AtY4kMsOAvk/3G1o1pydSfUGsv9ouqda42P4u6l0fIlO5epPe8s
         w6JXas9oekqwDKGf8AP4JI9Rvuj5hLAufpci21ym0QmWZU81tUP45+ByYeR8I/+cu7Nc
         E0wOf1zKWj37m3fcTVvwWWrnka7dqAroXLkqAd7bPcJ+r2jFFVCM6Mt14pRRAytfoF33
         Wtl84O8Gf+A6sybJC/1bOiUq75qkuX2zyjekJ8Dn4T9rfjONKdsXO4lR2Rjquw2N4a3G
         1LPsG9dJvqZKxiTRqOWG+2+iepiBRMT9BgrzerQ9r6hwLktoG7sfIJFijti7svDkdcaW
         jkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nkSe1LfVROw3w1IkfpQvvLOYZlo3qH6gt9xogpXm8a0=;
        b=EpwizD4BjGySTThdJcd4dX4Jm2yHEbpO8q8Bo053g33Fcqbw8E36JU0hkxmEgNCrL0
         SVhbxZor0IfbRFoCkfnXmd3XqfkCF/uWmgSGpfiQHZfygG0bbYdSqGJfh71EIHBITTGM
         3QWHoBv/wBkS0Srtemay/A1JA6c6jDuZkwF/QmsqgUcGGMkfyWqYquMqQvDd1mvDXPx0
         5TtZBKBqoq+xQuMBNAA3G1vdzbs9t9t4Ig9UPdqBzJ8bRdoueTcloJl2yRkpqXRKwWU+
         07i+RM8HWnJYQK6/fZQVk+cbSDr4hbNWAAms2KFHcKQKK7CsWMFiAXZ5udjovvrl4G9E
         ym2w==
X-Gm-Message-State: AHQUAuZgn+CHt9kXRsEgdzneW5J8vWEIOmFT7Anp1j0N9zJW7o/v1Swu
        ++rG0m1BVAFVHSqQ1cYNsN50nA==
X-Google-Smtp-Source: AHgI3IbyZmp7IJPRiX/xNdXPxZLEImA2VWyiqhh0/BWVPJVcHDCfErSb9qWwj2bN4MphKcT5Zb1zUw==
X-Received: by 2002:a24:4641:: with SMTP id j62mr2933528itb.57.1549385944220;
        Tue, 05 Feb 2019 08:59:04 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v13sm1584584iom.8.2019.02.05.08.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 08:59:03 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        jannh@google.com
References: <20190201152414.23296-1-axboe@kernel.dk>
 <20190201152414.23296-6-axboe@kernel.dk>
 <x49sgx3t9yv.fsf@segfault.boston.devel.redhat.com>
 <x49o97rt8l8.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <271575a9-ea5c-5d73-ccc8-eb5a53e9ff06@kernel.dk>
Date:   Tue, 5 Feb 2019 09:59:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <x49o97rt8l8.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/19 4:52 PM, Jeff Moyer wrote:
> Jeff Moyer <jmoyer@redhat.com> writes:
> 
>> Hi, Jens,
>>
>> Jens Axboe <axboe@kernel.dk> writes:
>>
>>> +static void io_ring_ctx_free(struct io_ring_ctx *ctx)
>>> +{
>>> +	destroy_workqueue(ctx->sqo_wq);
>>
>> You need to make sure sqo_wq is non-null before calling
>> destroy_workqueue.
> 
> You also need to check for non-null sqo_files and sqo_mm.
> 
> Basically, you're tearing things down twice if setup of the context
> fails in some way.

Also fixed, thanks!

-- 
Jens Axboe

