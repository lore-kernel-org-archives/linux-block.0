Return-Path: <joe@perches.com>
Message-ID: <1519144870.4326.7.camel@perches.com>
Subject: Re: [PATCH] fix double ;;s in code
From: Joe Perches <joe@perches.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Daniel Vetter <daniel@ffwll.ch>,
	Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Pavel Machek <pavel@ucw.cz>, elfring@users.sourceforge.net, kernel list
 <linux-kernel@vger.kernel.org>, vgupta@synopsys.com, linux@armlinux.org.uk,
  oleg@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
 paulus@ozlabs.org,  benh@kernel.crashing.org, ard.biesheuvel@linaro.org,
 tglx@linutronix.de,  mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
 scott.bauer@intel.com,  jonathan.derrick@intel.com, axboe@kernel.dk,
 daniel.lezcano@linaro.org,  maxime.ripard@free-electrons.com,
 wens@csie.org, alexander.deucher@amd.com,  christian.koenig@amd.com,
 David1.Zhou@amd.com, airlied@linux.ie,  robdclark@gmail.com,
 joro@8bytes.org, shli@kernel.org, shawnguo@kernel.org,
 kernel@pengutronix.de, fabio.estevam@nxp.com, akpm@linux-foundation.org,
 Alexey.Brodkin@synopsys.com, mhocko@suse.com, vbabka@suse.cz,
 Vladislav.Zakharov@synopsys.com, noamca@mellanox.com,
 yamada.masahiro@socionext.com, sboyd@codeaurora.org,
 viresh.kumar@linaro.org,  linus.walleij@linaro.org, heiko@sntech.de,
 aik@ozlabs.ru, ruscur@russell.cc,  david@gibson.dropbear.id.au,
 fbarrat@linux.vnet.ibm.com, alistair@popple.id.au,  robh@kernel.org,
 harry.wentland@amd.com, tony.cheng@amd.com, Wenjing.Liu@amd.com,
 airlied@redhat.com, Ding.Wang@amd.com, sylvia.tsai@amd.com,
 hersenxs.wu@amd.com,  Rex.Zhu@amd.com, JinHuiEric.Huang@amd.com,
 dan.carpenter@oracle.com,  architt@codeaurora.org, daniel.vetter@ffwll.ch,
 narmstrong@baylibre.com,  ville.syrjala@linux.intel.com,
 jcrouse@codeaurora.org, aishpant@gmail.com,  noralf@tronnes.org,
 andresx7@gmail.com, Monk.Liu@amd.com, nicolai.haehnle@amd.com,
 Andrey.Grodzovsky@amd.com, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org,
 linux-block@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-raid@vger.kernel.org
Date: Tue, 20 Feb 2018 08:41:10 -0800
In-Reply-To: <87vaesrxn0.fsf@concordia.ellerman.id.au>
References: <20180217211955.GE9640@amd>
	 <187435d4-5017-edb5-9b6a-b433a148bfcc@c-s.fr>
	 <20180219154135.GV22199@phenom.ffwll.local>
	 <87vaesrxn0.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-02-20 at 17:19 +1100, Michael Ellerman wrote:
> Daniel Vetter <daniel@ffwll.ch> writes:
> > On Sun, Feb 18, 2018 at 11:00:56AM +0100, Christophe LEROY wrote:
> > > Le 17/02/2018 � 22:19, Pavel Machek a �crit :
> > > > 
> > > > Fix double ;;'s in code.
> > > > 
> > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > A summary of the files modified on top of the patch would help understand
> > > the impact.
> > > 
> > > A maybe there should be one patch by area, eg one for each arch specific
> > > modif and one for drivers/ and one for block/ ?
> > 
> > Yeah, pls split this into one patch per area, with a suitable patch
> > subject prefix. Look at git log of each file to get a feeling for what's
> > the standard in each area.
> 
> This part is actually pretty annoying.
> 
> I hacked up a script (below) which seems to do a reasonable job in most
> cases.

Here was another suggestion from awhile ago
https://lkml.org/lkml/2010/11/16/245
