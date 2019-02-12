Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D3DC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 04:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A6F2184A
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 04:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="boLhc8UC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfBLEQA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 23:16:00 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56712 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726961AbfBLEQA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 23:16:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C8DD18EE235;
        Mon, 11 Feb 2019 20:15:59 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PB-VvO3JcdoZ; Mon, 11 Feb 2019 20:15:59 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3A90B8EE121;
        Mon, 11 Feb 2019 20:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1549944959;
        bh=DEMAfkza0rPxuTxRwwivaRv9qwcKG5pJu2Q7b44VlyE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=boLhc8UCzWW55O51ZYu/TBe54u8RP7ydReHOSsUG7YRvHdSoonGKpx/yKhtu51v3O
         3q1ntRCyHzxwF2EbYyEqQNspd19yYcIscI6DW47jOCHs0zb0Tlx9rl/Fb1gxEV/ElC
         eYsF2AhDhFF+A6JCA31V/szuusm17KoZo8pcYW2A=
Message-ID: <1549944957.2857.13.camel@HansenPartnership.com>
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes
 5 minute delay during boot on Sun Blade 2500
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Mon, 11 Feb 2019 20:15:57 -0800
In-Reply-To: <AT5PR8401MB1169D3DBEBC4F88D76BD1710AB650@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
         <1549736341.2971.7.camel@HansenPartnership.com>
         <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
         <1549813472.4142.3.camel@HansenPartnership.com>
         <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
         <1549815924.4142.8.camel@HansenPartnership.com>
         <0e6e5d67-d305-dd00-2e42-e2299166c8b2@kernel.dk>
         <1549898730.2831.6.camel@HansenPartnership.com>
         <44bb4374-0b7c-733b-a53e-92d2f03f2f49@kernel.dk>
         <1549899773.2831.12.camel@HansenPartnership.com>
         <1a00da0e-cb8e-30ea-8d17-120f97242b2f@kernel.dk>
         <1549902521.2831.23.camel@HansenPartnership.com>
         <fce66227-ff41-3a4e-4c6a-f4c2ca492b95@kernel.dk>
         <1549937598.2857.8.camel@HansenPartnership.com>
         <fc547d40-9a42-a823-b62f-460c3244fe7d@kernel.dk>
         <AT5PR8401MB1169D3DBEBC4F88D76BD1710AB650@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-02-12 at 03:37 +0000, Elliott, Robert (Persistent Memory)
wrote:
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > owner@vger.kernel.org> On Behalf Of Jens Axboe
> > Sent: Monday, February 11, 2019 8:50 PM
> > To: James Bottomley <James.Bottomley@HansenPartnership.com>; Mikael
> > Pettersson <mikpelinux@gmail.com>
> > Cc: Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>;
> > linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > scsi
> > <linux-scsi@vger.kernel.org>
> > Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO
> > path"
> > causes 5 minute delay during boot on Sun Blade 2500
> 
> ...
> 
> > > We can either fix this by setting the QUEUE_FLAG_ADD_RANDOM if
> > > there's no 0xB1 page or by setting the default as Jens proposed.
> > 
> > I'd recommend just doing my patch, since that'll be the same
> > behavior that SCSI had before.
> 
> When blk-mq and scsi-mq were introduced to boost SAS SSDs over
> 1 million IOPS, this was purposely kept off, because it generated
> a noticeable 3-12 us latency blip whenever the "fast_mix" code ran
> out of bits. If Jens' patch changes the default to be enabled for
> all scsi-mq users, that'll be a change for the newer legacy
> scsi-mq users (except for users that don't trust the default and
> always set the value in sysfs).

All high IOPs devices have a device characteristics page, so even if we
 default this to ON, it will get turned off for these devices which
should be the desired result regardless of the default setting. 

James

