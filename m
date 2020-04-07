Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D49C2BA16
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 08:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B3020748
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 08:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHqsYupL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDGIvb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:51:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725817AbgDGIvb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Apr 2020 04:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586249490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jykHO/SKPEfQgLiTVDsBlq5E9x7OAuQZbAht/mZ4Uik=;
        b=fHqsYupLnRTlUhY55L3qFm8pdRsImgQnKq5hG6jFNmnWjkvD49Uxh8FeqbpyAhPot4AGiB
        gzAGX2DxDUId8p/sKluL9eMDZV13Wqqe0+KMkfvkpDTE7b9QjGZeSGtOZt1nomsPHVqK0k
        NE5yeV3zrwDGAc4sonNL1wHeAo9KuTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-FiAM1shJMnep_9mw09IkHA-1; Tue, 07 Apr 2020 04:51:28 -0400
X-MC-Unique: FiAM1shJMnep_9mw09IkHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54C161005513;
        Tue,  7 Apr 2020 08:51:27 +0000 (UTC)
Received: from localhost (ovpn-113-168.ams2.redhat.com [10.36.113.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB08BCDBCA;
        Tue,  7 Apr 2020 08:51:24 +0000 (UTC)
Date:   Tue, 7 Apr 2020 09:51:23 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v8 09/19] virtio: stop using legacy struct vring in kernel
Message-ID: <20200407085123.GA247777@stefanha-x1.localdomain>
References: <20200407011612.478226-1-mst@redhat.com>
 <20200407011612.478226-10-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200407011612.478226-10-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 09:16:46PM -0400, Michael S. Tsirkin wrote:
> struct vring (in the uapi directory) and supporting APIs are kept
> around to solely avoid breaking old userspace builds.
> It's not actually part of the UAPI - it was kept in the UAPI
> header by mistake, and using it in kernel isn't necessary
> and prevents us from making changes safely.
> In particular, the APIs actually assume the legacy layout.
>=20
> Add an internal kernel-only struct vring and
> switch everyone to use that.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c       |  1 +
>  include/linux/virtio.h           |  1 -
>  include/linux/virtio_ring.h      | 10 ++++++++++
>  include/linux/vringh.h           |  1 +
>  include/uapi/linux/virtio_ring.h | 26 ++++++++++++++++----------
>  5 files changed, 28 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6MPwoACgkQnKSrs4Gr
c8i4iwf/bOwj2ZidNGGENtcVu7gvojGcqqZUH3YTJ7iTnAiBQzurGIHN6p9vGEal
2cS8Jb9OuArHQhIfm5M/AaSzNa3zmy8D9l2tWRVFAooBSK40l4Q10e5EUkybhClw
ITad9nQtPO0n0IGfFGrJasavS7MBhBJw/7wqNtzkHIxq3I86MKA9aLdefTGmkMVp
+PJjhgvzRzjtmbHL/wIu9+bVEFEmMOIjTgHaOoaYvStvVmOqKEOtoiyyb/hormmM
yLJJOmq4zMKsjpKYeQB4wmFDKtXheVRFrRPASciZEMRS8+dPVBRq7QzzWUdG1Awq
edDSidc+l3t9UZBO/tsqBqQQSC6YNQ==
=wat3
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

