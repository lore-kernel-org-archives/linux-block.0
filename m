Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1751C433F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 15:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbhKXPl2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:41:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231860AbhKXPlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 10:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637768295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46y3rdu6iUG1CYH2wKUqw8yXte9uDTkV/SHmghHQmB8=;
        b=OwXW7mDsLNB3+zrqhqg81hLKfxHXsQ4Uchm208QvNHNqBJe+Qv255dkfQDFsIrmCfyBHeP
        hGlGLpnmyR/ThAkYTmoIQdzk9HyZQrosYc6axyznpLvv0Z94WpHwSSAFwBkuiRM0YpuS0y
        dzI9v84fDOqjW25aAgpHpT1Bv9rZt2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-409-CEOnUjgdP3ulP_N-adU-Ig-1; Wed, 24 Nov 2021 10:38:12 -0500
X-MC-Unique: CEOnUjgdP3ulP_N-adU-Ig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 909C91800D41;
        Wed, 24 Nov 2021 15:38:10 +0000 (UTC)
Received: from localhost (unknown [10.39.195.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB99A79457;
        Wed, 24 Nov 2021 15:37:57 +0000 (UTC)
Date:   Wed, 24 Nov 2021 15:37:56 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     cgel.zte@gmail.com
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        axboe@kernel.dk, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] virtio-blk: modify the value type of num in
 virtio_queue_rq()
Message-ID: <YZ5cVCy+bdvdcgxc@stefanha-x1.localdomain>
References: <20211117063955.160777-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4qNBzmFiqXAJam7g"
Content-Disposition: inline
In-Reply-To: <20211117063955.160777-1-ye.guojin@zte.com.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--4qNBzmFiqXAJam7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 06:39:55AM +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
>=20
> This was found by coccicheck:
> ./drivers/block/virtio_blk.c, 334, 14-17, WARNING Unsigned expression
> compared with zero  num < 0
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4qNBzmFiqXAJam7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGeXFQACgkQnKSrs4Gr
c8gkVwf/VP0Wcpg/NeC/3ubkg6ohgMgZ1GkS53l+f6cG9/aKWHuGmGvyXrjBXaiU
jFwsVz+f322Ip7s0lFbTlvDhknlv/5jG6Sd6uSAXRYiDS7bU55AazAWtMVe0yaRo
qcoRyogRn20jCrb5t1C/ukBMf4giPeHPY+U4rZCZmlZ3n9JOtPe0KPMA2f0tBMp4
4lj/4O7hlmx3Un9bkskeJ9zfIwLA7K06cQ2u2Cjfiz136Y3gXSMSKBHX/z4+pjAB
bJYlFe0QLQDLhPOB0vocSpeexr/lZjsIDlKH2jo1IE1Y29AXmTKTH2M2BDOMjrRS
mc12UmSpgULbXSygbOVXqEYFnYarog==
=pXYE
-----END PGP SIGNATURE-----

--4qNBzmFiqXAJam7g--

