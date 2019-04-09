Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6DDC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46B0217F9
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 18:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PoL/k0X6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfDISqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:46:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37229 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDISqS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 14:46:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so9946105ply.4
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0vApW/buY6OtCIWOQhnD5Xdm5WPEcH/+QK5/B7HgPtU=;
        b=PoL/k0X6ejuMiI0c9MQKWm9xd2VHgVKAB9jdtVvO3kK/e3wM/mpcxFVRmHspMNOgC/
         bB1b9loCQDjA1VnrgOvVXwfQ+gllNSnaecp+jqKsn9Ol/BtRXIIFVul4IVhADr9weE42
         RmAetUkOE3iZ2F1dLzmooSr/dt7QAdit053yA0l7Ki1DaYGkdFO4G4au7kSPT/OGcAQh
         Z0fQe4/q+c454Z4G2I+jsz9dXCNoeiS86mBjV0JUUkCKoFzQGQ27zq84otl/tuAokojP
         sdcsLxvOVvYmCI8FetX8eTq51isRqSaQ3OyPWhKyRVHE9xa+Ru/n4KgX9T+OeZS2KB0P
         SCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0vApW/buY6OtCIWOQhnD5Xdm5WPEcH/+QK5/B7HgPtU=;
        b=ntnUT02VQu/znxQuCKK4+NNYsi2wvTlAwSOLCq+pnL6mZClyHjqvonZWCgyZGyqKcZ
         5qTOSXTbnadQYGolX2l9AgF5Z1AK7W4irbykPD44cSXqYfLHP6g+fW1vLqrZtT4X77Lq
         ZZbsjuKEKzgPwcv9Zg9UdJP7MDCBJr8dinB+5PEe1lDcVojXB/8vB9cEyf1FWgNOxLyV
         bc1ImwnVeKhGmnF8tEYyVL12Sh26eMcp2CkVJJsU30OWFp4aiH0IxGJH6+T5zN0BLxKI
         kGkRFJQyf9jRzfZcv3GMm9lXdGoGk7usa+ery3p3LN+WtYYeSnHziR/dMtsg0EATC9xK
         s6Qg==
X-Gm-Message-State: APjAAAWIUn3imy8CieZO1fNfqB61t30bgnjKB0omdKF+k8tJwadETmt6
        Cg9/VktY5Cqz0/QfFOnGfrybqw==
X-Google-Smtp-Source: APXvYqxCFYzGofLG3ra9STFDozNvsDGaIZYxmKv5Hy7Ee58vyLLkvQg2fJGIj6Q+oooq1xpqXuGskA==
X-Received: by 2002:a17:902:ec0c:: with SMTP id cy12mr16772022plb.291.1554835577855;
        Tue, 09 Apr 2019 11:46:17 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id h4sm42587504pgn.20.2019.04.09.11.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 11:46:16 -0700 (PDT)
Subject: Re: [PATCH] io_uring: add support for barrier fsync
To:     Chris Mason <clm@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <7c7276e4-8ffa-495a-6abf-926a58ee899e@kernel.dk>
 <20190409181742.GA24925@infradead.org>
 <5f8d9644-9e8f-c9d2-611e-4b144c62539c@kernel.dk>
 <5BF7FDDE-212E-4F9A-9B50-26BDA99E952A@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a7f00629-f822-7271-7a4e-ad3b802752e4@kernel.dk>
Date:   Tue, 9 Apr 2019 12:46:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5BF7FDDE-212E-4F9A-9B50-26BDA99E952A@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/9/19 12:42 PM, Chris Mason wrote:
> On 9 Apr 2019, at 14:23, Jens Axboe wrote:
> 
>> On 4/9/19 12:17 PM, Christoph Hellwig wrote:
>>> On Tue, Apr 09, 2019 at 10:27:43AM -0600, Jens Axboe wrote:
>>>> It's a quite common use case to issue a bunch of writes, then an 
>>>> fsync
>>>> or fdatasync when they complete. Since io_uring doesn't guarantee 
>>>> any
>>>> type of ordering, the application must track issued writes and wait
>>>> with the fsync issue until they have completed.
>>>>
>>>> Add an IORING_FSYNC_BARRIER flag that helps with this so the 
>>>> application
>>>> doesn't have to do this manually. If this flag is set for the fsync
>>>> request, we won't issue it until pending IO has already completed.
>>>
>>> I think we need a much more detailed explanation of the semantics,
>>> preferably in man page format.
>>>
>>> Barrier at least in Linux traditionally means all previously 
>>> submitted
>>> requests have finished and no new ones are started until the
>>> barrier request finishes, which is very heavy handed.  Is that what
>>> this is supposed to do?  If not what are the exact guarantees vs
>>> ordering and or barrier semantics?
>>
>> The patch description isn't that great, and maybe the naming isn't 
>> that
>> intuitive either. The way it's implemented, the fsync will NOT be 
>> issued
>> until previously issued IOs have completed. That means both reads and
>> writes, since there's no way to wait for just one.  In terms of
>> semantics, any previously submitted writes will have completed before
>> this fsync is issued. The barrier fsync has no ordering wrt future
>> writes, no ordering is implied there. Hence:
>>
>> W1, W2, W3, FSYNC_W_BARRIER, W4, W5
>>
>> W1..3 will have been completed by the hardware side before we start
>> FSYNC_W_BARRIER. We don't wait with issuing W4..5 until after the 
>> fsync
>> completes, no ordering is provided there.
> 
> Looking at the patch, why is fsync special?  Seems like you could add 
> this ordering bit to any write?

It's really not, the exact same technique could be used on any type of
command to imply ordering. My initial idea was to have an explicit
barrier/ordering command, but I didn't think that separating it from an
actual command would be needed/useful.

> While you're here, do you want to add a way to FUA/cache flush?  
> Basically the rest of what user land would need to make their own 
> write-back-cache-safe implementation.

FUA would be a WRITEV/WRITE_FIXED flag, that should be trivially doable.

In terms of cache flush, that's very heavy handed (and storage
oriented).  What applications would want/need to do an explicit whole
device flush?

-- 
Jens Axboe

