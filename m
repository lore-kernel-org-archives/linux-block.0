Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EFEC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 16:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC56218F0
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 16:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tOXq6WS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfBKQ2o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:28:44 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47764 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbfBKQ2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 11:28:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0C3618EE235;
        Mon, 11 Feb 2019 08:28:44 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1DH1RR_F85Ss; Mon, 11 Feb 2019 08:28:43 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 859E08EE121;
        Mon, 11 Feb 2019 08:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1549902523;
        bh=eVqqr2vRyAucYgej9M3SlCKrG0QWNt25NjY5/11pdh4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tOXq6WS4veXGsO0JIgtFLWJhGoxWKoGpeCrst8ykWJdBjvGK5tcf7L3s8wmQjf+NH
         PVXRMmi5Be0ybaDgTXWRzFmAylTu3zxch6crbVJloEYF0O7daaD3uVwx0lvJ8vcgb9
         8Si85QZKroyuIYsPoXLc6VlhUeqhXP+JX3Bk1QpE=
Message-ID: <1549902521.2831.23.camel@HansenPartnership.com>
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes
 5 minute delay during boot on Sun Blade 2500
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Feb 2019 08:28:41 -0800
In-Reply-To: <1a00da0e-cb8e-30ea-8d17-120f97242b2f@kernel.dk>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-02-11 at 08:46 -0700, Jens Axboe wrote:
> On 2/11/19 8:42 AM, James Bottomley wrote:
> > On Mon, 2019-02-11 at 08:28 -0700, Jens Axboe wrote:
> > > On 2/11/19 8:25 AM, James Bottomley wrote:
> > > > On Sun, 2019-02-10 at 09:35 -0700, Jens Axboe wrote:
> > > > > On 2/10/19 9:25 AM, James Bottomley wrote:
[...]
> > > > > > That check wasn't changed by the code removal.
> > > > > 
> > > > > As I said above, for sd. This isn't true for non-disks.
> > > > 
> > > > Yes, but the behaviour above doesn't change across a switch to
> > > > MQ, so I don't quite understand how it bisects back to that
> > > > change.  If we're not gathering entropy for the device now, we
> > > > wouldn't have been before the switch, so the entropy
> > > > characteristics shouldn't have changed.
> > > 
> > > But it does, as I also wrote in that first email. The legacy
> > > queue flags had QUEUE_FLAG_ADD_RANDOM set by default, the MQ ones
> > > do not. Hence any non-sd device would previously ALWAYS have
> > > ADD_RANDOM set, now none of them do. Also see the patch I sent.
> > 
> > So your theory is that the disk in question never gets to the
> > rotational check?  because the check will clear the flag if it's
> > non-rotational and set it if it's not, so the default state of the
> > flag shouldn't matter.
> 
> No, my point is about non-disks, devices that aren't driven by sd.
> The behavior for sd hasn't changed, as it sets/clears it
> unconditionally.

I agree, but I don't think any of them were significant entropy
contributors before: things like nvme have always been outside of this
and sr and st don't really contribute much to the seek load during boot
because they're probed but not used by the boot sequence, so I can't
see how they would cause this behaviour.  I suppose it could be target
probing, but even that seems unlikely because it should be dwarfed by
the number of root disk reads during boot.

For the rng to take an additional 5 minutes to initialize, we must have
lost a significant entropy source somewhere.

James

> That's not true for something driven by sr, for instance, and
> anything else non-sd. For those we defaulted to adding randomness for
> !scsi-mq, and default to not adding randomness for scsi-mq.
> 
> The patch I included would have the same behavior for scsi-mq as we
> had for non-mq.

