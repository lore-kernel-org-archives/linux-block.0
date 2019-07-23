Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48714C76190
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 13:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143FD227BF
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 13:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSNTvFrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfGWNeC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:34:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46366 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732718AbfGWNeC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 09:34:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so20601502plz.13;
        Tue, 23 Jul 2019 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w9+ZmzMTvq2iSo2ujhpLGpBEFet1WMn1gqo2dfrjb/E=;
        b=MSNTvFrZdBuTkcv6J2c6zOvMJXPHLl2nsaaSqrUy2hsatnWGr5v3RhzF5Qv/2HSSoB
         FiBL0ucr8akcV/auBmb36ZqMaEXHkmF4I9TXRksG6QZFRIrha8lxDGZPIi7fxrsOPKTq
         M97+AkClcvMWEMYg2e5hfjhbZ76x6Wh3yhCue68czqoOL4Ao0Pz1QNtmxzYfrjf+97OB
         BjFyvKFbrj6zwXH4VDAjgNDoG6t0ylgO90UrUYG85x036+ywDTX+n3KkSf956+vhYweo
         7i6xIGGN//Fo5oWiCyXJF94IA4Fl25mbT576y+Xi5A3MN8SBr4RhhnXDPslisLwvCzDc
         Ocpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w9+ZmzMTvq2iSo2ujhpLGpBEFet1WMn1gqo2dfrjb/E=;
        b=etZO09hmND/Lt2V9jUXVkvxO6NW52S4dJlwqNxbCUnvVv4gJJOHcrlCeD0hoifD/wp
         /OInGoBk4CTkD4/9+EOc2KSJvDh3sDF8maDMukAvvTT2GEpdM/wm2EvQB5hbghhG7Bdf
         hG/LVnU7PU1I7rFp/LnoFTAotpV7CtCJyBZaSK1mFa/6E3qqbvSjbL5t03b/aq3oncj2
         I9o3R+lzM3xa2x5asFzUPiKlYNGnfpzgJI1Ju2rxjytWByBfuAdHhRAAvSLgSJBhLOPN
         U5yY5mFipX5eS6HIrHxrVa04G8uC43y2jnlPcOoXxscYa8fojyExGMJNR62IcQzOBHmH
         G8Fw==
X-Gm-Message-State: APjAAAVQbdL0BhGmISyA8WSfP2TUPlCLvuf42bedqY3kJ8q3jQmgTHRn
        t8PDgCZ0R1cyMxEtE0YWyw0=
X-Google-Smtp-Source: APXvYqxna/HiWFKj4QIrOWVI0xdv7iyo5CoL30GT9u3tN6dvHQdEsTVYdRn8y+YgGhdlOi/5ydEDOQ==
X-Received: by 2002:a17:902:f216:: with SMTP id gn22mr78826259plb.118.1563888841134;
        Tue, 23 Jul 2019 06:34:01 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id h26sm46900292pfq.64.2019.07.23.06.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 06:34:00 -0700 (PDT)
Date:   Tue, 23 Jul 2019 22:33:58 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     minwoo.im@samsung.com,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Euihyeok Kwon <eh81.kwon@samsung.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH V2] mpt3sas: support target smid for [abort|query] task
Message-ID: <20190723133358.GB7148@minwoo-desktop>
References: <CGME20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
 <20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
 <860cc8cf-6419-c649-b2d9-19b82f6ebc99@suse.de>
 <CAK=zhgocY3Ute_6RiowaWsOROx3+Nzq6+WvkobmR_SB0Rt9_1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK=zhgocY3Ute_6RiowaWsOROx3+Nzq6+WvkobmR_SB0Rt9_1g@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-23 16:57:49, Sreekanth Reddy wrote:
> On Mon, Jul 15, 2019 at 11:43 AM Hannes Reinecke <hare@suse.de> wrote:
> >
> > On 7/14/19 5:44 AM, Minwoo Im wrote:
> > > We can request task management IOCTL command(MPI2_FUNCTION_SCSI_TASK_MGMT)
> > > to /dev/mpt3ctl.  If the given task_type is either abort task or query
> > > task, it may need a field named "Initiator Port Transfer Tag to Manage"
> > > in the IU.
> > >
> > > Current code does not support to check target IPTT tag from the
> > > tm_request.  This patch introduces to check TaskMID given from the
> > > userspace as a target tag.  We have a rule of relationship between
> > > (struct request *req->tag) and smid in mpt3sas_base.c:
> > >
> > > 3318 u16
> > > 3319 mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
> > > 3320         struct scsi_cmnd *scmd)
> > > 3321 {
> > > 3322         struct scsiio_tracker *request = scsi_cmd_priv(scmd);
> > > 3323         unsigned int tag = scmd->request->tag;
> > > 3324         u16 smid;
> > > 3325
> > > 3326         smid = tag + 1;
> > >
> > > So if we want to abort a request tagged #X, then we can pass (X + 1) to
> > > this IOCTL handler.  Otherwise, user space just can pass 0 TaskMID to
> > > abort the first outstanding smid which is legacy behaviour.
> > >
> > > Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> > > Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> > > Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> > > Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> > > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > > Cc: MPT-FusionLinux.pdl@broadcom.com
> > > Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> > > ---
> > >  drivers/scsi/mpt3sas/mpt3sas_ctl.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > > index b2bb47c14d35..f6b8fd90610a 100644
> > > --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > > +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > > @@ -596,8 +596,16 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command *karg,
> > >               if (priv_data->sas_target->handle != handle)
> > >                       continue;
> > >               st = scsi_cmd_priv(scmd);
> > > -             tm_request->TaskMID = cpu_to_le16(st->smid);
> > > -             found = 1;
> > > +
> > > +             /*
> > > +              * If the given TaskMID from the user space is zero, then the
> > > +              * first outstanding smid will be picked up.  Otherwise,
> > > +              * targeted smid will be the one.
> > > +              */
> > > +             if (!tm_request->TaskMID || tm_request->TaskMID == st->smid) {
> > > +                     tm_request->TaskMID = cpu_to_le16(st->smid);
> > > +                     found = 1;
> > > +             }
> > >       }
> > >
> > >       if (!found) {
> > >
> > I think this is fundamentally wrong.
> > ABORT_TASK is used to abort a single task, which of course has to be
> > known beforehand. If you don't know the task, what exactly do you hope
> > to achieve here? Aborting random I/O?
> > Or, even worse, aborting I/O the driver uses internally and corrupt the
> > internal workflow of the driver?
> >
> > We should simply disallow any ABORT TASK from userspace if the TaskMID
> > is zero. And I would even argue to disabllow ABORT TASK from userspace
> > completely, as the smid is never relayed to userland, and as such the
> > user cannot know which task should be aborted.
> 
> Hannes,
> 
> This interface was added long time back in mpt2sas driver and I don't
> have exact reason of adding this interface at that time.
> But I know that this interface is still used by BRCM test team & few
> customers only for some functionality and regression testing.

Actually I have sent this patch for the testing purpose for the SAS storage
that I'm working with now.  Some of test platform could figure out which
command has to be aborted or queried via debugfs and information from the
device itself with some other methods.  If the mpt3sas driver supports
the targeted TMF for a single command, then it would be great for the
testing.

Thanks,
	Minwoo Im
