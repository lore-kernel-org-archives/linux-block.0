Return-Path: <SRS0=rsSL=Y2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C1ECA9EC7
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 15:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9531B217D9
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 15:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W3YaSOz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKBP5p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Nov 2019 11:57:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40919 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfKBP5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Nov 2019 11:57:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id e3so3538608plt.7
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+sc/3lbYLeRenCxlNeVetpPhU0U1h6NbKPzKtjXF1xg=;
        b=W3YaSOz56DnskZPJBq/ceIlltaMa473BoohT5/C7ndNW7GwIcyNRn2iK2N+jtmUXon
         GThgnkwd8qqG2XlsoCMiUyuuwOk39AquoxCsuFnjgMae16aIoFPaayO3KQ9VEsdF80eO
         x65cDv2ocgvtrJCHLlcY0PVBGMNpPoBZv5LJOA+pFAmpwbdXII6wYLjcRhZGa7G7ydoD
         neaNGPtMy2/97A7OelOTEiHmGXhElMFMBdvEjZHw0P8bAntjxcTOnHsBFQ3Q+DTqezHt
         zjR3K0L1CqbK7tyPs3keWP3HyQCPKW1i7qkbz5SQ+agMvxkhY/tpHJNDKFEUuOnOM8B7
         1uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+sc/3lbYLeRenCxlNeVetpPhU0U1h6NbKPzKtjXF1xg=;
        b=KP5pv+Qh06G962pPkILmOyXyBraMTCKQhPvPbcda5UUSaLaVm0madVkLpMbc4dS3ar
         1SUqNnRMck8f0ORPM08whtOo4EKcUWkxJJRMdrc/eZjQRKiskv1aVQ+x7KdAF2lcVffq
         qO5xh91XrA7/tcrSpgjNXsVNVTpKByGvvlvutncjgX8x2tFYT0jJ6+13O6/yMllsqa37
         vVOOA8177XgFvmhQ79VS3gxJ4mx2vMjQae+Z4gB7dXVpDUYxrYpoEbaJ3Vw3qSTKLCOy
         bsRWpQ+Nw4l0Kaji5BdnNjBThI9nPGmCrvirTFW0dZEK1qF+MYBphqS7dNw9Jpm0Fyks
         F2xA==
X-Gm-Message-State: APjAAAUjZX14qKTcSmmtSkpsz0NiAtY8GE99j51+yvkW4WJdvotnSbQP
        ZWI6dG2iPY+3obEY3pGaowoBiw==
X-Google-Smtp-Source: APXvYqyM9FW4+I6/9d5E/0oi+0SWnnzLrFfkeR/FYBEmdE4eZm5uOzS6FvGruylnK9L2OQimmxn0Ag==
X-Received: by 2002:a17:902:a9c1:: with SMTP id b1mr10782827plr.227.1572710262325;
        Sat, 02 Nov 2019 08:57:42 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 6sm11015721pfz.156.2019.11.02.08.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 08:57:41 -0700 (PDT)
Subject: Re: [PATCH V4] block: optimize for small block size IO
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-bcache@vger.kernel.org
References: <20191102072911.24817-1-ming.lei@redhat.com>
 <606b9117-1fb6-780b-8fb1-001c06768a2e@kernel.dk>
Message-ID: <36786e85-fd19-0631-4acf-c9bf9468d4e1@kernel.dk>
Date:   Sat, 2 Nov 2019 09:57:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <606b9117-1fb6-780b-8fb1-001c06768a2e@kernel.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/19 8:03 AM, Jens Axboe wrote:
> On 11/2/19 1:29 AM, Ming Lei wrote:
>> __blk_queue_split() may be a bit heavy for small block size(such as
>> 512B, or 4KB) IO, so introduce one flag to decide if this bio includes
>> multiple page. And only consider to try splitting this bio in case
>> that the multiple page flag is set.
>>
>> ~3% - 5% IOPS improvement can be observed on io_uring test over
>> null_blk(MQ), and the io_uring test code is from fio/t/io_uring.c
>>
>> bch_bio_map() should be the only one which doesn't use bio_add_page(),
>> so force to mark bio built via bch_bio_map() as MULTI_PAGE.
>>
>> RAID5 has similar usage too, however the bio is really single-page bio,
>> so not necessary to handle it.
> 
> Thanks Ming, applied.

Actually, I took a closer look at this. I thought the BIO_MAP_USER
overload would be ok, but that seems potentially fragile and so does
the fact that we need to now maintain an extra state for multipage.
Any serious objections to just doing the somewhat hacky bio->bi_vcnt
check? With a comment I think that's more acceptable, and it doesn't
rely on maintaining extra state. Particularly the latter is a big
win, imho.

-- 
Jens Axboe

