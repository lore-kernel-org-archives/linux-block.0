Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE74C2BA1A
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1435320736
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpiI5oFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDXKm7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:42:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21376 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbgDXKm7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 06:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587724976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pL+Y2FSl5usXnWFqFb9T8Nd7Bq7Qkybd1Lh3zGsmB9U=;
        b=CpiI5oFil2TsEndcxe4xNrQn1e3UbepoTtU61Afwcqn0v8edX4PUrwWrz6FgDbvCbrohtP
        CV+5YA1G7hPIswGajHQFpJuzQGhmmDfufA6FWC4STlcTkQCaZTpfG+VF5jshBNp6n01p6f
        e4LbmAFP24DJop/1SsguItqdt3cjzrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-vsW2AbJbOEuaFi50kmH8qQ-1; Fri, 24 Apr 2020 06:42:54 -0400
X-MC-Unique: vsW2AbJbOEuaFi50kmH8qQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D9D91005510;
        Fri, 24 Apr 2020 10:42:53 +0000 (UTC)
Received: from localhost (ovpn-114-136.ams2.redhat.com [10.36.114.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E20915D70B;
        Fri, 24 Apr 2020 10:42:49 +0000 (UTC)
Date:   Fri, 24 Apr 2020 11:42:48 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: Re: [PATCH] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Message-ID: <20200424104248.GB174193@stefanha-x1.localdomain>
References: <20200423123717.139141-1-stefanha@redhat.com>
 <20200423141338.GA29646@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20200423141338.GA29646@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2020 at 07:13:38AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 23, 2020 at 01:37:17PM +0100, Stefan Hajnoczi wrote:
> > A virtio_blk block device can still be referenced after hot unplug by
> > userspace processes that hold the file descriptor.  In this case
> > virtblk_getgeo() can be invoked after virtblk_remove() was called.  For
> > example, a program that has /dev/vdb open can call ioctl(HDIO_GETGEO)
> > after hot unplug.
> >=20
> > Fix this by clearing vblk->disk->private_data and checking that the
> > virtio_blk driver instance is still around in virtblk_getgeo().
> >=20
> > Note that the virtblk_getgeo() function itself is guaranteed to remain
> > in memory after hot unplug because the virtio_blk module refcount is
> > still held while a block device reference exists.
> >=20
> > Originally-by: Lance Digby <ldigby@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  drivers/block/virtio_blk.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 93468b7c6701..b50cdf37a6f7 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -300,6 +300,10 @@ static int virtblk_getgeo(struct block_device *bd,=
 struct hd_geometry *geo)
> >  {
> >  =09struct virtio_blk *vblk =3D bd->bd_disk->private_data;
> > =20
> > +=09/* Driver instance has been removed */
> > +=09if (!vblk)
> > +=09=09return -ENOTTY;
>=20
> If this ever hits you have a nasty race condition and this is not
> going to fix it, as it could be removed just after this check as well.

Perhaps a better fix is to keep a refcount in struct virtio_blk and
implement block_device_operations->release() to decrement the refcount.

That way the struct virtio_blk stays around until all block device
references are dropped.  This is similar to nbd_put() in
drivers/block/nbd.c.

Stefan

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6iwqgACgkQnKSrs4Gr
c8gkBQgAwHhtsW9ZXLDZXqp0Kkfsefk/q7JtsVeNejQKlMtOxFqaksestEjC6QvD
i1eTIlK/eNKdy6dfYcLANEpE4GQWxfYcdRGjVFiEghbpyOxCqbhk+Tj2PYIEpczs
Hs0l/nnEN07+hP7nI+owGGdpPN3USN8ZPGJyUOEVjPMT10wYbU5msh2sFnPGGAcU
NbCMJQq6PaNij35r1AL8GdimGQ6lqjnMoTbL1ex9Jrf1KzBoYBBJckK/JkDd1v59
5DsDbjTkDFcaRHKJzf3iuxg8a0AzGXQKudwiS2rGzVirxwVQN1RAi5yHBZnLJ0uT
C0Q7z66olBCYP+IxjOpt5ZtA7X8H6A==
=+zCT
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

