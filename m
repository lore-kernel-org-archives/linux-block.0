Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA0C433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 08:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5927560FC4
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 08:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJ1IV1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229833AbhJ1IVW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 04:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635409135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pXMrcpHehLRVHJk/nMeA6+QLvzVDo2cx25CECDi4i7A=;
        b=JAJnUFjPqlv1tq/hh0E+TED8BpilQejxGHjiKBiysXigTdTJqeqCUCUBXaaf4kLzAfyQM6
        Qc74S11k6+asX8ooLERRU/y4bdY/TkEGhd4QM7WSdOdq67b+N2Xw6Hy/ZxKv3eLgDFiH+1
        C3JBAQrvzdZTRX/nliMScDC0A35q6qI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-i4Dnxkw1NDyC3baBbDAFUQ-1; Thu, 28 Oct 2021 04:18:51 -0400
X-MC-Unique: i4Dnxkw1NDyC3baBbDAFUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 497889F932;
        Thu, 28 Oct 2021 08:18:50 +0000 (UTC)
Received: from localhost (unknown [10.39.194.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E742B57CB9;
        Thu, 28 Oct 2021 08:18:46 +0000 (UTC)
Date:   Thu, 28 Oct 2021 09:18:46 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] virtio_blk: Fix spelling mistake: "advertisted" ->
 "advertised"
Message-ID: <YXpc5l6lzp+aBTaU@stefanha-x1.localdomain>
References: <20211025102240.22801-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U+u1ddsxMsOIkdhu"
Content-Disposition: inline
In-Reply-To: <20211025102240.22801-1-colin.i.king@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--U+u1ddsxMsOIkdhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 25, 2021 at 11:22:40AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err error message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--U+u1ddsxMsOIkdhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmF6XOUACgkQnKSrs4Gr
c8j8vgf9GmyeRUXKxu9ABJAENCKSjxXLD6Vukn+lKvXAMvprvR+m82GgNwtX37u5
ag8cYzpK3JKZ8pu2U9hmsbormnnXTPhwSv4Xu6rwSsmLK2kx1ZrVjmlh3/z4MA8T
yoUsJQOpMsIjO6Y0R+t+/Hl/8bzxuH3d4mWWca4GTbIF2ZAvOxEgute1VVGcUr9L
yiFT3Ym5HVxP7VaHrtXBCwjXl/taWhB+oTo4cToa4OPo6/ccnTaXtuJEn+ytGlTd
ZBiPFVVGIpPNqasYkZeMcE8Jxxp/4+c5uDW89FVZ3l2NxKoX3TmaLHyfFDk0RqJY
1tK8mop6eVQvpb7pkQwjikTXOG8/7g==
=0jkP
-----END PGP SIGNATURE-----

--U+u1ddsxMsOIkdhu--

