Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658BEC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C41B64EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhBBJjO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhBBJhG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:37:06 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70514C06174A;
        Tue,  2 Feb 2021 01:36:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d16so19634227wro.11;
        Tue, 02 Feb 2021 01:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=Zz8FFykTcux2eAHU4qruCPE/CaDgws9rPlVFrgLBmDE=;
        b=n0na40lt2YrJjOE1hvFtNiO/wlcvGHgllxcJfOb+wkGhd8mAeV4zcdMNFuVWvf5bxm
         blPJ61MgpDxWvC8snrZbeUJTpzZhBCBI7ILLW+J/fEcA+xEEKDeGtq7MBMZEivS4Hr6E
         /sv427EwM7KRx7YOKAWVOKpatV3A5cxBS77ubD0H5jiPQWp7fJWwjmwtA2IlSV/2SEXb
         mHuve3Y0Vp9+WrzkydbX35K1NEBzrDN8GcICCqavgLmVPucYDQ5qUzZlfq96HmrrHIu+
         fupr60uAveOSPbzlF7fGoY3gggQCDNXsU2+nG2dAMw9TiRzBwg9M5E+g2HwP9BiVlA5y
         XwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
         :subject:date:message-id:mime-version:content-transfer-encoding
         :thread-index:content-language;
        bh=Zz8FFykTcux2eAHU4qruCPE/CaDgws9rPlVFrgLBmDE=;
        b=BtjrSCUHEBeYkuMpQOGSAYO1sRMyju30n4+mE3Ooo6hKJj6YAsTHCryXn5C/Y8+hBG
         eKBGpy7uLNJ4FEk4pZHaeTsZa9NWo+7+24fdJII/fc/i/43NP7LbTR87mpMkal2AQEi1
         HmmU8lU7rHSyMNxlXDF+2ASAdLi0VNP8YO/wGe8410tGqsdZKhXoct7SRVnoTeq2DhMF
         rmPaxkpskV40vdLRB5i5m5emQ2mzE8VI8xAKegnG45n+f/pv8r0Zm6LJBBeMASJACDMs
         9jsnmCdya+IfDkk/efcSD9Y0PggUrss1svr6ThVrHgfidDjNXViyjjUsLFXVhtliUliN
         9tGA==
X-Gm-Message-State: AOAM5319hP5fi6Y2X7dhoQE20FDd1RtTi5TNsra1lWEUSae11fYESPsK
        i4lDwkbUdEvGpUXVaWJ1bGlnjabUO2g=
X-Google-Smtp-Source: ABdhPJz4fEifub8TGwz6LNU29pnusFYU5k+lNNiZwnGQJkpMxAQLzpZDkwPWXtgHYaCpE0U2sOL2/A==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr22541568wrb.205.1612258609190;
        Tue, 02 Feb 2021 01:36:49 -0800 (PST)
Received: from CBGR90WXYV0 (host86-190-149-163.range86-190.btcentralplus.com. [86.190.149.163])
        by smtp.gmail.com with ESMTPSA id d16sm30262030wrr.59.2021.02.02.01.36.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 01:36:48 -0800 (PST)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
Reply-To: <paul@xen.org>
To:     "'Dongli Zhang'" <dongli.zhang@oracle.com>,
        =?utf-8?Q?'J=C3=BCrgen_Gro=C3=9F'?= <jgross@suse.com>,
        =?utf-8?Q?'Roger_Pau_Monn=C3=A9'?= <roger.pau@citrix.com>
Cc:     "'Paul Durrant'" <pdurrant@amazon.com>,
        "'Konrad Rzeszutek Wilk'" <konrad.wilk@oracle.com>,
        "'Jens Axboe'" <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
