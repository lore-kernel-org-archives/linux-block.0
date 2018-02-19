Return-Path: <pavel@ucw.cz>
Date: Mon, 19 Feb 2018 20:33:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
	elfring@users.sourceforge.net,
	kernel list <linux-kernel@vger.kernel.org>, vgupta@synopsys.com,
	linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
	will.deacon@arm.com, paulus@ozlabs.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, ard.biesheuvel@linaro.org, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	scott.bauer@intel.com, jonathan.derrick@intel.com, axboe@kernel.dk,
	daniel.lezcano@linaro.org, maxime.ripard@free-electrons.com,
	wens@csie.org, alexander.deucher@amd.com, christian.koenig@amd.com,
	David1.Zhou@amd.com, airlied@linux.ie, robdclark@gmail.com,
	joro@8bytes.org, shli@kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, fabio.estevam@nxp.com,
	akpm@linux-foundation.org, Alexey.Brodkin@synopsys.com,
	mhocko@suse.com, vbabka@suse.cz, Vladislav.Zakharov@synopsys.com,
	noamca@mellanox.com, yamada.masahiro@socionext.com,
	sboyd@codeaurora.org, viresh.kumar@linaro.org,
	linus.walleij@linaro.org, heiko@sntech.de, aik@ozlabs.ru,
	ruscur@russell.cc, david@gibson.dropbear.id.au,
	fbarrat@linux.vnet.ibm.com, alistair@popple.id.au, robh@kernel.org,
	joe@perches.com, harry.wentland@amd.com, tony.cheng@amd.com,
	Wenjing.Liu@amd.com, airlied@redhat.com, Ding.Wang@amd.com,
	sylvia.tsai@amd.com, hersenxs.wu@amd.com, Rex.Zhu@amd.com,
	JinHuiEric.Huang@amd.com, dan.carpenter@oracle.com,
	architt@codeaurora.org, narmstrong@baylibre.com,
	ville.syrjala@linux.intel.com, jcrouse@codeaurora.org,
	aishpant@gmail.com, noralf@tronnes.org, andresx7@gmail.com,
	Monk.Liu@amd.com, nicolai.haehnle@amd.com,
	Andrey.Grodzovsky@amd.com, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kvm-ppc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org,
	linux-block@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH] fix double ;;s in code
Message-ID: <20180219193312.GA3709@amd>
References: <20180217211955.GE9640@amd>
 <187435d4-5017-edb5-9b6a-b433a148bfcc@c-s.fr>
 <20180219154135.GV22199@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
In-Reply-To: <20180219154135.GV22199@phenom.ffwll.local>
List-ID: <linux-block@vger.kernel.org>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-02-19 16:41:35, Daniel Vetter wrote:
> On Sun, Feb 18, 2018 at 11:00:56AM +0100, Christophe LEROY wrote:
> >=20
> >=20
> > Le 17/02/2018 =E0 22:19, Pavel Machek a =E9crit=A0:
> > >=20
> > > Fix double ;;'s in code.
> > >=20
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > A summary of the files modified on top of the patch would help understa=
nd
> > the impact.
> >=20
> > A maybe there should be one patch by area, eg one for each arch specific
> > modif and one for drivers/ and one for block/ ?
>=20
> Yeah, pls split this into one patch per area, with a suitable patch
> subject prefix. Look at git log of each file to get a feeling for what's
> the standard in each area.

Yeah I can spend hour spliting it, and then people will ignore it
anyway.

If you care about one of the files being modified, please fix the
bug, ";;" is a clear bug.

If you don't care ... well I don't care either.

drivers/gpu/ has four entries, i guess that's something for you.

								Pavel

> > > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drive=
rs/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > > index 61e8c3e..33d91e4 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > > @@ -718,7 +718,7 @@ static enum link_training_result perform_channel_=
equalization_sequence(
> > >   	uint32_t retries_ch_eq;
> > >   	enum dc_lane_count lane_count =3D lt_settings->link_settings.lane_=
count;
> > >   	union lane_align_status_updated dpcd_lane_status_updated =3D {{0}};
> > > -	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] =3D {{{0}}};;
> > > +	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] =3D {{{0}}};
> > >   	hw_tr_pattern =3D get_supported_tp(link);
> > > diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/=
gpu/drm/amd/powerplay/amd_powerplay.c
> > > index 4c3223a..adb6e7b 100644
> > > --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > > +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > > @@ -162,7 +162,7 @@ static int pp_hw_init(void *handle)
> > >   		if(hwmgr->smumgr_funcs->start_smu(pp_handle->hwmgr)) {
> > >   			pr_err("smc start failed\n");
> > >   			hwmgr->smumgr_funcs->smu_fini(pp_handle->hwmgr);
> > > -			return -EINVAL;;
> > > +			return -EINVAL;
> > >   		}
> > >   		if (ret =3D=3D PP_DPM_DISABLED)
> > >   			goto exit;
> > > diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c b/drivers/gpu/dr=
m/msm/mdp/mdp5/mdp5_kms.c
> > > index 3e9bba4..6d8e3a9 100644
> > > --- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
> > > +++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
> > > @@ -680,7 +680,7 @@ struct msm_kms *mdp5_kms_init(struct drm_device *=
dev)
> > >   	} else {
> > >   		dev_info(&pdev->dev,
> > >   			 "no iommu, fallback to phys contig buffers for scanout\n");
> > > -		aspace =3D NULL;;
> > > +		aspace =3D NULL;
> > >   	}
> > >   	pm_runtime_put_sync(&pdev->dev);
> > > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/=
drm/scheduler/gpu_scheduler.c
> > > index 2c18996..0d95888 100644
> > > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > > @@ -461,7 +461,7 @@ void drm_sched_hw_job_reset(struct drm_gpu_schedu=
ler *sched, struct drm_sched_jo
> > >   {
> > >   	struct drm_sched_job *s_job;
> > >   	struct drm_sched_entity *entity, *tmp;
> > > -	int i;;
> > > +	int i;
> > >   	spin_lock(&sched->job_list_lock);
> > >   	list_for_each_entry_reverse(s_job, &sched->ring_mirror_list, node)=
 {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqLJngACgkQMOfwapXb+vLMuACfZ4g9YFmQ7Hp3tW427eLSrtF4
XoEAn2z1vRKfakxYqYv9uHa2jCPTvkLO
=NM8e
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
