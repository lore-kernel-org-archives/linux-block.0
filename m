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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FDCC433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 13:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7E064DDD
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 13:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhA1NFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 08:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhA1NFI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 08:05:08 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C83C061574;
        Thu, 28 Jan 2021 05:04:27 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m13so5306073wro.12;
        Thu, 28 Jan 2021 05:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=r07cOqUlvYp1WHsrzj44Yu4OUpOcguYfeeuIVj/qDbw=;
        b=Rk9fe53K5VTpfm2U8PBdHv3XLLce2P9oCisRF5Yq7u5xWCiQyya+mRjVqICGiDpQzF
         OfHsObhL4vEt7jysO8HGdoWfXAHeenYbbT5LR/bAe5aB8a6XVOcZq9YLrbVNQeC57vSU
         dWTA91gao9LuVDiPnm7avh/sVwUllBd384L100cMvUJltceSmqK7ksV0071SEMXbOzXX
         BEgd1EX5FYHv/Qt7nUoY66us3qr/uAwS55F/AUFs+nw/htdc9UvcDkDitC6m8OtiRn/I
         YieryB2eMAdTorQ3EpxnO2Vq9pjE4eh3ZlzjXW99YXDe6uEil16KlnwRAGoS9Yug3tcd
         HUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
         :subject:date:message-id:mime-version:content-transfer-encoding
         :thread-index:content-language;
        bh=r07cOqUlvYp1WHsrzj44Yu4OUpOcguYfeeuIVj/qDbw=;
        b=FXT6d02D6JXewW+EMbvVL1xRsOrPy0Xid+oZpVArcc/k8iNtDnCIyTavl5WrlLqOuT
         a114HeKysP39/kmpP0X+yDjz/I7lmNX2Galku7YTEUSsI/gnQKdBOITnm1cVvtvuk2Fw
         jGZ5Wh4wkuH4Kb3RyV9ReRgozdpXS0/hvILnTAcmWzZW3dwJS8asI12ivET3nZ5F7L/b
         8eI9eRPvfmXdsTKs59m0Ss9Mdo0OnA7YOfQko2uLW2rTxMuwcS6aqpVuBJwP95IpWFl6
         5ApFflhLgdBef7LGtXv9bYf5v9+Z4bH4+movqj09yddAq6SiyHtfgJ/Bf/j/2GijCK0h
         pOLw==
X-Gm-Message-State: AOAM532kDCg4C+4kpow+kZDsdStneg6ejKPw95etX+FSabVe5bUCKhD1
        AUgSWMOPYkLrb3bgw0Bbv/8=
X-Google-Smtp-Source: ABdhPJwQUxiX6zGyLrranHuj0NewclnhDgNhAQ2BzZAthx/6h3zL1Z4gkQzviuIoYLbADwPTmKs0og==
X-Received: by 2002:adf:9cc4:: with SMTP id h4mr14857238wre.403.1611839066350;
        Thu, 28 Jan 2021 05:04:26 -0800 (PST)
Received: from CBGR90WXYV0 ([2a00:23c5:5785:9a01:ad9a:ab78:5748:a7ec])
        by smtp.gmail.com with ESMTPSA id y11sm6824526wrh.16.2021.01.28.05.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 05:04:25 -0800 (PST)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
Reply-To: <paul@xen.org>
To:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Paul Durrant'" <pdurrant@amazon.com>,
        "'Konrad Rzeszutek Wilk'" <konrad.wilk@oracle.com>,
        =?utf-8?Q?'Roger_Pau_Monn=C3=A9'?= <roger.pau@citrix.com>,
        "'Jens Axboe'" <axboe@kernel.dk>,
        "'Dongli Zhang'" <dongli.zhang@oracle.com>
References: <20210128125528.11695-1-paul@xen.org>
In-Reply-To: <20210128125528.11695-1-paul@xen.org>
Subject: RE: [PATCH] xen-blkback: fix compatibility bug with single page rings
Date:   Thu, 28 Jan 2021 13:04:24 -0000
Message-ID: <029401d6f576$1ab25850$501708f0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEx9UUKjS8MZ31yL9XSzmIYX+yNXKuHAXpA
Content-Language: en-gb
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Apologies; I missed the v2 from the subject line. I'll re-send.

  Paul

