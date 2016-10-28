Return-Path: <broonie@sirena.org.uk>
Date: Fri, 28 Oct 2016 18:12:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>,
	Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hannes Reinecke <hare@suse.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Message-ID: <20161028171201.4tzhuedvybwrmwzb@sirena.org.uk>
References: <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
 <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk>
 <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
 <CAPDyKFpLhp0eoS8LWy-jU0_U_cWq4immq2+bPdi-j7=oa24OjA@mail.gmail.com>
 <e792e932-cf16-4272-2388-ae813a0372b6@kernel.dk>
 <CAPDyKFqDqhMgpCN83P_dFf6wgfT3KCVT1Uw4kDMz620=3Hkj+A@mail.gmail.com>
 <4948c47a-6e24-0a81-0564-5a61b6be35e9@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7r537rz6c3oikgku"
In-Reply-To: <4948c47a-6e24-0a81-0564-5a61b6be35e9@kernel.dk>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
List-ID: <linux-block@vger.kernel.org>


--7r537rz6c3oikgku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2016 at 08:17:01AM -0600, Jens Axboe wrote:
> On 10/28/2016 12:36 AM, Ulf Hansson wrote:

> > You have been pushing Paolo in different directions throughout the
> > years with his work in BFQ, wasting lots of his time/effort.

> I have not. Various entities have advised Paolo approach it in various ways.
> We've had blk-mq for 3 years now, my position should have been pretty clear
> on that.

Having come to this somewhat late I have to say that that hasn't been
100% clear as a set opinion from everyone - in the time I've been
following things there's been engagement about the meat of the code
which gave the impression the patches were being seriously considered.

But like I said in a previous mail this is all in the past anyway, we
need to focus on the present situation.

--7r537rz6c3oikgku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE4bhAAoJECTWi3JdVIfQRbUH/jY2o1Fh0UtDI+3EzfglRtuL
0a3ihAYJSD4FbOimtMbyLgLG/3iKMmjWq3IFfxmlGIFvbxd3w6JKV/TBQLEwH7S+
vcNPBdHqCZMg+ClnnZlPKhYcVfCaaLDHkiV/Z3zi8NL09PAlMxNkfCeata9tKiji
w/PInBb2Dw3TG5V1Pe/C4ZTwrjS20tjqMUmZtFF6dFSGZWXBBH3MwjnjjcPeZ6Hq
u0r4JcxJ8jhwVj8jvb0krIS86BOAz5WuKrcRAGkLb+3aFUq/lMQBeW3fyP/VHC1P
HCCewPhWZNxbJ4k2S6fnhUk8mVfjfVnxc+ao7lVVFr6ydfXpLMfhy06k9rQzwrk=
=IVh6
-----END PGP SIGNATURE-----

--7r537rz6c3oikgku--
