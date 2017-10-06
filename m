Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:56175 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbdJFJTO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 05:19:14 -0400
Received: by mail-wm0-f44.google.com with SMTP id u138so6656401wmu.4
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2017 02:19:14 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_EC8FC98A-2CCC-4AB7-B29C-6DD121BAA665";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Why removing REQ_FAILFAST_DRIVER in LightNVM?
Message-Id: <216FF7C0-4B2A-438A-BC63-88A9BBDC77CC@lightnvm.io>
Date: Fri, 6 Oct 2017 11:19:09 +0200
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_EC8FC98A-2CCC-4AB7-B29C-6DD121BAA665
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Hi Christoph,

I'm cleaning up lightnvm.c to use as much as possible the nvme helpers.

I see that in Commit: d49187e97e94 "nvme: introduce struct nvme_request"

you introduced:
  rq->cmd_flags &= ~REQ_FAILFAST_DRIVER

on the lightnvm I/O path and that has propagated through the code as we
added more functionality. Can you explain why this is necessary? If I
can just remove it, it is much easier to do the cleanup.

I have tested on or HW and all works fine without it.

Thanks,
Javier


--Apple-Mail=_EC8FC98A-2CCC-4AB7-B29C-6DD121BAA665
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnXSo0ACgkQYx8FO3WZ
GMrkVxAA5EZzKjjuqasdIqzjK41v/DH6dSSzEfvyi0jiDjW6lDL4q3ahwlAnbMVz
k64kYknRFK38XNfW1dirxxIuF+J0jmJqO6NEGtTRNOmyTgbyQ/dhIpA5jvxhf9PV
ednjGk3S0hK3aMMOM7MigKvrQ3/RD0VDvcuU+2SSS+d8UX3KGKu8OoIf3uQ9k/1/
mJWMIgRVBvsEuJem/quMryEIOAxL3B1roCXrqO9gIkniX0yKw4XibYTTl+/utoF5
PfNyQgBp2oXySGXIxCA++z4lBUHsigYeVafu6fYv+J52MTqMakmjImWQsPefmkAT
smwh+SFHx0oewwXnajzYC5j6LTg2Gy70BmiGVMFzn6bKUcxhFLi1jOoHfkXNMRj7
jCr+T/jmfWK22G9ygncAK8gi0u6/ik96s52GQuYPKsZKalRBWu3uUNvkhlAWozp7
q5S15/+7RcSsbEf4xRZQjOjNzUbx2J/9xoEFlron7w7So2hpqJCOj+Bnhj6VEZa4
nVxUlJy9oMxJGUuTFnLy4vSQuaAJxKBliJ16rKb9jBTwzEEGIivvK8YMXTmnp/+A
EaBDPTlac9hKcVfpgTGa6ASSyJNbgxzqZv1iwP3TDuPt/hv2uP+uecAjRSi8WxYw
Z4Bco0X20Mp9Q010F6vFJQt/yg3LkBiZt2b6FdDTT54GWGOzEPw=
=itA5
-----END PGP SIGNATURE-----

--Apple-Mail=_EC8FC98A-2CCC-4AB7-B29C-6DD121BAA665--
