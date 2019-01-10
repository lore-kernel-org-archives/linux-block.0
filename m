Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B7C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 23:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D01E208E3
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 23:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SeF3SstE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfAJXrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:47:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34349 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfAJXrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 18:47:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so5507040pga.1
        for <linux-block@vger.kernel.org>; Thu, 10 Jan 2019 15:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=orQTzzFZhstfOxWiPDU+V7t1O1pECdJw/+2s72IMmcc=;
        b=SeF3SstEcUZfYBuNQph+H/vpm0nE3gQjOSgxzfOtPxzP9J5er9sYzR4IzVrfSVEx6z
         N3QG+KB36CdlXbXrB1qHX6Lwpk+nYVOpQxGTwsn3gm7l+HCSeit9WQJ9SFnk3XK/KmB8
         9hCBHmR9S1RR3Q+dsGd4BJs0tDhNx2+REAMzLRXtYT21+BhNYYD/TbZQzgEfI8EuUwJL
         IrzIzH5uzXBlxkenG3QcBbmEmQC9SDhvyF9t8WgClIBWpD8OAOGfxpRWk6qFDAr0ISMO
         ke26UR0YIC704qyK96xPOmirDKCK0Um8x2KzNGY09CoiwVL0gLZ9uvslF4B7xE/59fRe
         qrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=orQTzzFZhstfOxWiPDU+V7t1O1pECdJw/+2s72IMmcc=;
        b=Mx/uRt3KAYfywEAQgcKejmwtye7V9sKXZ6zP+F99Nc3Em1j7a9w8gjWaQz7XP1+UCU
         dboZRB14snh3SaHInQxm59m/Gta81HN/sE9v14koeiHE1YHGfs7Slnbq53r8Kk2zbpJJ
         RPF09LVjM4dmqN8V0Hlj1vhswnb9HOD5fCc2XlorLcnZuIhbY6j20acMrYfMts7UN60G
         JPQpw7w+6bZgIMpNSjFZvQTzr7JYZAVgEsDeQnsrY/xLZyx50uOx/WnPfuZTxOcmALgp
         15al6oQEaGSgEbrDAAKtSfbPlWnVXNhpWSrobyIazTZO7BgjhDWVmlJarvZNxU+98l7c
         LHUg==
X-Gm-Message-State: AJcUukevCK3qCmp9+ywMDiiUVuU2zlDdks2h8zBo69tbOkcfLEnVkg0g
        XKsSK8oRDFwCmY76lDn1on1Bh/5GFRMzWw==
X-Google-Smtp-Source: ALg8bN5KAeFB7fRw9I0sM3uYmmMHb0aP1fwLVBIT3GUqVCOufH/9+FB1eBsxBEsUh33VDxMzA+zH8w==
X-Received: by 2002:a62:670f:: with SMTP id b15mr12171472pfc.212.1547164052793;
        Thu, 10 Jan 2019 15:47:32 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v14sm178237847pgf.3.2019.01.10.15.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 15:47:31 -0800 (PST)
Subject: Re: [PATCH 15/15] io_uring: add io_uring_event cache hit information
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, avi@scylladb.com
References: <20190110024404.25372-1-axboe@kernel.dk>
 <20190110024404.25372-16-axboe@kernel.dk>
 <x4936q0ds3y.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf92044f-1672-1354-b1c4-b86de52f55b9@kernel.dk>
Date:   Thu, 10 Jan 2019 16:47:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x4936q0ds3y.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/19 4:12 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> Add hint on whether a read was served out of the page cache, or if it
>> hit media. This is useful for buffered async IO, O_DIRECT reads would
>> never have this set (for obvious reasons).
>>
>> If the read hit page cache, cqe->flags will have IOCQE_FLAG_CACHEHIT
>> set.
> 
> We may want to hold off on this one until the whole mincore/RWF_NOWAIT
> debate is sorted. [1]

Definitely, it's why it's separate and at the end of the series. But
in reality, this doesn't leak anything that timing doesn't already
tell you. So it's kind of a moot point.

-- 
Jens Axboe

