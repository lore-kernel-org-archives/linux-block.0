Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49875C072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 08:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1583B2184E
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 08:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbfEXIsa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 04:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389404AbfEXIsa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 04:48:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BB2DC0546EE;
        Fri, 24 May 2019 08:48:29 +0000 (UTC)
Received: from localhost (ovpn-117-142.ams2.redhat.com [10.36.117.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A38175B689;
        Fri, 24 May 2019 08:48:28 +0000 (UTC)
Date:   Fri, 24 May 2019 09:48:27 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>, linux-block@vger.kernel.org
Subject: Packaging liburing for Fedora
Message-ID: <20190524084827.GA31048@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 24 May 2019 08:48:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,
Applications are beginning to use liburing and I'd like to package it
for Fedora.

Two items that would be useful for an official distro package:

1. A 0.2 release git tag so that downstream packagers have a
   well-defined version to package.  0.1 has no git tag and useful
   changes have been made since the 0.1 .spec file was committed.

2. A pkg-config .pc file so that applications don't need to hardcode
   details of how to compile against liburing.

I can take care of #2.

Are there other known todos before distros start shipping liburing?

Thanks,
Stefan

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlznr9sACgkQnKSrs4Gr
c8jFxAf+Povzv/YXqft6uhnLLJvMEwhRkonOypXzuj9V26EjHjg4ZmYSOGOer9s4
ASEzhBXulPaSSzUA97nszUzoifO1PQZW30/gHXg7d9gjpePu5LHtqGnBFp/U5s12
eRkXXb2bxeL9S9pcFUZG3Ajhvoo+PXi4FmsIHmhlCFuct08AGCxPx4cUB2FKbKTr
bNIJN9OvWPATScgWsXGcDF6Kf0Y4y+dSknwrNcXAv9HXQvkfxlbATm7Z9ngVVULc
qB1qji1ctd8BkAECjGA3gcKn7pwCC8UOhllNP6SrL9DUc39/dhrz7loT4+juAFES
MrfJwsI6bAbEU6cVSeeXwOCx9OTnrw==
=UZsF
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
