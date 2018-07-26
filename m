Return-Path: <ps@pks.im>
Date: Thu, 26 Jul 2018 10:38:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180726083850.GB1674@ncase>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
In-Reply-To: <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 06:13:02PM +0000, Bart Van Assche wrote:
> On Fri, 2018-07-13 at 15:29 +-0200, Patrick Steinhardt wrote:
> +AD4- When power management for SCSI is enabled and if a device uses blk-=
mq,
> +AD4- it is possible to trigger a +AGA-NULL+AGA- pointer exception when r=
esuming that
> +AD4- device. The NPE is triggered when trying to dereference the +AGA-re=
quest+AF8-fn+AGA-
> +AD4- function pointer of the device's +AGA-request+AF8-queue+AGA-:
> +AD4-=20
> +AD4-     +AF8AXw-blk+AF8-run+AF8-queue+AF8-uncond:470
> +AD4-     +AF8AXw-blk+AF8-run+AF8-queue:490
> +AD4-     blk+AF8-post+AF8-runtime+AF8-resume:3889
> +AD4-     sdev+AF8-runtime+AF8-resume:263
> +AD4-     scsi+AF8-runtime+AF8-resume:275
> +AD4-=20
> +AD4- When the SCSI device is being allocated by +AGA-scsi+AF8-alloc+AF8-=
sdev+AGA-, the
> +AD4- device's request queue will either be initialized via
> +AD4- +AGA-scsi+AF8-mq+AF8-alloc+AF8-queue+AGA- or +AGA-scsi+AF8-old+AF8-=
alloc+AF8-queue+AGA-. But the +AGA-request+AF8-fn+AGA-
> +AD4- member of the request queue is in fact only being set in
> +AD4- +AGA-scsi+AF8-old+AF8-alloc+AF8-queue+AGA-, which will then later c=
ause the mentioned NPE.
> +AD4-=20
> +AD4- Fix the issue by checking whether the +AGA-request+AF8-fn+AGA- is s=
et in
> +AD4- +AGAAXwBf-blk+AF8-run+AF8-queue+AF8-uncond+AGA-. In case it is unse=
t, we'll silently return and
> +AD4- not try to invoke the callback, thus fixing the NPE.
>=20
> Which kernel version are you using? Can you check whether the following t=
wo
> commits are in your kernel tree?
>=20
> +ACo- 4fd41a8552af (+ACI-SCSI: Fix NULL pointer dereference in runtime PM=
+ACIAOw- December
>   2015).
> +ACo- 765e40b675a9 (+ACI-block: disable runtime-pm for blk-mq+ACIAOw- Jul=
y 2017).

Commit 765e40b675a9 (block: disable runtime-pm for blk-mq July
2017) was indeed not part of my kernel. Back when I upgraded to
v4.14, suspend to RAM on my laptop was broken, and a bisect
showed that this particular commit was the culprit. So I reverted
it and forgot until it bit me now -- so it's been my own
stupidity. Guess it serves me right for not checking my own
changes.

That still leaves the other problem of broken suspend. I've just
checked with v4.17.10, and it's still there: as soon as I resume
=66rom suspend, the kernel oopses and reboots the machine. I guess
I'll have to do another debugging session and see where it fails
exactly (and no, this time there are no more changes to the
kernel tree).

Anyway, thanks for pointing out my own mistakes.

Regards
Patrick

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAltZiJkACgkQEXxntp6r
8SxRLxAAkU9UD0v0U1ouRCJHoMGtpVRGWAn6pv6QpDIZnWbn8DsD8wgwnnRk2Mt+
2hiiqgLaSO21+gTYEefzV++cjUvkCpyTNHvCoPyRABNN18UUCUDlzhApZyaUWdKp
c/uGV+ihMYTFR6mzNpfWmhqKMdtZ8z+KyY1Mp8GeLco/oovF1x7yw0bn287s9WAO
GJI9K20ZBrrMPBMKKgvDJlKlshrTEkqKGAAqNuXtwz4FlsPsGBav53TveKP2ZC1g
V3rzTpRJTCf0MkUb5MyWB0mk92K7jfZSEY2ez3pPtuF+BTi2vCzk2lIK1aDeH6iO
CldlkO6pF8jI+vHAJyu9T7iQ+rVroEndFrHENLsgKYDgkuSanwaoNhQ4H8M0gqaK
B5E1ivQ8pX7h58qH76k7PNVsgZxkBPlpngYMLSjCIOa81UzhR3gjlQoAflebACKj
P2bghMWNGTQHibimQ3vYzvvUIZgu659TiB7hTE6Ro3stclm1sYrf57+dpNm9bZMi
HlVieiMCd8PhefMJwbpbdbwFvA22Yko9O4uHdFrnNKD5fMoKTFQqS+4uDO8xI9ns
DaGwwmJnqg8h0edZ8zYRX7fanq4B7dhO+tDhRTtnp1+a0Lzs9ztWwB8r/m4jCWx4
15fBeaH9S80Fq0qyXIAMemiz4dnjtxoZa5J5/VDQQmD4C4UzM1M=
=3P1z
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
