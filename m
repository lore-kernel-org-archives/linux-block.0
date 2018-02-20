Return-Path: <jani.nikula@intel.com>
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Pavel Machek <pavel@ucw.cz>, Christophe LEROY <christophe.leroy@c-s.fr>,
 elfring@users.sourceforge.net, kernel list <linux-kernel@vger.kernel.org>,
 vgupta@synopsys.com, linux@armlinux.org.uk, oleg@redhat.com,
 catalin.marinas@arm.com, will.deacon@arm.com, paulus@ozlabs.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, ard.biesheuvel@linaro.org,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
 scott.bauer@intel.com, jonathan.derrick@intel.com, axboe@kernel.dk,
 daniel.lezcano@linaro.org, maxime.ripard@free-electrons.com,
 wens@csie.org, alexander.deucher@amd.com, christian.koenig@amd.com,
 David1.Zhou@amd.com, airlied@linux.ie, robdclark@gmail.com,
 joro@8bytes.org, shli@kernel.org, shawnguo@kernel.org,
 kernel@pengutronix.de, fabio.estevam@nxp.com, akpm@linux-foundation.org,
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
 architt@codeaurora.org, narmstrong@baylibre.com,
 ville.syrjala@linux.intel.com, jcrouse@codeaurora.org, aishpant@gmail.com,
 noralf@tronnes.org, andresx7@gmail.com, Monk.Liu@amd.com,
 nicolai.haehnle@amd.com, Andrey.Grodzovsky@amd.com,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH] fix double ;;s in code
In-Reply-To: <20180219193312.GA3709@amd>
References: <20180217211955.GE9640@amd> <187435d4-5017-edb5-9b6a-b433a148bfcc@c-s.fr> <20180219154135.GV22199@phenom.ffwll.local> <20180219193312.GA3709@amd>
Date: Tue, 20 Feb 2018 10:03:56 +0200
Message-ID: <87o9kkcck3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

On Mon, 19 Feb 2018, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2018-02-19 16:41:35, Daniel Vetter wrote:
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

Look, if this causes just one conflict down the line because it touches
the kernel all over the place, then IMO it already wasn't worth
it. Merge conflicts are inevitable, but there's no reason to make life
harder just to cater for a cleanup patch. It's not that important.

Had it been split up, the drm parts would've been merged already.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
