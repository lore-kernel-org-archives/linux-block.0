Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E8C32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 14:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0D0206B8
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 14:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dHTL7S/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbfGaOxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:53:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44428 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388074AbfGaOxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 10:53:25 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so136725864iob.11
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zlcAXkKW8QVqrB0POXO1HOMAe1Y+4ab/2cQba0Zxxzc=;
        b=dHTL7S/edkTumLq61B3dgRSTYGv9sotAJDMUJepTiJ29to2FTPzeJyv09hKFMXSzVd
         KVPKvqqxnR/Oh93EXD/+aFdn2oJMNE728ofoODS4waMtHAjizmUISSWpa+PZSNsMK6NQ
         D4CDBalZTrgsHbDmKAYrktzLxkox+OFDWkabHXC0WMtzWNWuyZqFzjM9SZoMlUM6fHy3
         9gbAeeSYDTQl6aace1YXOpFKb0gJ082cn/p7wayzz/OmrcxO69KKCcvN0V7GBreuTHvJ
         Ds3VuIZk98nydQHyX418KEGGQp02TOtX8eDxYbChd7t564PMfRLKvw9ZmOo/KQMqaLLe
         FQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zlcAXkKW8QVqrB0POXO1HOMAe1Y+4ab/2cQba0Zxxzc=;
        b=VN4N+Rx5E9QRS7b57+N9mkw4JXQi4wpKrYzyfCuZXOCcqFGS4wcDW6naIslycFNCyd
         WlvDO1l8llu3ChYLcpKLDfWBcdgNxDaaV5884ySynnL+Et2JyRNaK4rZIrOsNDK71x+6
         iy/Sq3c7TzgCKb+myF+fYPGpQM0nrxfT9Dbi05fo850uHf18bb+p9s6NhcjgzCvXzS+L
         18W89QwjMvhWBLgZOU1EUt0F/GvvyowE5VQn7IBJKy+plrpuDYbABUsW8s7FmAkucBLe
         IFDlR3tX9fCODw2Hjr7XM2XBMbU/ZpHbdJBXyJI1ZQ0RcTrun4dhzl1tjGaV2QDdTa0v
         F5WQ==
X-Gm-Message-State: APjAAAUQpCNOhojdvN69afxTi17IibEbSTciheVRbWOw5mudzmFGYgC3
        BDe2Sh5XeW0++rbys+w9P9g=
X-Google-Smtp-Source: APXvYqx+BXSVFPqAnw9J/ZjOuQ8bb3S7c7lnWx+PLlV1IxzY4n+cXUeefovmQctozHourMkeKSzzsA==
X-Received: by 2002:a5e:9e0a:: with SMTP id i10mr2803063ioq.44.1564584804230;
        Wed, 31 Jul 2019 07:53:24 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y18sm65072836iob.64.2019.07.31.07.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 07:53:23 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: floppy: take over maintainership
To:     efremov@linux.com, Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Will Deacon <will@kernel.org>,
        Greg KH <greg@kroah.com>,
        Alexander Popov <alex.popov@linux.com>, efremov@ispras.ru,
        linux-block@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20190712185523.7208-1-efremov@ispras.ru>
 <20190713080726.GA19611@1wt.eu>
 <ec0a6c5e-bdee-3c26-f5d2-31b883c0de5d@ispras.ru>
 <CAHk-=wi=fHuiQg1fMzqAP9cuykBQSN_feD=eALDwRPmw27UwEg@mail.gmail.com>
 <nycvar.YFH.7.76.1907172355020.5899@cbobk.fhfr.pm>
 <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <431bd981-d81a-d4dd-75fe-96a29f8f1065@kernel.dk>
Date:   Wed, 31 Jul 2019 08:53:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/31/19 8:47 AM, Denis Efremov wrote:
> Hi All,
> 
> On 18.07.2019 01:03, Jiri Kosina wrote:
>> On Wed, 17 Jul 2019, Linus Torvalds wrote:
>>
>>> I don't think we really have a floppy maintainer any more,
>>
>> Yeah, I basically volunteered myself to maintain it quite some time
>> ago back when I fixed the concurrency issues which exhibited itself
>> only with VM-emulated devices, and at the same time I still had the
>> physical 3.5" reader.
>>
>> The hardware doesn't work any more though. So I guess I should just
>> remove myself as a maintainer to reflect the reality and mark floppy.c
>> as Orphaned.
> 
> Well, without jokes about Thunderdome, I've got time, hardware and
> would like to maintain the floppy. Except the for recent fixes,
> I described floppy ioctls in syzkaller. I've already spent quite
> a lot of time with this code. Thus, if nobody minds

Great, can't see anyone objecting to doling out some floppy love.
Applied, thanks.

-- 
Jens Axboe