References: <20210128130441.11744-1-paul@xen.org> <c3a476c5-c671-4429-73d5-0bf7ced1a06b@oracle.com> <7fb64e2f-141a-c848-0f8a-2313d2e821b6@suse.com> <02d901d6f616$b0004750$1000d5f0$@xen.org> <c10b539b-0f86-ac60-d289-4e3b7ded25fb@oracle.com>
In-Reply-To: <c10b539b-0f86-ac60-d289-4e3b7ded25fb@oracle.com>
Subject: RE: [PATCH v2] xen-blkback: fix compatibility bug with single page rings
Date:   Tue, 2 Feb 2021 09:36:47 -0000
Message-ID: <035701d6f946$edb90180$c92b0480$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQESWKuFsxkk/iz7Hd1VT64wNwq0EAGAqAtPAflt50QCuTnTiQKN7zH0q4fRvEA=
Content-Language: en-gb
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -----Original Message-----
> From: Xen-devel <xen-devel-bounces@lists.xenproject.org> On Behalf Of =
Dongli Zhang
> Sent: 30 January 2021 05:09
> To: paul@xen.org; 'J=C3=BCrgen Gro=C3=9F' <jgross@suse.com>; =
xen-devel@lists.xenproject.org; linux-
> block@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: 'Paul Durrant' <pdurrant@amazon.com>; 'Konrad Rzeszutek Wilk' =
<konrad.wilk@oracle.com>; 'Roger Pau
> Monn=C3=A9' <roger.pau@citrix.com>; 'Jens Axboe' <axboe@kernel.dk>
> Subject: Re: [PATCH v2] xen-blkback: fix compatibility bug with single =
page rings
>=20
>=20
>=20
> On 1/29/21 12:13 AM, Paul Durrant wrote:
> >> -----Original Message-----
> >> From: J=C3=BCrgen Gro=C3=9F <jgross@suse.com>
> >> Sent: 29 January 2021 07:35
> >> To: Dongli Zhang <dongli.zhang@oracle.com>; Paul Durrant =
<paul@xen.org>; xen-
> >> devel@lists.xenproject.org; linux-block@vger.kernel.org; =
linux-kernel@vger.kernel.org
> >> Cc: Paul Durrant <pdurrant@amazon.com>; Konrad Rzeszutek Wilk =
<konrad.wilk@oracle.com>; Roger Pau
> >> Monn=C3=A9 <roger.pau@citrix.com>; Jens Axboe <axboe@kernel.dk>
> >> Subject: Re: [PATCH v2] xen-blkback: fix compatibility bug with =
single page rings
> >>
> >> On 29.01.21 07:20, Dongli Zhang wrote:
> >>>
> >>>
> >>> On 1/28/21 5:04 AM, Paul Durrant wrote:
> >>>> From: Paul Durrant <pdurrant@amazon.com>
> >>>>
> >>>> Prior to commit 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() =
to avoid
> >>>> inconsistent xenstore 'ring-page-order' set by malicious =
blkfront"), the
> >>>> behaviour of xen-blkback when connecting to a frontend was:
> >>>>
> >>>> - read 'ring-page-order'
> >>>> - if not present then expect a single page ring specified by =
'ring-ref'
> >>>> - else expect a ring specified by 'ring-refX' where X is between =
0 and
> >>>>    1 << ring-page-order
> >>>>
> >>>> This was correct behaviour, but was broken by the afforementioned =
commit to
> >>>> become:
> >>>>
> >>>> - read 'ring-page-order'
> >>>> - if not present then expect a single page ring (i.e. =
ring-page-order =3D 0)
> >>>> - expect a ring specified by 'ring-refX' where X is between 0 and
> >>>>    1 << ring-page-order
> >>>> - if that didn't work then see if there's a single page ring =
specified by
> >>>>    'ring-ref'
> >>>>
> >>>> This incorrect behaviour works most of the time but fails when a =
frontend
> >>>> that sets 'ring-page-order' is unloaded and replaced by one that =
does not
> >>>> because, instead of reading 'ring-ref', xen-blkback will read the =
stale
> >>>> 'ring-ref0' left around by the previous frontend will try to map =
the wrong
> >>>> grant reference.
> >>>>
> >>>> This patch restores the original behaviour.
> >>>>
> >>>> Fixes: 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() to avoid =
inconsistent xenstore 'ring-
> page-
> >> order' set by malicious blkfront")
> >>>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> >>>> ---
> >>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >>>> Cc: "Roger Pau Monn=C3=A9" <roger.pau@citrix.com>
> >>>> Cc: Jens Axboe <axboe@kernel.dk>
> >>>> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> >>>>
> >>>> v2:
> >>>>   - Remove now-spurious error path special-case when nr_grefs =
=3D=3D 1
> >>>> ---
> >>>>   drivers/block/xen-blkback/common.h |  1 +
> >>>>   drivers/block/xen-blkback/xenbus.c | 38 =
+++++++++++++-----------------
> >>>>   2 files changed, 17 insertions(+), 22 deletions(-)
> >>>>
> >>>> diff --git a/drivers/block/xen-blkback/common.h =
b/drivers/block/xen-blkback/common.h
> >>>> index b0c71d3a81a0..524a79f10de6 100644
> >>>> --- a/drivers/block/xen-blkback/common.h
> >>>> +++ b/drivers/block/xen-blkback/common.h
> >>>> @@ -313,6 +313,7 @@ struct xen_blkif {
> >>>>
> >>>>   	struct work_struct	free_work;
> >>>>   	unsigned int 		nr_ring_pages;
> >>>> +	bool                    multi_ref;
> >>>
> >>> Is it really necessary to introduce 'multi_ref' here or we may =
just re-use
> >>> 'nr_ring_pages'?
> >>>
> >>> According to blkfront code, 'ring-page-order' is set only when it =
is not zero,
> >>> that is, only when (info->nr_ring_pages > 1).
> >>
> >
> > That's how it is *supposed* to be. Windows certainly behaves that =
way too.
> >
> >> Did you look into all other OS's (Windows, OpenBSD, FreebSD, =
NetBSD,
> >> Solaris, Netware, other proprietary systems) implementations to =
verify
> >> that claim?
> >>
> >> I don't think so. So better safe than sorry.
> >>
> >
> > Indeed. It was unfortunate that the commit to blkif.h documenting =
multi-page (829f2a9c6dfae) was not
> crystal clear and (possibly as a consequence) blkback was implemented =
to read ring-ref0 rather than
> ring-ref if ring-page-order was present and 0. Hence the only safe =
thing to do is to restore that
> behaviour.
> >
>=20
> Thank you very much for the explanation!
>=20
> Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>
>=20

Thanks.

Roger, Konrad, can I get a maintainer ack or otherwise, please?

  Paul


