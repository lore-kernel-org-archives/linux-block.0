Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D999482F9
	for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938186; cv=none; b=fpnX9D2RtfbnKZrCI9dG9PKkZjn8/eGJkV41Ro0/8dPwpzTmabJ5JyFfh1WVFGVYr/ROaFRDUFG8Ca3jODjTYKezfYOYHooNQej4tfnvUynlEJszwHaSepW4HsT+ABUsLjXzNkNV4shhbbMQnj+7ELwBl+rsQYVzR7a3lR2h3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938186; c=relaxed/simple;
	bh=UEj4gAERIGEoPdtDn8jn8QnfibDGp7ffc61lkNbKZ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jww43kBIPW2BdhbXpev/M2cRijOny4PuuRNM6EbanzUTjKfsfUMYHu03G1V8pHRxrww6GRkZ4Icjd23k68ow15GogIO7edtm1vk3uAoMBqL3tMQyEcB93jH9ni5ua9t3NSiTzJEcPVoAdGDOQxqMd8BtMvH/qXRGcIO2i07Kmyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZtuyeko; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZtuyeko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705938184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEj4gAERIGEoPdtDn8jn8QnfibDGp7ffc61lkNbKZ9Q=;
	b=hZtuyekoNAfkKWqyPuB6gAmd+WBRUS0bq0TB7eeL4ZizL5LBalDq23xPmHkyNcPq3CXmw7
	JwBeukcEq3Etks2KZv5T/yvTHhNpLyBVpMIq2tH4EkmVR1ituwVbqyaYvamGOfmP6L/Enr
	zI2G4Fcl7z4lDXQYZt0dEasuSmT5Hko=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-t6nMjAPcMqGP7iNVD1tHag-1; Mon,
 22 Jan 2024 10:42:58 -0500
X-MC-Unique: t6nMjAPcMqGP7iNVD1tHag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2895B3C025B1;
	Mon, 22 Jan 2024 15:42:58 +0000 (UTC)
Received: from localhost (unknown [10.39.194.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61FCFC259DD;
	Mon, 22 Jan 2024 15:42:56 +0000 (UTC)
Date: Mon, 22 Jan 2024 10:42:55 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yi Sun <yi.sun@unisoc.com>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com,
	hongyu.jin@unisoc.com, sunyibuaa@gmail.com
Subject: Re: [PATCH 2/2] virtio-blk: Ensure no requests in virtqueues before
 deleting vqs.
Message-ID: <20240122154255.GA389442@fedora>
References: <20240122110722.690223-1-yi.sun@unisoc.com>
 <20240122110722.690223-3-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eXv2gE92Usb5fs07"
Content-Disposition: inline
In-Reply-To: <20240122110722.690223-3-yi.sun@unisoc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


--eXv2gE92Usb5fs07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2024 at 07:07:22PM +0800, Yi Sun wrote:
> Ensure no remaining requests in virtqueues before resetting vdev and
> deleting virtqueues. Otherwise these requests will never be completed.
> It may cause the system to become unresponsive. So it is better to place
> blk_mq_quiesce_queue() in front of virtio_reset_device().

QEMU's virtio-blk device implementation completes all requests during
device reset. Most device implementations have to do the same to avoid
leaving dangling requests in flight across device reset.

Which device implementation are you using and why is it safe for the
device is simply drop requests across device reset?

Stefan

--eXv2gE92Usb5fs07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWujP8ACgkQnKSrs4Gr
c8j4JQf/dPyJyYzS3Bby2PGbjhtqMfkxWPLzThhLRlbyvKX27qbZx0RGZoWtmUBM
vDn2i3qmIoXs6vvj6N/y67VNoMAellkdO4HFstAF2BW8AehglGRbQMW0Bxhp/4er
xIPRGRNhs77ybcO0DJB6qnB99e3VWRpAnALJXNgzAYkQrghnMCkQKFK6UsPP+GXc
XQ+Tlzm8RngA6L46s42zyJ9Do6ZEykuif5BLKpar7vzXz1mCKAgGlWG9HKmXFwta
FBqmnl8fB1GAmRsKqnqj6hQHnSXvdtBfbM4813qfCNUaaWGwaoCAQYTw9PDDWL8J
cmGCudXGHAQ4MNItXS65SUzHkpmlZg==
=OduK
-----END PGP SIGNATURE-----

--eXv2gE92Usb5fs07--

