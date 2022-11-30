Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA02AC4321E
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 20:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiK3Uw3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 15:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiK3Uw3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 15:52:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824054B34
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 12:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669841492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CQgAOvEZVM6ximlp/shF5gDfXHjOpS9Wecui6IHnldg=;
        b=G3ejfLXN4J9vsFOCa4F3sB1FODGqosRXpzL4z5oAycR7dWsxFvpu6N0SHn/0X2YX3iAgP2
        /QhOuRWiXbAdIDKgtGSz414BRGNjsUQjRrpgvIWIS574jkzs2PEAeI/lW/FA+TivNYitCv
        PikeRR1wngcDAG4d4+POfVWAWmqb2Vc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-DB69oWysORGQKIlKbJtf0A-1; Wed, 30 Nov 2022 15:51:29 -0500
X-MC-Unique: DB69oWysORGQKIlKbJtf0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 983D485A5B6;
        Wed, 30 Nov 2022 20:51:28 +0000 (UTC)
Received: from localhost (unknown [10.39.192.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F03BFC15BB4;
        Wed, 30 Nov 2022 20:51:27 +0000 (UTC)
Date:   Wed, 30 Nov 2022 15:51:23 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     pbonzini@redhat.com, jasowang@redhat.com, mst@redhat.com,
        gost.dev@samsung.com, Pankaj Raghav <pankydev8@gmail.com>,
        axboe@kernel.dk, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] virtio-blk: replace ida_simple[get|remove] with
 ida_[alloc_range|free]
Message-ID: <Y4fCS2d2r1YvSExI@fedora>
References: <CGME20221130123126eucas1p2cd3287ee4e5c03642f1847c50af0e4f2@eucas1p2.samsung.com>
 <20221130123001.25473-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nHTxRgQR67n6DBCs"
Content-Disposition: inline
In-Reply-To: <20221130123001.25473-1-p.raghav@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--nHTxRgQR67n6DBCs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2022 at 01:30:03PM +0100, Pankaj Raghav wrote:
> ida_simple[get|remove] are deprecated, and are just wrappers to
> ida_[alloc_range|free]. Replace ida_simple[get|remove] with their
> corresponding counterparts.
>=20
> No functional changes.
>=20
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/block/virtio_blk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Chaitanya proposed a similar patch in the past:
https://lore.kernel.org/all/20220420041053.7927-5-kch@nvidia.com/

Your patch calculates the max argument correctly. Looks good.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nHTxRgQR67n6DBCs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmOHwksACgkQnKSrs4Gr
c8gQuAf9H2mnAIrELNShopJ32U5cjYPwqU2Bu2qZ5RfQxU83eCwJp7kyw922O4ng
AOEQx/BV8cXytlv54kXWF2h4AKOAB/vGiIu1yZgF/Bfos9z8mKc9zjgV9G4vdKwf
NTKrINoBHl1NnSiTDKrA/i1s4rgHU8asU7GcfO0UpX+QBKhM5gG3QYBw6zU4eD2x
9lQ6S8DIvY16upOMwynUSiZ8ltUVAyBuRq6REZ5H0JtBz6nwvgLR+o344iVDxF6M
Cl7oWdVVBslv2R+ExTo9zQW8naerHkFGIqrsTKcTcgIPEaVexyL95FcTB7g49wOV
cfqQpZ04GJz3eDUDd59UWXlcDmcc3w==
=SjCs
-----END PGP SIGNATURE-----

--nHTxRgQR67n6DBCs--

