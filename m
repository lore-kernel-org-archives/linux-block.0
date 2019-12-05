Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C226C43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 22:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40FC21835
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 22:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfLEWWu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:22:50 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:45514 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfLEWWt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 17:22:49 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E811E1C246E; Thu,  5 Dec 2019 23:22:47 +0100 (CET)
Date:   Thu, 5 Dec 2019 23:22:47 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Christoph Hellwig <hch@lst.de>, Faiz Abbas <faiz_abbas@ti.com>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 240/321] mmc: core: align max segment size with
 logical block size
Message-ID: <20191205222247.GC25107@duo.ucw.cz>
References: <20191203223427.103571230@linuxfoundation.org>
 <20191203223439.627632861@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <20191203223439.627632861@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Ming Lei <ming.lei@redhat.com>
>=20
> [ Upstream commit c53336c8f5f29043fded57912cc06c24e12613d7 ]
>=20
> Logical block size is the lowest possible block size that the storage
> device can address. Max segment size is often related with controller's
> DMA capability. And it is reasonable to align max segment size with
> logical block size.

> SDHCI sets un-aligned max segment size, and causes ADMA error, so
> fix it by aligning max segment size with logical block size.

If un-aligned max segment sizes are problem, should we add checks to
prevent setting them?

At least these set unaligned problems; is that a problem?

drivers/block/nbd.c:	blk_queue_max_segment_size(disk->queue, UINT_MAX);
drivers/block/virtio_blk.c:		blk_queue_max_segment_size(q, -1U);
drivers/block/rbd.c:	blk_queue_max_segment_size(q, UINT_MAX);

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXemDNwAKCRAw5/Bqldv6
8qURAJ4kOXj+tnqLfx1WyRpyhyio48ajTACfROmekocIzIC5gwaHRrxa13c9rik=
=96V+
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
