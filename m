Return-Path: <SRS0=hgVe=C4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A33C43467
	for <linux-block@archiver.kernel.org>; Sat, 19 Sep 2020 09:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF1F321582
	for <linux-block@archiver.kernel.org>; Sat, 19 Sep 2020 09:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgISJN1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Sep 2020 05:13:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38958 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgISJN1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Sep 2020 05:13:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 354B41C0B8D; Sat, 19 Sep 2020 11:06:59 +0200 (CEST)
Date:   Sat, 19 Sep 2020 11:06:58 +0200
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
        linux-block@vger.kernel.org
Subject: Re: [PATCH 13/14] PM: mm: cleanup swsusp_swap_check
Message-ID: <20200919090658.GB12294@duo.ucw.cz>
References: <20200917165720.3285256-1-hch@lst.de>
 <20200917165720.3285256-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20200917165720.3285256-14-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-09-17 18:57:19, Christoph Hellwig wrote:
> Use blkdev_get_by_dev instead of bdget + blkdev_get.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2XKMgAKCRAw5/Bqldv6
8jnIAJ9gnRBuWwSimm3SXF7hOAxcdZjhvgCfSC/nzlC9BvYn3OzlsY0Fu9KJK58=
=7alK
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
