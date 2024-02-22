Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB80B1419A4
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615421; cv=none; b=tbw01c63I2/LSGT78uBLJ1TmWWkYlNI3ub/ZCyy4pciVsCypqIFmSyaw0o1nWRm6hg7JS/gO7kHkXfnzPk/v0QXskD1VqXaV35VsJPGHbpGXD6p0OVb2dTaScNxmVMt/z45Y+OvNj9flG6R/qkiAQln1Am/h2YuG08662/4LZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615421; c=relaxed/simple;
	bh=bydGYe1ufBIWX+7NTKXJIMHoWFfqIXP9vPqnaDiAdqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhfLCCr53yPcSPUrtzJZySTzzhjPhw18dF4+QChfS9puUgS+vCR+2Svr7MzeE3PeP1mdpNy3miScDSWYmxVD01Wn19vTF4xGlxdQ7KaVsk6e0eiql5FB8NEZ69AKirrntd1otVR3dmoigabMTBT/Q4ul9S/Bu66vIH9H9QtlEd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2u3qeAf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2u3qeAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708615418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zaczx+p/VxOU0s8VdA81k7yBin/ne6WtMzqxEmtWJak=;
	b=O2u3qeAfkw/uaKybzpNl7RCuqjfWQiZ6NU51qTTjU6v+ZsLaHXxwutBJlsvVs5ilJhu5Nq
	wLfloH5SFRTtQSeTKHrRkq/i+Y/3hf7qiHflFjNgFvg5nG3YtqR0KgEhSgxrKrmseZBMlr
	h3G2+MWxCbn9FfByT6lsEnjdWOWa1kc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-ZwHuT3CPO8eBT5z6vZixxw-1; Thu,
 22 Feb 2024 10:23:34 -0500
X-MC-Unique: ZwHuT3CPO8eBT5z6vZixxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C87329AB411;
	Thu, 22 Feb 2024 15:23:33 +0000 (UTC)
