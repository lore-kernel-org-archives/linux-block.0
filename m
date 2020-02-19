Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF03C34056
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 17:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6842E24670
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 17:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drYbqUA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgBSR6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:58:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33793 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726609AbgBSR6I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 12:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582135087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=osE6Os536TzWa3Iu36fjeW3PyeJPL+4fg4AlWyJ2Fe8=;
        b=drYbqUA1xg3lpJxhAz5S6eh0DMSDTZVRycjQDl28eeWPmrk0QuwGSWlTUscQ84DLRvypYn
        pwLyFsDiro18/y8He0somEQUUR+FX1m5wLMwhroTYayZmZAmQ3QKgV2UyHSwwYA3sLcedR
        UFtv5XZIPNXuOhVDgIBshJWe7q24Ir4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-Bt2leHTQP2q-fUD22d082g-1; Wed, 19 Feb 2020 12:57:59 -0500
X-MC-Unique: Bt2leHTQP2q-fUD22d082g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1470D100550E;
        Wed, 19 Feb 2020 17:57:57 +0000 (UTC)
Received: from localhost (unknown [10.36.118.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE60648;
        Wed, 19 Feb 2020 17:57:53 +0000 (UTC)
Date:   Wed, 19 Feb 2020 15:11:34 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 0/2] virtio-blk: improve handling of DMA mapping failures
Message-ID: <20200219151134.GI1078625@stefanha-x1.localdomain>
References: <20200213123728.61216-1-pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200213123728.61216-1-pasic@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zqjkMoGlbUJ91oFe"
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 01:37:26PM +0100, Halil Pasic wrote:
> Two patches are handling new edge cases introduced by doing DMA mappings
> (which can fail) in virtio core.
>=20
> I stumbled upon this while stress testing I/O for Protected Virtual
> Machines. I deliberately chose a tiny swiotlb size and have generated
> load with fio. With more than one virtio-blk disk in use I experienced
> hangs.
>=20
> The goal of this series is to fix those hangs.
>=20
> Halil Pasic (2):
>   virtio-blk: fix hw_queue stopped on arbitrary error
>   virtio-blk: improve virtqueue error to BLK_STS
>=20
>  drivers/block/virtio_blk.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
>=20
> base-commit: 39bed42de2e7d74686a2d5a45638d6a5d7e7d473
> --=20
> 2.17.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zqjkMoGlbUJ91oFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5NUCYACgkQnKSrs4Gr
c8j5Pgf+MI41fd9a93cz9zlmiW7E/b+B99Zg/shlPYBcQXo0INymDnvknnpzLpqK
uHn5ZGq85kM6+ls29Zhh4w7bxiJlBBNRzCkIIRxe5CwyOptQPcKHONreD1suCGT0
boXaZtrbU1Wt1bWRBK4F9OLZcyIFxUESQ36b1r1VddZsKeFETUXAwjpSEU9bVCZ6
qJfDp9RLYVvFISB17avVnsqyw8xO9mVI3RyIdzQATERL9W3DVxaacULruMmlBHvq
T3nt4WcQjbTHEmTjvpnwGg2Oz4uvaRGm617bv082XAOP+Xr0h9uNU119WKCYk1Qk
VML23VMN5owhMcib+gUXV3/9bQQkYQ==
=GsRc
-----END PGP SIGNATURE-----

--zqjkMoGlbUJ91oFe--

