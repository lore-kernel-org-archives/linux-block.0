Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D99C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 10:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiBIKCZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 05:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiBIKCG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 05:02:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DCB6E0EA452
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 02:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644400560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nrZaO1QLhXCKNSnMpSxxsA2uM/u3n5wse6OBdbYb6VM=;
        b=ITXSoXJjUvc9js5aeqSHXiyA8y5QtZpY1Z9SfeT535b2PQPHg3jaiqvdp1pIz2uUUDau5A
        +Sjkyk82Tvw6Cu+YeossRW72KXouI2kJyQnSdsFb0i9fLCQRBbhkvt3rLRbEXizeMajQG+
        OtsNOjIw6cM47TlmXgJGMpf19aj6uGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-IBZ2QZvUPNi116_lJZriTA-1; Wed, 09 Feb 2022 04:39:53 -0500
X-MC-Unique: IBZ2QZvUPNi116_lJZriTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D82985B6C8;
        Wed,  9 Feb 2022 09:39:50 +0000 (UTC)
Received: from localhost (unknown [10.39.193.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90BBE6C196;
        Wed,  9 Feb 2022 09:39:34 +0000 (UTC)
Date:   Wed, 9 Feb 2022 09:38:32 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 5/5] virtio_blk: simplify refcounting
Message-ID: <YgOLmLOCNZQS3EYG@stefanha-x1.localdomain>
References: <20220209082121.2628452-1-hch@lst.de>
 <20220209082121.2628452-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cXxZwQ9bZyPfG1Md"
Content-Disposition: inline
In-Reply-To: <20220209082121.2628452-6-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--cXxZwQ9bZyPfG1Md
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 09, 2022 at 09:21:20AM +0100, Christoph Hellwig wrote:
> Implement the ->free_disk method to free the virtio_blk structure only
> once the last gendisk reference goes away instead of keeping a local
> refcount.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 74 +++++++++++---------------------------
>  1 file changed, 21 insertions(+), 53 deletions(-)

Thanks!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cXxZwQ9bZyPfG1Md
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmIDi5cACgkQnKSrs4Gr
c8g2sAgAp/NAAO/juuKgvBUzwYfw+VgLihgtcRdyhBUc5WnO+Aev/sb2TqEGOP5c
UzY4CDswetq1vNZ9WitzwDaseUPVipRQtooSPmJwRFfLj2PQPeB/6MdLQljq4F67
CIjaudo4PEP1jXUkX8dmaTpx8R0pfF7MGRHI759J5/6hWntvd0P7GQaiGU8EzHJh
P5CA2pJvoXn5czUsigfT7DXqOEmRExrrNk2CnhATs/LQ49xLiDwEi5ysXMhNxKeR
4VTbRo6WiONe1hpT71b0g199I0/4o2o9rLy1kCaqMjUKZetL2q7UeqCBFuBWpFgp
X5DGkOtiZp8xt56ZheqqWQjrE8uuBA==
=7zac
-----END PGP SIGNATURE-----

--cXxZwQ9bZyPfG1Md--

