Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796F4C74
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791418; cv=none; b=QPx5AJ+zwh5tBSbDK+1oJd56eznlDRcRgBCAeMZsZpEadmZHgFbGE6QvBlZq3fHjJ1qgQJZjTbq95BH+95UBQNSsvJ4D0WvMo2W/o0eqRLHypsrepWJJuK+W1RHhx+LmvaLJ20+Z3+/RWRZQY8YTktcqqYmoOkSM4yDC0T4eI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791418; c=relaxed/simple;
	bh=k7+87lorjbk7yirRD6WO3f7yv9CJCF2JkVO4XzBluLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TR3v+RqHaj2MnhIdDyhsGnji8HFHmItLLncqp3V2kolMdVvTznZ5bQ91D8dGryTVSi23kNrnQcN4zgUYmYpLIX9zrH2mjlWGfsmmuh0pDKDXMTBP113uCTrOUgRCve54TfoPwcH/EB56UQDYC/GeRBwtTjv/ovDS1hBH5v1CfF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxWYQguh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxWYQguh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750791415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1eJKQCod9a7ytkrDXmSwASYimvlVZPkPrqx9b+5atfg=;
	b=NxWYQguhgrIBFkxDSl20RRzSCeFQArypvFpGPPOkamQFnsp/A/eGXVhwV8xaJ/IZjFJvUv
	Fo0+xCAZ+PRX4Poi5gKfGz1IOlPW9OnWuOCm1+IPmlFw87E52YQb19X1k6qV7chqCrRd8h
	3KuffQ/g5qgc4Z3YhvwSbyrgN9tNJ0M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-sPeFNE2-MXCRq9skRJc-vw-1; Tue,
 24 Jun 2025 14:56:51 -0400
X-MC-Unique: sPeFNE2-MXCRq9skRJc-vw-1
X-Mimecast-MFC-AGG-ID: sPeFNE2-MXCRq9skRJc-vw_1750791409
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 969D31920483;
	Tue, 24 Jun 2025 18:56:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.196])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F1DC219560A3;
	Tue, 24 Jun 2025 18:56:23 +0000 (UTC)
Date: Tue, 24 Jun 2025 14:56:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, axboe@kernel.dk, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, stable@vger.kernel.org,
	lirongqing@baidu.com, kch@nvidia.com, xuanzhuo@linux.alibaba.com,
	pbonzini@redhat.com, jasowang@redhat.com, alok.a.tiwari@oracle.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250624185622.GB5519@fedora>
References: <20250602024358.57114-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PMmMKbCizQT0pNag"
Content-Disposition: inline
In-Reply-To: <20250602024358.57114-1-parav@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


--PMmMKbCizQT0pNag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> When the PCI device is surprise removed, requests may not complete
> the device as the VQ is marked as broken. Due to this, the disk
> deletion hangs.

There are loops in the core virtio driver code that expect device
register reads to eventually return 0:
drivers/virtio/virtio_pci_modern.c:vp_reset()
drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset()

Is there a hang if these loops are hit when a device has been surprise
removed? I'm trying to understand whether surprise removal is fully
supported or whether this patch is one step in that direction.

Apart from that, I'm happy with the virtio_blk.c aspects of the patch:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>=20
> Fix it by aborting the requests when the VQ is broken.
>=20
> With this fix now fio completes swiftly.
> An alternative of IO timeout has been considered, however
> when the driver knows about unresponsive block device, swiftly clearing
> them enables users and upper layers to react quickly.
>=20
> Verified with multiple device unplug iterations with pending requests in
> virtio used ring and some pending with the device.
>=20
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci =
device")
> Cc: stable@vger.kernel.org
> Reported-by: Li RongQing <lirongqing@baidu.com>
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca=
9b4741@baidu.com/
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
> ---
> v4->v5:
> - fixed comment style where comment to start with one empty line at start
> - Addressed comments from Alok
> - fixed typo in broken vq check
> v3->v4:
> - Addressed comments from Michael
> - renamed virtblk_request_cancel() to
>   virtblk_complete_request_with_ioerr()
> - Added comments for virtblk_complete_request_with_ioerr()
> - Renamed virtblk_broken_device_cleanup() to
>   virtblk_cleanup_broken_device()
> - Added comments for virtblk_cleanup_broken_device()
> - Moved the broken vq check in virtblk_remove()
> - Fixed comment style to have first empty line
> - replaced freezed to frozen
> - Fixed comments rephrased
>=20
> v2->v3:
> - Addressed comments from Michael
> - updated comment for synchronizing with callbacks
>=20
> v1->v2:
> - Addressed comments from Stephan
> - fixed spelling to 'waiting'
> - Addressed comments from Michael
> - Dropped checking broken vq from queue_rq() and queue_rqs()
>   because it is checked in lower layer routines in virtio core
>=20
> v0->v1:
> - Fixed comments from Stefan to rename a cleanup function
> - Improved logic for handling any outstanding requests
>   in bio layer
> - improved cancel callback to sync with ongoing done()
> ---
>  drivers/block/virtio_blk.c | 95 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 7cffea01d868..c5e383c0ac48 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct virtio_device *vde=
v)
>  	return err;
>  }
> =20
> +/*
> + * If the vq is broken, device will not complete requests.
> + * So we do it for the device.
> + */
> +static bool virtblk_complete_request_with_ioerr(struct request *rq, void=
 *data)
