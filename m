Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA79C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 16:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00918214DA
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 16:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aHET9FOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfBJQZ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:25:27 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38792 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbfBJQZ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 11:25:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2BCBD8EE241;
        Sun, 10 Feb 2019 08:25:26 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fz8C-htArOH3; Sun, 10 Feb 2019 08:25:26 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A07838EE11D;
        Sun, 10 Feb 2019 08:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1549815925;
        bh=+AqdrZ9RAxtttyTqX/pJcpzsuQIc4/CvkdL2U3C2ICM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aHET9FOa4sb2ObobcyCddLV8zi+Z2hX4y7Zyze+6PbrIglt4wbIQEPHUGO7VsMByH
         blu4SYOCABn65EMxZN+/SdVdhFiix2gB9Zzs3mM2C/oB/Z6Lkq5snX0O9PbC3GMQd6
         8FUlRyiCYgCvTk2gBIaNoGLu6eZJu/TILD/95v7Q=
Message-ID: <1549815924.4142.8.camel@HansenPartnership.com>
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes
 5 minute delay during boot on Sun Blade 2500
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 10 Feb 2019 08:25:24 -0800
In-Reply-To: <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
         <1549736341.2971.7.camel@HansenPartnership.com>
         <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
         <1549813472.4142.3.camel@HansenPartnership.com>
         <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2019-02-10 at 09:05 -0700, Jens Axboe wrote:
> On 2/10/19 8:44 AM, James Bottomley wrote:
> > On Sun, 2019-02-10 at 10:17 +0100, Mikael Pettersson wrote:
> > > On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > [...]
> > > > I think the reason for this is that the block mq path doesn't
> > > > feed
> > > > the kernel entropy pool correctly, hence the need to install an
> > > > entropy gatherer for systems that don't have other good random
> > > > number sources.
> > > 
> > > That does sound plausible, I admit I didn't even consider the
> > > possibility that the old block I/O path also was an entropy
> > > source.
> > 
> > In theory, the new one should be as well since the rotational
> > entropy
> > collector is on the SCSI completion path.   I'd seen the same
> > problem
> > but had assumed it was something someone had done to our internal
> > entropy pool and thus hadn't bisected it.
> 
> The difference is that the old stack included ADD_RANDOM by default,
> so this check:
> 
> 	if (blk_queue_add_random(q))
> 		add_disk_randomness(req->rq_disk);
> 
> in scsi_end_request() would be true, and we'd add the randomness. For
> sd, it seems to set it just fine for non-rotational drives. Could
> this be because other devices don't? Maybe the below makes a
> difference.

No, in both we set it per the rotational parameters of the disk in 

sd.c:sd_read_block_characteristics()

	rot = get_unaligned_be16(&buffer[4]);

	if (rot == 1) {
	
	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
	
	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
	} else {
	
	blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
	
	blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
	}


That check wasn't changed by the code removal.

Although I suspect it should be unconditional: even SSDs have what
would appear as seek latencies at least during writes depending on the
time taken to find an erased block or even trigger garbage collection. 
The entropy collector is good at taking something completely regular
and spotting the inconsistencies, so it won't matter that loads of
"seeks" are deterministic.

James