> -----Original Message-----
> From: Xen-devel <xen-devel-bounces@lists.xenproject.org> On Behalf Of =
Paul Durrant
> Sent: 28 January 2021 12:55
> To: xen-devel@lists.xenproject.org; linux-block@vger.kernel.org; =
linux-kernel@vger.kernel.org
> Cc: Paul Durrant <pdurrant@amazon.com>; Konrad Rzeszutek Wilk =
<konrad.wilk@oracle.com>; Roger Pau
> Monn=C3=A9 <roger.pau@citrix.com>; Jens Axboe <axboe@kernel.dk>; =
Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH] xen-blkback: fix compatibility bug with single page =
rings
>=20
> From: Paul Durrant <pdurrant@amazon.com>
>=20
> Prior to commit 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() to =
avoid
> inconsistent xenstore 'ring-page-order' set by malicious blkfront"), =
the
> behaviour of xen-blkback when connecting to a frontend was:
>=20
> - read 'ring-page-order'
> - if not present then expect a single page ring specified by =
'ring-ref'
> - else expect a ring specified by 'ring-refX' where X is between 0 and
>   1 << ring-page-order
>=20
> This was correct behaviour, but was broken by the afforementioned =
commit to
> become:
>=20
> - read 'ring-page-order'
> - if not present then expect a single page ring (i.e. ring-page-order =
=3D 0)
> - expect a ring specified by 'ring-refX' where X is between 0 and
>   1 << ring-page-order
> - if that didn't work then see if there's a single page ring specified =
by
>   'ring-ref'
>=20
> This incorrect behaviour works most of the time but fails when a =
frontend
> that sets 'ring-page-order' is unloaded and replaced by one that does =
not
> because, instead of reading 'ring-ref', xen-blkback will read the =
stale
> 'ring-ref0' left around by the previous frontend will try to map the =
wrong
> grant reference.
>=20
> This patch restores the original behaviour.
>=20
> Fixes: 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() to avoid =
inconsistent xenstore 'ring-page-
> order' set by malicious blkfront")
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> ---
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: "Roger Pau Monn=C3=A9" <roger.pau@citrix.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
>=20
> v2:
>  - Remove now-spurious error path special-case when nr_grefs =3D=3D 1
> ---
>  drivers/block/xen-blkback/common.h |  1 +
>  drivers/block/xen-blkback/xenbus.c | 38 =
+++++++++++++-----------------
>  2 files changed, 17 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/block/xen-blkback/common.h =
b/drivers/block/xen-blkback/common.h
> index b0c71d3a81a0..524a79f10de6 100644
> --- a/drivers/block/xen-blkback/common.h
> +++ b/drivers/block/xen-blkback/common.h
> @@ -313,6 +313,7 @@ struct xen_blkif {
>=20
>  	struct work_struct	free_work;
>  	unsigned int 		nr_ring_pages;
> +	bool                    multi_ref;
>  	/* All rings for this device. */
>  	struct xen_blkif_ring	*rings;
>  	unsigned int		nr_rings;
> diff --git a/drivers/block/xen-blkback/xenbus.c =
b/drivers/block/xen-blkback/xenbus.c
> index 9860d4842f36..6c5e9373e91c 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -998,14 +998,17 @@ static int read_per_ring_refs(struct =
xen_blkif_ring *ring, const char *dir)
>  	for (i =3D 0; i < nr_grefs; i++) {
>  		char ring_ref_name[RINGREF_NAME_LEN];
>=20
> -		snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
> +		if (blkif->multi_ref)
> +			snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
> +		else {
> +			WARN_ON(i !=3D 0);
> +			snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref");
> +		}
> +
>  		err =3D xenbus_scanf(XBT_NIL, dir, ring_ref_name,
>  				   "%u", &ring_ref[i]);
>=20
>  		if (err !=3D 1) {
> -			if (nr_grefs =3D=3D 1)
> -				break;
> -
>  			err =3D -EINVAL;
>  			xenbus_dev_fatal(dev, err, "reading %s/%s",
>  					 dir, ring_ref_name);
> @@ -1013,18 +1016,6 @@ static int read_per_ring_refs(struct =
xen_blkif_ring *ring, const char *dir)
>  		}
>  	}
>=20
> -	if (err !=3D 1) {
> -		WARN_ON(nr_grefs !=3D 1);
> -
> -		err =3D xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u",
> -				   &ring_ref[0]);
> -		if (err !=3D 1) {
> -			err =3D -EINVAL;
> -			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
> -			return err;
> -		}
> -	}
> -
>  	err =3D -ENOMEM;
>  	for (i =3D 0; i < nr_grefs * XEN_BLKIF_REQS_PER_PAGE; i++) {
>  		req =3D kzalloc(sizeof(*req), GFP_KERNEL);
> @@ -1129,10 +1120,15 @@ static int connect_ring(struct backend_info =
*be)
>  		 blkif->nr_rings, blkif->blk_protocol, protocol,
>  		 blkif->vbd.feature_gnt_persistent ? "persistent grants" : "");
>=20
> -	ring_page_order =3D xenbus_read_unsigned(dev->otherend,
> -					       "ring-page-order", 0);
> -
> -	if (ring_page_order > xen_blkif_max_ring_order) {
> +	err =3D xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", =
"%u",
> +			   &ring_page_order);
> +	if (err !=3D 1) {
> +		blkif->nr_ring_pages =3D 1;
> +		blkif->multi_ref =3D false;
> +	} else if (ring_page_order <=3D xen_blkif_max_ring_order) {
> +		blkif->nr_ring_pages =3D 1 << ring_page_order;
> +		blkif->multi_ref =3D true;
> +	} else {
>  		err =3D -EINVAL;
>  		xenbus_dev_fatal(dev, err,
>  				 "requested ring page order %d exceed max:%d",
> @@ -1141,8 +1137,6 @@ static int connect_ring(struct backend_info *be)
>  		return err;
>  	}
>=20
> -	blkif->nr_ring_pages =3D 1 << ring_page_order;
> -
>  	if (blkif->nr_rings =3D=3D 1)
>  		return read_per_ring_refs(&blkif->rings[0], dev->otherend);
>  	else {
> --
> 2.17.1
>=20


