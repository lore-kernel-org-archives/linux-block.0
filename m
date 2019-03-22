Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF1EC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87BE2083D
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="m/etkseJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390334AbfCVMRN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:17:13 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44586 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390068AbfCVMRM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 08:17:12 -0400
Received: by mail-vs1-f65.google.com with SMTP id j184so1213102vsd.11
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CmjyJjQtUXKSmnwe6amdk5vUmqjcMxErli1tHzGcQfU=;
        b=m/etkseJLknXc/ZwBvVNalOR9smiHmuVZXJjP28h6O34x89cg2WhbCnxNiz74Z8Y6l
         95hpXaL4WugSE4iGZKaPuxpnTNe7fkSkxEV75OQ+Mx+Ph8vfP8QZiflbiZAnnDdFd2cZ
         E9+7qX5m4WlDdyyU1PteZ/Xg722pU1Ij3xNQOyfZMdI8wKWePcq9AgC4rtEVFEo9kJUM
         kk2mUErikkzljBgJOMSdAMd2DTEYjdEe7EbN8m1s+0bi9cDeTEa31FYBdsReuauBmv2D
         NMTKyBisydfakBC37iFVMFQxcFZ1DlJdqySaCB+p90Uz0Vr18JPDQMKmSfjcZvNORfrP
         +uUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CmjyJjQtUXKSmnwe6amdk5vUmqjcMxErli1tHzGcQfU=;
        b=FBA6Gr/inYDNXan2HGVaX8q37Fx7bnp9IJ0gwa2NT/bbZrPhR65px96bxRoWjssp0t
         xdC4WGK+WsYtIr4gY8SuWaVlP97fnXmb81XFcRsXBQgH+qGqpt3SijqdXgFlZbC1ZQaU
         XYPEDqQ/zhLq12n4Zkq53K2/OfZOWEvr+ayUM4Yyp8+lsLTBX0tWpkRC6OGAlBsSTmi5
         U+cyS3ZmjaCRmgY0yoB5URGc5iBljInFXyLuhZHfNHIjxEg8MR/g45313QI+ti0JDwQ+
         0xt4hUQJ0a1YY72ODUgM6WzSpSijyP5tL/+apXKCmMjTT79gi6YRH8YXKnv1fTGvEf1U
         O71Q==
X-Gm-Message-State: APjAAAWxNrg4sHOw1igrVxbZGUyaCY56/cEWiYcqLwYJKVGUlRoBMxKD
        4Vpl9KCJD9/9j9A2WtsfyifxfbCBQNDSQbvinbl9BnF0E1VfLw==
X-Google-Smtp-Source: APXvYqyPG7GMD1PlZiHG1UMLR/iJ/5t+RnxWb9x8UBx9epRaKHMuX/YTdXExPO0BxYXyL0fhKFVyzLnR6MTd759ptDs=
X-Received: by 2002:a67:ea4b:: with SMTP id r11mr5640152vso.184.1553257031413;
 Fri, 22 Mar 2019 05:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-16-igor.j.konopko@intel.com> <FFE27E31-83ED-41CB-9D6C-327C3E3BA7D9@javigon.com>
 <b6536c70-2593-7751-de3d-beba51dad092@intel.com> <0983C3F3-0141-43B4-A97D-A4ACB797E4D0@javigon.com>
 <c6e06dee-42b1-6fdc-2993-280acb121d54@intel.com>
In-Reply-To: <c6e06dee-42b1-6fdc-2993-280acb121d54@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Fri, 22 Mar 2019 13:17:00 +0100
Message-ID: <CANr-nt037_iSvyjsf=e0f20v7zK=Y-ZoCTZUL+hy3bQai2Xr3g@mail.gmail.com>
Subject: Re: [PATCH 15/18] lightnvm: pblk: fix in case of lack of lines
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 21, 2019 at 2:21 PM Igor Konopko <igor.j.konopko@intel.com> wro=
te:
>
>
>
> On 18.03.2019 20:21, Javier Gonz=C3=A1lez wrote:
> >
> >> On 18 Mar 2019, at 14.28, Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
> >>
> >>
> >>
> >> On 18.03.2019 08:42, Javier Gonz=C3=A1lez wrote:
> >>>> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> wr=
ote:
> >>>>
> >>>> In case when mapping fails (called from writer thread) due to lack o=
f
> >>>> lines, currently we are calling pblk_pipeline_stop(), which waits
> >>>> for pending write IOs, so it will lead to the deadlock. Switching
> >>>> to __pblk_pipeline_stop() in that case instead will fix that.
> >>>>
> >>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>>> ---
> >>>> drivers/lightnvm/pblk-map.c | 2 +-
> >>>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map=
.c
> >>>> index 5408e32..afc10306 100644
> >>>> --- a/drivers/lightnvm/pblk-map.c
> >>>> +++ b/drivers/lightnvm/pblk-map.c
> >>>> @@ -46,7 +46,7 @@ static int pblk_map_page_data(struct pblk *pblk, u=
nsigned int sentry,
> >>>>            pblk_line_close_meta(pblk, prev_line);
> >>>>
> >>>>            if (!line) {
> >>>> -                  pblk_pipeline_stop(pblk);
> >>>> +                  __pblk_pipeline_stop(pblk);
> >>>>                    return -ENOSPC;
> >>>>            }
> >>>>
> >>>> --
> >>>> 2.9.5
> >>> Have you seeing this problem?
> >>> Before checking if there is a line, we are closing metadata for the
> >>> previous line, so all inflight I/Os should be clear. Can you develop =
on
> >>> the case in which this would happen?
> >>
> >> So we have following sequence: pblk_pipeline_stop() -> __pblk_pipeline=
_flush() -> pblk_flush_writer() -> wait for emptying round buffer.
> >> This will never complete, since we still have some RB entries, which c=
annot be written since writer thread is blocked with waiting inside pblk_fl=
ush_writer().
> >>
> >> Am I missing sth?
> >
> > So this will be the case in which we are in the last line and
> > pblk_flush_writer() needs to allocate an extra line persist the write
> > buffer? Shouldn=E2=80=99t the rate-limiter take care of this? As I reca=
ll, Hans
> > implemented some logic to guarantee that at least one line is always
> > available for GC, which in turn will free a line for user data. When we
> > hit this limit, performance will drop dramatically, but it should not
> > stall.
> >
> > The reason I want to understand the real case behind this fix is that b=
y
> > calling __pblk_pipeline_stop() we are basically stopping all other
> > inflight I/Os; we should be able to serve all inflight I/Os before a
> > mapping error triggers the pipeline to get into read-only mode.
> >
>
> Javier,
> my understanding was that if we hit that particular case, we are simply
> "done" with pblk and there is no way to recover it, so I made this
> changes based on code analysis, if it is not true, than this patch does
> not make sense anymore.
>
> Hans,
> could you help me to understand how rate limiter ensure that what Javier
> mentioned about? Thanks

I think Javier refers to: '3bcebc5bac09 ("lightnvm: pblk: set
conservative threshold for user writes")'

See the commit message. Let me know if something is unclear :)

Hans
