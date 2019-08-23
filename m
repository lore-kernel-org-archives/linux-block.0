Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5E6C3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 10:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07916206DD
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 10:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbfHWK2G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:28:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731002AbfHWK2G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 06:28:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4965C0021D7;
        Fri, 23 Aug 2019 10:28:05 +0000 (UTC)
Received: from localhost (ovpn-117-204.ams2.redhat.com [10.36.117.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EADB818E2B;
        Fri, 23 Aug 2019 10:28:02 +0000 (UTC)
Date:   Fri, 23 Aug 2019 11:28:01 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Roman Penyaev <rpenyaev@suse.de>,
        Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] tools/io_uring: Fix memory ordering
Message-ID: <20190823102801.GG12092@stefanha-x1.localdomain>
References: <20190820172958.92837-1-bvanassche@acm.org>
 <20190822131406.GH20491@stefanha-x1.localdomain>
 <03b1e141-3e52-8df6-943a-97192f7a34a0@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Content-Disposition: inline
In-Reply-To: <03b1e141-3e52-8df6-943a-97192f7a34a0@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 23 Aug 2019 10:28:05 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 07:54:08AM -0700, Bart Van Assche wrote:
> On 8/22/19 6:14 AM, Stefan Hajnoczi wrote:
> > On Tue, Aug 20, 2019 at 10:29:58AM -0700, Bart Van Assche wrote:
> > > Order head and tail stores properly against CQE / SQE memory accesses.
> > > Use <asm/barrier.h> instead of the io_uring "barrier.h" header file.
> >=20
> > Where does this header file come from?
> >=20
> > Linux has an asm-generic/barrier.h file which is not uapi and therefore
> > not installed in /usr/include.
> >=20
> > I couldn't find an asm/barrier.h in the Debian packages collection
> > either.
>=20
> There two flavours of the asm/barrier.h header file present in the kernel
> tree. I think that the arch/*/include/asm/barrier.h header files are
> intended for kernel code and that the tools/include/asm/barrier.h header
> file is intended for the user space code in the tools directory.

Sorry, my mistake.  I thought this was a liburing.git patch :P.

Stefan

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1fv7EACgkQnKSrs4Gr
c8hcHAf/WXzLUGW1v0sFzWBmqkzZHRTKS0Q4UkfCRU7mJtd89B0JlYO6YVpQasQp
mjZb2XQ4BLA9ywwNtWv4a/gfDL49/6Rdd9LHvgKJedgB541KbsVeqAMeiOaBa9mE
qtMx2/40zHBroB1KvVTmdig887RGnJ363o9tQV+1S9KRjBk3JQcPVIK1P0RxU25M
d3nRgRGPVSk5eNgcg7l2ea3PDSkjM7Lnrs5+fxGmTcTg58soxMU6rTcrHOJYRAJ4
+GsmI98U6wTWNpaT2LArpPkhfsUzoPGX4xfGto+w26ZGGLjdYh1Q//KnMANKCK3z
NPiJxbbJaLqKruzdDcJ9wR6r0JIuUg==
=A4yS
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
