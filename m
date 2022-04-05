Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4358C4321E
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 09:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiDEJfO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345110AbiDEJWQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 05:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1088F1CFF6
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649149753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAS2zJr4RGhhYKW10JCPapfDFJYlad7vSeh9SuK0g88=;
        b=Mds0CZPgYCozHD5I9Ad25TGNWSaEOzA0a68xep5a8mj7XzWAB2xF7VpCTkU6qTuINbw1oR
        RSei2EIB1e2jucMzj5O6MuEqrMaIA9c4+A/6ZR+CapIttmAjK1gvEVwFePX5uuiFXWxvRg
        6OshEzsALoaBcUgF9jlA8i3r6dCJPsY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-M2v2-9cAOZyN3mBC6TGFTQ-1; Tue, 05 Apr 2022 05:09:02 -0400
X-MC-Unique: M2v2-9cAOZyN3mBC6TGFTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C04733801ECE;
        Tue,  5 Apr 2022 09:09:01 +0000 (UTC)
Received: from localhost (unknown [10.39.193.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F993145F949;
        Tue,  5 Apr 2022 09:09:01 +0000 (UTC)
Date:   Tue, 5 Apr 2022 10:09:00 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <YkwHLFrWKJXn02gL@stefanha-x1.localdomain>
References: <20220405053122.77626-1-suwan.kim027@gmail.com>
 <20220405053122.77626-3-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TccE7CylT9ec6Nxl"
Content-Disposition: inline
In-Reply-To: <20220405053122.77626-3-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--TccE7CylT9ec6Nxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 05, 2022 at 02:31:22PM +0900, Suwan Kim wrote:
> This patch supports mq_ops->queue_rqs() hook. It has an advantage of
> batch submission to virtio-blk driver. It also helps polling I/O because
> polling uses batched completion of block layer. Batch submission in
> queue_rqs() can boost polling performance.
>=20
> In queue_rqs(), it iterates plug->mq_list, collects requests that
> belong to same HW queue until it encounters a request from other
> HW queue or sees the end of the list.
> Then, virtio-blk adds requests into virtqueue and kicks virtqueue
> to submit requests.
>=20
> If there is an error, it inserts error request to requeue_list and
> passes it to ordinary block layer path.
>=20
> For verification, I did fio test.
> (io_uring, randread, direct=3D1, bs=3D4K, iodepth=3D64 numjobs=3DN)
> I set 4 vcpu and 2 virtio-blk queues for VM and run fio test 5 times.
> It shows about 2% improvement.
>=20
>                                  |   numjobs=3D2   |   numjobs=3D4
>       -----------------------------------------------------------
>         fio without queue_rqs()  |   291K IOPS   |   238K IOPS
>       -----------------------------------------------------------
>         fio with queue_rqs()     |   295K IOPS   |   243K IOPS
>=20
> For polling I/O performance, I also did fio test as below.
> (io_uring, hipri, randread, direct=3D1, bs=3D512, iodepth=3D64 numjobs=3D=
4)
> I set 4 vcpu and 2 poll queues for VM.
> It shows about 2% improvement in polling I/O.
>=20
>                                       |   IOPS   |  avg latency
>       -----------------------------------------------------------
>         fio poll without queue_rqs()  |   424K   |   613.05 usec
>       -----------------------------------------------------------
>         fio poll with queue_rqs()     |   435K   |   601.01 usec
>=20
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 110 +++++++++++++++++++++++++++++++++----
>  1 file changed, 99 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TccE7CylT9ec6Nxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJMBywACgkQnKSrs4Gr
c8grSQgAman3xRuQCT/MEKpDKENDYNmeSdt/bb5ZMZTpYYsVCFmEyf9yMli6wbeb
BzRIo1ibq12uEwYvTpr4xAt7QbXeAfpazh74FSdFyOsEiaxhAWaE8lrHvD+PYHt8
bExnX+rFjS8kLvtsizGI0urDn6JjRrbYjbAmgcKV8byHXFZGo/M1/B02hJ1unzcP
A0QRlvhbAfloAXLgmcj79BkuXox+XsYzzImGfWykTdTRRLq9VNBqrym3qkUlvsDJ
A2V48hKhP1U+5mOMpKJwnpJCSCP4z7+G61mpbVcF7FxKG5RJjei29JXl3dmVYXRE
nRjVI1eXcSKScD5FKh12WuBF0npczw==
=oety
-----END PGP SIGNATURE-----

--TccE7CylT9ec6Nxl--

