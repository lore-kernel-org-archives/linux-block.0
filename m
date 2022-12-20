Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA9C4332F
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 19:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiLTTvp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 14:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiLTTvn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 14:51:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAB51A38F
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 11:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671565857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6dJi8OKv/lfpiYHlxZQhWkr2Fn+pTTwnDKMiC+l7rhY=;
        b=aKEK1lGiizWtm0nKEvlxtd7IGX5rM4kyK6LGG7DU7sxPZ9bFKVF+UJxowbfpryG0AprlyX
        p8PjzxpjEbOs621GcrtH2DEbdqU/idW/bUQyb4fhv9g1lf/QrciM461ktf0yTgRDmcqzK9
        a1x4PoUQTb92QBy8HS2GhOgoK7B3E7s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-YJEg4p33N7yafxArripUdA-1; Tue, 20 Dec 2022 14:50:53 -0500
X-MC-Unique: YJEg4p33N7yafxArripUdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD541857A8A;
        Tue, 20 Dec 2022 19:50:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 355F7112132C;
        Tue, 20 Dec 2022 19:50:51 +0000 (UTC)
Date:   Tue, 20 Dec 2022 14:50:50 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: fix probe without CONFIG_BLK_DEV_ZONED
Message-ID: <Y6ISGqiSzK2WQi5G@fedora>
References: <20221220112340.518841-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qs7BktVcbA5Ws00G"
Content-Disposition: inline
In-Reply-To: <20221220112340.518841-1-mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--qs7BktVcbA5Ws00G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 06:23:44AM -0500, Michael S. Tsirkin wrote:
> When building without CONFIG_BLK_DEV_ZONED, VIRTIO_BLK_F_ZONED
> is excluded from array of driver features.
> As a result virtio_has_feature panics in virtio_check_driver_offered_feat=
ure
> since that by design verifies that a feature we are checking for
> is listed in the feature array.
>=20
> To fix, replace the call to virtio_has_feature with a stub.
>=20
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qs7BktVcbA5Ws00G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmOiEhoACgkQnKSrs4Gr
c8j1sAgArFbeE12ThS17C8bvQ/gd4ePFCbYmOiFcuTrQZ4fBWVzD6K2vGZhTWrRT
O5EJiIzBGTdeoWGg/BuhYXddcyXimSyiwBRQquawn5IIKeleNtODdiWT3dZOAiW6
ZEfTlKRGSjqSVWKkEiL943KRQ8Y3RYSGzu2pHNRgB2AieQmjX1hAjNj3WzhM/Emy
tKJr+R4FhEqfZF7i9x4fTAHQeyjgJWyY3m57yJ+Im0mxxiiQhufIKNeLDNSp2N5T
4z8XvTj81aLfQPtOeAppVdNetBBo2fS8Dzj7r+O0YfKRCPufHUILGnyU7SrnMpJ4
Tkt5GDbZi9cxlMFD2te/Vhs5RK/o4w==
=rcjH
-----END PGP SIGNATURE-----

--qs7BktVcbA5Ws00G--

