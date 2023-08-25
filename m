Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3CEC3DA6F
	for <linux-block@archiver.kernel.org>; Fri, 25 Aug 2023 12:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjHYMCt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Aug 2023 08:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243316AbjHYMC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2023 08:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0461BFA
        for <linux-block@vger.kernel.org>; Fri, 25 Aug 2023 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692964903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMsoz+RjCS7oydRnPPz5xqRxi+m5Ai2lc97p8T7ufVM=;
        b=C3qFVJCOTtAQ5iYn/1AJDN38eX8mNPxrPdL1aQ6SMlD0cMSxCaaJ38qqeWzHIA6TOQvZlT
        +cmIf9MIrnu1KlbzRVJBCw3IchikyDvomrEuH+GoPd3ZTLnaw1U7QXEiAsKSUuu5fDtd/f
        IGqpWtITcnKKcPXjqhC1eThERrmIYJw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-dOUNG1fAMLSRTgnYF635fQ-1; Fri, 25 Aug 2023 08:01:42 -0400
X-MC-Unique: dOUNG1fAMLSRTgnYF635fQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-59299db9977so8751037b3.2
        for <linux-block@vger.kernel.org>; Fri, 25 Aug 2023 05:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692964901; x=1693569701;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uMsoz+RjCS7oydRnPPz5xqRxi+m5Ai2lc97p8T7ufVM=;
        b=dAZU4WFoc8N9a7vpMLPWc603Lw7adloewNFJCrzOJajxTwyajmB06fA9ciN/e/Tjff
         8q2oGnWcJKGOFPCb3WwUeOJ80thjp9LMy1HSOcZCOOleF5KawhQPAPrTPzATS6B9jwwj
         y3zQtC26VTt4idRNIVd4pJnb97wvf5pTm3LFzUTyWcOwwslZ+nVZuPQPaB7HsPWqSA+2
         UzdeYq8gbgmC9LW1FzgXzJBwuWODy8l7hDtmCDAYJm/S7uPB7pQNU94V8GKbyb7JD1XH
         hP20iFWQho42GPW3YoM29m9c8J0epKPmebd9mEQmldn+Seu2YTAYpGIK630iHZr/ylu4
         MnvQ==
X-Gm-Message-State: AOJu0Yxmbyq1QTwmmO4yK810vy1tLHykDjdVkuBE/8miO/yUCw+AjZRf
        5298JMfKX4+DI2ps52GahtXQHU+PSTV0G4TSfIOpjsnl2avNcltcX9TTmQClbC3Gf7p3FhpqtsS
        oH/a3LJ21ttApuLR71jjjr9e1DbXZNJY=
X-Received: by 2002:a81:8841:0:b0:592:2bf2:6578 with SMTP id y62-20020a818841000000b005922bf26578mr14081740ywf.46.1692964901550;
        Fri, 25 Aug 2023 05:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSQZb0OZPbNJqB0DRMx2dYC4TeKFNgcezh1dDotaAK29llYli9G2/PK0LTZFiE0zHBeLV5wQ==
X-Received: by 2002:a81:8841:0:b0:592:2bf2:6578 with SMTP id y62-20020a818841000000b005922bf26578mr14081719ywf.46.1692964901177;
        Fri, 25 Aug 2023 05:01:41 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id f68-20020a0ddc47000000b00585f60e970esm455266ywe.134.2023.08.25.05.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:01:40 -0700 (PDT)
Message-ID: <b641b62d42fe890fa298dd1e3d56d685c6496441.camel@redhat.com>
Subject: Re: LVM kernel lockup scenario during lvcreate
From:   Laurence Oberman <loberman@redhat.com>
To:     Jaco Kroon <jaco@uls.co.za>, Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Fri, 25 Aug 2023 08:01:39 -0400
In-Reply-To: <564fe606-1bbf-4f29-4f10-7142ae07321f@uls.co.za>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
         <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
         <94477c459a398c47cb251afbcafbc9a6a83bba6f.camel@redhat.com>
         <977a1223-a543-a6ca-4a6c-0cf0fc6f84a0@uls.co.za>
         <69227e4091f3d9b05e739f900340f11afacdd91f.camel@redhat.com>
         <564fe606-1bbf-4f29-4f10-7142ae07321f@uls.co.za>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2023-08-25 at 01:40 +0200, Jaco Kroon wrote:
