Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26FC295D99
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859337; cv=none; b=W5Ze2sheyhseqImWAzPgF/meJWraCPmNAuhYs0FitIiELVgfPbeAJ/UB77WfQc3nY+2EFXVlEBjQo++9Rthls88HGjX7UNIiIG3FBUan+J24sFQnXUgmNxsDroaDgbMxmFbxIcSXJuMGOLEOtoTuvMsy6WnWk9XM2iCEAwTlPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859337; c=relaxed/simple;
	bh=sDMX05rwAcaf5JZdL77JqMEMMhgFNwHHhPCYUT+S4h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyuZ5JMHIy5V8mtAqqFEDippbCP9/B9GbJqaIf8KsnifjEtmLvotjHv184bc2enpWQot8rl3UyDqUvtOWsshwHOGO4wNe2X28ER9ThIByPHx3uUJNley0vm0UdZMJbKFjuiMqxxS16OuruvV+ysedDq0SvGzFFkAtsdo9wwLtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZKcPejF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZKcPejF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747859335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqa+Slzqpm+EOjMG2kM+nu6Tk6ksZ7x6vdr8OubiJrE=;
	b=HZKcPejFarz0h1q3mGKo/wc3CLRYj0ZBK1a149AiZBvb8hGwDEIrbok+SX4bQA9sxSYJat
	VRQrchlWUX3S4yKCGilmZvqrwd5OHtU+lB1fMcjFR1v/6MVryIWPl9UCviqdv//g9UvPF6
	fOBq6ytdvUqjKef0TcQ0CJUgsc6NBWk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-Pwi3R_IGNK2bIMIWalWxFA-1; Wed,
 21 May 2025 16:28:51 -0400
X-MC-Unique: Pwi3R_IGNK2bIMIWalWxFA-1
X-Mimecast-MFC-AGG-ID: Pwi3R_IGNK2bIMIWalWxFA_1747859330
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 955A8180036D;
	Wed, 21 May 2025 20:28:49 +0000 (UTC)
Received: from localhost (unknown [10.2.16.97])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1175B19560AE;
	Wed, 21 May 2025 20:28:47 +0000 (UTC)
Date: Wed, 21 May 2025 10:56:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, axboe@kernel.dk, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, stable@vger.kernel.org,
	lirongqing@baidu.com, kch@nvidia.com, xuanzhuo@linux.alibaba.com,
	pbonzini@redhat.com, jasowang@redhat.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250521145635.GA120766@fedora>