Received: from localhost (unknown [10.39.194.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BC07E2022AAA;
	Thu, 22 Feb 2024 15:23:31 +0000 (UTC)
Date: Thu, 22 Feb 2024 10:23:28 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] virtio_blk: Fix device surprise removal
Message-ID: <20240222152328.GA1810574@fedora>
References: <20240217180848.241068-1-parav@nvidia.com>
 <20240220220501.GA1515311@fedora>
 <PH0PR12MB54812D3772181FEAA46054BEDC562@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JM6DPXOyemwbe1nU"
Content-Disposition: inline
In-Reply-To: <PH0PR12MB54812D3772181FEAA46054BEDC562@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


--JM6DPXOyemwbe1nU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 04:46:38AM +0000, Parav Pandit wrote:
>=20
>=20
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: Wednesday, February 21, 2024 3:35 AM
> > To: Parav Pandit <parav@nvidia.com>
> >=20
> > On Sat, Feb 17, 2024 at 08:08:48PM +0200, Parav Pandit wrote:
> > > When the PCI device is surprise removed, requests won't complete from
> > > the device. These IOs are never completed and disk deletion hangs
> > > indefinitely.
> > >
> > > Fix it by aborting the IOs which the device will never complete when
> > > the VQ is broken.
> > >
> > > With this fix now fio completes swiftly.
> > > An alternative of IO timeout has been considered, however when the
> > > driver knows about unresponsive block device, swiftly clearing them
> > > enables users and upper layers to react quickly.
> > >
> > > Verified with multiple device unplug cycles with pending IOs in virtio
> > > used ring and some pending with device.
> > >
> > > In future instead of VQ broken, a more elegant method can be used. At
> > > the moment the patch is kept to its minimal changes given its urgency
> > > to fix broken kernels.
> > >
> > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > pci device")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: lirongqing@baidu.com
> > > Closes:
> > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > > 1@baidu.com/
> > > Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >  drivers/block/virtio_blk.c | 54
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 2bf14a0e2815..59b49899b229 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -1562,10 +1562,64 @@ static int virtblk_probe(struct virtio_device
> > *vdev)
> > >  	return err;
> > >  }
> > >
> > > +static bool virtblk_cancel_request(struct request *rq, void *data) {
> > > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > > +
> > > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > > +		blk_mq_complete_request(rq);
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static void virtblk_cleanup_reqs(struct virtio_blk *vblk) {
> > > +	struct virtio_blk_vq *blk_vq;
> > > +	struct request_queue *q;
> > > +	struct virtqueue *vq;
> > > +	unsigned long flags;
> > > +	int i;
> > > +
> > > +	vq =3D vblk->vqs[0].vq;
> > > +	if (!virtqueue_is_broken(vq))
> > > +		return;
> > > +
> > > +	q =3D vblk->disk->queue;
> > > +	/* Block upper layer to not get any new requests */
> > > +	blk_mq_quiesce_queue(q);
> > > +
> > > +	for (i =3D 0; i < vblk->num_vqs; i++) {
> > > +		blk_vq =3D &vblk->vqs[i];
> > > +
> > > +		/* Synchronize with any ongoing virtblk_poll() which may be
> > > +		 * completing the requests to uppper layer which has already
> > > +		 * crossed the broken vq check.
> > > +		 */
> > > +		spin_lock_irqsave(&blk_vq->lock, flags);
> > > +		spin_unlock_irqrestore(&blk_vq->lock, flags);
> > > +	}
> > > +
> > > +	blk_sync_queue(q);
> > > +
> > > +	/* Complete remaining pending requests with error */
> > > +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_cancel_request,
> > > +vblk);
> >=20
> > Interrupts can still occur here. What prevents the race between
> > virtblk_cancel_request() and virtblk_request_done()?
> >
> The PCI device which generates the interrupt is already removed so interr=
upt shouldn't arrive when executing cancel_request.
> (This is ignoring the race that Ming pointed out. I am preparing the v1 t=
hat eliminates such condition.)
>=20
> If there was ongoing virtblk_request_done() is synchronized by the for lo=
op above.

Ah, I see now that:

+if (!virtqueue_is_broken(vq))
+    return;

relates to:

static void virtio_pci_remove(struct pci_dev *pci_dev)
{
	struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
	struct device *dev =3D get_device(&vp_dev->vdev.dev);

	/*
	 * Device is marked broken on surprise removal so that virtio upper
	 * layers can abort any ongoing operation.
	 */
	if (!pci_device_is_present(pci_dev))
		virtio_break_device(&vp_dev->vdev);

Please rename virtblk_cleanup_reqs() to virtblk_cleanup_broken_device()
or similar so it's clear that this function only applies when the device
is broken? For example, it won't handle ACPI hot unplug requests because
the device will still be present.

Thanks,
Stefan

>=20
> =20
> > > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > +
> > > +	/*
> > > +	 * Unblock any pending dispatch I/Os before we destroy device. From
> > > +	 * del_gendisk() -> __blk_mark_disk_dead(disk) will set GD_DEAD
> > flag,
> > > +	 * that will make sure any new I/O from bio_queue_enter() to fail.
> > > +	 */
> > > +	blk_mq_unquiesce_queue(q);
> > > +}
> > > +
> > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > >  	struct virtio_blk *vblk =3D vdev->priv;
> > >
> > > +	virtblk_cleanup_reqs(vblk);
> > > +
> > >  	/* Make sure no work handler is accessing the device. */
> > >  	flush_work(&vblk->config_work);
> > >
> > > --
> > > 2.34.1
> > >
>=20

--JM6DPXOyemwbe1nU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXXZvAACgkQnKSrs4Gr
c8g8ywf/fxxNuXQ8G5t9KZBuJov1HTZvmDWU+gMRNN1uzbwttv1Y/L7Hx7J5GsV9
WKDp5Dgw84LzYVtoERdkHFJfYEv9t3xsb3qOmhWrIxBF9kiHsSk25N7OnV9GE1l8
qrj0uD2/E4WrtwTnPQGlIqpJrnspbJYvQjD8KQwga9LxE+KChvdplxIzIww8Zh50
2TikWB71u+ZojLnClIp8EdzG9O3lAczY+eHDko4xLPK/V1X7PiTXXNoo6A56cgVB
4RUQ4FJytf7t252lIfQ1cJauEtWCay0u0ia+Z+GtCoTfXZ8k7NPNXsYBdrYJjcc5
ZcHUv9/XGqCEUY0i95OguCaTFdgs1w==
=ncG4
-----END PGP SIGNATURE-----

--JM6DPXOyemwbe1nU--

