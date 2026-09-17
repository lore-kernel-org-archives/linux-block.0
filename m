Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF8655C330
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091892; cv=none; b=f4irRz34elJXInGpUo/Kb1gBWhBz1mK9vThXWIyFrCdt2uYL0wXH43nlHmeWSghfbjX6DrN8UiXtfrE/k2goUK7VVIyymZs9yw39FymwVfIpBoRRBO4iFhGvhjXn/Vh0njpc3IGxpSj8JwWrr7TwuCNqXaU5CRntJLfo7PWLpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091892; c=relaxed/simple;
	bh=vPi0kK3q34yEBUQ23IrFLjnsFYhRDd5xnsAgeZA3PSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyGgeW1eiI95GRNpgY30lHPAO+SAL32D08bDvRdfLhiiEX1FcuW4FgDDDi23dzPQvAGTre+ozKRl3dk5LklUR0QrWUGQOTejK7vOMYtC9KWIopgUJltWjymQmiE3AZXaqPzVSavjPF0b9LaGOl0Vc9sKA+Z9RLMK4p/C7Awrof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMAN7Dtv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMAN7Dtv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790091888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AJ/Vay7c5Bgi2O0k7N6fj3+pS1q8z/hYlkVBsoFvrJ4=;
	b=SMAN7Dtv+3+L5TXa+DxPgYmEEYtbEBpQgie9n95XCGLFLISiAbQqcM/HTf2JGcTnYw675j
	r1l6mh5k3/VxWuvYCH/70wqi/F02Kc4brP5O4dl4A+JTH5Vl5/soxC5Gz4H8CsOBDBWWIV
	/G4+wjxhnrhk2HLPq68uaw9pR8TcTgU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-vpvdV80zMSaYR1xaPkxmyw-1; Tue,
 22 Sep 2026 11:44:43 -0400
X-MC-Unique: vpvdV80zMSaYR1xaPkxmyw-1
X-Mimecast-MFC-AGG-ID: vpvdV80zMSaYR1xaPkxmyw_1790091881
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F7B018011E1;
	Tue, 22 Sep 2026 15:44:41 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD973180056E;
	Tue, 22 Sep 2026 15:44:40 +0000 (UTC)
Date: Thu, 17 Sep 2026 12:06:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-arm-msm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Message-ID: <20260917160645.GA323825@fedora>
References: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dy8Z7Idm8RuWqAdu"
Content-Disposition: inline
In-Reply-To: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

--dy8Z7Idm8RuWqAdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 04:52:44PM +0800, Cong Zhang wrote:
> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
> virtblk_freeze_priv().
>=20
> Keep the existing freeze and unfreeze order. The synchronous call waits
> for dispatch code that was already running. The queue remains quiesced
> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().
>=20
> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system s=
uspend")
>=20
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> ---
> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
>=20
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.
> ---
> Changes in v2:
> - Cc stable@vger.kernel.org.
> - Link to v1: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-=
a883f8f31258@oss.qualcomm.com
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Modulo Michael's comments about the commit message:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dy8Z7Idm8RuWqAdu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqsEBUACgkQnKSrs4Gr
c8jtiQf+NiukvAMH5bpSidfRu2qrf4zKvGkbv2VSKit/fEDilUft7I8qpykjAPGS
BlbLHO+oPNWA/fSA/7B5dNjUbfrTM28UcZvwdwMJufhE3QBB4Yz7cO1L8B/6Y+wn
DFfYmokCTJOFqZJGwEYoZDatSYMcd4tfMuOH+bCZ1t5gvFl5H1BOlEtOKj/dnmes
l8ofbMgmdhKGff+y6lwV4W3VQo3lFjUsbI6FxnLjQNkixQQspyuA7GIVwroPCrOE
FKBC8DXgWrDevRRgn+Fwj2b8ZIg0ngtiQditXDqK14UTfnyyckC2gNszvanVbwhm
/olV3bkhIcdgL8bKvgqJ3ZSYtut3cQ==
=TD0g
-----END PGP SIGNATURE-----

--dy8Z7Idm8RuWqAdu--

