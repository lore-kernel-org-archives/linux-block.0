Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6224AC7618F
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E93020838
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 18:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fGPajyWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfGZSjs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:39:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39479 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfGZSjs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 14:39:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so25166023pgi.6
        for <linux-block@vger.kernel.org>; Fri, 26 Jul 2019 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JhAY1HMODkeLfugY1cZZSN1o618UDKmIb/HdeZvmix0=;
        b=fGPajyWJc/v9pdwSxC+GqwQYXcXpXPuU/zE2KqT1dPG5DOx4w4kWWUIuzr0XexP+9C
         XbA9YsuOnkR//VC+BboQs3y9LSJS+3u+b2xaMH4I9S2X4RZBqto41akJdgXO31DkZ28z
         SVFse4j6lZWZT7Znoq0ttMlmnGHQhcStefaHLhSTQRKaKolcwO7h5E+WWibVquvC679j
         vG1fnW8dFcTbafbPOYCM7u0OYTI514SCV86JGqgxFcY9duI9BBJSJPNFk8Lciz1Bn2R9
         FwilUcjN3KXpbNhom3w+HUVJHPEd0FKZjHyW8W9/U1S5/Axqxbs0yAdeNPgfMmUubkj5
         IPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JhAY1HMODkeLfugY1cZZSN1o618UDKmIb/HdeZvmix0=;
        b=Y4KDtLwcxjPpRreKNt9rTj01imaTV62I5gRs2fTWcyhyF63vTK9YCdSdWj6/XBGe7Y
         SGgTWvMK2Wq1Cyb+FBP6qzPXlEE/L9xea4S3JsqDsS/ErbrFeeARkx3cMrEZHgzhmzNp
         u7GYqfal4aOTmLHSd15KZ135doZLQWzBMHNJ2KqfPduHEBKddZ2uESJxxc3afD2Bih6y
         NXtomra8m/VqiOfahRLhmKcXQIOEPFAnXzPxUUGWpJUbI+XEzUnGN7LmwpiP4C59ltAA
         lTZdQRpIN1d4P0qxKDWzLCtusNIuUxjSonIcIY6GYgSRnonTS4G5zeXimg3uoiHbGc4x
         hwwQ==
X-Gm-Message-State: APjAAAW46fm7I0N7f7eQDfzqWGDTkcMu5GXZgt7zN5OApbhFXgD7wkfq
        n1SJl/ZsINh537qEKvxk4qNjXu0LN1Y=
X-Google-Smtp-Source: APXvYqzeZEJItuqpGt+xjSBn2C6SEQ+yuTZEcD9zLKeIbcXaq8KIl0ZxpXmReUwhThM8yf09tdajdQ==
X-Received: by 2002:a63:934a:: with SMTP id w10mr8755949pgm.271.1564166386611;
        Fri, 26 Jul 2019 11:39:46 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z13sm44945074pjn.32.2019.07.26.11.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 11:39:45 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.3-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
 <CAHk-=wjV1cykm1UYSVR1KzwV4ZF0QtU9rOTsThVJj8qSX6hKgQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <34bce605-51c0-b1b7-1d1d-f64f0e24b6c6@kernel.dk>
Date:   Fri, 26 Jul 2019 12:39:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjV1cykm1UYSVR1KzwV4ZF0QtU9rOTsThVJj8qSX6hKgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/19 11:56 AM, Linus Torvalds wrote:
> Guys, what happened to the wrong sector boundary and max sector mess?
> 
> There are at least two different issues (with one of them having two
> proposed fixes);
> 
>    https://lore.kernel.org/linux-block/1563896932.3609.15.camel@HansenPartnership.com/
>    https://lore.kernel.org/lkml/1563895995.3609.10.camel@HansenPartnership.com/
>    https://lore.kernel.org/lkml/1563839144.2504.5.camel@HansenPartnership.com/
> 
> but I don't actually seem to have a pull request for any of this.
> 
> The
> 
>     dma_max_mapping_size(dev) << SECTOR_SHIFT
> 
> this in scsi_lib.c is clearly completely wrong, and is still there in my tree.
> 
> The virt_boundary_mask thing can apparently be fixed other ways too
> (ie questionable whether it should be fixed in block/blk-settings.c or
> in drivers/scsi/scsi_lib.c, but I don't see either one. I was
> expecting the block/blk-settings.c one to be in this pull request.
> 
> Maybe I'm missing some alternate fix? I don't think so, particularly
> since I still see the wrong-way shift, at least.
> 
> Is this due to some confusion about who is supposed to fix it?
> Christoph was involved in both, issues, and the problems came throigh
> different trees (ie block tree for the virt_boundary_mask, scsi with
> the

The fix is sitting in the SCSI tree:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git/commit/?h=fixes&id=1b5d9a6e98350e0713b4faa1b04e8f239f63b581

so hopefully it'll be pushed upstream in time for -rc2...

-- 
Jens Axboe

