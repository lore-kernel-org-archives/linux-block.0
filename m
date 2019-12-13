Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFF7C34988
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5AF246A2
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMRBq8S/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLMLrv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:47:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40769 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfLMLru (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 06:47:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so1736767lfo.7;
        Fri, 13 Dec 2019 03:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+ETvCMmbMzGGY7YShfNB5f2VnM4MZsAsh4twUwxFttw=;
        b=bMRBq8S/kwxE1PXDeOHnWLOOKrJk1tT/LxX5Vm5f3Yz65KwgOCHuUz2g5HmTdntqWf
         VZXkH3R+ZIbEnReyZ11N6sU2HFoaIBdmwmaT191OCKCDsy6MFEo7YKOv+5eJ2N5IfeBN
         a1UQCVorcAULEx+i93eD5GpgIpY3yOL1KWIQqgScXygI27E7ZUSIA5UhW3fK0TCJnCgd
         lE4NgX+7l00p/9kEiN4mJWTru2Yox13lW96pEgKvv+JsWryeuRO1l8svQgZuIleDMWt7
         dYf6BlwP4gcyhiWmR/vod/zGekbc4GDoEOyd5RATkBFpfQayJWNfbYT+XekFLM4EXzCh
         ZJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ETvCMmbMzGGY7YShfNB5f2VnM4MZsAsh4twUwxFttw=;
        b=TfHTPqQWiHQTycaY0EO04bRnnOR5D3m9lBtN4mfPwkqoGyra+SRG0R+vtUijwTrQn7
         eons6tngF2VOb5RBtf26ecF02199aVo8Ft6NnHx6DA5vcIodhRpOd+K+n9kGekg3VKao
         LjjNSH54TcX2oI2XfZDZKdIAx7fi5PxIP3Bc5oO8IVAEnhAVCFA4A64NJAkcs9YAGPBL
         p0Q74X/R/5HplyQewqhxhYVU72J2LSzSJAYs+XH01Qc7Z6UZAZeqLR/kmQMTJYW3Ut1H
         B4x/8/YHZ5CU7EO26WhNtHk5GSGoz3o2WcDmfUCU/w8GYxSDrVKiC0lwDe9/OvKDC9r3
         +rbA==
X-Gm-Message-State: APjAAAWYOej71mLaHdxA5WHVAp/sGM0u8H2MFB/w1iKxxTlfYVsP2Uhp
        R4AF4XlRb2MhYyoE59lZdV8Y8VyeUaWxLBhi8qk=
X-Google-Smtp-Source: APXvYqz0CcvXDIgPQfEOn1UWPvPxDvqqBrgb/qmtE1XqPsfWy5MILYQ0RZxaJCsdjyngisILPZlGomv4w/Poud0iok8=
X-Received: by 2002:a19:7015:: with SMTP id h21mr8405869lfc.68.1576237667682;
 Fri, 13 Dec 2019 03:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20191212152757.GF11756@Air-de-Roger> <20191212160658.10466-1-sj38.park@gmail.com>
 <20191213092742.GG11756@Air-de-Roger> <8425d77b-37cf-d959-9466-7bc1d4d99642@suse.com>
In-Reply-To: <8425d77b-37cf-d959-9466-7bc1d4d99642@suse.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Fri, 13 Dec 2019 12:47:19 +0100
Message-ID: <CAEjAshpuT_S44Fn12XRZz-aLs38awkJSiQ_J2ofXsJRXKopScQ@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v7 2/3] xen/blkback: Squeeze page pools if a
 memory pressure is detected
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        SeongJae Park <sjpark@amazon.com>, konrad.wilk@oracle.com,
        pdurrant@amazon.com, SeongJae Park <sjpark@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 13, 2019 at 10:33 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wr=
