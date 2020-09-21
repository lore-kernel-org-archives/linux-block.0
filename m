Return-Path: <SRS0=nPog=C6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839EEC4727E
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 21:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5034B23A60
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 21:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgIUVqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 17:46:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51596 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUVqf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 17:46:35 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3E3A31C0B8C; Mon, 21 Sep 2020 23:46:33 +0200 (CEST)
Date:   Mon, 21 Sep 2020 23:46:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 11/14] PM: rewrite is_hibernate_resume_dev to not require
 an inode
Message-ID: <20200921214632.GA11006@amd>
References: <20200921071958.307589-1-hch@lst.de>
 <20200921071958.307589-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20200921071958.307589-12-hch@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-09-21 09:19:55, Christoph Hellwig wrote:
> Just check the dev_t to help simplifying the code.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9pHzgACgkQMOfwapXb+vLjrwCgkqX/NkSqeB9h9XmupMxguXKk
HU8An2MYofOY5WFBUrwRO2mqpLwzFEzu
=u07+
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
