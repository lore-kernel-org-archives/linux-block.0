Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166B1E6732
	for <linux-block@vger.kernel.org>; Wed,  7 Aug 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036790; cv=none; b=dpePZqJr6CVhFGGIo8Q0BTHTL4r4MJtMQfKafePirO2naC6F+Dmae6hsEEvh+ykzObGF8uxFnxi9wRhBpAJr96rGZAx7M/aHWafaoB2FA76O0vGq/0iXR4eMSZG55Za2/ACL3zZ1SQvC3ZlxEKIeorAj7tr5zfIDB1qowypYPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036790; c=relaxed/simple;
	bh=SsU2iF/kr87GRPwKXL7dEKrDmhbhkz6VOTu0Y6hDdu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/ymGv8RIRLPkeEWMsYy8MtZRNnVogZZPvhmg7Hx6dv9mwMOBClLlc+7/AZxk+Zloidm2AQbtzazw2wQoqP5OhPxbPf0G/v+HBUZjXc+HHpr+XOHYn45czBQexVNfVziEy1YYLQRiT6qYqmr5mhY763K/KfTSyNyx49T47gJOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeZuSZQC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeZuSZQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723036788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsU2iF/kr87GRPwKXL7dEKrDmhbhkz6VOTu0Y6hDdu8=;
	b=VeZuSZQC0/4sJ6abZPGkT3KQg1+zcIna622gfm6+NQwCOnBVg8Ad4OIjfV9WQKh5GGFs4G
	gY6qYTyae/mFKCJ4z8ipdTfsLVbgPN5SHpBilQvdupzonEiUaFkbUP0y1Lgv4bJt5bxJ1P
	nRUvPeNWUmDayH52EwkNX6JStEL/Bcg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-0PCfTmtjPXW91nZBK36-Cw-1; Wed,
 07 Aug 2024 09:19:42 -0400
X-MC-Unique: 0PCfTmtjPXW91nZBK36-Cw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8263119560A2;
	Wed,  7 Aug 2024 13:19:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73EB43000197;
	Wed,  7 Aug 2024 13:19:40 +0000 (UTC)
Date: Wed, 7 Aug 2024 09:19:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
	axboe@kernel.dk, kvm@vger.kernel.org, linux-block@vger.kernel.org,
	oren@nvidia.com
Subject: Re: [PATCH 1/1] virtio_blk: implement init_hctx MQ operation
Message-ID: <20240807131939.GA131475@fedora.redhat.com>
References: <20240801111337-mutt-send-email-mst@kernel.org>
 <0888da3b-3283-405b-b1a8-a315e2623289@nvidia.com>
 <20240801112843-mutt-send-email-mst@kernel.org>
 <9400fb28-47c2-4629-af17-df2a95f2d3d8@nvidia.com>
 <20240801114205-mutt-send-email-mst@kernel.org>
 <6a8f0c72-ba77-42c3-8d85-6bb23a23f025@nvidia.com>
 <20240801175617.GA1133773@fedora.redhat.com>
 <a10e97ce-792a-410f-b68e-d00292987b3a@nvidia.com>
 <20240803083824-mutt-send-email-mst@kernel.org>
 <7022d183-f98e-40b4-b3cb-00eb43c1ff06@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cD+r1+2b44WpCs/0"
Content-Disposition: inline
In-Reply-To: <7022d183-f98e-40b4-b3cb-00eb43c1ff06@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


