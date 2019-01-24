Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B19FC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 13:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7AD218A2
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 13:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1cS7zjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfAXNgu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:36:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44909 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfAXNgu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 08:36:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so2979615pfh.11;
        Thu, 24 Jan 2019 05:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nacWKUTdF5ZxLNfBONeLIxUM1CNJbtiM0sW5Yfdo638=;
        b=D1cS7zjd3FndN971/ja5gWB2+Jw4LlWvVEDNSfKee0c4txSc2OczOCBmRrn1lj8SHA
         84kSl969ah9PrZTa+3GeIS/60IzqVuz1ad72GuyA9tE8VPqE1WF0lPBeEu5t9M5Q5RPF
         pSsHME7G9aK+4Xgrxs821YK2C5SmYLJLG/8HHkpyaST9D/ZNKgP7jIlCpMPe4+v9c8YO
         1RX0S+yZjABue05eCg3gPZYCAKw4i6Oki6gkRpIyDd+CgNKsu4a8KI0jTINf9Bb90pvo
         1SAjHgma550KvISjfYUHuf/FO74vDD2q6ajSsSo5SsaSqCaepDye0K6gIirMPOR4o7Ko
         XVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nacWKUTdF5ZxLNfBONeLIxUM1CNJbtiM0sW5Yfdo638=;
        b=By950NVSDPLU/msMe8aKymhVOcaqqKx8kRZjwCzzMo9Qns/5VSGHR/Il/+NGZGvKiO
         OQPExSyow2gzOFRSbZ2aPjuGcop/OJfIPt4IfLa7Vx8YdYQge1aT0D9xJ8qQCuEOe8L6
         dsuS9hddd8Wl09BLE0SHvj2ZbPkf8zz2TNsnYyry2rWFx2bhyUJjoHfzKWaq7jAqvR/A
         DNB2LXHlY8id11rCNlpBdm/L4QfvaDSytQ6ofLQekjaYVEO+UBnVxqCE33pszc7Wgk3e
         Cq9wRwk1KOC+miF8L+MveNgL8MhV7IfH7jXxtmXK/fR2KhX+IbNZ2lUOpC9cLxaRhG0g
         SEYQ==
X-Gm-Message-State: AJcUukedrohvtdOQbxu48JNobd09xigdArr48Gb/OGNdARr+9hFSWsOz
        qWZ5qmHUDZk+WWx11J5b986e8MPgTMUPCNGwHpnw5XMu
X-Google-Smtp-Source: ALg8bN46y3mn3tsXXM3Z40Upb8k6Z2t1GAhdThF9AYJzxMDk0j5D9yU4KzLLgV3Te8ZriiTeYBRBlx2JnA0rKKl5oUY=
X-Received: by 2002:a63:f615:: with SMTP id m21mr6068021pgh.428.1548337009321;
 Thu, 24 Jan 2019 05:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20190110143051.52305-1-andriy.shevchenko@linux.intel.com>
 <20190121084732.GE18680@lst.de> <20190124121659.GH9224@smile.fi.intel.com> <6D748F08-F9F9-4DFB-84DF-63E97C691013@javigon.com>
In-Reply-To: <6D748F08-F9F9-4DFB-84DF-63E97C691013@javigon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 15:36:38 +0200
Message-ID: <CAHp75Vf4ndBaS6BjAM==7csYB9EYDvjV9jT9C6kioDryzb_HnQ@mail.gmail.com>
Subject: Re: [PATCH v1] : Switch to use new generic UUID API
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 24, 2019 at 3:19 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
> > On 24 Jan 2019, at 13.16, Andy Shevchenko <andriy.shevchenko@linux.inte=
l.com> wrote:
> > On Mon, Jan 21, 2019 at 09:47:32AM +0100, Christoph Hellwig wrote:
> >> On Thu, Jan 10, 2019 at 04:30:51PM +0200, Andy Shevchenko wrote:
> >>> There are new types and helpers that are supposed to be used in new c=
ode.
> >>>
> >>> As a preparation to get rid of legacy types and API functions do
> >>> the conversion here.
> >>
> >> This seems to miss a "lightnvm" in the subject line.
> >>
> >>> static inline void pblk_setup_uuid(struct pblk *pblk)
> >>> {
> >>> +   guid_gen((guid_t *)&pblk->instance_uuid);
> >>> }
> >>
> >> I think we can just kill this wrapper.
> >>
> >> But more importantly the instance_uuid fied, and the header.uuid one
> >> it is copied from should be turned into an actual guid_t, the memcpys
> >> and memcmps should also be replaced with the proper UUID API.
> >
> > header.uuid is defined using __u8 type, I'm not sure we can use guid_t =
there.
> >
>
> We can turn it into a guid_t and bump the minor version.

It's not so easy. __uXX types are dedicated for external APIs. guid_t
is kernel internal type disregard of (still) presence some uapi bits.
So, the question is those __uXX types in the driver definition is a
simple mistake, (weird) style decision, or what?

--=20
With Best Regards,
Andy Shevchenko
