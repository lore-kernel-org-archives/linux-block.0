Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DA8C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 14:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjC1Owm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjC1OwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 10:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01440C67B
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680015080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/oKKt2DK6bwGN7ndJizhz5+rNpVeV2w9AuWI3HQnFEM=;
        b=hXugKkagfx68RQT7nMdH4KaVOPx5szcikw8WT2abe/UHzGuvYrVgk4OMwjS8jGftgd19X6
        0HHHbctzorWNXMT7X7x+oD0wwFReP7vEJ8PvJjXwP2OrZ6EbsNRL3UuUQLlXyRQ9McT+Me
        C/WzU7UiQzdDLod792YkKL16g8IgHiU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-Y6KFKFGlMjesR4n930Bj6A-1; Tue, 28 Mar 2023 10:51:15 -0400
X-MC-Unique: Y6KFKFGlMjesR4n930Bj6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15E96886469;
        Tue, 28 Mar 2023 14:51:15 +0000 (UTC)
Received: from localhost (unknown [10.39.195.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 345D62166B26;
        Tue, 28 Mar 2023 14:51:13 +0000 (UTC)
Date:   Tue, 28 Mar 2023 10:51:12 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [virtio-dev] [PATCH 2/2] virtio-blk: fix ZBD probe in kernels
 without ZBD support
Message-ID: <20230328145112.GA1623159@fedora>
References: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
 <20230328022928.1003996-3-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UeJ1ldfXW4hAubI9"
Content-Disposition: inline
In-Reply-To: <20230328022928.1003996-3-dmitry.fomichev@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--UeJ1ldfXW4hAubI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 10:29:28PM -0400, Dmitry Fomichev wrote:
> When the kernel is built without support for zoned block devices,
> virtio-blk probe needs to error out any host-managed device scans
> to prevent such devices from appearing in the system as non-zoned.
> The current virtio-blk code simply bypasses all ZBD checks if
> CONFIG_BLK_DEV_ZONED is not defined and this leads to host-managed
> block devices being presented as non-zoned in the OS. This is one of
> the main problems this patch series is aimed to fix.
>=20
> In this patch, make VIRTIO_BLK_F_ZONED feature defined even when
> CONFIG_BLK_DEV_ZONED is not. This change makes the code compliant with
> the voted revision of virtio-blk ZBD spec. Modify the probe code to
> look at the situation when VIRTIO_BLK_F_ZONED is negotiated in a kernel
> that is built without ZBD support. In this case, the code checks
> the zoned model of the device and fails the probe is the device
> is host-managed.
>=20
> The patch also adds the comment to clarify that the call to perform
> the zoned device probe is correctly placed after virtio_device ready().
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  drivers/block/virtio_blk.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UeJ1ldfXW4hAubI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQi/uAACgkQnKSrs4Gr
c8iXUQf/XeQDhMQwhrkmGbNhqXJTGDOpHG9MFxMuLAyseS0nCgzBwHREd3ta3ZJH
o7wCIYOoCpVJLBEbYT3DswgL8YZvW9kAQd9TTiVSILN7lO1ZuLrTzopS0dUCofKK
CTsfVp5RwR+kmDr0nsZR/l4O6GMP1IuNv0ZLxMu10YuQZWO9pzJYbIaEA7K2J88G
3cfMF5TnrcIfPMsOBJPLiLDW6npuvY9ch9A+MFLawmMl9bLJYZHYNN5esmkmbsH/
1OXRs/vSK3RFUaBmCzVfupCq6p8hI7NeoHNVHosLb0zwuTowF7ooz40oJqCmSzPT
v5VAggpWBRbOcOz6UOz0Vjwa5dVlVQ==
=w94Z
-----END PGP SIGNATURE-----

--UeJ1ldfXW4hAubI9--

