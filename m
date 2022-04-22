Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D272DC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Apr 2022 08:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiDYI0C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 04:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiDYIZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 04:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85EE51CB2B
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650874937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pSx9DFRN+NXzO8KvmEpZt/ZmLB7PjIvaUwAyvIlr/DI=;
        b=AFspNctmlC1K8DTOPdLk8UpIAqIIym+IAqQfj/xdZydLZgnk0cixVt2/Wkx0aEZjowqjDi
        QMjU6ShVy/FLc6SQEBUebR/pmbSUk/BUQ25qeM1ZvO23ifTZQ+6bTNRg3JpMVLBsBNAM3U
        jYbQb2bqQLuF+9nZGIxbQUfOLVwAEF0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-cp8a_Ih8M3q73QxAWEZlxg-1; Mon, 25 Apr 2022 04:22:12 -0400
X-MC-Unique: cp8a_Ih8M3q73QxAWEZlxg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1993783396B;
        Mon, 25 Apr 2022 08:22:09 +0000 (UTC)
Received: from localhost (unknown [10.39.192.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5DFF40314F;
        Mon, 25 Apr 2022 08:22:08 +0000 (UTC)
Date:   Fri, 22 Apr 2022 15:56:55 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH 0/4] virtio-blk: small cleanup
Message-ID: <YmLCN9EHA9R05xmC@stefanha-x1.localdomain>
References: <20220420041053.7927-1-kch@nvidia.com>
 <6c21dd2d-830a-8842-428e-6fc60966b73e@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g0839ppuCZya34th"
Content-Disposition: inline
In-Reply-To: <6c21dd2d-830a-8842-428e-6fc60966b73e@nvidia.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--g0839ppuCZya34th
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2022 at 09:56:28PM +0000, Chaitanya Kulkarni wrote:
> On 4/19/22 21:10, Chaitanya Kulkarni wrote:
> > Hi,
> >=20
> > This has some nit fixes and code cleanups along with removing
> > deprecated API fir ida_simple_XXX().
> >=20
> > -ck
> >=20
> > Chaitanya Kulkarni (4):
> >    virtio-blk: remove additional check in fast path
> >    virtio-blk: don't add a new line
> >    virtio-blk: avoid function call in the fast path
> >    virtio-blk: remove deprecated ida_simple_XXX()
> >=20
> >   drivers/block/virtio_blk.c | 38 +++++++++++++++++---------------------
> >   1 file changed, 17 insertions(+), 21 deletions(-)
> >=20
>=20
> Thanks for the review, I'll send out a V2 and drop patches that
> lacks the quantitative data..

Thank you!

Stefan

--g0839ppuCZya34th
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJiwjYACgkQnKSrs4Gr
c8jOhQf+NAjIxbIpz49jBiC5oSMiAQdLKLILSvVFZq0bkyFlj+B7kDypj1S8pyEp
vlu/io8j5B8VNVZMjxj8s14OnwQ7e2H1rFrlwLh9uxDz4x4JSZ4d2+XpVuxgXzr7
HZUqWc9nSBbop4XoylU3rr+ASVoUZVi9HRO3cai37kGQrRNt+0L94D1JWWt1UAG5
qAMoQyHfrWA/wK1tcvvHO0i65OuFFwa6vtzyiiNrhnBWkDjU7s3D6qRrahFN41fv
2NsBCqS0seVGF+kDmGxADZqGl2p38uPSz4lkZhDBl//iDkPgn+/Ch363laWq0xWi
gWC1jD+U+9I2/sjh+7jlcnNPKzFTrQ==
=0s2z
-----END PGP SIGNATURE-----

--g0839ppuCZya34th--

