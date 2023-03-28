Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93468C76196
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 14:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjC1OxG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjC1Owu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 10:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C791DBDE
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680015112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0cR29LyY11JQFvMX2a2zTEiw5p1+i0O8ayeeXYSH/LE=;
        b=jDOMVVCUfPwxRPibzQ319qhI+8/YENW0pXbgmDcyhBiO5sCilpru32b0CsQlvboBo0Z1ZF
        5WkPo2+sbm+i/q/l2V48NYOBQ7l3wuc9AFkoW77ViMv0g75rrKHiDAd3T9Y0++CD4GSk9c
        lo5IuGkkQkUrPeG9IkziSPpXbdSzZUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-RPfPPF6wPLmSOhF3zAx9_w-1; Tue, 28 Mar 2023 10:51:48 -0400
X-MC-Unique: RPfPPF6wPLmSOhF3zAx9_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64D4685A5B1;
        Tue, 28 Mar 2023 14:51:47 +0000 (UTC)
Received: from localhost (unknown [10.39.195.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D51B51121330;
        Tue, 28 Mar 2023 14:51:46 +0000 (UTC)
Date:   Tue, 28 Mar 2023 10:51:45 -0400
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
Subject: Re: [virtio-dev] [PATCH 1/2] virtio-blk: migrate to the latest
 patchset version
Message-ID: <20230328145145.GB1623159@fedora>
References: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
 <20230328022928.1003996-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W+f9eOPTmKJwgc15"
Content-Disposition: inline
In-Reply-To: <20230328022928.1003996-2-dmitry.fomichev@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--W+f9eOPTmKJwgc15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 10:29:27PM -0400, Dmitry Fomichev wrote:
> The merged patch series to support zoned block devices in virtio-blk
> is not the most up to date version. The merged patch can be found at
>=20
> https://lore.kernel.org/linux-block/20221016034127.330942-3-dmitry.fomich=
ev@wdc.com/
>=20
> , but the latest and reviewed version is
>=20
> https://lore.kernel.org/linux-block/20221110053952.3378990-3-dmitry.fomic=
hev@wdc.com/
>=20
> The differences between the two are mostly cleanups, but there is one
> change that is very important in terms of compatibility with the
> approved virtio-zbd specification.
>=20
> Before it was approved, the OASIS virtio spec had a change in
> VIRTIO_BLK_T_ZONE_APPEND request layout that is not reflected in the
> current virtio-blk driver code. In the running code, the status is
> the first byte of the in-header that is followed by some pad bytes
> and the u64 that carries the sector at which the data has been written
> to the zone back to the driver, aka the append sector.
>=20
> This layout turned out to be problematic for implementing in QEMU and
> the request status byte has been eventually made the last byte of the
> in-header. The current code doesn't expect that and this causes the
> append sector value always come as zero to the block layer. This needs
> to be fixed ASAP.
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  drivers/block/virtio_blk.c      | 238 +++++++++++++++++++++-----------
>  include/uapi/linux/virtio_blk.h |  18 +--
>  2 files changed, 165 insertions(+), 91 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--W+f9eOPTmKJwgc15
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQi/wEACgkQnKSrs4Gr
c8imZggAhJA5G85LLc28etjnXDmkF7WtvrUc4MoHpgxVUys1SEaxhlmAsh+EIrd5
oSIHcBTkAv6xkMA44ogTyq+Ewl0J4e8Ma46s+HE9Pn0XXuHpOZKeVxJxLvyYUkkS
9RbxlExUCi68vdHy4JKqS8u+iisGRILKXCu06B5Ce3wD1o07kuvYlkZcOKyaJMUs
1Z1ifmiTphIsUT7KHMJ13GsR1QhgBr0+1LH2uCTJu8faD3UGGTJHtH9r+wmFVKbt
AKQ7DsQuhIUfreukTh4AOK1LOAjTgtNyf9mhkQl4js1KkKKoiedxmGqVV9RlHbZw
WFTFCtcjbgVhBQi4SvLAlAgy0yC++g==
=KqDZ
-----END PGP SIGNATURE-----

--W+f9eOPTmKJwgc15--

