Return-Path: <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] fix double ;;s in code
To: Pavel Machek <pavel@ucw.cz>, <elfring@users.sourceforge.net>,
	kernel list <linux-kernel@vger.kernel>, <linux@armlinux.org.uk>,
	<oleg@redhat.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<paulus@ozlabs.org>, <benh@kernel.crashing.org>,
	<mpe@ellerman.id.au>, <ard.biesheuvel@linaro.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<x86@kernel.org>, <scott.bauer@intel.com>,
	<jonathan.derrick@intel.com>, <axboe@kernel.dk>,
	<daniel.lezcano@linaro.org>, <maxime.ripard@free-electrons.com>,
	<wens@csie.org>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <David1.Zhou@amd.com>,
	<airlied@linux.ie>, <robdclark@gmail.com>, <joro@8bytes.org>,
	<shli@kernel.org>, <shawnguo@kernel.org>, <kernel@pengutronix.de>,
	<fabio.estevam@nxp.com>, <akpm@linux-foundation.org>,
	<Alexey.Brodkin@synopsys.com>, <mhocko@suse.com>, <vbabka@suse.cz>,
	<Vladislav.Zakharov@synopsys.com>, <noamca@mellanox.com>,
	<yamada.masahiro@socionext.com>, <sboyd@codeaurora.org>,
	<viresh.kumar@linaro.org>, <linus.walleij@linaro.org>,
	<heiko@sntech.de>, <aik@ozlabs.ru>, <ruscur@russell.cc>,
	<david@gibson.dropbear.id.au>, <fbarrat@linux.vnet.ibm.com>,
	<alistair@popple.id.au>, <robh@kernel.org>, <joe@perches.com>,
	<harry.wentland@amd.com>, <tony.cheng@amd.com>,
	<Wenjing.Liu@amd.com>, <airlied@redhat.com>, <Ding.Wang@amd.com>,
	<sylvia.tsai@amd.com>, <hersenxs.wu@amd.com>, <Rex.Zhu@amd.com>,
	<JinHuiEric.Huang@amd.com>, <dan.carpenter@oracle.com>,
	<architt@codeaurora.org>, <daniel.vetter@ffwll.ch>,
	<narmstrong@baylibre.com>, <ville.syrjala@linux.intel.com>,
	<jcrouse@codeaurora.org>, <aishpant@gmail.com>, <noralf@tronnes.org>,
	<andresx7@gmail.com>, <Monk.Liu@amd.com>, <nicolai.haehnle@amd.com>,
	<Andrey.Grodzovsky@amd.com>, <linux-snps-arc@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm-ppc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-efi@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
	<freedreno@lists.freedesktop.org>,
	<iommu@lists.linux-foundation.org>, <linux-raid@vger.kernel.org>
References: <20180217211955.GE9640@amd>
CC: Luis de Bethencourt <luisbg@kernel.org>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <f81083a2-4c64-b694-2059-16894e19a79e@synopsys.com>
Date: Mon, 19 Feb 2018 21:33:49 -0800
MIME-Version: 1.0
In-Reply-To: <20180217211955.GE9640@amd>
Content-Type: multipart/alternative;
	boundary="------------5F0C80F3EF0A744020863B16"
List-ID: <linux-block@vger.kernel.org>

--------------5F0C80F3EF0A744020863B16
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 02/17/2018 01:19 PM, Pavel Machek wrote:
> Fix double ;;'s in code.
>
> Signed-off-by: Pavel Machek<pavel@ucw.cz>
>
> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
> index 9d27331..ec12fe1 100644
> --- a/arch/arc/kernel/setup.c
> +++ b/arch/arc/kernel/setup.c
> @@ -373,7 +373,7 @@ static void arc_chk_core_config(void)
>   {
>   	struct cpuinfo_arc *cpu = &cpuinfo_arc700[smp_processor_id()];
>   	int saved = 0, present = 0;
> -	char *opt_nm = NULL;;
> +	char *opt_nm = NULL;
>   
>   	if (!cpu->extn.timer0)
>   		panic("Timer0 is not present!\n");
> diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
> index 333daab..183391d 100644
> --- a/arch/arc/kernel/unwind.c
> +++ b/arch/arc/kernel/unwind.c
> @@ -366,7 +366,7 @@ static void init_unwind_hdr(struct unwind_table *table,
>   	return;
>   
>   ret_err:
> -	panic("Attention !!! Dwarf FDE parsing errors\n");;
> +	panic("Attention !!! Dwarf FDE parsing errors\n");
>   }
>   

I have a fix from Luis to same effect from Jan sitting in my for-curr

Thx for it anyways.

-Vineet

--------------5F0C80F3EF0A744020863B16
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 02/17/2018 01:19 PM, Pavel Machek
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20180217211955.GE9640@amd">
      <pre wrap="">Fix double ;;'s in code.

Signed-off-by: Pavel Machek <a class="moz-txt-link-rfc2396E" href="mailto:pavel@ucw.cz" moz-do-not-send="true">&lt;pavel@ucw.cz&gt;</a>

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 9d27331..ec12fe1 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -373,7 +373,7 @@ static void arc_chk_core_config(void)
 {
 	struct cpuinfo_arc *cpu = &amp;cpuinfo_arc700[smp_processor_id()];
 	int saved = 0, present = 0;
-	char *opt_nm = NULL;;
+	char *opt_nm = NULL;
 
 	if (!cpu-&gt;extn.timer0)
 		panic("Timer0 is not present!\n");
diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 333daab..183391d 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -366,7 +366,7 @@ static void init_unwind_hdr(struct unwind_table *table,
 	return;
 
 ret_err:
-	panic("Attention !!! Dwarf FDE parsing errors\n");;
+	panic("Attention !!! Dwarf FDE parsing errors\n");
 }
 </pre>
    </blockquote>
    <br>
    <font face="DejaVu Sans">I have a fix from Luis to same effect from
      Jan sitting in my for-curr<br>
      <br>
      Thx for it anyways.<br>
      <br>
      -Vineet<br>
    </font>
  </body>
</html>

--------------5F0C80F3EF0A744020863B16--
