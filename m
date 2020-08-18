Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E519C433E1
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 13:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395E5206B5
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 13:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOINyKop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgHRNxC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbgHRNw6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 09:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597758776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gj+yuFs97PSj1BhFaKZXUiQOsZabxQQ/UBOrfWP7tC8=;
        b=JOINyKop5ln+GtMzv+OAHH+3rn7zKmVmzP5mHlPystylNsAW/8iDyNiq46KnisSGCvG8UX
        JxDC8JssAhj33JWplSsRcgrPfzQHMUTllUxAhfzLqqTM2uf7zcvtSneezO7LqoFU5PXQF7
        DSfyQMF8M1ZmUGDWdR0v9/8w7GcHIH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-sx-dgrq3OJKPczRt2gevpA-1; Tue, 18 Aug 2020 09:52:53 -0400
X-MC-Unique: sx-dgrq3OJKPczRt2gevpA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D8ACCC542;
        Tue, 18 Aug 2020 13:52:52 +0000 (UTC)
Received: from localhost (ovpn-114-160.ams2.redhat.com [10.36.114.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E57F7DFC0;
        Tue, 18 Aug 2020 13:52:46 +0000 (UTC)
Date:   Tue, 18 Aug 2020 14:52:44 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V3 2/3] block: virtio_blk: fix handling single range
 discard request
Message-ID: <20200818135244.GD36102@stefanha-x1.localdomain>
References: <20200817095241.2494763-1-ming.lei@redhat.com>
 <20200817095241.2494763-3-ming.lei@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200817095241.2494763-3-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2020 at 05:52:40PM +0800, Ming Lei wrote:
> 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
> to support multi-range discard for virtio-blk. However, the virtio-blk
> disk may report max discard segment as 1, at least that is exactly what
> qemu is doing.
>=20
> So far, block layer switches to normal request merge if max discard segme=
nt
> limit is 1, and multiple bios can be merged to single segment. This way m=
ay
> cause memory corruption in virtblk_setup_discard_write_zeroes().
>=20
> Fix the issue by handling single max discard segment in straightforward
> way.
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Changpeng Liu <changpeng.liu@intel.com>
> Cc: Daniel Verkamp <dverkamp@chromium.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)

Thanks for fixing this!

Stefan

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl873SwACgkQnKSrs4Gr
c8ijIwf+K3v+vkqSCxHaDFy+TQ3zoIglmcMfAfXMR8Ys3dUFfA4zV2iR6xGS4Jvg
6vy1wqd+nFtnQR+I8zKa3PyvDvvBggfbc+WOPlSYFsI8PFESj49Y7lN6B3smS+GB
Ik5MV1WSvPRMvq1YcIbTXTOMQLVv5/uf8ttO1QcCzrC8iBRCA3AzvUC4sBB4MYdx
GEMFFXy/+k+18Yxuo6MvS1VUZTRvZ6GFoB6RSYrdM2g1yYOqzpNrayQfhO5y1W3M
YML6lsv7bYn9T/QuWuSCxKsBRKeNId82wPSXpMM+gxGXmpUo3+pVApmVq6pHft/X
Hwr8DUbcdcrCSVSdsUON6w4F9RWImg==
=D4P0
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--

