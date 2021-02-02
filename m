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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B37C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 16:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C5364F7B
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 16:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhBBQp0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbhBBQnG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 11:43:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C2C06174A;
        Tue,  2 Feb 2021 08:42:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c4so18465842wru.9;
        Tue, 02 Feb 2021 08:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=STneyShm0vCPYM4l3wpr4D69jWlxGiJ4g4tzZ7/33lE=;
        b=Z8h1xH9LrCIPbnUzDhB6+8OgUVkaq3lMCCgyLN0ZPUv8uKh1CGeCtexXpijdWGeEdR
         GmuMpknz9Xi/KKlCXJNdmCykqb7XMrDbl1hQeONsplw0h5K7DxwcmeBHPTqhf/n1FwSl
         twSkencRK6PL1ThnkyhuV9IKTwtSLwmBLvCqYEzPgYOevXeJRrABOjSSgyK7nG+nfMv7
         LDAUDusE6mxPyKTsXFh2FcyPBev6/DzxmoHcZbXvChChWJxHY74FbieBOcnEIessfNAs
         mk6DBnsjmySGjFkdSOqoy39WYd6OgG1pU+/6SX5SG2SNErZj1nSPVoQdbah0wjMck+ji
         b7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
         :subject:date:message-id:mime-version:content-transfer-encoding
         :thread-index:content-language;
        bh=STneyShm0vCPYM4l3wpr4D69jWlxGiJ4g4tzZ7/33lE=;
        b=ea4RIgs9/CPZYOL3964+zwAwpNuhFte+3N9T+ddw7/Nf2RF6A2yRMZTKQGV6R5qSJg
         BwRs9ZPCyDO/mFQyfOWLvBqMnEeeXyyFzZstozZuEWMdeUTmdSbq0CzKc2xpqTodmlCc
         e3W1qPtME3x9e5BulWMSBs3S8r4CIXfRDjP2CVeHvE7hFP7K2bqJCvH2IsKUjLrue+fW
         KERc2NdSUH+ypSo3+80SXNFiriwy8+aj9KF41xCGY10FovatjAVfaLsMywnMal4u6z5k
         ULj8h1OKarJtY7CSG+rPgNU7P/7ABcIlCYWUTnuQKb0sBiSM4hPnpwhmS+rgVhkeR4CM
         FVTQ==
X-Gm-Message-State: AOAM533Ly+uqkTq8azEysvc/Gn4PSA2UsWCXKZUElso4YPYufDhWLX7V
        78TomkAI3DFuYWc5qLuJuTk=
X-Google-Smtp-Source: ABdhPJy2nnGmtTJ3TUqoRthgCxgYu0/DthvxcvL9h7iYFq5Z3OEkSPZ7bmrdl5r8eH8nbB7nJSHkNg==
X-Received: by 2002:adf:f891:: with SMTP id u17mr24929982wrp.253.1612284144489;
        Tue, 02 Feb 2021 08:42:24 -0800 (PST)
Received: from CBGR90WXYV0 (host86-190-149-163.range86-190.btcentralplus.com. [86.190.149.163])
        by smtp.gmail.com with ESMTPSA id b4sm32480479wrn.12.2021.02.02.08.42.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 08:42:23 -0800 (PST)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
Reply-To: <paul@xen.org>
To:     =?utf-8?Q?'Roger_Pau_Monn=C3=A9'?= <roger.pau@citrix.com>
Cc:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Paul Durrant'" <pdurrant@amazon.com>,
        "'Konrad Rzeszutek Wilk'" <konrad.wilk@oracle.com>,
        "'Jens Axboe'" <axboe@kernel.dk>,
        "'Dongli Zhang'" <dongli.zhang@oracle.com>
