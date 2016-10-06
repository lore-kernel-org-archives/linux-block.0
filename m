Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56838 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933370AbcJFTp0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 15:45:26 -0400
Date: Thu, 6 Oct 2016 21:44:15 +0200
From: Mark Brown <broonie@kernel.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Paolo Valente <paolo.valente@unimore.it>, Shaohua Li <shli@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Kernel-team@fb.com, jmoyer@redhat.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-ID: <20161006194415.bpl5zylqmgy4izyc@sirena.org.uk>
References: <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it>
 <20161004202754.GJ4205@htj.duckdns.org>
 <257945FA-6789-4D80-8DA3-AC75640C71AE@unimore.it>
 <20161005144946.GA26977@htj.duckdns.org>
 <20161005183052.GA97491@anikkar-mbp.local.dhcp.thefacebook.com>
 <E7D744B7-22B1-4D6B-9C42-A43517AA490F@unimore.it>
 <20161005204601.GB1754@anikkar-mbp.local.dhcp.thefacebook.com>
 <5699035C-6DC3-497A-9D7A-A4E43D17C3CD@unimore.it>
 <35D8ECB2-BE20-4A4E-9B93-951B0D5042C9@unimore.it>
 <20161006174943.GD17335@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibzj7p4p2qpw744y"
In-Reply-To: <20161006174943.GD17335@redhat.com>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--ibzj7p4p2qpw744y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 06, 2016 at 01:49:43PM -0400, Vivek Goyal wrote:

> Paolo, CFQ is legacy now and if we can come up with a proportional
> IO mechanism which works reasonably well with fast devices using
> blk-mq interfaces, that will be much more interesting.

CFQ is not legacy yet.  Until we've got scheduling in blk-mq and
converted all the existing users over to blk-mq it's still going
to be something that affects real, production systems that don't
have any other meaningful option.

--ibzj7p4p2qpw744y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9qmLAAoJECTWi3JdVIfQ5MUH/RcURI7NXASW75tQqapOKKow
w28jEp8Q3V8q/WV/MkshJ+K1YRZ8qnFCY6mcvyiT1gV5uEokZnceKacEGtADGA16
6ZemAKD7OsCCaXNCYR1Df9e4SCxl1Y+kEMJ/jnxqaly/2v59ihAoo6afFUI9m+1t
/2m8lbop/ee8kiT1rBd4AqZWzjNl+/2WDtokLanPWccHqUjH8SIGTawYwcwrNwgd
Z3kf+WGeTg1QZezgR8eqVKFdUkVfPYKIdMLIgtsdO3Q332paM2Tu++Q5diuj8cVV
dFV6xsPxPMwNGq02z23E3H2ItHZP98wk5RH7cxJKFXQ+7b6hqrhJwhEHsi9mqyQ=
=sYkL
-----END PGP SIGNATURE-----

--ibzj7p4p2qpw744y--
