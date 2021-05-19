Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0927C433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE39260FF2
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbhESIly (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 04:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245508AbhESIlx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 04:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621413634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mkN+A85lgPrZH7VDKRYNCAvAEYR/ajMf5DcgfkGKIgw=;
        b=bd0Se5zngARryTdHez3LxRqmm9e8cMKyufUa8oH++NYM0lilhFMhODXm/EtZWVIoCjb+3V
        xvFlecwQi2U096UMRdj/4pisYhVKQg9irqw8jCi7J8N9l2tT+1HunKmL/9vHNzsqSc+soC
        /StTW4E/3hGJkHroREgKT8Kl2kM6YHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-yJumr082P4qa-broKF928w-1; Wed, 19 May 2021 04:40:30 -0400
X-MC-Unique: yJumr082P4qa-broKF928w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74BC41009461;
        Wed, 19 May 2021 08:40:29 +0000 (UTC)
Received: from localhost (ovpn-114-43.ams2.redhat.com [10.36.114.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ED90100AE43;
        Wed, 19 May 2021 08:40:22 +0000 (UTC)
Date:   Wed, 19 May 2021 09:40:21 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, jasowang@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] virtio-blk: limit seg_max to a safe value
Message-ID: <YKTO9QKwoyu/F3x9@stefanha-x1.localdomain>
References: <20210518150415.152730-1-stefanha@redhat.com>
 <20210519075702.GA4225@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7A5I70D1oyKhPVJl"
Content-Disposition: inline
In-Reply-To: <20210519075702.GA4225@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--7A5I70D1oyKhPVJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 19, 2021 at 09:57:02AM +0200, Christoph Hellwig wrote:
> On Tue, May 18, 2021 at 04:04:15PM +0100, Stefan Hajnoczi wrote:
> > +	/* Prevent integer overflows and excessive blk-mq req cmd_size */
> > +	sg_elems =3D min_t(u32, sg_elems, SG_MAX_SEGMENTS);
>=20
> Please pick your own constant here instead of abusing some kernel
> implementation detail (that is fairly SCSI specific to start with).
>=20
> It might be useful to also document such limits, even if just advisory,
> in the virtio spec.

Thanks, will fix in v2.

Stefan

--7A5I70D1oyKhPVJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCkzvUACgkQnKSrs4Gr
c8jZ2ggAtRDUVNUuSa7GZlkBGW3Jt+cNcp5td6zNyQOpRt404CS9vChCtW11BF2X
8WjVnZrFCAWl9MQqS3RWHuOwIAGR54K2qmfZUdt4Jod2e/I2DTwvpj0iegQWkUeK
jtX1mWC1rrwm50rgOYVHm5QbAjauiluMeQiUxxsOz48KakUj8Dc2wZ7HoxALpaM9
garoxKh2pwqR5jiO8QqNQOmM/mIFMepBPn32x4JYZHqRCoogsyjW8xFB1mlwZ0Q6
ozyLLSMIXHZXYieRyKdUSmfWqWdZ3hC+nyKO3kJvnJQdR8d62BC3MsVqhlfyXiRK
KD/STf4CTMi0HvPMgYwIU1VVmR/pLA==
=GkU9
-----END PGP SIGNATURE-----

--7A5I70D1oyKhPVJl--

