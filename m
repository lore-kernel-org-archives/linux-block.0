Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB8DC7618B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 11:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692F420449
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 11:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y/HU4gBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfGWL2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:28:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34456 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731278AbfGWL2B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 07:28:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so19005200pfo.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 04:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M085sQxZRNbz0OBDy5dlhICQwU4DuRFnxzjIAf3um2Q=;
        b=Y/HU4gBu9cfcIksRpnfWvBh3ybK9Bdyb0tmjGu2jg+zF1zDuRdlJGxKPMPadJiVqQS
         9jIk1wVgo+/DmqjMa8XIFinj35cZdfffqzX94lAcwGZpjzd0kOUHhJ4OjM1RNhdkPzFA
         3CUz89uvZhtOmr12Jxz1gVcaI1WmTk3pE4n40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M085sQxZRNbz0OBDy5dlhICQwU4DuRFnxzjIAf3um2Q=;
        b=UKrQTHTtcvrUzOAgncof7Wgez3l0GLEuRh6Ql1rVmA40NZ8CpzVskv3Uugsfc5BU6t
         qLGtXcC/dWgdHmZyZcFyiNUP4fbgNyAZ6MYWwAd5L19t1+GcAlvyoaWxQV4G4iU8Ma0E
         YDevdXwp160QqZH56LSjCTQJtWT9s9884NDw99GksFW05aGbhqvbuGTkSaMpnRC5YcyY
         MovTwwxKvgviE+c7/9WPmz37T0uh1gAjyMzRcatDahL+FWiNLEIgH1Wn4FN9Ex3Z0PuA
         TPhR8uV817mQaomJJdSxpfxlUDYQH1iJ+knsU+GealPIQy39C6WZMT1g5+z8aWuJPPuF
         EIAQ==
X-Gm-Message-State: APjAAAX8xPBWDfb6NoQ0pFynQwqsW2RUw01xOpHkbMiRS4IfUxcdh74G
        28m3FRYCXqkGwv6LAIJ2MLCIs5WH7J1ObYCRtV6qLg==
X-Google-Smtp-Source: APXvYqzZDkTOgdXMUeFY02PsNikZPUtkh8JUhyh0C8GPkwyZQsAdDCcvXpyCzfTYtmLlC5j4vyeCjt4Ewfi4KJPcXuk=
X-Received: by 2002:a63:b346:: with SMTP id x6mr76347800pgt.218.1563881280431;
 Tue, 23 Jul 2019 04:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
 <20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2> <860cc8cf-6419-c649-b2d9-19b82f6ebc99@suse.de>
In-Reply-To: <860cc8cf-6419-c649-b2d9-19b82f6ebc99@suse.de>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Tue, 23 Jul 2019 16:57:49 +0530
Message-ID: <CAK=zhgocY3Ute_6RiowaWsOROx3+Nzq6+WvkobmR_SB0Rt9_1g@mail.gmail.com>
Subject: Re: [PATCH V2] mpt3sas: support target smid for [abort|query] task
To:     Hannes Reinecke <hare@suse.de>
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
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 15, 2019 at 11:43 AM Hannes Reinecke <hare@suse.de> wrote:
>
> On 7/14/19 5:44 AM, Minwoo Im wrote:
> > We can request task management IOCTL command(MPI2_FUNCTION_SCSI_TASK_MG=
MT)
> > to /dev/mpt3ctl.  If the given task_type is either abort task or query
> > task, it may need a field named "Initiator Port Transfer Tag to Manage"
> > in the IU.
> >
> > Current code does not support to check target IPTT tag from the
> > tm_request.  This patch introduces to check TaskMID given from the
> > userspace as a target tag.  We have a rule of relationship between
> > (struct request *req->tag) and smid in mpt3sas_base.c:
> >
> > 3318 u16
> > 3319 mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_id=
x,
> > 3320         struct scsi_cmnd *scmd)
> > 3321 {
> > 3322         struct scsiio_tracker *request =3D scsi_cmd_priv(scmd);
> > 3323         unsigned int tag =3D scmd->request->tag;
> > 3324         u16 smid;
> > 3325
> > 3326         smid =3D tag + 1;
> >
> > So if we want to abort a request tagged #X, then we can pass (X + 1) to
> > this IOCTL handler.  Otherwise, user space just can pass 0 TaskMID to
> > abort the first outstanding smid which is legacy behaviour.
> >
> > Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> > Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> > Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> > Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > Cc: MPT-FusionLinux.pdl@broadcom.com
> > Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> > ---
> >  drivers/scsi/mpt3sas/mpt3sas_ctl.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/=
mpt3sas_ctl.c
> > index b2bb47c14d35..f6b8fd90610a 100644
> > --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > @@ -596,8 +596,16 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc, str=
uct mpt3_ioctl_command *karg,
> >               if (priv_data->sas_target->handle !=3D handle)
> >                       continue;
> >               st =3D scsi_cmd_priv(scmd);
> > -             tm_request->TaskMID =3D cpu_to_le16(st->smid);
> > -             found =3D 1;
> > +
> > +             /*
> > +              * If the given TaskMID from the user space is zero, then=
 the
> > +              * first outstanding smid will be picked up.  Otherwise,
> > +              * targeted smid will be the one.
> > +              */
> > +             if (!tm_request->TaskMID || tm_request->TaskMID =3D=3D st=
->smid) {
> > +                     tm_request->TaskMID =3D cpu_to_le16(st->smid);
> > +                     found =3D 1;
> > +             }
> >       }
> >
> >       if (!found) {
> >
> I think this is fundamentally wrong.
> ABORT_TASK is used to abort a single task, which of course has to be
> known beforehand. If you don't know the task, what exactly do you hope
> to achieve here? Aborting random I/O?
> Or, even worse, aborting I/O the driver uses internally and corrupt the
> internal workflow of the driver?
>
> We should simply disallow any ABORT TASK from userspace if the TaskMID
> is zero. And I would even argue to disabllow ABORT TASK from userspace
> completely, as the smid is never relayed to userland, and as such the
> user cannot know which task should be aborted.

Hannes,

This interface was added long time back in mpt2sas driver and I don't
have exact reason of adding this interface at that time.
But I know that this interface is still used by BRCM test team & few
customers only for some functionality and regression testing.

Thanks,
Sreekanth

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Teamlead Storage & Networking
> hare@suse.de                                   +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=C3=BCrnberg)