ote:
>
> On 13.12.19 10:27, Roger Pau Monn=C3=A9 wrote:
> > On Thu, Dec 12, 2019 at 05:06:58PM +0100, SeongJae Park wrote:
> >> On Thu, 12 Dec 2019 16:27:57 +0100 "Roger Pau Monn=C3=A9" <roger.pau@c=
itrix.com> wrote:
> >>
> >>>> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen=
-blkback/blkback.c
> >>>> index fd1e19f1a49f..98823d150905 100644
> >>>> --- a/drivers/block/xen-blkback/blkback.c
> >>>> +++ b/drivers/block/xen-blkback/blkback.c
> >>>> @@ -142,6 +142,21 @@ static inline bool persistent_gnt_timeout(struc=
t persistent_gnt *persistent_gnt)
> >>>>            HZ * xen_blkif_pgrant_timeout);
> >>>>   }
> >>>>
> >>>> +/* Once a memory pressure is detected, squeeze free page pools for =
a while. */
> >>>> +static unsigned int buffer_squeeze_duration_ms =3D 10;
> >>>> +module_param_named(buffer_squeeze_duration_ms,
> >>>> +          buffer_squeeze_duration_ms, int, 0644);
> >>>> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> >>>> +"Duration in ms to squeeze pages buffer when a memory pressure is d=
etected");
> >>>> +
> >>>> +static unsigned long buffer_squeeze_end;
> >>>> +
> >>>> +void xen_blkbk_reclaim_memory(struct xenbus_device *dev)
> >>>> +{
> >>>> +  buffer_squeeze_end =3D jiffies +
> >>>> +          msecs_to_jiffies(buffer_squeeze_duration_ms);
> >>>
> >>> I'm not sure this is fully correct. This function will be called for
> >>> each blkback instance, but the timeout is stored in a global variable
> >>> that's shared between all blkback instances. Shouldn't this timeout b=
e
> >>> stored in xen_blkif so each instance has it's own local variable?
> >>>
> >>> Or else in the case you have 1k blkback instances the timeout is
> >>> certainly going to be longer than expected, because each call to
> >>> xen_blkbk_reclaim_memory will move it forward.
> >>
> >> Agreed that.  I think the extended timeout would not make a visible
> >> performance, though, because the time that 1k-loop take would be short=
 enough
> >> to be ignored compared to the millisecond-scope duration.
> >>
> >> I took this way because I wanted to minimize such structural changes a=
s far as
> >> I can, as this is just a point-fix rather than ultimate solution.  Tha=
t said,
> >> it is not fully correct and very confusing.  My another colleague also=
 pointed
> >> out it in internal review.  Correct solution would be to adding a vari=
able in
> >> the struct as you suggested or avoiding duplicated update of the varia=
ble by
> >> initializing the variable once the squeezing duration passes.  I would=
 prefer
> >> the later way, as it is more straightforward and still not introducing
> >> structural change.  For example, it might be like below:
> >>
> >> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-b=
lkback/blkback.c
> >> index f41c698dd854..6856c8ef88de 100644
> >> --- a/drivers/block/xen-blkback/blkback.c
> >> +++ b/drivers/block/xen-blkback/blkback.c
> >> @@ -152,8 +152,9 @@ static unsigned long buffer_squeeze_end;
> >>
> >>   void xen_blkbk_reclaim_memory(struct xenbus_device *dev)
> >>   {
> >> -       buffer_squeeze_end =3D jiffies +
> >> -               msecs_to_jiffies(buffer_squeeze_duration_ms);
> >> +       if (!buffer_squeeze_end)
> >> +               buffer_squeeze_end =3D jiffies +
> >> +                       msecs_to_jiffies(buffer_squeeze_duration_ms);
> >>   }
> >>
> >>   static inline int get_free_page(struct xen_blkif_ring *ring, struct =
page **page)
> >> @@ -669,10 +670,13 @@ int xen_blkif_schedule(void *arg)
> >>                  }
> >>
> >>                  /* Shrink the free pages pool if it is too large. */
> >> -               if (time_before(jiffies, buffer_squeeze_end))
> >> +               if (time_before(jiffies, buffer_squeeze_end)) {
> >>                          shrink_free_pagepool(ring, 0);
> >> -               else
> >> +               } else {
> >> +                       if (unlikely(buffer_squeeze_end))
> >> +                               buffer_squeeze_end =3D 0;
> >>                          shrink_free_pagepool(ring, max_buffer_pages);
> >> +               }
> >>
> >>                  if (log_stats && time_after(jiffies, ring->st_print))
> >>                          print_stats(ring);
> >>
> >> May I ask you what way would you prefer?
> >
> > I'm not particularly found of this approach, as I think it's racy. Ie:
> > you would have to add some kind of lock to make sure the contents of
> > buffer_squeeze_end stay unmodified during the read and set cycle, or
> > else xen_blkif_schedule will race with xen_blkbk_reclaim_memory.
> >
> > This is likely not a big deal ATM since the code will work as
> > expected in most cases AFAICT, but I would still prefer to have a
> > per-instance buffer_squeeze_end added to xen_blkif, given that the
> > callback is per-instance. I wouldn't call it a structural change, it's
> > just adding a variable to a struct instead of having a shared one, but
> > the code is almost the same as the current version.
>
> FWIW, I agree.

Agreed, will send v8 soon!


Thanks,
SeongJae Park

>
>
> Juergen
