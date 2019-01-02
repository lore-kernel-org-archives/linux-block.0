Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0743C43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 16:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8669218A4
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 16:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfABQK2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:10:28 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:42224 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbfABQK1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 11:10:27 -0500
Received: by mail-qt1-f182.google.com with SMTP id d19so33890716qtq.9
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 08:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4BN37l7dHOdx2ZubceEJ6pTq6i0DachpZ8nlfn5yIc=;
        b=dgqn6YhZIT03ZgKtXldBDVJrC2VbKSL+t1qqUjwNuBbAeX825WoREjuSo8cWTbNyE2
         Um9Jrck21vW+t+Ds1BwushrciscUp0CdYGzb3gCwP7XChXGSe0yJbH0WywyqJ5EqDh+r
         Py30ak1eH1dxYfKESlxTHifJf2+EA557WOapDQy/xmKyea6gYt0rruPriW3SVGmpzbvD
         oOSwhBkQefgnVBC/21MY06NN0gsvVCM3Jx/+aeFkpr2guEjUaSjgb28DNdhaG/CJMzNY
         CLtTYzMGqyGxsCyjfFeB5v30q91cxnsOeX2qRpXXNP4s4scf5IllNERUDVfGaP/yVJmz
         d2Aw==
X-Gm-Message-State: AJcUukdTOzmgZ06Yqu6R+BWkFwzwuiHZ+OHXHt23QhMa39eyxek4gHsx
        dWQ+/9JRFLXBCoIXw6m8/yBqBw==
X-Google-Smtp-Source: ALg8bN6JXg/7NN0fXDT+lVsJtvoyFOUd1cVtLz09OMP1xrJj8YWm79x/GZ0bRyzXfczV67qmE8WOWA==
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr43557353qvb.218.1546445426056;
        Wed, 02 Jan 2019 08:10:26 -0800 (PST)
Received: from 2600-6c64-4e80-00f1-56ee-75ff-fe93-2951.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-56ee-75ff-fe93-2951.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:56ee:75ff:fe93:2951])
        by smtp.gmail.com with ESMTPSA id p47sm32442760qta.36.2019.01.02.08.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 08:10:25 -0800 (PST)
Message-ID: <1546445424.29282.1.camel@redhat.com>
Subject: Re: failed command: WRITE FPDMA QUEUED with Samsung 860 EVO
From:   Laurence Oberman <loberman@redhat.com>
To:     Sitsofe Wheeler <sitsofe@gmail.com>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Date:   Wed, 02 Jan 2019 11:10:24 -0500
In-Reply-To: <CALjAwxj8LHFomCJJNCDmne1PZ6ygjtzKyvA+09kQA62vQZ3OBA@mail.gmail.com>
References: <CALjAwxgOhbYF=A4PbVipP9M+XnwnRG+c2Pcid=cZjtBe0uDUHw@mail.gmail.com>
         <CALjAwxj8LHFomCJJNCDmne1PZ6ygjtzKyvA+09kQA62vQZ3OBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-01-02 at 15:29 +0000, Sitsofe Wheeler wrote:
> (Also trying linux-ide list)
> 
> On Wed, 2 Jan 2019 at 15:25, Sitsofe Wheeler <sitsofe@gmail.com>
> wrote:
> > 
> > Hi,
> > 
> > I recently purchased a SATA Samsung 860 EVO SSD and put it in an
> > old
> > HP microserver (which has an AMD N36L). By default, when the disk
> > load
> > becomes a little heavy e.g. by running a job like
> > 
> > fio --name=test --readonly --rw=randread --filename /dev/sdb --
> > bs=32k \
> >     --ioengine=libaio --iodepth=32 --direct=1 --runtime=10m --
> > time_based=1
> > 
> > the kernel starts repeatedly producing error messages like:
> > 
> > [ 1177.729912] ata2.00: exception Emask 0x10 SAct 0x3c000 SErr 0x0
> > action 0x6 frozen
> > [ 1177.729931] ata2.00: irq_stat 0x08000000, interface fatal error
> > [ 1177.729943] ata2.00: failed command: WRITE FPDMA QUEUED
> > [ 1177.729962] ata2.00: cmd 61/80:70:80:50:e6/06:00:00:00:00/40 tag
> > 14
> > ncq dma 851968 out
> > [ 1177.729962]          res 40/00:80:00:5a:e6/00:00:00:00:00/40
> > Emask
> > 0x10 (ATA bus error)
> > [ 1177.729978] ata2.00: status: { DRDY }
> > [ 1177.729986] ata2.00: failed command: WRITE FPDMA QUEUED
> > [ 1177.730002] ata2.00: cmd 61/00:78:00:57:e6/03:00:00:00:00/40 tag
> > 15
> > ncq dma 393216 out
> > [ 1177.730002]          res 40/00:80:00:5a:e6/00:00:00:00:00/40
> > Emask
> > 0x10 (ATA bus error)
> > [ 1177.730017] ata2.00: status: { DRDY }
> > [ 1177.730024] ata2.00: failed command: WRITE FPDMA QUEUED
> > [ 1177.730039] ata2.00: cmd 61/00:80:00:5a:e6/05:00:00:00:00/40 tag
> > 16
> > ncq dma 655360 out
> > [ 1177.730039]          res 40/00:80:00:5a:e6/00:00:00:00:00/40
> > Emask
> > 0x10 (ATA bus error)
> > [ 1177.730053] ata2.00: status: { DRDY }
> > [ 1177.730060] ata2.00: failed command: WRITE FPDMA QUEUED
> > [ 1177.730078] ata2.00: cmd 61/00:88:00:5f:e6/01:00:00:00:00/40 tag
> > 17
> > ncq dma 131072 out
> > [ 1177.730078]          res 40/00:80:00:5a:e6/00:00:00:00:00/40
> > Emask
> > 0x10 (ATA bus error)
> > [ 1177.730096] ata2.00: status: { DRDY }
> > [ 1177.730108] ata2: hard resetting link
> > [ 1178.205831] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl
> > 300)
> > [ 1178.206165] ata2.00: supports DRM functions and may not be fully
> > accessible
> > [ 1178.209743] ata2.00: supports DRM functions and may not be fully
> > accessible
> > [ 1178.212786] ata2.00: configured for UDMA/133
> > [ 1178.212826] ata2: EH complete
> > [ 1178.212988] ata2.00: Enabling discard_zeroes_data
> > 
> > I tried moving the SSD to another caddy and bay but the issue
> > persists. None of the regular hard disks (a Western Digital and a
> > Seagate) nor the other SSD (a Crucial MX500) already in the system
> > trigger the issue the Samsung 860 EVO does. Adding
> > 
> > libata.force=2.00:noncq
> > 
> > seems to make the issue go away but seemingly at some speed cost
> > (at
> > least compared to what the MX500 achieves). The OS in use is Ubuntu
> > 18.04 with a 4.15.0-43-generic kernel but even a 4.18.0-13-generic
> > had
> > the same issue.
> > 
> > Is there anything software-wise that might need investigating that
> > would allow NCQ to work and a better speed to be reached?
> 
> 

Hello 

I have seen issues reported due to low power delivery to the drive.
However investigating this, its starts with an exception Emask and then
the link error code runs.
Reviewing online some folks are reporting cable issues can cause this
or firmware.
I don't have one to test myself, and you are using an enclosure. Are
you able to connect direct to the motherboard via another cable and
test again.

Regards
Laurence