--cD+r1+2b44WpCs/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2024 at 08:54:45PM +0300, Max Gurtovoy wrote:
>=20
> On 03/08/2024 15:39, Michael S. Tsirkin wrote:
> > On Sat, Aug 03, 2024 at 01:07:27AM +0300, Max Gurtovoy wrote:
> > > On 01/08/2024 20:56, Stefan Hajnoczi wrote:
> > > > On Thu, Aug 01, 2024 at 06:56:44PM +0300, Max Gurtovoy wrote:
> > > > > On 01/08/2024 18:43, Michael S. Tsirkin wrote:
> > > > > > On Thu, Aug 01, 2024 at 06:39:16PM +0300, Max Gurtovoy wrote:
> > > > > > > On 01/08/2024 18:29, Michael S. Tsirkin wrote:
> > > > > > > > On Thu, Aug 01, 2024 at 06:17:21PM +0300, Max Gurtovoy wrot=
e:
> > > > > > > > > On 01/08/2024 18:13, Michael S. Tsirkin wrote:
> > > > > > > > > > On Thu, Aug 01, 2024 at 06:11:37PM +0300, Max Gurtovoy =
wrote:
> > > > > > > > > > > In this operation set the driver data of the hctx to =
point to the virtio
> > > > > > > > > > > block queue. By doing so, we can use this reference i=
n the and reduce
> > > > > > > > > > in the .... ?
> > > > > > > > > sorry for the type.
> > > > > > > > >=20
> > > > > > > > > should be :
> > > > > > > > >=20
> > > > > > > > > "By doing so, we can use this reference and reduce the nu=
mber of operations in the fast path."
> > > > > > > > ok. what kind of benefit do you see with this patch?
> > > > > > > As mentioned. This is a micro optimization that reduce the nu=
mber of
> > > > > > > instructions/dereferences in the fast path.
> > > > > > By how much? How random code tweaks affect object code is unpre=
dictable.
> > > > > > Pls show results of objdump to prove it does anything
> > > > > > useful.
> > > > > This is the way all modern block drivers such as NVMe PCI/RDMA/TC=
P use the
> > > > > driver_data.
> > > > >=20
> > > > > These drivers don't have driver specific mechanisms to find the q=
ueue from
> > > > > the hctx->queue->queuedata like vblk driver has for some unknown =
reason.
> > > > >=20
> > > > > It is pretty easy to review this patch and see its benefits, isn'=
t it ?
> > > > >=20
> > > > > It is not expected to provide extreme perf improvement.
> > > > >=20
> > > > > It is introduced for aligning the driver to use common MQ mechani=
sms and
> > > > > reduce dereferences.
> > > > >=20
> > > > > This is not "random code tweaks".
> > > > If you cannot observe a performance change, then adjusting the comm=
it
> > > > description to explain this as a code cleanup to reduce dereference=
s and
> > > > local variables, improving code readability seems fine to me. I thi=
nk
> > > > it's a nice cleanup when presented as such rather than a performance
> > > > optimization.
> > > >=20
> > > > Stefan
> > > Sure. Please check the bellow adjustment:
> > >=20
> > > virtio_blk: implement init_hctx MQ operation
> > >=20
> > > Set the driver data of the hardware context (hctx) to point directly =
to
> > > the virtio block queue. This cleanup improves code readability, reduc=
es
> > > the number of dereferences, and minimizes local variables in the fast
> > > path.
> > I'd drop the local variables part, it is not at all clear why is that
> > a win.
>=20
> We can drop it:
>=20
> virtio_blk: implement init_hctx MQ operation
>=20
> Set the driver data of the hardware context (hctx) to point directly to
> the virtio block queue. This cleanup improves code readability and reduces
> the number of dereferences in the fast path.
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cD+r1+2b44WpCs/0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmazdGoACgkQnKSrs4Gr
c8hZnggArijtbcstPiHweHlu7ZUx9IZcfreWeGf372o4b/T2ImRDfuqNzzNZK/Eg
8kCYY6URkZwAIwO8tYyNUH0jFfL6JI/E/Gy6V02R+4Oniq3y7SjKoUj5Znc0m0hj
SGkbQTpE9jg+sq9PX/xcSgZedN0hC+TBjgL1v+5HVKDmUg+biy4wBxEIVP7KjTbg
mezG1iZd1tnFNnKZ21AacbHDfl56r6MXZ+F/S1DF6g2G/lUs9DiaaHJomRee3seZ
vD5JnA+N700wWVr3EJUpvOU7z7K14/ej9V6id4eTHftXTx24je3aPhpmpDojJ1wc
47yp+/3m0tTStzvO7eElwco3G/E/8g==
=q0mn
-----END PGP SIGNATURE-----

--cD+r1+2b44WpCs/0--

