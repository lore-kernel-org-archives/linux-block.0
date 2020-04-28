Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B66AC83008
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 15:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DA620757
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 15:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afIAYw1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgD1P5b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:57:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48895 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728038AbgD1P5a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 11:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588089448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zmAFNdPPInB0BNzlaWvdz5SJ4OD4Dhy3h9PKZjQlFsU=;
        b=afIAYw1mdPTZBlUasheE+ZqiqVvHVn0KcGS+kNAYrgnonOJt8I6wKQ87KP1dKdwnEUJwJj
        Rld59b9IzgD8j1uzYdzg5unkLC9U3OzQIiEciF7UUfNXl5Hy/O9mmZA29upWvb1tO7Yl4R
        NvdagbLnme0caugyAu2J3Rz11ETK15E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-4UNeYxB9OJ2aNzU6u98fVg-1; Tue, 28 Apr 2020 11:57:20 -0400
X-MC-Unique: 4UNeYxB9OJ2aNzU6u98fVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E60346B;
        Tue, 28 Apr 2020 15:57:19 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D16025C1D4;
        Tue, 28 Apr 2020 15:57:16 +0000 (UTC)
Date:   Tue, 28 Apr 2020 16:57:15 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Message-ID: <20200428155715.GA109767@stefanha-x1.localdomain>
References: <20200428143009.107645-1-stefanha@redhat.com>
 <20200428110515-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200428110515-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 11:25:07AM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 28, 2020 at 03:30:09PM +0100, Stefan Hajnoczi wrote:
> > A userspace process holding a file descriptor to a virtio_blk device ca=
n
> > still invoke block_device_operations after hot unplug.  For example, a
> > program that has /dev/vdb open can call ioctl(HDIO_GETGEO) after hot
> > unplug to invoke virtblk_getgeo().
>=20
>=20
> which causes what? a use after free?

Yes, use after free.  I will include the kernel panic in the next
revision.

virtio_check_driver_offered_feature() accesses vdev->dev.driver, which
doesn't work after virtblk_remove() has freed vdev :).

> >=20
> > Introduce a reference count in struct virtio_blk so that its lifetime
> > covers both virtio_driver probe/remove and block_device_operations
> > open/release users.  This ensures that block_device_operations function=
s
> > like virtblk_getgeo() can safely access struct virtio_blk.
> >=20
> > Add remove_mutex to prevent block_device_operations functions from
> > accessing vblk->vdev during virtblk_remove() and let the safely check
>=20
> let the -> let them?

Thanks, will fix.

>=20
> > for !vblk->vdev after virtblk_remove() returns.
> >=20
> > Switching to a reference count also solves the vd_index_ida leak where
> > vda, vdb, vdc, etc indices were lost when the device was hot unplugged
> > while the block device was still open.
>=20
> Can you move this statement up so we list both issues (use after free
> and leak) upfront, then discuss the fix?

Thanks, will fix.

