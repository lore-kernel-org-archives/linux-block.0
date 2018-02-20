Return-Path: <alexdeucher@gmail.com>
MIME-Version: 1.0
In-Reply-To: <87o9kkcck3.fsf@intel.com>
References: <20180217211955.GE9640@amd> <187435d4-5017-edb5-9b6a-b433a148bfcc@c-s.fr>
 <20180219154135.GV22199@phenom.ffwll.local> <20180219193312.GA3709@amd> <87o9kkcck3.fsf@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Feb 2018 11:34:20 -0500
Message-ID: <CADnq5_MY932hPkozosY4ODa5tB3qf7TYNxph1mt_qswkU4tBgw@mail.gmail.com>
Subject: Re: [PATCH] fix double ;;s in code
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Christophe LEROY <christophe.leroy@c-s.fr>,
	SF Markus Elfring <elfring@users.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>,
	vgupta@synopsys.com, Russell King <linux@armlinux.org.uk>, oleg@redhat.com,
	catalin.marinas@arm.com, will.deacon@arm.com, paulus@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au, ard.biesheuvel@linaro.org,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	scott.bauer@intel.com, jonathan.derrick@intel.com, axboe@kernel.dk,
	daniel.lezcano@linaro.org, Maxime Ripard <maxime.ripard@free-electrons.com>, wens@csie.org,
	"Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
	Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Rob Clark <robdclark@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Shaohua Li <shli@kernel.org>, shawnguo@kernel.org,
	Sascha Hauer <kernel@pengutronix.de>, fabio.estevam@nxp.com,
	Andrew Morton <akpm@linux-foundation.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, mhocko@suse.com,
	vbabka@suse.cz, Vladislav.Zakharov@synopsys.com, noamca@mellanox.com,
	yamada.masahiro@socionext.com, sboyd@codeaurora.org, viresh.kumar@linaro.org,
	linus.walleij@linaro.org, heiko@sntech.de, aik@ozlabs.ru, ruscur@russell.cc,
	david@gibson.dropbear.id.au, fbarrat@linux.vnet.ibm.com,
	alistair@popple.id.au, robh@kernel.org, Joe Perches <joe@perches.com>,
	"Wentland, Harry" <harry.wentland@amd.com>, "Cheng, Tony" <tony.cheng@amd.com>,
	Wenjing Liu <Wenjing.Liu@amd.com>, Dave Airlie <airlied@redhat.com>, Ding Wang <Ding.Wang@amd.com>,
	Sylvia Tsai <sylvia.tsai@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
	Eric Huang <JinHuiEric.Huang@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>,
	Archit Taneja <architt@codeaurora.org>, narmstrong@baylibre.com,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	Jordan Crouse <jcrouse@codeaurora.org>, aishpant@gmail.com,
	=?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
	Andres Rodriguez <andresx7@gmail.com>, "monk.liu" <Monk.Liu@amd.com>,
	=?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>,
	Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kvm-ppc@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-efi@vger.kernel.org,
	linux-block@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>,
	Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, freedreno <freedreno@lists.freedesktop.org>,
	iommu@lists.linux-foundation.org, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 20, 2018 at 3:03 AM, Jani Nikula
<jani.nikula@linux.intel.com> wrote:
> On Mon, 19 Feb 2018, Pavel Machek <pavel@ucw.cz> wrote:
>> On Mon 2018-02-19 16:41:35, Daniel Vetter wrote:
>>> Yeah, pls split this into one patch per area, with a suitable patch
>>> subject prefix. Look at git log of each file to get a feeling for what's
>>> the standard in each area.
>>
>> Yeah I can spend hour spliting it, and then people will ignore it
>> anyway.
>>
>> If you care about one of the files being modified, please fix the
>> bug, ";;" is a clear bug.
>>
>> If you don't care ... well I don't care either.
>
> Look, if this causes just one conflict down the line because it touches
> the kernel all over the place, then IMO it already wasn't worth
> it. Merge conflicts are inevitable, but there's no reason to make life
> harder just to cater for a cleanup patch. It's not that important.
>
> Had it been split up, the drm parts would've been merged already.

FWIW, the amdgpu and scheduler changes have already been fixed for -next.

Alex

>
> BR,
> Jani.
>
> --
> Jani Nikula, Intel Open Source Technology Center
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
