Return-Path: <robdclark@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180219193312.GA3709@amd>
References: <20180217211955.GE9640@amd> <187435d4-5017-edb5-9b6a-b433a148bfcc@c-s.fr>
 <20180219154135.GV22199@phenom.ffwll.local> <20180219193312.GA3709@amd>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 19 Feb 2018 20:25:57 -0500
Message-ID: <CAF6AEGu=pJa8nVqBDXZyKenCGi=FpjiKEYmMrMdSJD23mk1WJA@mail.gmail.com>
Subject: Re: [PATCH] fix double ;;s in code
To: Pavel Machek <pavel@ucw.cz>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
	SF Markus Elfring <elfring@users.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>,
	vgupta@synopsys.com, Russell King - ARM Linux <linux@armlinux.org.uk>, oleg@redhat.com,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, paulus@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, scott.bauer@intel.com,
	jonathan.derrick@intel.com, axboe@kernel.dk, daniel.lezcano@linaro.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
	Alexander Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Chunming Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, Shaohua Li <shli@kernel.org>, shawnguo@kernel.org,
	kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, mhocko@suse.com,
	vbabka@suse.cz, Vladislav.Zakharov@synopsys.com, noamca@mellanox.com,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Stephen Boyd <sboyd@codeaurora.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, aik@ozlabs.ru, ruscur@russell.cc,
	david@gibson.dropbear.id.au, fbarrat@linux.vnet.ibm.com,
	alistair@popple.id.au, Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
	Harry Wentland <harry.wentland@amd.com>, "Cheng, Tony" <tony.cheng@amd.com>, Wenjing.Liu@amd.com,
	Dave Airlie <airlied@redhat.com>, Ding.Wang@amd.com, sylvia.tsai@amd.com,
	hersenxs.wu@amd.com, Rex.Zhu@amd.com, JinHuiEric.Huang@amd.com,
	Dan Carpenter <dan.carpenter@oracle.com>, Archit Taneja <architt@codeaurora.org>,
	narmstrong@baylibre.com, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	Jordan Crouse <jcrouse@codeaurora.org>, Aishwarya Pant <aishpant@gmail.com>,
	=?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, andresx7@gmail.com,
	Monk.Liu@amd.com, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>,
	"Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kvm-ppc@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-efi@vger.kernel.org,
	linux-block@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel <dri-devel@lists.freedesktop.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, freedreno <freedreno@lists.freedesktop.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 19, 2018 at 2:33 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2018-02-19 16:41:35, Daniel Vetter wrote:
>> On Sun, Feb 18, 2018 at 11:00:56AM +0100, Christophe LEROY wrote:
>> >
>> >
>> > Le 17/02/2018 =C3=A0 22:19, Pavel Machek a =C3=A9crit :
>> > >
>> > > Fix double ;;'s in code.
>> > >
>> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
>> >
>> > A summary of the files modified on top of the patch would help underst=
and
>> > the impact.
>> >
>> > A maybe there should be one patch by area, eg one for each arch specif=
ic
>> > modif and one for drivers/ and one for block/ ?
>>
>> Yeah, pls split this into one patch per area, with a suitable patch
>> subject prefix. Look at git log of each file to get a feeling for what's
>> the standard in each area.
>
> Yeah I can spend hour spliting it, and then people will ignore it
> anyway.
>
> If you care about one of the files being modified, please fix the
> bug, ";;" is a clear bug.
>
> If you don't care ... well I don't care either.
>
> drivers/gpu/ has four entries, i guess that's something for you.

fwiw, one of those four is dup of a patch that I've already pushed to
msm-next for drm/msm (which seems to be an argument for splitting up a
treewide patch.. which seems something quite scriptable, but up to you
whether you want to bother with that.. either way drm/msm is ;;-clean
now)

BR,
-R


>                                                                 Pavel
>
>> > > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/driv=
ers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> > > index 61e8c3e..33d91e4 100644
>> > > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> > > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> > > @@ -718,7 +718,7 @@ static enum link_training_result perform_channel=
_equalization_sequence(
>> > >           uint32_t retries_ch_eq;
>> > >           enum dc_lane_count lane_count =3D lt_settings->link_settin=
gs.lane_count;
>> > >           union lane_align_status_updated dpcd_lane_status_updated =
=3D {{0}};
>> > > - union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] =3D {{{0}}};=
;
>> > > + union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] =3D {{{0}}};
>> > >           hw_tr_pattern =3D get_supported_tp(link);
>> > > diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers=
/gpu/drm/amd/powerplay/amd_powerplay.c
>> > > index 4c3223a..adb6e7b 100644
>> > > --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>> > > +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>> > > @@ -162,7 +162,7 @@ static int pp_hw_init(void *handle)
>> > >                   if(hwmgr->smumgr_funcs->start_smu(pp_handle->hwmgr=
)) {
>> > >                           pr_err("smc start failed\n");
>> > >                           hwmgr->smumgr_funcs->smu_fini(pp_handle->h=
wmgr);
>> > > -                 return -EINVAL;;
>> > > +                 return -EINVAL;
>> > >                   }
>> > >                   if (ret =3D=3D PP_DPM_DISABLED)
>> > >                           goto exit;
>> > > diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c b/drivers/gpu/d=
rm/msm/mdp/mdp5/mdp5_kms.c
>> > > index 3e9bba4..6d8e3a9 100644
>> > > --- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
>> > > +++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
>> > > @@ -680,7 +680,7 @@ struct msm_kms *mdp5_kms_init(struct drm_device =
*dev)
>> > >           } else {
>> > >                   dev_info(&pdev->dev,
>> > >                            "no iommu, fallback to phys contig buffer=
s for scanout\n");
>> > > -         aspace =3D NULL;;
>> > > +         aspace =3D NULL;
>> > >           }
>> > >           pm_runtime_put_sync(&pdev->dev);
>> > > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu=
/drm/scheduler/gpu_scheduler.c
>> > > index 2c18996..0d95888 100644
>> > > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> > > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> > > @@ -461,7 +461,7 @@ void drm_sched_hw_job_reset(struct drm_gpu_sched=
uler *sched, struct drm_sched_jo
>> > >   {
>> > >           struct drm_sched_job *s_job;
>> > >           struct drm_sched_entity *entity, *tmp;
>> > > - int i;;
>> > > + int i;
>> > >           spin_lock(&sched->job_list_lock);
>> > >           list_for_each_entry_reverse(s_job, &sched->ring_mirror_lis=
t, node) {
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
