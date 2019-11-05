Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F39CA9ED9
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 07:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAA7217F4
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 07:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDxdhqtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbfKEHkY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:40:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39220 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387484AbfKEHkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Nov 2019 02:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572939623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QAkZjtU1WaUYRmoweuk0afmXnw9Hgc0IlMcwiSyThos=;
        b=bDxdhqtIkIklBRefltEmzdEA2nqR0gl5BnFk6QiAYEeyp2T9yjh1Jifpg1HPMN7Bu55U5t
        Ldcq0WcW/19yas7ya+RISxnrE3HzAfjwNOmB//nzEsw0goUVkDDaZQ1bplE98O1lVpIGo4
        y54h+vI7EhVwcVZp3ozz6zWcJ+SU/M4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-n2So3mYqPRWoPqjev7_zZQ-1; Tue, 05 Nov 2019 02:40:19 -0500
X-MC-Unique: n2So3mYqPRWoPqjev7_zZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3A2D1005500;
        Tue,  5 Nov 2019 07:40:17 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D853B5D6D0;
        Tue,  5 Nov 2019 07:40:13 +0000 (UTC)
Date:   Tue, 5 Nov 2019 08:40:12 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH liburing v2 3/3] spec: Fedora RPM cleanups
Message-ID: <20191105074012.GA62254@stefanha-x1.localdomain>
References: <20191104155524.58422-1-stefanha@redhat.com>
 <20191104155524.58422-4-stefanha@redhat.com>
 <fd3e6fde-72b7-32d2-b9cc-2616a843d534@kernel.dk>
MIME-Version: 1.0
In-Reply-To: <fd3e6fde-72b7-32d2-b9cc-2616a843d534@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2019 at 08:59:22AM -0700, Jens Axboe wrote:
> On 11/4/19 8:55 AM, Stefan Hajnoczi wrote:
> >   %changelog
> > +* Thu Oct 31 2019 Jeff Moyer <jmoyer@redhat.com> - 0.2-1
> > +- Initial fedora package.
> > +
>=20
> Rest looks good now, but I think you forgot this one!

I forgot to commit my changes before sending v2 >_<

Will fix in v3

Stefan

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3BJ1wACgkQnKSrs4Gr
c8ggBQf+OH6fTzLt9xcoevTijDY8RBzHGvvNKhszHxNPAiDC7TcTsJ/x5lIV6LQ3
M4enrcpdSDKzoweBRlZzA3eQD3Amb7RcZ0Cp4xUCppRwe/YerhHMCM9vr/Z1Ci+J
soRmP8/RSNAnPktarr8URCLzqyBzS9SAeAT0mcWn0KRZ9ADLAxfGiJGcjWFsaiqv
2IORvMO8N1ABmuh4wDqfLypXGRuloyZcZZ+YEyNgUADjg1WnAfCcVd3qhgTKtv7i
+yY8JxsLUlqzoaqetUU0Wer3SdpO9WDv87ZeSUh1UBoJ0WzSr/+/hxGwodyaQJSJ
qomvRmGQ3/eu/Qcy7HeStOSBI67Cxg==
=5AAD
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