>=20
> >=20
> > Reported-by: Lance Digby <ldigby@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > If someone has a simpler solution please let me know.  I looked at
> > various approaches including reusing device_lock(&vblk->vdev.dev) but
> > they were more complex and extending the lifetime of virtio_device afte=
r
> > remove() has been called seems questionable.
> > ---
> >  drivers/block/virtio_blk.c | 85 ++++++++++++++++++++++++++++++++++----
> >  1 file changed, 77 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 93468b7c6701..3dd53b445cc1 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -44,6 +44,13 @@ struct virtio_blk {
> >  =09/* Process context for config space updates */
> >  =09struct work_struct config_work;
> > =20
> > +=09/*
> > +=09 * Tracks references from block_device_operations open/release and
> > +=09 * virtio_driver probe/remove so this object can be freed once no
> > +=09 * longer in use.
> > +=09 */
> > +=09refcount_t refs;
> > +
> >  =09/* What host tells us, plus 2 for header & tailer. */
> >  =09unsigned int sg_elems;
> > =20
> > @@ -53,6 +60,9 @@ struct virtio_blk {
> >  =09/* num of vqs */
> >  =09int num_vqs;
> >  =09struct virtio_blk_vq *vqs;
> > +
> > +=09/* Provides mutual exclusion with virtblk_remove(). */
>=20
> This is not the best way to document access rules.
> Which fields does this protect, exactly?
> I think it's just vdev. Right?
> Pls add to the comment.

Yes, vblk->vdev cannot be dereferenced after virtblk_remove() is
entered.

I'll document this mutex as protecting vdev.

>=20
> > +=09struct mutex remove_mutex;
> >  };
> > =20
> >  struct virtblk_req {
> > @@ -295,10 +305,54 @@ static int virtblk_get_id(struct gendisk *disk, c=
har *id_str)
> >  =09return err;
> >  }
> > =20
> > +static void virtblk_get(struct virtio_blk *vblk)
> > +{
> > +=09refcount_inc(&vblk->refs);
> > +}
> > +
> > +static void virtblk_put(struct virtio_blk *vblk)
> > +{
> > +=09if (refcount_dec_and_test(&vblk->refs)) {
> > +=09=09ida_simple_remove(&vd_index_ida, vblk->index);
> > +=09=09mutex_destroy(&vblk->remove_mutex);
> > +=09=09kfree(vblk);
> > +=09}
> > +}
> > +
> > +static int virtblk_open(struct block_device *bd, fmode_t mode)
> > +{
> > +=09struct virtio_blk *vblk =3D bd->bd_disk->private_data;
> > +=09int ret =3D -ENXIO;
>=20
>=20
> It's more common to do
>=20
> =09int ret =3D 0;
>=20
> and on error:
> =09ret =3D -ENXIO;
>=20
>=20
> let's do this.

Will fix.

> > +
> > +=09mutex_lock(&vblk->remove_mutex);
> > +
> > +=09if (vblk->vdev) {
> > +=09=09virtblk_get(vblk);
> > +=09=09ret =3D 0;
> > +=09}
>=20
> I prefer
> =09else
> =09=09ret =3D -ENXIO
>=20
> here.

Got it.

> > +
> > +=09mutex_unlock(&vblk->remove_mutex);
> > +=09return ret;
> > +}
> > +
> > +static void virtblk_release(struct gendisk *disk, fmode_t mode)
> > +{
> > +=09struct virtio_blk *vblk =3D disk->private_data;
> > +
> > +=09virtblk_put(vblk);
> > +}
> > +
> >  /* We provide getgeo only to please some old bootloader/partitioning t=
ools */
> >  static int virtblk_getgeo(struct block_device *bd, struct hd_geometry =
*geo)
> >  {
> >  =09struct virtio_blk *vblk =3D bd->bd_disk->private_data;
> > +=09int ret =3D -ENXIO;
>=20
> It's more common to do
>=20
> =09int ret =3D 0;
>=20
> and on error:
> =09ret =3D -ENXIO;
>=20
>=20
> let's do this.

Will fix.

>=20
> > +
> > +=09mutex_lock(&vblk->remove_mutex);
> > +
> > +=09if (!vblk->vdev) {
> > +=09=09goto out;
> > +=09}
>=20
>=20
> single lines are not supposed to use {}.
> if you add ret =3D -ENXIO here then it won't be a single line anymore
> though.

Oops, a QEMU coding style habit :).

> > =20
> >  =09/* see if the host passed in geometry config */
> >  =09if (virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_GEOMETRY)) {
> > @@ -314,11 +368,17 @@ static int virtblk_getgeo(struct block_device *bd=
, struct hd_geometry *geo)
> >  =09=09geo->sectors =3D 1 << 5;
> >  =09=09geo->cylinders =3D get_capacity(bd->bd_disk) >> 11;
> >  =09}
> > -=09return 0;
> > +
> > +=09ret =3D 0;
> > +out:
> > +=09mutex_unlock(&vblk->remove_mutex);
> > +=09return ret;
> >  }
> > =20
> >  static const struct block_device_operations virtblk_fops =3D {
> >  =09.owner  =3D THIS_MODULE,
> > +=09.open =3D virtblk_open,
> > +=09.release =3D virtblk_release,
> >  =09.getgeo =3D virtblk_getgeo,
> >  };
> > =20
> > @@ -655,6 +715,10 @@ static int virtblk_probe(struct virtio_device *vde=
v)
> >  =09=09goto out_free_index;
> >  =09}
> > =20
> > +=09/* This reference is dropped in virtblk_remove(). */
> > +=09refcount_set(&vblk->refs, 1);
> > +=09mutex_init(&vblk->remove_mutex);
> > +
> >  =09vblk->vdev =3D vdev;
> >  =09vblk->sg_elems =3D sg_elems;
> > =20
> > @@ -820,8 +884,12 @@ static int virtblk_probe(struct virtio_device *vde=
v)
> >  static void virtblk_remove(struct virtio_device *vdev)
> >  {
> >  =09struct virtio_blk *vblk =3D vdev->priv;
> > -=09int index =3D vblk->index;
> > -=09int refc;
> > +
> > +=09/*
> > +=09 * Virtqueue processing is stopped safely here but mutual exclusion=
 is
> > +=09 * needed for block_device_operations.
> > +=09 */
> > +=09mutex_lock(&vblk->remove_mutex);
> > =20
> >  =09/* Make sure no work handler is accessing the device. */
> >  =09flush_work(&vblk->config_work);
> > @@ -834,15 +902,16 @@ static void virtblk_remove(struct virtio_device *=
vdev)
> >  =09/* Stop all the virtqueues. */
> >  =09vdev->config->reset(vdev);
> > =20
> > -=09refc =3D kref_read(&disk_to_dev(vblk->disk)->kobj.kref);
> > +=09/* Virtqueue are stopped, nothing can use vblk->vdev anymore. */
>=20
> Virtqueues?

Thanks, will fix.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6oUloACgkQnKSrs4Gr
c8gl5wgAmwDcVKA5AuCFLUZIf/5bBk/mKI+8U3eiiM5F3nJvoGNhnpbCC60paAl9
WaqppfC+EJXcsrnjpMHOoLa4XYeQqRPoxhttJvaMRdnbtxl2gz/pScVg/nQDCvUs
PBGrLSVR5LGDo1VIWCm7QhS7zJKbiGkJEooTxSJ9ar1C+bwfcvObYYRBc5DbS+uV
HG4lz6oTIw00fetjdO8qRWtjwB+4a6Quhlm4tyx9qcFlF5lHN9zaksLcw6igEzKI
jbgv1/BUhbucBT3mvZHXdgQo7jec5GEv3SX9TNNIWvYYiN6ug3YkHRQWJ4lwQI8t
nqdlk4AQ6FiJSti1TbB12m6pKfWwUA==
=Oif3
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

