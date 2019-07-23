Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E5C76190
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C602166E
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Dnt1CZhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfGWULi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:11:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43391 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbfGWULi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 16:11:38 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so84551109ios.10
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MgP9LPfN10DUEaC+WQ9A4hu3RGENheRoiLTrymj8eyk=;
        b=Dnt1CZhC2LYrT/U3mvjzzjc/RRyAMYJOiUzUkgn51dAkhx+Z4lcf09bmfDkctEXXRs
         5WL5CMAyjzmhtl34HFSzAUjLII10NFwFJuNE8hEKvnovGUJ/CiYCzeKZ7epZsxQRQPCB
         anBEh6KFs13SbidfvWEw/5+P2APykujHGOBPn/ne5C5xPjtNNmsDk7zQmjGhu412bKcU
         HWvMp9CFLG7Gk6Hau1cxqTlPc/p3VYNu5oNxRRzeC8DbrLP663nzm9UBg1/8NBQHIwcM
         gHkSsaUNCItUn0jSZR1kS8K5mPBJtzgtXi7FANNwEMluuacnQ2cQ5Dza/ryEtDKwT/5l
         CiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MgP9LPfN10DUEaC+WQ9A4hu3RGENheRoiLTrymj8eyk=;
        b=DogX8hIpAW4PdfXs8kUei16rBJ4zpee5wA9kpySksSzLJ+3/5LvG01TO91v7kMmC4I
         PzgEe7sWFR57fhDoSet64J26zhE3PTO+XYF5RfuomQpGLINYOwt1niBUrvh/0IAXjNcI
         2ira1p7D+SLXe1I3z6+CEJNk6W9g2om5raz5YJuq5OddCpUkJpjDdWouM78kULKnQ3cH
         yWsV3PVCEYR7J0shvtVqm3ADSR3ZkzfOioojoVkcSWz92NUyjYvb3Yv4YG6lPzO6971D
         UJSPmqZDXlso05xYdvJL2iDHihDIWOoFxoJeuUt8rSIyI51Z9ANBJDraM0Nm8jttc+zt
         27aQ==
X-Gm-Message-State: APjAAAUdSoWak5vyU/A5dQ6bF6hI9iGseI0moN0VcUyyx+6zwHuJsM+U
        PNQ7DYtGyyLAfku1ARgNd10=
X-Google-Smtp-Source: APXvYqyw+FYUYBH7PHPM9hNQ10u20FZLOaBrygg1nawT4ojZ4fbrKNALassUfMdL2vC7z2sCMRVyyg==
X-Received: by 2002:a6b:ed01:: with SMTP id n1mr71686178iog.255.1563912697407;
        Tue, 23 Jul 2019 13:11:37 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b14sm47499178iod.33.2019.07.23.13.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 13:11:36 -0700 (PDT)
Subject: Re: EIO with io_uring O_DIRECT writes on ext4
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20190723080701.GA3198@stefanha-x1.localdomain>
 <9a13c3b9-ecf2-6ba7-f0fb-c59a1e1539f3@kernel.dk>
 <20190723200713.GA4565@mit.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ed518886-19b1-88c4-a63c-8bde65330e5b@kernel.dk>
Date:   Tue, 23 Jul 2019 14:11:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723200713.GA4565@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/23/19 2:07 PM, Theodore Y. Ts'o wrote:
> On Tue, Jul 23, 2019 at 09:20:05AM -0600, Jens Axboe wrote:
>>
>> I actually think it's XFS that's broken here, it's not passing down
>> the IOCB_NOWAIT -> IOMAP_NOWAIT -> REQ_NOWAIT. This means we lose that
>> important request bit, and we just block instead of triggering the
>> not_supported case.
>>
>> Outside of that, that case needs similar treatment to what I did for
>> the EAGAIN case here:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=893a1c97205a3ece0cbb3f571a3b972080f3b4c7
>>
>> It was a big mistake to pass back these values in an async fashion,
>> and it also means that some accounting in other drivers are broken
>> as we can get completions without the bio actually being submitted.
> 
> Hmmm, I had been trying to track down a similar case with virtio-scsi
> on top of LVM, using a Google Compute Engine VM.  In that case,
> xfstests generic/471 was failing with EIO, when it would pass just
> *fine* when I was using KVM with a virtio-scsi device w/o LVM.
> 
> So it sounds like that what's going on is if the device driver (or
> LVM, or anything else in the storage stack) needs to do a blocking
> memory allocation, and NOWAIT is requested, we'll end up returning EIO
> because an asynchronous error is getting reported, where as if we
> could return it synchronously, the file system could properly return
> EOPNOTSUP.  Am I understanding you correctly?

Yes, that's exactly right. The EAGAIN/EOPNOTSUPP for blocking reasons
should be returned sync, so ext4/xfs can return that error as well. This
enables us to punt the IO appropriately to a workqueue. It should NOT
result in being translated into an EIO to the application.

Working on this change right now...

> I guess there's a separate question hiding here, which is whether
> there's a way to allow dm-linear or dm-crypt to handle NOWAIT requests
> without needing to block.

That's certainly the next step. Right now we just guard this with
queue_is_mq(), but in reality it should be a queue flag so that stacking
drivers can opt in when they have been vetted/changed to support NOWAIT
properly.

But wading through this stuff is leaving me a little disappointed in the
level of NOWAIT support we have right now. It seems mostly half-assed
and there are plenty of cases where we don't really do the right thing.
I'll try and work through all that, to the extent possible.

-- 
Jens Axboe