> Hi Laurence,
> > > > One I am aware of is this
> > > > commit 106397376c0369fcc01c58dd189ff925a2724a57
> > > > Author: David Jeffery <djeffery@redhat.com>
>=20
> I should have held off on replying until I finished looking into
> this.=C2=A0=20
> This looks very interesting indeed, that said, this is my first
> serious=20
> venture into the block layers of the kernel :), so the essay below is
> more for my understanding than anything else, would be great to have
> a=20
> better understanding of the underlying principles here and your
> feedback=20
> on my understanding thereof would be much appreciated.
>=20
> If I understand this correctly (and that's a BIG IF) then it's
> possible=20
> that a bunch of IO requests goes into a wait queue for whatever
> reason=20
> (pending some other event?).=C2=A0 It's then possible that some of them=
=20
> should get woken up, and previously (prior to above) it could happen=20
> that only a single request gets woken up, and then that request would
> go=20
> straight back to the wait queue ... with the patch, isn't it still=20
> possible that all woken up requests could just go straight back to
> the=20
> wait queue (albeit less likely)?
>=20
> Could the creation of a snapshot (which should based on my
> understanding=20
> of what a snapshot is block writes whilst the snapshot is being
> created,=20
> ie, make them go to the wait queue), and could it be that the process
> of=20
> setting up the snapshot (which itself involves writes) then
> potentially=20
> block due to this?=C2=A0 Ie, the write request that needs to get into the=
=20
> next batch to allow other writes to proceed gets blocked?
>=20
> And as I write that it stops making sense to me because most likely
> the=20
> IO for creating a snapshot would only result in blocking writes to
> the=20
> LV, not to the underlying PVs which contains the metadata for the VG=20
> which is being updated.
>=20
> But still ... if we think about this, the probability of that "bug"=20
> hitting would increase as the number of outstanding IO requests=20
> increase?=C2=A0 With iostat reporting r_await values upwards of 100 and=
=20
> w_await values periodically going up to 5000 (both generally in the=20
> 20-50 range for the last few minutes that I've been watching them),
> it=20
> would make sense for me that the number of requests blocking in-
> kernel=20
> could be much higher than that, it makes perfect sense for me that it
> could be related to this.=C2=A0 On the other hand, IIRC iostat -dmx 1
> usually=20
> showed only minimal if any requests in either [rw]_await during
> lockups.
>=20
> Consider the AHCI controller on the other hand where we've got 7200
> RPM=20
> SATA drives which are slow to begin with, now we've got traditional=20
> snapshots, which are also causing an IO bottleneck and artificially=20
> raising IO demand (much more so than thin snaps, really wish I could=20
> figure out the migration process to convert this whole host to thin=20
> pools but lvconvert scares me something crazy), so now having that
> first=20
> snapshot causes IO bottleneck (ignoring relevant metadata updates,
> every=20
> write to a not yet duplicated segment becomes a read + write + write
> to=20
> clone the written to segment to the snapshot - thin pools just a read
> +=20
> write for same), so already IO is more demanding, and now we try to=20
> create another snapshot.
>=20
> What if some IO fails to finish (due to continually being put back
> into=20
> the wait queue), thus blocking the process of creating the snapshot
> to=20
> begin with?
>=20
> I know there are numerous other people using snapshots, but I've
> often=20
> wondered how many use it quite as heavily as we do on this specific=20
> host?=C2=A0 Given the massive amount of virtual machine infrastructure on
> the=20
> one hand I think there must be quite a lot, but then I also think
> many=20
> of them use "enterprise" (for whatever your definition of that is)=20
> storage or something like ceph, so not based on LVM.=C2=A0 And more and
> more=20
> so either SSD/flash or even NVMe, which given the faster response
> times=20
> would also lower the risks of IO related problems from showing
> themselves.
>=20
> The risk seems to be during the creation of snapshots, so IO not
> making=20
> progress makes sense.
>=20
> I've back-ported the referenced path onto 6.4.12 now, which will go=20
> alive Saturday morning.=C2=A0 Perhaps we'll be sorted now.=C2=A0 Will als=
o
> revert=20
> to mq-deadline which has been shown to more regularly trigger this,
> so=20
> let's see.
>=20
> >=20
> > Hello, this would usually need an NMI sent from a management
> > interface
> > as with it locked up no guarantee a sysrq c will get there from the
> > keyboard.
> > You could try though.
> >=20
> > As long as you have in /etc/kdump.conf
> >=20
> > path /var/crash
> > core_collector makedumpfile -l --message-level 7 -d 31
> >=20
> > This will get kernel only pages and would not be very big.
> >=20
> > I could work with you privately to get what we need out of the
> > vmcore
> > and we would avoid transferring it.
> Thanks.=C2=A0 This helps.=C2=A0 Let's get a core first (if it's going to =
happen
> again) and then take it from there.
>=20
> Kind regards,
> Jaco
>=20

Hello Jaco
These hangs usually require the stacks to see where and why we are
blocked. The vmcore will definitely help in that regard.

Regards
Laurence

