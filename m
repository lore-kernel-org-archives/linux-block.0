Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96147C433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69757206A3
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KiEwryao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfGaPbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:31:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43934 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfGaPbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 11:31:09 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so137154656ios.10
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NhDp9pB52pEJ9oRSh1f9rOMY2HRPDd+xxEBM3tyomOA=;
        b=KiEwryaotyWrJjNgeSpDaJXe1nW/Kc3GwwMNMx04fKoGaN9GQjSX5+Kkm3KXxhaYpE
         ygjDhFMPIVMGhBpr+7Xe0o0x0ut78ghCFj/Sb1+Z5+PUhR2l10jY/jQU1n/4bsP6cVEf
         2vKxLtbMLXK6WZWHSBacQe2wGDOM9nhDVekIdZqvvxXOyBb7Yewuw07ZieaTv6OfLrqP
         gTiQZBGS/Oj5NbArVgHD2Wqvz46vGEvmWlUi8wB1E0+MtkxShFQXsJ0WbKG+WvH0jZad
         eDETGaRcbelhCY3YPbD59ynmcQgORQbhBf16FgTzNjGZpxowTbgC6T8piKFAbe2fWmrk
         dprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NhDp9pB52pEJ9oRSh1f9rOMY2HRPDd+xxEBM3tyomOA=;
        b=lb78pTFDYRxp+VpyL9f3E54ULB0RBVvnBiKZ6OODpu5k5mv2o2MrTEAe3UGvtaLxG5
         8xUoFkiJksLvvNo1DaAR8n6yHYqdhZ6pNy+D2EEtzFxXikZmuMrN+6Hux+LHJb3LUniJ
         zYodlw1eo7CY1WGzpcgloLpj3vUFdkp4YxE9ZjEkWaRSikU9ZwzfEtwb6iFco2B6ce6B
         SZxamy+29XkYZoiQ/5bcOtU9wqn3JkT/JBHV6zf6Wu4jcwjJHeiXmfJ1vka7oaOTHLvD
         rl79GsvDgFbIsl7VwA1OD74jQZPpIoaJ+UrxxY/10gCFpcu3SCWvesyMFSHx6yutDGhY
         8ilg==
X-Gm-Message-State: APjAAAXPRCWV8ebMQP5W/vWlPK0DDUjbHm9rf1cG4UN9p20MJAqdWru5
        1ATNyJUPaLBsXSqlMVJemEo=
X-Google-Smtp-Source: APXvYqwGXXjJXjEsoxOuddpeliVA63sBvMHhTn1ZCrzLO5mUN9Bt6IhneaHjxuTusUpX/lvztpwbIw==
X-Received: by 2002:a5e:9b05:: with SMTP id j5mr50822005iok.75.1564587068518;
        Wed, 31 Jul 2019 08:31:08 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l2sm48642691ioh.20.2019.07.31.08.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:31:07 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: floppy: take over maintainership
To:     Will Deacon <will@kernel.org>
Cc:     efremov@linux.com, Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, Greg KH <greg@kroah.com>,
        Alexander Popov <alex.popov@linux.com>, efremov@ispras.ru,
        linux-block@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20190712185523.7208-1-efremov@ispras.ru>
 <20190713080726.GA19611@1wt.eu>
 <ec0a6c5e-bdee-3c26-f5d2-31b883c0de5d@ispras.ru>
 <CAHk-=wi=fHuiQg1fMzqAP9cuykBQSN_feD=eALDwRPmw27UwEg@mail.gmail.com>
 <nycvar.YFH.7.76.1907172355020.5899@cbobk.fhfr.pm>
 <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
 <431bd981-d81a-d4dd-75fe-96a29f8f1065@kernel.dk>
 <20190731152220.xgif4fwyqybb37pp@willie-the-truck>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e98a4fdd-530b-28e0-f8a3-cc8fb1b95320@kernel.dk>
Date:   Wed, 31 Jul 2019 09:31:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731152220.xgif4fwyqybb37pp@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/31/19 9:22 AM, Will Deacon wrote:
> On Wed, Jul 31, 2019 at 08:53:22AM -0600, Jens Axboe wrote:
>> On 7/31/19 8:47 AM, Denis Efremov wrote:
>>> Hi All,
>>>
>>> On 18.07.2019 01:03, Jiri Kosina wrote:
>>>> On Wed, 17 Jul 2019, Linus Torvalds wrote:
>>>>
>>>>> I don't think we really have a floppy maintainer any more,
>>>>
>>>> Yeah, I basically volunteered myself to maintain it quite some time
>>>> ago back when I fixed the concurrency issues which exhibited itself
>>>> only with VM-emulated devices, and at the same time I still had the
>>>> physical 3.5" reader.
>>>>
>>>> The hardware doesn't work any more though. So I guess I should just
>>>> remove myself as a maintainer to reflect the reality and mark floppy.c
>>>> as Orphaned.
>>>
>>> Well, without jokes about Thunderdome, I've got time, hardware and
>>> would like to maintain the floppy. Except the for recent fixes,
>>> I described floppy ioctls in syzkaller. I've already spent quite
>>> a lot of time with this code. Thus, if nobody minds
>>
>> Great, can't see anyone objecting to doling out some floppy love.
> 
> Whatever that involves, I don't like the sound of it.

Floppy love? It's not that hard.

This is where we need GIFs in kernel communication...

> Here's a belated Ack if you can add it:
> 
> Acked-by: Will Deacon <will@kernel.org>

Added, thanks.

-- 
Jens Axboe

