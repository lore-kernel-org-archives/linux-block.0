Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12E2C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE32208C3
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 13:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FYEWyoM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfLKN15 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:27:57 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:21659 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfLKN15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 08:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576070876; x=1607606876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h+I/y/hh9mwvZsFHkPrp9BUaspgjanOcRaLt/gZS7Bg=;
  b=FYEWyoM+f3uhNPNW0h1Uj61QAcWu0cBqthRfUgpY0lqgI1kqyyV4QMkv
   K/Phks2RyanpfQCnHjO988gDs6po6G52Ugjgc5siw2imiMTl3CGUZWZF/
   bhfuR8wMBx/ql870qjXY0uouiDFYD8ArP2rfrUZvOTxR/0lpEudVq2j2f
   w=;
IronPort-SDR: +VTCyzX9vkW91tHUamk0YAMMjD2t7eWWg8g93kHcyiUGd7wEHyZe4WkwqcWTOLYkmnEP3EOxaa
 QvHqB+wJne2Q==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="4494221"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 11 Dec 2019 13:27:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 3270DA2473;
        Wed, 11 Dec 2019 13:27:44 +0000 (UTC)
Received: from EX13D32EUC004.ant.amazon.com (10.43.164.121) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 13:27:43 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC004.ant.amazon.com (10.43.164.121) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 13:27:43 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Wed, 11 Dec 2019 13:27:42 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: RE: [PATCH] xen-blkback: prevent premature module unload
Thread-Topic: [PATCH] xen-blkback: prevent premature module unload
Thread-Index: AQHVr2mJT7izwmimDUiZW3emm6kz0qe0zXcAgAAhBkA=
Date:   Wed, 11 Dec 2019 13:27:42 +0000
Message-ID: <14a01d62046c48ee9b2486917370b5f5@EX13D32EUC003.ant.amazon.com>
References: <20191210145305.6605-1-pdurrant@amazon.com>
 <20191211112754.GM980@Air-de-Roger>
In-Reply-To: <20191211112754.GM980@Air-de-Roger>
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
> Sent: 11 December 2019 11:29
> To: Durrant, Paul <pdurrant@amazon.com>
> Cc: xen-devel@lists.xenproject.org; linux-block@vger.kernel.org; linux-
> kernel@vger.kernel.org; Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>;
> Jens Axboe <axboe@kernel.dk>
> Subject: Re: [PATCH] xen-blkback: prevent premature module unload
>=20
> On Tue, Dec 10, 2019 at 02:53:05PM +0000, Paul Durrant wrote:
> > Objects allocated by xen_blkif_alloc come from the 'blkif_cache' kmem
> > cache. This cache is destoyed when xen-blkif is unloaded so it is
> > necessary to wait for the deferred free routine used for such objects t=
o
> > complete. This necessity was missed in commit 14855954f636 "xen-blkback=
:
> > allow module to be cleanly unloaded". This patch fixes the problem by
> > taking/releasing extra module references in xen_blkif_alloc/free()
> > respectively.
> >
> > Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>=20
> Reviewed-by: Roger Pau Monn=E9 <roger.pau@citrix.com>
>=20
> One nit below.
>=20
> > ---
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: "Roger Pau Monn=E9" <roger.pau@citrix.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > ---
> >  drivers/block/xen-blkback/xenbus.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-
> blkback/xenbus.c
> > index e8c5c54e1d26..59d576d27ca7 100644
> > --- a/drivers/block/xen-blkback/xenbus.c
> > +++ b/drivers/block/xen-blkback/xenbus.c
> > @@ -171,6 +171,15 @@ static struct xen_blkif *xen_blkif_alloc(domid_t
> domid)
> >  	blkif->domid =3D domid;
> >  	atomic_set(&blkif->refcnt, 1);
> >  	init_completion(&blkif->drain_complete);
> > +
> > +	/*
> > +	 * Because freeing back to the cache may be deferred, it is not
> > +	 * safe to unload the module (and hence destroy the cache) until
> > +	 * this has completed. To prevent premature unloading, take an
> > +	 * extra module reference here and release only when the object
> > +	 * has been free back to the cache.
>                     ^ freed

Oh yes. Can this be done on commit, or would you like me to send a v2?

  Paul

> > +	 */
> > +	__module_get(THIS_MODULE);
> >  	INIT_WORK(&blkif->free_work, xen_blkif_deferred_free);
> >
> >  	return blkif;
> > @@ -320,6 +329,7 @@ static void xen_blkif_free(struct xen_blkif *blkif)
> >
> >  	/* Make sure everything is drained before shutting down */
> >  	kmem_cache_free(xen_blkif_cachep, blkif);
> > +	module_put(THIS_MODULE);
> >  }
> >
> >  int __init xen_blkif_interface_init(void)
> > --
> > 2.20.1
> >
