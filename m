Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD03C433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 14:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbiCNOta (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 10:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbiCNOt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 10:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81395304
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647269293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4GMiQH1LonPMifl6a0QGWi66yOtSeKNsLnwJKGhjtJ4=;
        b=IgLHMk1Pv5z4uJtVpYYfKcMC/RwnzHxReXEB/WhxropQDucRsh3yUlT8HI1l0GpeZcqRVw
        2V2LwMatElvJUCBTfCFtOMUp+7jPIAVKPmKyw04nvm5nkTxpVioNcoKYn+/wRam+E4XjU8
        Zkh3UHmQ7yIN5oAfNfi689+xeda72qU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-_AiYtbFCNPSqn4Ye0dIA2g-1; Mon, 14 Mar 2022 10:48:10 -0400
X-MC-Unique: _AiYtbFCNPSqn4Ye0dIA2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07DEA85A5BC;
        Mon, 14 Mar 2022 14:48:09 +0000 (UTC)
Received: from localhost (unknown [10.39.195.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93ACDC33260;
        Mon, 14 Mar 2022 14:48:08 +0000 (UTC)
Date:   Mon, 14 Mar 2022 14:48:07 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <Yi9Vp3+wkpH8VMNU@stefanha-x1.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m9x06S17g2qlOLVa"
Content-Disposition: inline
In-Reply-To: <Yi82BL9KecQsVfgX@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--m9x06S17g2qlOLVa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2022 at 09:33:08PM +0900, Suwan Kim wrote:
> On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
> >=20
> > =E5=9C=A8 2022/3/11 =E4=B8=8B=E5=8D=8811:28, Suwan Kim =E5=86=99=E9=81=
=93:
> > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/vir=
tio_blk.h
> > > index d888f013d9ff..3fcaf937afe1 100644
> > > --- a/include/uapi/linux/virtio_blk.h
> > > +++ b/include/uapi/linux/virtio_blk.h
> > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > >   	 * deallocation of one or more of the sectors.
> > >   	 */
> > >   	__u8 write_zeroes_may_unmap;
> > > +	__u8 unused1;
> > > -	__u8 unused1[3];
> > > +	__virtio16 num_poll_queues;
> > >   } __attribute__((packed));
> >=20
> >=20
> > This looks like a implementation specific (virtio-blk-pci) optimization=
, how
> > about other implementation like vhost-user-blk?
>=20
> I didn=E2=80=99t consider vhost-user-blk yet. But does vhost-user-blk also
> use vritio_blk_config as kernel-qemu interface?
>=20
> Does vhost-user-blk need additional modification to support polling
> in kernel side?

I think QEMU's --device vhost-user-blk-pci will work with this patch
series because QEMU passes the struct virtio_blk_config from the
vhost-user-blk server to the guest. If a new vhost-user-blk server
supports num_poll_queues then the guest will see the config field.

However, the new feature bit that was discussed in another sub-thread
needs to be added to hw/block/vhost-user-blk.c:user_feature_bits[] and
QEMU needs to be recompiled.

Stefan

--m9x06S17g2qlOLVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmIvVacACgkQnKSrs4Gr
c8gNdAf/QqaaX2nmChWxko1xxMTk7lYZ5ul9IpAj5Thd3yrP/UoXspWLVgNJ0DJE
wJGOkll8hsc7/vGALzp7Z3d1ZOnridtMXJvFnsSLzVdLvP7EjKuJ62RdrWZIrezd
Gf52L9Lq1C4UOekVfz2Lv6Sap4ELCLn8xhfkWK1ktb8qMNmsFKl1jXaBpTfZpGUO
17+/oi2P0upSgFN9sYN4hjgnFspCiEJgrTloYpuPCKPkkw+Lh7fu5HTGtF9UiXWN
y5QZqhqTj0jvvLgDZPTazWvr5XPmIACjiSV4w+khaJV3OWDk+EoDgugVzbLiCoFO
rNxlQlEYNOmg6tFXYKg/VduyB5N+LQ==
=L947
-----END PGP SIGNATURE-----

--m9x06S17g2qlOLVa--

