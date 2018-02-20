Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Vetter <daniel@ffwll.ch>, Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Pavel Machek <pavel@ucw.cz>, elfring@users.sourceforge.net, kernel list
 <linux-kernel@vger.kernel.org>, vgupta@synopsys.com,
 linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com, paulus@ozlabs.org, benh@kernel.crashing.org,
 ard.biesheuvel@linaro.org, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, x86@kernel.org, scott.bauer@intel.com,
 jonathan.derrick@intel.com, axboe@kernel.dk, daniel.lezcano@linaro.org,
 maxime.ripard@free-electrons.com, wens@csie.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com,
 airlied@linux.ie, robdclark@gmail.com, joro@8bytes.org, shli@kernel.org,
 shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
 akpm@linux-foundation.org, Alexey.Brodkin@synopsys.com, mhocko@suse.com,
 vbabka@suse.cz, Vladislav.Zakharov@synopsys.com, noamca@mellanox.com,
 yamada.masahiro@socionext.com, sboyd@codeaurora.org,
 viresh.kumar@linaro.org, linus.walleij@linaro.org, heiko@sntech.de,
 aik@ozlabs.ru, ruscur@russell.cc, david@gibson.dropbear.id.au,
 fbarrat@linux.vnet.ibm.com, alistair@popple.id.au, robh@kernel.org,
 joe@perches.com, harry.wentland@amd.com, tony.cheng@amd.com,
 Wenjing.Liu@amd.com, airlied@redhat.com, Ding.Wang@amd.com,
 sylvia.tsai@amd.com, hersenxs.wu@amd.com, Rex.Zhu@amd.com,
 JinHuiEric.Huang@amd.com, dan.carpenter@oracle.com,
 architt@codeaurora.org, daniel.vetter@ffwll.ch, narmstrong@baylibre.com,
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
In-Reply-To: <20180219154135.GV22199@phenom.ffwll.local>
References: <20180217211955.GE9640@amd> <187435d4-5017-edb5-9b6a-b433a148bfcc@c-s.fr> <20180219154135.GV22199@phenom.ffwll.local>
Date: Tue, 20 Feb 2018 17:19:31 +1100
Message-ID: <87vaesrxn0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Daniel Vetter <daniel@ffwll.ch> writes:
> On Sun, Feb 18, 2018 at 11:00:56AM +0100, Christophe LEROY wrote:
>> Le 17/02/2018 =C3=A0 22:19, Pavel Machek a =C3=A9crit=C2=A0:
>> >=20
>> > Fix double ;;'s in code.
>> >=20
>> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>=20
>> A summary of the files modified on top of the patch would help understand
>> the impact.
>>=20
>> A maybe there should be one patch by area, eg one for each arch specific
>> modif and one for drivers/ and one for block/ ?
>
> Yeah, pls split this into one patch per area, with a suitable patch
> subject prefix. Look at git log of each file to get a feeling for what's
> the standard in each area.

This part is actually pretty annoying.

I hacked up a script (below) which seems to do a reasonable job in most
cases.

For this patch it gives:

  $ for f in $(git ls-files -m); do ./guess-prefix.py $f; done
  ARC:=20
  ARC:=20
  ARM:=20
  arm64: ptrace:=20
  KVM: PPC:=20
  powerpc/powernv:
  x86/efi:
  block/sed-opal:
  clocksource: mips-gic:=20
  clocksource/drivers/sun5i:
  drm/amd/display:
  drm/amd/powerplay:
  drm/msm/mdp5:
  drm:=20
  iommu/vt-d:
  md:=20
  soc: imx: gpc:=20

I think those are correct except for:
 - "drm:" for "drivers/gpu/drm/scheduler" which has only a single commit.
 - "md:" for "drivers/md/raid1.c" which is tricked by inconsistent
    usage of "md: raid1:" and "md/raid1:".

But that seems like a reasonable hit rate.

Another approach would be to have a file that defines for each subsystem
what the preferred style is, but that is likely to be a PITA to
maintain.

cheers


#!/usr/bin/python3

import sys
import re
from subprocess import check_output
from collections import Counter

if len(sys.argv) !=3D 2:
    print('Usage: %s <path>' % sys.argv[0], file=3Dsys.stderr)
    sys.exit(1)

fname =3D sys.argv[1]

cmd =3D ['git', 'log', '--format=3D%s', '-n', '100', fname]
output =3D check_output(cmd).decode('utf-8')

ignore =3D ['License', 'Merge']

# Ordered list of patterns
patterns =3D [
    # Common style "foo/bar/baz: Fix the foo"
    re.compile('^([\w\-_]+: )+'),
    # Less common "foo bar baz: Fix the foo"
    re.compile('^([\w\-_]+:? )+: ')
]

words =3D []
for line in output.splitlines():
    prefix =3D line.split()[0]
    for patt in patterns:
        match =3D patt.search(line)
        if match:
            prefix =3D match.group(0)
            break

    if prefix in ignore:
        continue

    words.append(prefix)

# Warn if we didn't find many examples
if len(words) < 5:
    print("Warning: only found %d previous commits to guess from for" % len=
(words),
          fname, file=3Dsys.stderr)

counts =3D Counter(words)
print(counts.most_common(1)[0][0])
