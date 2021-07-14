Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9477C07E9A
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 14:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987926117A
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 14:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhGNO2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jul 2021 10:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231977AbhGNO2A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jul 2021 10:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626272708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nNLg7RS2OdgpG2Q0vTdal+uwHMaNAnRrGcEAwkI6Yk=;
        b=XcJY/qIRIDjmd7IpQx+bCGPn1FS2dg/ML7GPcqdpo24uI2fAqGuPQh2fMNZDeWzpCJsc01
        ZR8pUZj9YUzouvUAjN32WC/2vW6/4xWq7KeXX4ToCzFV3hJ6NUaVEHRttAuQgllp2GWrbp
        J+0tFWrm+PgM352MHb4Gd2KlvPZdS/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-0Cks6rrQMmG7eyvVV8lXlg-1; Wed, 14 Jul 2021 10:25:07 -0400
X-MC-Unique: 0Cks6rrQMmG7eyvVV8lXlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACD81106B7D6;
        Wed, 14 Jul 2021 14:25:05 +0000 (UTC)
Received: from localhost (ovpn-112-200.ams2.redhat.com [10.36.112.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AE761000324;
        Wed, 14 Jul 2021 14:25:05 +0000 (UTC)
Date:   Wed, 14 Jul 2021 15:25:04 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Enrico Granata <egranata@google.com>,
        virtio-dev@lists.oasis-open.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
Message-ID: <YO7zwKbH6OEW2z1o@stefanha-x1.localdomain>
References: <20210505193655.2414268-1-egranata@google.com>
 <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
 <YO6ro345FI0XE8vv@stefanha-x1.localdomain>
 <87pmvlck3p.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+Yv6eVjta5rSDZ4E"
Content-Disposition: inline
In-Reply-To: <87pmvlck3p.fsf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--+Yv6eVjta5rSDZ4E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2021 at 11:36:58AM +0200, Cornelia Huck wrote:
> On Wed, Jul 14 2021, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > On Wed, May 05, 2021 at 12:37:26PM -0700, Enrico Granata wrote:
> >> ---------- Forwarded message ---------
> >> From: Enrico Granata <egranata@google.com>
> >> Date: Wed, May 5, 2021 at 1:37 PM
> >> Subject: [PATCH v2] Provide detailed specification of virtio-blk
> >> lifetime metrics
> >> To: <virtio-dev@lists.oasis-open.org>
> >> Cc: <egranata@google.com>, <hch@infradead.org>, <mst@redhat.com>,
> >> <linux-block@vger.kernel.org>,
> >> <virtualization@lists.linux-foundation.org>
> >>=20
> >>=20
> >> In the course of review, some concerns were surfaced about the
> >> original virtio-blk lifetime proposal, as it depends on the eMMC
> >> spec which is not open
> >>=20
> >> Add a more detailed description of the meaning of the fields
> >> added by that proposal to the virtio-blk specification, as to
> >> make it feasible to understand and implement the new lifetime
> >> metrics feature without needing to refer to JEDEC's specification
> >>=20
> >> This patch does not change the meaning of those fields nor add
> >> any new fields, but it is intended to provide an open and more
> >> clear description of the meaning associated with those fields.
> >>=20
> >> Signed-off-by: Enrico Granata <egranata@google.com>
> >> ---
> >> Changes in v2:
> >>   - clarified JEDEC references;
> >>   - added VIRTIO_BLK prefix and cleaned up comment syntax;
> >>   - clarified reserved block references
> >>=20
> >>  content.tex | 40 ++++++++++++++++++++++++++++++++--------
> >>  1 file changed, 32 insertions(+), 8 deletions(-)
> >
> > Ping?
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> [Enrico is currently on leave of absence]
>=20
> Is there any outstanding feedback from the linux-block folks? I've lost
> track of this, I'm afraid. (Your R-b is the only feedback I see on this
> list...)
>=20
> We can certainly put up a vote. This is one of the things I wanted to
> see fixed for the next release of the standard.

I have CCed Christoph, linux-block@, and virtualization@. Here is the
link to the patch that we're discussing:
https://patchwork.kernel.org/project/linux-block/patch/20210505193655.24142=
68-1-egranata@google.com/

Stefan

--+Yv6eVjta5rSDZ4E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDu88AACgkQnKSrs4Gr
c8hYVAgAtnPGTJOBrka0qF+k5pZMbaxQ0R+0x3XTXkLy9ps2CboeHmh7hrmLCskK
eQ+v6hPvAygCGNArFIqg/0AEUuXgu7xAEhwdDtFZ1ahO8ULxxrCFCWnFhhqn0U0k
JAalGCzyTHpnDtYGWvvIEPYoF8GBrpeEWTJLrff1KReSujxuDeetB4jpPiLYwqE2
hWNsEeQjlTNuCAGSAMAACG02JCs4thf8GNlAAkMZRD8K1O1iFkNQYmUCpebP9pl9
qkIyPeVhpFCIO0hfDGA5TLoqdRne7vLbBeRawMf6JEESq1plQIpCNP0ez6KVmC9k
b5Wb+AaQyWJsP0Wdf/Qb+QbiyGQoeA==
=oGMA
-----END PGP SIGNATURE-----

--+Yv6eVjta5rSDZ4E--