References: <20250521062744.1361774-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3dS4cFcU99GDWhEB"
Content-Disposition: inline
In-Reply-To: <20250521062744.1361774-1-parav@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--3dS4cFcU99GDWhEB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> When the PCI device is surprise removed, requests may not complete
> the device as the VQ is marked as broken. Due to this, the disk
> deletion hangs.
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
> Reported-by: lirongqing@baidu.com
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca=
9b4741@baidu.com/
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v0->v1:
> - Fixed comments from Stefan to rename a cleanup function
> - Improved logic for handling any outstanding requests
>   in bio layer
> - improved cancel callback to sync with ongoing done()
>=20
> ---
>  drivers/block/virtio_blk.c | 95 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 7cffea01d868..5212afdbd3c7 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw=
_ctx *hctx,
>  	blk_status_t status;
>  	int err;
> =20
> +	/* Immediately fail all incoming requests if the vq is broken.
> +	 * Once the queue is unquiesced, upper block layer flushes any pending
> +	 * queued requests; fail them right away.
> +	 */
> +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> +		return BLK_STS_IOERR;
> +
>  	status =3D virtblk_prep_rq(hctx, vblk, req, vbr);
>  	if (unlikely(status))
>  		return status;
> @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list *rqlist)
>  	while ((req =3D rq_list_pop(rqlist))) {
>  		struct virtio_blk_vq *this_vq =3D get_virtio_blk_vq(req->mq_hctx);
> =20
> +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> +			rq_list_add_tail(&requeue_list, req);
> +			continue;
> +		}
> +
>  		if (vq && vq !=3D this_vq)
>  			virtblk_add_req_batch(vq, &submit_list);
>  		vq =3D this_vq;
> @@ -1554,6 +1566,87 @@ static int virtblk_probe(struct virtio_device *vde=
v)
>  	return err;
>  }
> =20
> +static bool virtblk_request_cancel(struct request *rq, void *data)
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
> +static void virtblk_broken_device_cleanup(struct virtio_blk *vblk)
> +{
> +	struct request_queue *q =3D vblk->disk->queue;
> +
> +	if (!virtqueue_is_broken(vblk->vqs[0].vq))
> +		return;

Can a subset of virtqueues be broken? If so, then this code doesn't
handle it.

> +
> +	/* Start freezing the queue, so that new requests keeps waitng at the

s/waitng/waiting/

> +	 * door of bio_queue_enter(). We cannot fully freeze the queue because
> +	 * freezed queue is an empty queue and there are pending requests, so
> +	 * only start freezing it.
> +	 */
> +	blk_freeze_queue_start(q);
> +
> +	/* When quiescing completes, all ongoing dispatches have completed
> +	 * and no new dispatch will happen towards the driver.
> +	 * This ensures that later when cancel is attempted, then are not
> +	 * getting processed by the queue_rq() or queue_rqs() handlers.
> +	 */
> +	blk_mq_quiesce_queue(q);
> +
> +	/*
> +	 * Synchronize with any ongoing VQ callbacks, effectively quiescing
> +	 * the device and preventing it from completing further requests
> +	 * to the block layer. Any outstanding, incomplete requests will be
> +	 * completed by virtblk_request_cancel().
> +	 */
> +	virtio_synchronize_cbs(vblk->vdev);
> +
> +	/* At this point, no new requests can enter the queue_rq() and
> +	 * completion routine will not complete any new requests either for the
> +	 * broken vq. Hence, it is safe to cancel all requests which are
> +	 * started.
> +	 */
> +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_request_cancel, vblk);

Although virtio_synchronize_cbs() was called, a broken/malicious device
can still raise IRQs. Would that lead to use-after-free or similar
undefined behavior for requests that have been submitted to the device?

It seems safer to reset the device before marking the requests as
failed.

> +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> +
> +	/* All pending requests are cleaned up. Time to resume so that disk
> +	 * deletion can be smooth. Start the HW queues so that when queue is
> +	 * unquiesced requests can again enter the driver.
> +	 */
> +	blk_mq_start_stopped_hw_queues(q, true);
> +
> +	/* Unquiescing will trigger dispatching any pending requests to the
> +	 * driver which has crossed bio_queue_enter() to the driver.
> +	 */
> +	blk_mq_unquiesce_queue(q);
> +
> +	/* Wait for all pending dispatches to terminate which may have been
> +	 * initiated after unquiescing.
> +	 */
> +	blk_mq_freeze_queue_wait(q);
> +
> +	/* Mark the disk dead so that once queue unfreeze, the requests
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
> @@ -1561,6 +1654,8 @@ static void virtblk_remove(struct virtio_device *vd=
ev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
> =20
> +	virtblk_broken_device_cleanup(vblk);
> +
>  	del_gendisk(vblk->disk);
>  	blk_mq_free_tag_set(&vblk->tag_set);
> =20
> --=20
> 2.34.1
>=20

--3dS4cFcU99GDWhEB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgt6aIACgkQnKSrs4Gr
c8hViAf/S7swQHpodVd5j7OCtLmscMR35kqLBC3k6WdyC0jhZOzt5HOCeLTaL1TT
KGRw+hm7x/UaGnu3O/IgqVnCQljKBPDPXnyn48UJqWo2x/zuXVZqsXQQ1tf81KF5
doV++2StxiTDXrj6PAQwCEhvtbCbytpMdEOSjOHUjEm+E3v67NUmZTf05cvNeh/z
o+8LKiWWmI0+p8eIg5yuvKteRP0JHy3cKGiAvVgtl6sZiB5ZbIhNb29kpkUTnkeW
6DiFyRfQV5b6qPl9sIR3rTW0eMWnw5zll4CTlW9FSAKwKZgak/MXk24zmcwsI+Qd
bxBb+XUr16cytBDRCrna/5A8trpUOg==
=WLny
-----END PGP SIGNATURE-----

--3dS4cFcU99GDWhEB--

