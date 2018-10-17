Return-Path: <broonie@sirena.org.uk>
Date: Wed, 17 Oct 2018 17:01:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Paolo Valente <paolo.valente@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Message-ID: <20181017160157.GE24097@sirena.org.uk>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
 <ab70f1dd-6943-9642-aafa-71840fd44f07@kernel.dk>
 <689F28AA-92B5-48B5-BBE7-0B589F163228@linaro.org>
 <7375c004-ac6e-c692-4282-46de554285d5@kernel.dk>
 <20181017100526.GB23493@quack2.suse.cz>
 <d1d082f3-d681-02ed-5bbe-5eb011d6b0da@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
In-Reply-To: <d1d082f3-d681-02ed-5bbe-5eb011d6b0da@acm.org>
List-ID: <linux-block@vger.kernel.org>


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 17, 2018 at 07:48:33AM -0700, Bart Van Assche wrote:
> On 10/17/18 3:05 AM, Jan Kara wrote:

> > Well, the problem with this is that big distro people really don't care
> > much because they already use udev for tuning the IO scheduler. So whatever
> > defaults the kernel is going to pick likely won't be seen by distro
> > customers. Embedded people seem to be driving this effort because they
> > either don't run udev or they feel not all their teams building new
> > products have enough expertise to come up with a proper set of rules...

> What's missing in this discussion is a definition of "embedded system". Is
> that a system like a streaming player for TV channels that neither has a
> keyboard nor a display or a system that can run multiple apps simultaneously
> like a smartphone? I think the difference matters because some embedded
> devices hardly do any background I/O nor load any executable code from
> storage after boot. So at least for some embedded devices the problem
> discussed in this e-mail thread does not exist.

It's a combination of things - smartphones are definitely part of the
target audience but other things can be affected, I'd guess your
streaming TV player example can have issues if it's got local storage
and downloads things in the background for example.  There's definitely
systems that never really use storage once they're booted but there's
also things that move data around and/or have interactive apps.  Even
with some of the things that don't really use storage at runtime it can
be important to help cut down boot times.

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHXPQACgkQJNaLcl1U
h9BhTQf9GECNh5g/DQ+VYS9iJ4yj1dRKlfSJITLYWxTSwWNP1hW5T+UA3lJWvKIT
2a9nRUq5DopBFuuph/zU9pt/GWI2MB6dWym3aYoDgBPp/KOBsBYD0wAlJc61QLS5
PLPfDAnRb/NzhOXNKce7DIWlCJg+Oxk91gsegxXHcF/7jS/QKgyG3Y2Ajcp4zsiz
hVCqPdKBkZLgK60JVUqNGVnFtrW2fE1WdCKE4rWRjkvUOLitUBL9n1Melh6aWqMX
JXGPrnkQre7u6YXMq71xST/iJvx4NGt4T+/ga7PQ8tvSorNcdK+cSEmizv+YGt9Y
DxsNDMfQyPX1mz30cGslJZGndsPG1g==
=FkF0
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
