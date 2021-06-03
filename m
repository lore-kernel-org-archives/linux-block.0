Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64DBC47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA978613E3
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 14:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhFCPB0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 11:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231411AbhFCPB0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Jun 2021 11:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622732381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ADu76+p4nf9ImDidUf9vbCKDqxKYVQlnVlPUSkX62Eo=;
        b=aiCyjwzzhHCRp3w4WGq0zpty53rV4zTffQJt2mTpzpDHjMkT+B8qxRaa4weDaPIFkv7G1e
        3Cir9KieSJ60QIZAjbT4+yNFQN17Oe7Z8KMJGCsPm/w+h7bbiP5ulKkc/V+f38JcLSzx73
        G5af81ND1RwVcz+CoTwhhx6a8IbjffI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-__Uq8riSP36JWWtMS6wYyg-1; Thu, 03 Jun 2021 10:59:35 -0400
X-MC-Unique: __Uq8riSP36JWWtMS6wYyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44E2780EDAA;
        Thu,  3 Jun 2021 14:59:34 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1C5A5D6AB;
        Thu,  3 Jun 2021 14:59:30 +0000 (UTC)
Date:   Thu, 3 Jun 2021 15:59:29 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-block@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
        Christoph Hellwig <hch@lst.de>, jasowang@redhat.com
Subject: Re: [PATCH v2] virtio-blk: limit seg_max to a safe value
Message-ID: <YLjuUdNN9CGnOPkd@stefanha-x1.localdomain>
References: <20210524154020.98195-1-stefanha@redhat.com>
 <20210524164202-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2Z67iQIxteW+CnbL"
Content-Disposition: inline
In-Reply-To: <20210524164202-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--2Z67iQIxteW+CnbL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 24, 2021 at 04:47:37PM -0400, Michael S. Tsirkin wrote:
> On Mon, May 24, 2021 at 04:40:20PM +0100, Stefan Hajnoczi wrote:
> > The struct virtio_blk_config seg_max value is read from the device and
> > incremented by 2 to account for the request header and status byte
> > descriptors added by the driver.
> >=20
> > In preparation for supporting untrusted virtio-blk devices, protect
> > against integer overflow and limit the value to a safe maximum.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > v2:
> >  * Limit to a virtio-specific value instead of using SG_MAX_SEGMENTS
> >    [Christoph]
> > ---
> >  drivers/block/virtio_blk.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index b9fa3ef5b57c..1635d4289202 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -21,6 +21,9 @@
> >  #define VQ_NAME_LEN 16
> >  #define MAX_DISCARD_SEGMENTS 256u
> > =20
> > +/* The maximum number of sg elements that fit into a virtqueue */
> > +#define VIRTIO_BLK_MAX_SG_ELEMS 32768
>=20
> 32768 is what it says for split queues but for packed queues
> it says 2^15.
>=20
> So 0x8000 then?

Yes.

2^15 =3D 0x8000 =3D 32768

> > +
> >  static int major;
> >  static DEFINE_IDA(vd_index_ida);
> > =20
> > @@ -728,7 +731,10 @@ static int virtblk_probe(struct virtio_device *vde=
v)
> >  	if (err || !sg_elems)
> >  		sg_elems =3D 1;
> > =20
> > -	/* We need an extra sg elements at head and tail. */
>=20
> s/an extra/extra/

That line is being removed by this patch :).

--2Z67iQIxteW+CnbL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC47lEACgkQnKSrs4Gr
c8jCdAf9ExoKopvbspJTdbq/1GnyoPZzQWa0pCvWFLL3/ujutt1lGChMGTJCLT6v
R0i1kZzc7TJJc59nA2VyFIkYN0l4IWe5ab2dl296zeBExD6Yj1f/a2/sxqG5ih2J
lljY1gVEHDzh1xISfE0ZGNman02FoFxRppOR/5aCrGLySvF+vI23PHFEP/BV00AN
9WUihDm7ocaMQJq48asMJCjPWeY93eipmr37qJgs4OgWNc7nzbRAfSGhhjoIXRfR
bdQYgg8kvKgUWq3xyxwE92mOKT6fiWzf49LuipxTSX1QbjKA95YParjuxlTbDx6D
FGn8Rq/Fig6vlEL1s+DOwrpVCsYwYw==
=Dx9Z
-----END PGP SIGNATURE-----

--2Z67iQIxteW+CnbL--

