Return-Path: <pavel@ucw.cz>
Date: Sat, 24 Feb 2018 09:52:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Guo <shawnguo@kernel.org>
Cc: elfring@users.sourceforge.net,
	kernel list <linux-kernel@vger.kernel.org>, vgupta@synopsys.com,
	linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
	will.deacon@arm.com, paulus@ozlabs.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, ard.biesheuvel@linaro.org, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	scott.bauer@intel.com, jonathan.derrick@intel.com, axboe@kernel.dk,
	daniel.lezcano@linaro.org, maxime.ripard@free-electrons.com,
	wens@csie.org, alexander.deucher@amd.com, christian.koenig@amd.com,
	David1.Zhou@amd.com, airlied@linux.ie, robdclark@gmail.com,
	joro@8bytes.org, shli@kernel.org, kernel@pengutronix.de,
	fabio.estevam@nxp.com, akpm@linux-foundation.org,
	Alexey.Brodkin@synopsys.com, mhocko@suse.com, vbabka@suse.cz,
	Vladislav.Zakharov@synopsys.com, noamca@mellanox.com,
	yamada.masahiro@socionext.com, sboyd@codeaurora.org,
	viresh.kumar@linaro.org, linus.walleij@linaro.org, heiko@sntech.de,
	aik@ozlabs.ru, ruscur@russell.cc, david@gibson.dropbear.id.au,
	fbarrat@linux.vnet.ibm.com, alistair@popple.id.au, robh@kernel.org,
	joe@perches.com, harry.wentland@amd.com, tony.cheng@amd.com,
	Wenjing.Liu@amd.com, airlied@redhat.com, Ding.Wang@amd.com,
	sylvia.tsai@amd.com, hersenxs.wu@amd.com, Rex.Zhu@amd.com,
	JinHuiEric.Huang@amd.com, dan.carpenter@oracle.com,
	architt@codeaurora.org, daniel.vetter@ffwll.ch,
	narmstrong@baylibre.com, ville.syrjala@linux.intel.com,
	jcrouse@codeaurora.org, aishpant@gmail.com, noralf@tronnes.org,
	andresx7@gmail.com, Monk.Liu@amd.com, nicolai.haehnle@amd.com,
	Andrey.Grodzovsky@amd.com, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kvm-ppc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org,
	linux-block@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH] fix double ;;s in code
Message-ID: <20180224085227.GA12996@amd>
References: <20180217211955.GE9640@amd>
 <20180222090932.GJ3217@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
In-Reply-To: <20180222090932.GJ3217@dragon>
List-ID: <linux-block@vger.kernel.org>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> > index 53f7275..cfb42f5 100644
> > --- a/drivers/soc/imx/gpc.c
> > +++ b/drivers/soc/imx/gpc.c
> > @@ -348,7 +348,7 @@ static int imx_gpc_old_dt_init(struct device *dev, =
struct regmap *regmap,
> >  		if (i =3D=3D 1) {
> >  			domain->supply =3D devm_regulator_get(dev, "pu");
> >  			if (IS_ERR(domain->supply))
> > -				return PTR_ERR(domain->supply);;
> > +				return PTR_ERR(domain->supply);
> > =20
> >  			ret =3D imx_pgc_get_clocks(dev, domain);
> >  			if (ret)
> >=20
>=20
> Considering the controversy how the changes should be merged, I'm going
> to send a separate patch just for IMX GPC driver with a reported-by-you
> tag.  Thanks for catching this.

That works for me.

Alternatively... Andrew Morton merged the patch to his -mm tree
(thanks!), so you don't need to take any action, and it will be
eventually fixed.

If you merge your own version of the patch, that's ok, too, since
Andrew will just drop his version.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqRJ8sACgkQMOfwapXb+vJnFQCfWSkka/liG8y+QlhIsWXlYlju
LMwAoKeeuJ1utbSPd+SNFlihXcdggiAP
=Ejo3
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
