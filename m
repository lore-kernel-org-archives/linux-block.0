Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3303C4332F
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 19:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiLTTw0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 14:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiLTTwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 14:52:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DDD186F4
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 11:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671565896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BGc57pMu8PZQqKa78AS39aQQLkuWJYOqorRpGd4QEMU=;
        b=Y+JTN7SICkffnApjtVW6fTZ6AhglIGDNYmDwCh8LlmH/fRENjvHCld1w2Jrh2fd0yDnr1D
        OgY4ApLjdTBz5CX8o88PnBERYGcVj/wZl8CH5dM9vaadRexKlXLosS/7wOk6DyRsNHhDqU
        HpSujZI1wq2pFM/8rggkbxzcL4WP9+w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-xyGbolVIP0KzXT-6k4ZI5g-1; Tue, 20 Dec 2022 14:51:31 -0500
X-MC-Unique: xyGbolVIP0KzXT-6k4ZI5g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBB8E282380B;
        Tue, 20 Dec 2022 19:51:30 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47F98492B00;
        Tue, 20 Dec 2022 19:51:29 +0000 (UTC)
Date:   Tue, 20 Dec 2022 14:51:28 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: temporary variable type tweak
Message-ID: <Y6ISQGnxdW7RB0sN@fedora>
References: <20221220124152.523531-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="imwUiy+yiKAqjoRf"
Content-Disposition: inline
In-Reply-To: <20221220124152.523531-1-mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--imwUiy+yiKAqjoRf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 07:41:53AM -0500, Michael S. Tsirkin wrote:
> virtblk_result returns blk_status_t which is a bitwise restricted type,
> so we are not supposed to stuff it in a plain int temporary variable.
> All we do with it is pass it on to a function expecting blk_status_t so
> the generated code is ok, but we get warnings from sparse:
>=20
> drivers/block/virtio_blk.c:326:36: sparse: sparse: incorrect type in init=
ializer (different base types) @@     expected int status @@
> +got restricted blk_status_t @@
> drivers/block/virtio_blk.c:334:33: sparse: sparse: incorrect type in argu=
ment 2 (different base types) @@     expected restricted
> +blk_status_t [usertype] error @@     got int status @@
>=20
> Make sparse happy by using the correct type.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--imwUiy+yiKAqjoRf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmOiEkAACgkQnKSrs4Gr
c8jYogf/S4jEFrznpo8+c66way8ejJTXmDDq3YtWCOVGDr3f6q+0sxNxmhnHAn+z
rEK7ByQtnH/ZRSo7mfJ+cnmViSwkm5fCrykdm0w6sh5DiaZlHfWdp/cAS2ZggOej
v3dQUnrTvDZhkFLbRshy+G20T7b3wqCP0sU/IHw3MMW9iobl6Utv5dfsvD38Dz2+
X5OjBuFs2oTHu+M9jSMJU7/rmxEQtbnMIY0UlguKfDCZmzRUWoEd/AD+zDxBmcTa
IQft81vadyNZnOE+LlC1xsY3pxqm38EgB23X+YY1ctTSw0LGjLJjKeXdZYJ353NY
0TwIr9eWgbHUS4Lbcq0fHhKY0RfVOg==
=6ckR
-----END PGP SIGNATURE-----

--imwUiy+yiKAqjoRf--