References: <20210128130441.11744-1-paul@xen.org> <YBl9ycif3bG/Y+eR@Air-de-Roger>
In-Reply-To: <YBl9ycif3bG/Y+eR@Air-de-Roger>
Subject: RE: [PATCH v2] xen-blkback: fix compatibility bug with single page rings
Date:   Tue, 2 Feb 2021 16:42:22 -0000
Message-ID: <037601d6f982$61e34f80$25a9ee80$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQESWKuFsxkk/iz7Hd1VT64wNwq0EAFvpAqOq8LV10A=
Content-Language: en-gb
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -----Original Message-----
> From: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> Sent: 02 February 2021 16:29
> To: Paul Durrant <paul@xen.org>
> Cc: xen-devel@lists.xenproject.org; linux-block@vger.kernel.org; =
linux-kernel@vger.kernel.org; Paul
> Durrant <pdurrant@amazon.com>; Konrad Rzeszutek Wilk =
<konrad.wilk@oracle.com>; Jens Axboe
> <axboe@kernel.dk>; Dongli Zhang <dongli.zhang@oracle.com>
> Subject: Re: [PATCH v2] xen-blkback: fix compatibility bug with single =
page rings
>=20
> On Thu, Jan 28, 2021 at 01:04:41PM +0000, Paul Durrant wrote:
> > From: Paul Durrant <pdurrant@amazon.com>
> >
> > Prior to commit 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() to =
avoid
> > inconsistent xenstore 'ring-page-order' set by malicious blkfront"), =
the
> > behaviour of xen-blkback when connecting to a frontend was:
> >
> > - read 'ring-page-order'
> > - if not present then expect a single page ring specified by =
'ring-ref'
> > - else expect a ring specified by 'ring-refX' where X is between 0 =
and
> >   1 << ring-page-order
> >
> > This was correct behaviour, but was broken by the afforementioned =
commit to
> > become:
> >
> > - read 'ring-page-order'
> > - if not present then expect a single page ring (i.e. =
ring-page-order =3D 0)
> > - expect a ring specified by 'ring-refX' where X is between 0 and
> >   1 << ring-page-order
> > - if that didn't work then see if there's a single page ring =
specified by
> >   'ring-ref'
> >
> > This incorrect behaviour works most of the time but fails when a =
frontend
> > that sets 'ring-page-order' is unloaded and replaced by one that =
does not
> > because, instead of reading 'ring-ref', xen-blkback will read the =
stale
> > 'ring-ref0' left around by the previous frontend will try to map the =
wrong
> > grant reference.
> >
> > This patch restores the original behaviour.
> >
> > Fixes: 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() to avoid =
inconsistent xenstore 'ring-page-
> order' set by malicious blkfront")
> > Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> > ---
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: "Roger Pau Monn=C3=A9" <roger.pau@citrix.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Dongli Zhang <dongli.zhang@oracle.com>
> >
> > v2:
> >  - Remove now-spurious error path special-case when nr_grefs =3D=3D =
1
> > ---
> >  drivers/block/xen-blkback/common.h |  1 +
> >  drivers/block/xen-blkback/xenbus.c | 38 =
+++++++++++++-----------------
> >  2 files changed, 17 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/block/xen-blkback/common.h =
b/drivers/block/xen-blkback/common.h
> > index b0c71d3a81a0..524a79f10de6 100644
> > --- a/drivers/block/xen-blkback/common.h
> > +++ b/drivers/block/xen-blkback/common.h
> > @@ -313,6 +313,7 @@ struct xen_blkif {
> >
> >  	struct work_struct	free_work;
> >  	unsigned int 		nr_ring_pages;
> > +	bool                    multi_ref;
>=20
> You seem to have used spaces between the type and the variable name
> here, while neighbors also use hard tabs.
>=20

Oops. Xen vs. Linux coding style :-( I'll send a v3 with the whitespace =
fixed.

> The rest LGTM:
>=20
> Reviewed-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>=20
> We should have forbidden the usage of ring-page-order =3D 0 and we =
could
> have avoided having to add the multi_ref variable, but that's too late
> now.

Thanks. Yes, that cat is out of the bag and has been for a while =
unfortunately.

  Paul

>=20
> Thanks, Roger.

