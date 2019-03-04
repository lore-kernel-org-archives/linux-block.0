Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BE8C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 11:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E168720645
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 11:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="k63MtNId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCDLmB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:42:01 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40007 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDLmB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 06:42:01 -0500
Received: by mail-ua1-f68.google.com with SMTP id c5so4093176uaq.7
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 03:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BXx1gK6cv7TFShV/USfAhGjUPb+gMlsTzfwPpn6xMxw=;
        b=k63MtNIdCXEhH9xjcmNORbvmaPZLlwD583k6MMsHXq5VdsLgd93ubwMczLOB4dZxjy
         91ukjWZOLQrSIqExgw8auodxa2zH2A2biKg+vBrGUaAAFCe4GMH2KLcUM9PURwLxZSpe
         lu/vL2ZBWKrmxQbecH4UD/+wd29UUhLCZSgtlKjkt1v8K7jyogW0yaV8UBGmNpJsGb8x
         afznl00htFwdkJr0WDrlPG3pFJ7dsSTdaYBjL6JzBUTfS97FNRBcAJokNrTXdNhwcgUj
         u76NthiTAY6sBn3e2tuwTI+Ac4cK9WozDbQ5mwTpBnZErgkzIC8l/kiLX0C100hhp22C
         DIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BXx1gK6cv7TFShV/USfAhGjUPb+gMlsTzfwPpn6xMxw=;
        b=NMGhLG1u6UZ++0IGxp3N+0oryVUJ2AiFBrPxHkjAI9p1OnhxH7KEVcEt4UO+5MDacD
         /0wzANPscYpgNjxG8555Hycd/VGkPvnSr6I0wH7nfWmaqgKp9tWctFD0jKiT6l+UMNXm
         w/UpLnTKRU+qAzg3nfokZS8YB0KcxT8iXJVSWM+xdjP7u8VX2kyKxgqWNCcUltRALmID
         0rrSF3XFbN0D215oXgIkCHt1ASG3x7csJIRlvxNlAzrZC8UfNz2unheZD0vXwnfn3qos
         9znTrIflnXqTvgNOr8ugk1h4Pl0uzFkpaPJ/lFwFeqy3lGqAI3g9ftqZLY6cFY+8WaM6
         GByA==
X-Gm-Message-State: APjAAAWDFxD9cIvFuCVpRHXYxzg84J8odFVRUNjUl8C73L2GlN/4xdqt
        6vYoYz7wHD5i8HOVFSnB5pHALo7yVjirT7G5kfKRTQ==
X-Google-Smtp-Source: APXvYqwVk5s2BkiMtn+lD/Yb4douX5VVeCENq4h3PVyU09hT+V35S1Fk0WnsCjukNQ4JOUHUS4khLt0/fJkTJv6WzvA=
X-Received: by 2002:a67:bb16:: with SMTP id m22mr9474492vsn.153.1551699719590;
 Mon, 04 Mar 2019 03:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-6-igor.j.konopko@intel.com> <BAC8CFE4-5D1E-4FA0-80DF-9BA655D458D1@javigon.com>
 <CANr-nt3rzEGw0wNdOmm3ba9Oz10BLh_dbHoCECobMr2cfakLhQ@mail.gmail.com> <3E70BD55-1CBF-4695-ADA5-91C342E40F6C@javigon.com>
In-Reply-To: <3E70BD55-1CBF-4695-ADA5-91C342E40F6C@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 12:41:48 +0100
Message-ID: <CANr-nt2Sj13VStWC4_GeTxCCVgztxqxm3HP7+7cNn+OoN=BCaQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] lightnvm: pblk: Count all read errors in stats
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 4, 2019 at 10:23 AM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
> > On 4 Mar 2019, at 10.02, Hans Holmberg <hans.ml.holmberg@owltronix.com>=
 wrote:
> >
> > Igor: Have you seen this happening in real life?
> >
> > I think it would be better to count all expected errors and put them
> > in the right bucket (without spamming dmesg). If we need a new bucket
> > for i.e. vendor-specific-errors, let's do that instead.
> >
> > Someone wiser than me told me that every error print in the log is a
> > potential customer call.
> >
> > Javier: Yeah, I think S.M.A.R.T is the way to deliver this
> > information. Why can't we let the drives expose this info and remove
> > this from pblk? What's blocking that?
>
> Until now the spec. We added some new log information in Denali exactly
> for this. But since pblk supports OCSSD 1.2 and 2.0 I think it is needed =
to
> have it here, at least for debugging.

Why add it to the spec? Why not use whatever everyone else is using?

https://en.wikipedia.org/wiki/S.M.A.R.T. :
"S.M.A.R.T. (Self-Monitoring, Analysis and Reporting Technology; often
written as SMART) is a monitoring system included in computer hard
disk drives (HDDs), solid-state drives (SSDs),[1] and eMMC drives. Its
primary function is to detect and report various indicators of drive
reliability with the intent of anticipating imminent hardware
failures."
Sounds like what we want here.

For debugging, a trace point or something(i.e. BPF) would be a better
solution that would not impact hot-path performance.

>
> >
> > Thanks,
> > Hans
> >
> > On Mon, Mar 4, 2019 at 8:42 AM Javier Gonz=C3=A1lez <javier@javigon.com=
> wrote:
> >>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wro=
te:
> >>>
> >>> Currently when unknown error occurs on read path
> >>> there is only dmesg information about it, but it
> >>> is not counted in sysfs statistics. Since this is
> >>> still an error we should also count it there.
> >>>
> >>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>> ---
> >>> drivers/lightnvm/pblk-core.c | 1 +
> >>> 1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-cor=
e.c
> >>> index eabcbc119681..a98b2255f963 100644
> >>> --- a/drivers/lightnvm/pblk-core.c
> >>> +++ b/drivers/lightnvm/pblk-core.c
> >>> @@ -493,6 +493,7 @@ void pblk_log_read_err(struct pblk *pblk, struct =
nvm_rq *rqd)
> >>>              atomic_long_inc(&pblk->read_failed);
> >>>              break;
> >>>      default:
> >>> +             atomic_long_inc(&pblk->read_failed);
> >>>              pblk_err(pblk, "unknown read error:%d\n", rqd->error);
> >>>      }
> >>> #ifdef CONFIG_NVM_PBLK_DEBUG
> >>> --
> >>> 2.17.1
> >>
> >> I left this out intentionally  so that we could correlate the logs fro=
m
> >> the controller and the errors in the read path. Since we do not have a=
n
> >> standard way to correlate this on SMART yet, let=E2=80=99s add this no=
w (I
> >> assume that you are using it for something?) and we can separate the
> >> error stats in the future.
> >>
> >> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
