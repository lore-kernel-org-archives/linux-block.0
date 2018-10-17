Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: Crash on FSL Book3E due to pte_pgprot()? (was Re: [PATCH v3 12/24] powerpc/mm: use pte helpers in generic code)
In-Reply-To: <236d72cd-e6d7-61e5-2c80-e4311e41b4f6@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr> <343c844bbc5081d13ee4c9aa27ff3118f607e1cc.1539092112.git.christophe.leroy@c-s.fr> <87va61jsma.fsf@concordia.ellerman.id.au> <236d72cd-e6d7-61e5-2c80-e4311e41b4f6@c-s.fr>
Date: Wed, 17 Oct 2018 21:32:10 +1100
Message-ID: <87efcoeudx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> On 10/17/2018 12:59 AM, Michael Ellerman wrote:
...
>> The question is what's the right way to fix it? Should pte_pgprot() not
>> be filtering those bits out on book3e?
>
> I think we should not use pte_pggrot() for that then. What about the 
> below fix ?

Thanks, that almost works.

pte_mkprivileged() also needs to not strip _PAGE_BAP_SR.


But there's also a use of pte_pgprot() in mm/memory.c, and I think that
is also broken now that we don't add PAGE_KERNEL back in.

Aneesh is going to do a patch to make pte_pgprot() only mask the PFN
which is what other arches do.

cheers

> From: Christophe Leroy <christophe.leroy@c-s.fr>
> Date: Wed, 17 Oct 2018 05:56:25 +0000
> Subject: [PATCH] powerpc/mm: don't use pte_pgprot() in ioremap_prot()
>
> pte_pgprot() filters out some required flags like _PAGE_PRESENT.
>
> This patch replaces pte_pgprot() by __pgprot(pte_val())
> in ioremap_prot()
>
> Fixes: 26973fa5ac0e ("powerpc/mm: use pte helpers in generic code")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/mm/pgtable_32.c | 3 ++-
>   arch/powerpc/mm/pgtable_64.c | 4 ++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 5877f5aa8f5d..a606e2f4937b 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -122,7 +122,8 @@ ioremap_prot(phys_addr_t addr, unsigned long size, 
> unsigned long flags)
>   	pte = pte_exprotect(pte);
>   	pte = pte_mkprivileged(pte);
>
> -	return __ioremap_caller(addr, size, pte_pgprot(pte), 
> __builtin_return_address(0));
> +	return __ioremap_caller(addr, size, __pgprot(pte_val(pte)),
> +				__builtin_return_address(0));
>   }
>   EXPORT_SYMBOL(ioremap_prot);
>
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index fb1375c07e8c..836bf436cabb 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -245,8 +245,8 @@ void __iomem * ioremap_prot(phys_addr_t addr, 
> unsigned long size,
>   	pte = pte_mkprivileged(pte);
>
>   	if (ppc_md.ioremap)
> -		return ppc_md.ioremap(addr, size, pte_pgprot(pte), caller);
> -	return __ioremap_caller(addr, size, pte_pgprot(pte), caller);
> +		return ppc_md.ioremap(addr, size, __pgprot(pte_val(pte)), caller);
> +	return __ioremap_caller(addr, size, __pgprot(pte_val(pte)), caller);
>   }
>
>
> -- 
> 2.13.3
