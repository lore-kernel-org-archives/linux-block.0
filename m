Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110C9C282DD
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 15:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FCC2072E
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 15:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0fygNM0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbgAIPSH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:18:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40462 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgAIPSH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jan 2020 10:18:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id k25so3355430pgt.7
        for <linux-block@vger.kernel.org>; Thu, 09 Jan 2020 07:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xnvh2W+xpJGygRaWuOC1md1GzbHVK4CcIJCaMRke0kQ=;
        b=0fygNM0NOSzRmHwjqM/eXY1c2RxV7Ry3CYXfR6CUSGUDxwSS1GMyQJCLSlhlq75w/N
         fEeKcFKnzExu+48zqh743cseZvSV1wxzkFRjx8TeX80hhvTJZvXgrUE6PVe/fRm/WZDf
         K+M9zMZOo2yCGgruN48AB68ixRU3Rtl+kCrg/mz4Kpb0LD7ORpDMg1fV/gQxD83rIo9C
         yLPoyr9KXq5IA2PRivbDtGV4yGu0xZ4LdpNlI06Ga9/gKvzeXNyuNkCyTyTDL0ko0o93
         Holh4qbUB9kok5QA3Uggjov1hUm98t2P+BuBQnespKs93F+UUy0NWJlb/F9hhis3Dckh
         8AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xnvh2W+xpJGygRaWuOC1md1GzbHVK4CcIJCaMRke0kQ=;
        b=o2g0cn7rwawGEQxI5k9lDUkpDx28KFi88Q5dRVCODTAIvttdngMAgceQuW5NbmqPwX
         iwyR09PWN8pNP3exBFsqdgThX/HL4KdsXs5gW8ZIph0XGPfTpp1WFK7dMKmU+gHporBa
         cmQmn7vF3r6HiRIOFe6U5JTEOHm2PPSBNLFrqQdNZf8xARLXkJgQLkWK8z96kyTcmoNe
         XPP9+xUgFNM6k/OnfAWGu1rUSw/1XDei2lqyyPhqZV8vP8AQifVyplTsZexzk9xRDSdP
         wHDbMK8MFQyOWeor3EPGiAtbZ0aRpmeeQwc67SyH9/vQVr585pY0/UJZKElWib4YpshV
         2S6w==
X-Gm-Message-State: APjAAAVOZng1NKME9yXReX4dq/WXSfTBOkp7Fn3ddp5rzrLATydL80q8
        DJlvqIKzB6jNxvNwiaaCitLDIaPYwpk=
X-Google-Smtp-Source: APXvYqyoJU1R2u+CvwpXfpBsd/Cr9GB7GM3hwdS6+5t7dl4WqYu/7J8hQPq6H3+uZdz982qlylPf7Q==
X-Received: by 2002:a63:220b:: with SMTP id i11mr11573181pgi.50.1578583085977;
        Thu, 09 Jan 2020 07:18:05 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z64sm8471416pfz.23.2020.01.09.07.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 07:18:05 -0800 (PST)
Subject: Re: [PATCH] block: fix splitting segments
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200108140248.GA2896@infradead.org> <20200109020341.GC9655@ming.t460p>
 <20200109071616.GA32217@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd3f3aa8-4880-f06b-7ac5-1982b890ca53@kernel.dk>
Date:   Thu, 9 Jan 2020 08:18:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109071616.GA32217@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/20 12:16 AM, Christoph Hellwig wrote:
> On Thu, Jan 09, 2020 at 10:03:41AM +0800, Ming Lei wrote:
>> It has been addressed in:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=ecd255974caa45901d0b8fab03626e0a18fbc81a
> 
> That is probably correct, but still highly suboptimal for most 32-bit
> architectures where physical addresses are 32 bits wide.  To fix that
> the proper phys_addr_t type should be used.

I'll swap it for phys_addr_t - we used to use dma_address_t or something
like that, but I missed this type.

-- 
Jens Axboe

