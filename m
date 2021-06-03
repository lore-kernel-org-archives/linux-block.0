Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26A9C47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 15:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1600613EE
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 15:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFCPcW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 11:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229769AbhFCPcW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Jun 2021 11:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622734237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/S1XKe/GM4qQZl4GJJ8xfCrJIwaECIza2brwo279Qw4=;
        b=RWOGJRy3gSpUVaDgRJHkTcqhlPMauyA2wT/xbQAzR+OYCdsvUxa9e28Wpyn+JmU9GBy0Qa
        lXyesmzcTbYNkj7+6+tlqHMv3DqUrmXColwDKa/r2fh+OJrJOzsRB+E1fmOzIpsAuxGPoA
        QrgwkeFJz4Jd+HPF/aQ28PHCDW+ETJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-KdW-98JTOBmvLj354ZUpbg-1; Thu, 03 Jun 2021 11:30:36 -0400
X-MC-Unique: KdW-98JTOBmvLj354ZUpbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96FD780EDB3;
        Thu,  3 Jun 2021 15:30:34 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE1CE10016FC;
        Thu,  3 Jun 2021 15:30:26 +0000 (UTC)
Date:   Thu, 3 Jun 2021 16:30:25 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] virtio_blk: blk-mq io_poll support
Message-ID: <YLj1kUiTTlLm5HwU@stefanha-x1.localdomain>
References: <20210520141305.355961-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B/OddBweazIqrPeI"
Content-Disposition: inline
In-Reply-To: <20210520141305.355961-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--B/OddBweazIqrPeI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2021 at 03:13:02PM +0100, Stefan Hajnoczi wrote:
> This patch series implements blk_mq_ops->poll() so REQ_HIPRI requests can=
 be
> polled. IOPS for 4k and 16k block sizes increases by 5-18% on a virtio-blk
> device with 4 virtqueues backed by an NVMe drive.
>=20
> - Benchmark: fio ioengine=3Dpvsync2 numjobs=3D4 direct=3D1
> - Guest: 4 vCPUs with one virtio-blk device (4 virtqueues)
> - Disk: Intel Corporation NVMe Datacenter SSD [Optane] [8086:2701]
> - CPU: Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz
>=20
> rw          bs hipri=3D0 hipri=3D1
> ------------------------------
> randread    4k 149,426 170,763 +14%
> randread   16k 118,939 134,269 +12%
> randread   64k  34,886  34,906   0%
> randread  128k  17,655  17,667   0%
> randwrite   4k 138,578 163,600 +18%
> randwrite  16k 102,089 120,950 +18%
> randwrite  64k  32,364  32,561   0%
> randwrite 128k  16,154  16,237   0%
> read        4k 146,032 170,620 +16%
> read       16k 117,097 130,437 +11%
> read       64k  34,834  35,037   0%
> read      128k  17,680  17,658   0%
> write       4k 134,562 151,422 +12%
> write      16k 101,796 107,606  +5%
> write      64k  32,364  32,594   0%
> write     128k  16,259  16,265   0%
>=20
> Larger block sizes do not benefit from polling as much but the
> improvement is worthwhile for smaller block sizes.
>=20
> Stefan Hajnoczi (3):
>   virtio: add virtioqueue_more_used()
>   virtio_blk: avoid repeating vblk->vqs[qid]
>   virtio_blk: implement blk_mq_ops->poll()
>=20
>  include/linux/virtio.h       |   2 +
>  drivers/block/virtio_blk.c   | 126 +++++++++++++++++++++++++++++------
>  drivers/virtio/virtio_ring.c |  17 +++++
>  3 files changed, 123 insertions(+), 22 deletions(-)

Christoph and Jens: Any more thoughts on this irq toggling approach?

Stefan

--B/OddBweazIqrPeI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC49ZEACgkQnKSrs4Gr
c8j34Af+OlGHrPFOu/uCty4kQUK2eoLVfirmODk3dZSTw9dI349E+luWFSE+dOyn
UJL1cKCs3Cw8jgwiUkzjt/lSMlpmjvQiqGmJCxfC+0Z+mkinpthhhK5G7DlSFTQl
BoQ+h64/9rU7rXXP4jJarxNV/LAu2jXPBL2pypG8UfGSB6wPFdcd/01ftiKLbkZE
ja044LxlD84TUn3sgtGRtH5MupRE7k/izZMYmyBlWLE/vH4DySVhvA6kwGWeAD82
dClnQ/TiFkvkf7GM4CvdX+PZ2f+sGpa4dPJ7LUJOz6RxpdUo+fW7loKm1zu5IyO9
/qF7ys9OUNREOxR9hiWtpcE+2V/HBA==
=/ihk
-----END PGP SIGNATURE-----

--B/OddBweazIqrPeI--