> +{
> +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> +	struct virtio_blk *vblk =3D data;
> +	struct virtio_blk_vq *vq;
> +	unsigned long flags;
> +
> +	vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +
> +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> +		blk_mq_complete_request(rq);
> +
> +	spin_unlock_irqrestore(&vq->lock, flags);
> +	return true;
> +}
> +
> +/*
> + * If the device is broken, it will not use any buffers and waiting
> + * for that to happen is pointless. We'll do the cleanup in the driver,
> + * completing all requests for the device.
> + */
> +static void virtblk_cleanup_broken_device(struct virtio_blk *vblk)
> +{
> +	struct request_queue *q =3D vblk->disk->queue;
> +
> +	/*
> +	 * Start freezing the queue, so that new requests keeps waiting at the
> +	 * door of bio_queue_enter(). We cannot fully freeze the queue because
> +	 * frozen queue is an empty queue and there are pending requests, so
> +	 * only start freezing it.
> +	 */
> +	blk_freeze_queue_start(q);
> +
> +	/*
> +	 * When quiescing completes, all ongoing dispatches have completed
> +	 * and no new dispatch will happen towards the driver.
> +	 */
> +	blk_mq_quiesce_queue(q);
> +
> +	/*
> +	 * Synchronize with any ongoing VQ callbacks that may have started
> +	 * before the VQs were marked as broken. Any outstanding requests
> +	 * will be completed by virtblk_complete_request_with_ioerr().
> +	 */
> +	virtio_synchronize_cbs(vblk->vdev);
> +
> +	/*
> +	 * At this point, no new requests can enter the queue_rq() and
> +	 * completion routine will not complete any new requests either for the
> +	 * broken vq. Hence, it is safe to cancel all requests which are
> +	 * started.
> +	 */
> +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> +				virtblk_complete_request_with_ioerr, vblk);
> +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> +
> +	/*
> +	 * All pending requests are cleaned up. Time to resume so that disk
> +	 * deletion can be smooth. Start the HW queues so that when queue is
> +	 * unquiesced requests can again enter the driver.
> +	 */
> +	blk_mq_start_stopped_hw_queues(q, true);
> +
> +	/*
> +	 * Unquiescing will trigger dispatching any pending requests to the
> +	 * driver which has crossed bio_queue_enter() to the driver.
> +	 */
> +	blk_mq_unquiesce_queue(q);
> +
> +	/*
> +	 * Wait for all pending dispatches to terminate which may have been
> +	 * initiated after unquiescing.
> +	 */
> +	blk_mq_freeze_queue_wait(q);
> +
> +	/*
> +	 * Mark the disk dead so that once we unfreeze the queue, requests
> +	 * waiting at the door of bio_queue_enter() can be aborted right away.
> +	 */
> +	blk_mark_disk_dead(vblk->disk);
> +
> +	/* Unfreeze the queue so that any waiting requests will be aborted. */
> +	blk_mq_unfreeze_queue_nomemrestore(q);
> +}
> +
>  static void virtblk_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk =3D vdev->priv;
> @@ -1561,6 +1653,9 @@ static void virtblk_remove(struct virtio_device *vd=
ev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
> =20
> +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> +		virtblk_cleanup_broken_device(vblk);
> +
>  	del_gendisk(vblk->disk);
>  	blk_mq_free_tag_set(&vblk->tag_set);
> =20
> --=20
> 2.34.1
>=20

--PMmMKbCizQT0pNag
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmha9NYACgkQnKSrs4Gr
c8irNAf/dcQsS90jfXhVTEEf1kGgf/W2L/TCXD9w0qRhXPle17Z1a7N6gSucSxlH
fudfm7m2xsJ4Y3KaNkeOj+4tjyoRnyeoBUB5E4nFyvvAzQkm5IiJc0ixbB3syQyG
U/O/Tf0f/BH13xW/UluKrosdop8ZIrg8SnDRu5d2HC0sJXSUxg8vDWEA/MirBubc
XYsqphNYooPqtAcsXzBqrvu9uVdk1Hzy5TMzKNUe7WZUBElzqvzKsHYcCUVyR8fs
vjl3V9rQ3AMmO8RtkDPBUrBIb9/2xJJT/f2Gh6DgQbHjMuuy7a+BLXPBkPj6UvC9
nwTCE1tEbagRLt5MONPk+4jfurniZQ==
=l+z2
-----END PGP SIGNATURE-----

--PMmMKbCizQT0pNag--

