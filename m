Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45908 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbcJFLEA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 07:04:00 -0400
Date: Thu, 6 Oct 2016 13:03:42 +0200
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tejun Heo <tj@kernel.org>,
        Paolo Valente <paolo.valente@unimore.it>,
        Shaohua Li <shli@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Hannes Reinecke <hare@suse.com>
Message-ID: <20161006110342.gyyiwaqw4ivzdaww@sirena.org.uk>
References: <20161004155616.GB4205@htj.duckdns.org>
 <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it>
 <20161004162759.GD4205@htj.duckdns.org>
 <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it>
 <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
 <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it>
 <20161004185413.GF4205@htj.duckdns.org>
 <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it>
 <20161004191427.GG4205@htj.duckdns.org>
 <CACRpkdavM0ZGdDjXAsEG1MMy4WuAnudNw9KL8eFJFsfm_ptEBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sxnpsrsixrbz5syv"
In-Reply-To: <CACRpkdavM0ZGdDjXAsEG1MMy4WuAnudNw9KL8eFJFsfm_ptEBg@mail.gmail.com>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--sxnpsrsixrbz5syv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 06, 2016 at 10:04:41AM +0200, Linus Walleij wrote:
> On Tue, Oct 4, 2016 at 9:14 PM, Tejun Heo <tj@kernel.org> wrote:

> > I get that bfq can be a good compromise on most desktop workloads and
> > behave reasonably well for some server workloads with the slice
> > expiration mechanism but it really isn't an IO resource partitioning
> > mechanism.

> Not just desktops, also Android phones.

> So why not have BFQ as a separate scheduling policy upstream,
> alongside CFQ, deadline and noop?

Right.

> We're already doing the per-usecase Kconfig thing for preemption.
> But maybe somebody already hates that and want to get rid of it,
> I don't know.

Hannes also suggested going back to making BFQ a separate scheduler
rather than replacing CFQ earlier, pointing out that it mitigates
against the risks of changing CFQ substantially at this point (which
seems to be the biggest issue here).

--sxnpsrsixrbz5syv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9i+NAAoJECTWi3JdVIfQElgH/3FbGbBbn4VeUDld3HkB5TK0
eH3BjhttmfXbgQJdF1kPWxHJcAHSAxMrxeZXRe9CBOVkEtnM52FiRI/DSgZf6Es4
TmbDDiNBohT120qtPC+8arnsCq5VRXohwvOBkYPhJq3J6oNM+e4XIDw5c0B3Vga5
w8aCw5hkgoT7/wHv4E+m1njFheQTIXvIpYtYaRotTUOaw+GL4VUeCLYKZQ/+ocd1
mVWVF+GTv/Nt2KFDe7rZPd6lHeu6sfPTERNRtU429pdwT34IOcerQBzrSqsoso8n
tEAo4j+VWlcWpeJmMz9Fh6CSQrChKTHGHEf95DfK96B9JWKLZ8Tzu8JQOOhaFP4=
=biW+
-----END PGP SIGNATURE-----

--sxnpsrsixrbz5syv--
