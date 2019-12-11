Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E7C2D0C6
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 13:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D5821556
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 13:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pLF6+ECJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfLKN6D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:58:03 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:38463 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfLKN6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 08:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576072682; x=1607608682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W8TTi/2IIEXbPsGUA9DEIj5AQ0RHJuHWIGTOmHVUQus=;
  b=pLF6+ECJZtqBNaM3K4bnY13fxpzUOh5lElBDTq3fONH549VhWM+TCnnT
   bfZwXkHHtcF0/gkTHM5Vf3T9l72Pfpfj1PzVuslTpe+jnCAHj4B73wQSI
   8+MsXA0gQW++m9t1xTOtCDJYBuh9saAvI2sGrOE4ZdkQjyV+rp/ghZGvg
   o=;
IronPort-SDR: mkmquFRZdQ8fhag+H0SlzhM9qj48wmtmu0VhkeL9obp3+XTB70l/s1tnfYtMUyjId7XwSWkwiv
 Nb2KZPkVlIvA==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="4498934"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 11 Dec 2019 13:57:44 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 38FCAA2707;
        Wed, 11 Dec 2019 13:57:44 +0000 (UTC)
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 13:57:43 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC003.ant.amazon.com (10.43.164.24) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 13:57:42 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Wed, 11 Dec 2019 13:57:42 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: RE: [PATCH] xen-blkback: prevent premature module unload
Thread-Topic: [PATCH] xen-blkback: prevent premature module unload
Thread-Index: AQHVr2mJT7izwmimDUiZW3emm6kz0qe0zXcAgAAhBkCAAAfzgIAAAGuQ
Date:   Wed, 11 Dec 2019 13:57:42 +0000
Message-ID: <4c9a0d81d0634f27a41fe10c8d93a4ea@EX13D32EUC003.ant.amazon.com>
References: <20191210145305.6605-1-pdurrant@amazon.com>
 <20191211112754.GM980@Air-de-Roger>
 <14a01d62046c48ee9b2486917370b5f5@EX13D32EUC003.ant.amazon.com>
 <20191211135523.GP980@Air-de-Roger>
In-Reply-To: <20191211135523.GP980@Air-de-Roger>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.172]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -----Original Message-----
> From: Roger Pau Monn=E9 <roger.pau@citrix.com>
> Sent: 11 December 2019 13:55
> To: Durrant, Paul <pdurrant@amazon.com>; Juergen Gross <jgross@suse.com>
> Cc: xen-devel@lists.xenproject.org; linux-block@vger.kernel.org; linux-
> kernel@vger.kernel.org; Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>;
> Jens Axboe <axboe@kernel.dk>
> Subject: Re: [PATCH] xen-blkback: prevent premature module unload
>=20
> On Wed, Dec 11, 2019 at 01:27:42PM +0000, Durrant, Paul wrote:
> > > -----Original Message-----
> > > From: Roger Pau Monn=E9 <roger.pau@citrix.com>
> > > Sent: 11 December 2019 11:29
> > > To: Durrant, Paul <pdurrant@amazon.com>
> > > Cc: xen-devel@lists.xenproject.org; linux-block@vger.kernel.org;
> linux-
> > > kernel@vger.kernel.org; Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com>;
> > > Jens Axboe <axboe@kernel.dk>
> > > Subject: Re: [PATCH] xen-blkback: prevent premature module unload
> > >
> > > On Tue, Dec 10, 2019 at 02:53:05PM +0000, Paul Durrant wrote:
> > > > Objects allocated by xen_blkif_alloc come from the 'blkif_cache'
> kmem
> > > > cache. This cache is destoyed when xen-blkif is unloaded so it is
> > > > necessary to wait for the deferred free routine used for such
> objects to
> > > > complete. This necessity was missed in commit 14855954f636 "xen-
> blkback:
> > > > allow module to be cleanly unloaded". This patch fixes the problem
> by
> > > > taking/releasing extra module references in xen_blkif_alloc/free()
> > > > respectively.
> > > >
> > > > Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> > >
> > > Reviewed-by: Roger Pau Monn=E9 <roger.pau@citrix.com>
> > >
> > > One nit below.
> > >
> > > > ---
> > > > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > > Cc: "Roger Pau Monn=E9" <roger.pau@citrix.com>
> > > > Cc: Jens Axboe <axboe@kernel.dk>
> > > > ---
> > > >  drivers/block/xen-blkback/xenbus.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen=
-
> > > blkback/xenbus.c
> > > > index e8c5c54e1d26..59d576d27ca7 100644
> > > > --- a/drivers/block/xen-blkback/xenbus.c
> > > > +++ b/drivers/block/xen-blkback/xenbus.c
> > > > @@ -171,6 +171,15 @@ static struct xen_blkif
> *xen_blkif_alloc(domid_t
> > > domid)
> > > >  	blkif->domid =3D domid;
> > > >  	atomic_set(&blkif->refcnt, 1);
> > > >  	init_completion(&blkif->drain_complete);
> > > > +
> > > > +	/*
> > > > +	 * Because freeing back to the cache may be deferred, it is
> not
> > > > +	 * safe to unload the module (and hence destroy the cache)
> until
> > > > +	 * this has completed. To prevent premature unloading, take an
> > > > +	 * extra module reference here and release only when the
> object
> > > > +	 * has been free back to the cache.
> > >                     ^ freed
> >
> > Oh yes. Can this be done on commit, or would you like me to send a v2?
>=20
> Adjusting on commit would be fine for me, but it's up to Juergen since
> he is the one that will pick this up. IIRC the module unload patches
> didn't go through the block subsystem.

True. I forgot manually add Juergen cc list.

  Paul

>=20
> Thanks, Roger.
