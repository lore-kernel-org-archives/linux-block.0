Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953C8C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AD320815
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="IWYN7jhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfCDMsj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:48:39 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34954 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDMsj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 07:48:39 -0500
Received: by mail-ua1-f68.google.com with SMTP id f88so4262865uaf.2
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 04:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WYEhAetPIQNlt0rqLZDZwJWSU4kMCYrZRO+5TwcOnGQ=;
        b=IWYN7jhBkg4mJoQajTOX0f+gbe0guc5E4s7jdu6vkBiTrV5PQbj9Ek9NFvBcfgsBDn
         cZFySBYxDy/DSRvkRlO0Tbfx/0InKOeMkol35HjWaIQjUbFgmHSbU8pclzL1GhGJrgBn
         EIoWG2pM4rjjJAsb1rrd3lINsaxK0FNQIHCUrRWULWq12+MAadut3kJpJHDjJb3diBQ+
         U6vQBQymXE0ZBuUOI8O/nJqGK0xHBaRqxnNmq8wcRATQVpaPkGzty3nrWTjGsZJ4ezj0
         keEE4r5Wbm+A3Rm7Dv1YgJ1s3KkRJvXhCwCU81Xv/wHTNzhJ6BymUU8hP5fU6AwcMD3G
         4fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WYEhAetPIQNlt0rqLZDZwJWSU4kMCYrZRO+5TwcOnGQ=;
        b=Fc8hFLOv7YNp3PkXiXlMLyJ3RkB0/pJl4PpGfBMMv0wRolExWoGvv7OgT7OaiNoyMi
         AOQe3VmGsypPQa+rpSo0l6S8K+Z4PqmRDSqx6OU/CTF5uQBkjNp/Ao6dwC6KMz9A1P1+
         rSLsQPko2KPaJ9dCWlVo8TBKa9QCEHpTQmRgch+uItDGGKwmd2TF6wvPMguiGgrt3q9G
         v+VLRTzDwEBIJxLrgU1QZJcVI/TS2gorX4L1vBekFs8lVmdfNB2xa57Rv2AIDVbzXctX
         T37i5A87aPneZc5B/bHUCCR7c3XFVD2bs7MauT7meSlJK36U0Zm7j3cUt4036x6Cq4IZ
         yx6A==
X-Gm-Message-State: APjAAAVAuqwky7USO1Fobidp017RGV/nQ0KUyPyD1g8zaSeue3ODzSfZ
        geng7hT1ZASDkjmSr0OPHIW+EOyNy3JAQDIcUHFs6w==
X-Google-Smtp-Source: APXvYqzjzMnvPkk2tkkppeY2ixh6kAybG+ESO13mBXigp39JZDyube1Y+VE/Km4J/FbaFPdufiLKJUBJXNIIS8ELEVo=
X-Received: by 2002:a67:f409:: with SMTP id p9mr9403058vsn.213.1551703718186;
 Mon, 04 Mar 2019 04:48:38 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-6-igor.j.konopko@intel.com> <BAC8CFE4-5D1E-4FA0-80DF-9BA655D458D1@javigon.com>
 <CANr-nt3rzEGw0wNdOmm3ba9Oz10BLh_dbHoCECobMr2cfakLhQ@mail.gmail.com>
 <3E70BD55-1CBF-4695-ADA5-91C342E40F6C@javigon.com> <CANr-nt2Sj13VStWC4_GeTxCCVgztxqxm3HP7+7cNn+OoN=BCaQ@mail.gmail.com>
 <04F04C0B-25B6-4F1A-AEB6-36E4D6BB32B7@javigon.com> <e3fb769f-d20a-d5d3-42f7-5b62fc5d5a79@intel.com>
In-Reply-To: <e3fb769f-d20a-d5d3-42f7-5b62fc5d5a79@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 13:48:27 +0100
Message-ID: <CANr-nt3sE_UtM9oW-b9uPR0oYcDMt=yorcngUHQ5FYY94ySBPw@mail.gmail.com>
Subject: Re: [PATCH 05/13] lightnvm: pblk: Count all read errors in stats
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 4, 2019 at 1:42 PM Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
>
>
>
> On 04.03.2019 12:45, Javier Gonz=C3=A1lez wrote:
> >
> >> On 4 Mar 2019, at 12.41, Hans Holmberg <hans@owltronix.com> wrote:
> >>
> >> On Mon, Mar 4, 2019 at 10:23 AM Javier Gonz=C3=A1lez <javier@javigon.c=
om> wrote:
> >>>> On 4 Mar 2019, at 10.02, Hans Holmberg <hans.ml.holmberg@owltronix.c=
om> wrote:
> >>>>
> >>>> Igor: Have you seen this happening in real life?
> >>>>
> >>>> I think it would be better to count all expected errors and put them
> >>>> in the right bucket (without spamming dmesg). If we need a new bucke=
t
> >>>> for i.e. vendor-specific-errors, let's do that instead.
>
> Generally I'm seeing different types of errors (which are typically as
> Javier mention controller errors) in cases such as hot drive removal, etc=
.
>
> We can skip that patch, since this are kind of corner cases. I can also
> create new type of pblk stats, sth. like "controller errors", which
> would collect all the other unexpected errors in one place instead of
> mixing them with real read/write errors as I did.

Yes, that makes sense.

Thanks,
Hans

>
> >>>>
> >>>> Someone wiser than me told me that every error print in the log is a
> >>>> potential customer call.
> >>>>
> >>>> Javier: Yeah, I think S.M.A.R.T is the way to deliver this
> >>>> information. Why can't we let the drives expose this info and remove
> >>>> this from pblk? What's blocking that?
> >>>
> >>> Until now the spec. We added some new log information in Denali exact=
ly
> >>> for this. But since pblk supports OCSSD 1.2 and 2.0 I think it is nee=
ded to
> >>> have it here, at least for debugging.
> >>
> >> Why add it to the spec? Why not use whatever everyone else is using?
> >>
> >> https://en.wikipedia.org/wiki/S.M.A.R.T. :
> >> "S.M.A.R.T. (Self-Monitoring, Analysis and Reporting Technology; often
> >> written as SMART) is a monitoring system included in computer hard
> >> disk drives (HDDs), solid-state drives (SSDs),[1] and eMMC drives. Its
> >> primary function is to detect and report various indicators of drive
> >> reliability with the intent of anticipating imminent hardware
> >> failures."
> >> Sounds like what we want here.
> >
> > I know what smart is=E2=80=A6 You need to define the fields. Maybe you =
want to
> > read Denali again - the extensions are couple with smart.
> >
> >> For debugging, a trace point or something(i.e. BPF) would be a better
> >> solution that would not impact hot-path performance.
> >
> > Cool. Look forward to the patches ;)
> >
> > Javier
> >
