Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIsAWQkN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175E3AC
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701960733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0xpo2ryVhd+3GXnE5ml+fwWQScftYbSzd+a1VvBh0k=;
	b=ZIsAWQkN/r4V5myrrscFAcTKjf9MocjekZQs/veywNJyn7xA4y5RvKaRthA2nvjsydItUY
	iFwzxXkpdaGaUO8Pf3nr+96NJlFHIdrOveifEuWg+14E1dNdGc9kHL15HAhVBn7Taul9+7
	AQuGBaVJ6JcDf3v2ueJdT2RQ7uyEd+Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-2V5E8xUnMuWEVomgn9XDhg-1; Thu,
 07 Dec 2023 09:52:08 -0500
X-MC-Unique: 2V5E8xUnMuWEVomgn9XDhg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCC7E1C01724;
	Thu,  7 Dec 2023 14:52:07 +0000 (UTC)
Received: from localhost (unknown [10.39.193.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 205F1492BE6;
	Thu,  7 Dec 2023 14:52:06 +0000 (UTC)
Date: Thu, 7 Dec 2023 09:51:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231207145159.GB2147383@fedora>
References: <20231207043118.118158-1-fengli@smartx.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jzahsJkBdAiW+nf1"
Content-Disposition: inline
In-Reply-To: <20231207043118.118158-1-fengli@smartx.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


--jzahsJkBdAiW+nf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
> virtio-blk is generally used in cloud computing scenarios, where the
> performance of virtual disks is very important. The mq-deadline scheduler
> has a big performance drop compared to none with single queue. In my test=
s,
> mq-deadline 4k readread iops were 270k compared to 450k for none. So here
> the default scheduler of virtio-blk is set to "none".
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This seems similar to commit f8b12e513b95 ("virtio_blk: revert
QUEUE_FLAG_VIRT addition") where changing the default sounded good in
theory but exposed existing users to performance regressions.

Christoph's suggestion back in 2009 was to introduce a flag in the
virtio-blk hardware interface so that the device can provide a hint from
the host side.

Do you have more performance data aside from 4k randread? My suggestion
would be for everyone with an interest to collect and share data so
there's more evidence that this new default works well for a range of
configurations.

I don't want to be overly conservative. The virtio_blk driver has
undergone changes in this regard from the legacy block layer to blk-mq
(without an I/O scheduler) to blk-mq (mq-deadline). Performance changed
at each step and that wasn't a showstopper, so I think we could default
to 'none' without a lot of damage. Let's just get more data.

Stefan

>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index d53d6aa8ee69..5183ec8e00be 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1367,7 +1367,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	vblk->tag_set.ops =3D &virtio_mq_ops;
>  	vblk->tag_set.queue_depth =3D queue_depth;
>  	vblk->tag_set.numa_node =3D NUMA_NO_NODE;
> -	vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
> +	vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED_BY_DE=
FAULT;
>  	vblk->tag_set.cmd_size =3D
>  		sizeof(struct virtblk_req) +
>  		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
> --=20
> 2.42.0
>=20

--jzahsJkBdAiW+nf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVx3A8ACgkQnKSrs4Gr
c8iW7Af/SwZCn/GpSj7j9V527PVV437hXYHQ04RyKzmI6js4NU3gfzqaV/hqy4O4
LMD9gAUovQGx9OhvYRtCkpEw+gLhn51wwUxNYX77y3eaHGEyxb4btN0DetBu3LDp
Rz4caz4YiFMxFcSB9yHt84Q/noT97Iy4lar3xNiy8OEOdleVKGhuv351zvwdMnJ5
lBiP9yNaSUgapXJbD6nAmrt765aR3ByQInkS/kxjLURF4gFQKlx76kUcFlC7FquV
+Pwk1QQr1tT8vfKCzYm8YeDl8tNecPEm+N3gtnAbMv+1dAtnI+7b4P8K3+GPiE7d
6Ze512aHSeonNEi6hUqQpiUb2ae2pw==
=FsbK
-----END PGP SIGNATURE-----

--jzahsJkBdAiW+nf1--

