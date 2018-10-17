Return-Path: <christophe.leroy@c-s.fr>
Subject: Re: Crash on FSL Book3E due to pte_pgprot()? (was Re: [PATCH v3
 12/24] powerpc/mm: use pte helpers in generic code)
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <343c844bbc5081d13ee4c9aa27ff3118f607e1cc.1539092112.git.christophe.leroy@c-s.fr>
 <87va61jsma.fsf@concordia.ellerman.id.au>
 <236d72cd-e6d7-61e5-2c80-e4311e41b4f6@c-s.fr> <87ftx4x67q.fsf@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <bc7b2996-45b4-fc39-6795-da2489b3fd27@c-s.fr>
Date: Wed, 17 Oct 2018 11:55:12 +0200
MIME-Version: 1.0
In-Reply-To: <87ftx4x67q.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



Le 17/10/2018 à 11:39, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> On 10/17/2018 12:59 AM, Michael Ellerman wrote:
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> Get rid of platform specific _PAGE_XXXX in powerpc common code and
>>>> use helpers instead.
>>>>
>>>> mm/dump_linuxpagetables.c will be handled separately
>>>>
>>>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> ---
>>>>    arch/powerpc/include/asm/book3s/32/pgtable.h |  9 +++------
>>>>    arch/powerpc/include/asm/nohash/32/pgtable.h | 12 ++++++++----
>>>>    arch/powerpc/include/asm/nohash/pgtable.h    |  3 +--
>>>>    arch/powerpc/mm/pgtable.c                    | 21 +++++++--------------
>>>>    arch/powerpc/mm/pgtable_32.c                 | 15 ++++++++-------
>>>>    arch/powerpc/mm/pgtable_64.c                 | 14 +++++++-------
>>>>    arch/powerpc/xmon/xmon.c                     | 12 +++++++-----
>>>>    7 files changed, 41 insertions(+), 45 deletions(-)
>>>
>>> So turns out this patch *also* breaks my p5020ds :)
>>>
>>> Even with patch 4 merged, see next.
>>>
>>> It's the same crash:
>>>
>>>     pcieport 2000:00:00.0: AER enabled with IRQ 480
>>>     Unable to handle kernel paging request for data at address 0x8000080080080000
>>>     Faulting instruction address: 0xc0000000000192cc
>>>     Oops: Kernel access of bad area, sig: 11 [#1]
>>>     BE SMP NR_CPUS=24 CoreNet Generic
>>>     Modules linked in:
>>>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc3-gcc7x-g98c847323b3a #1
>>>     NIP:  c0000000000192cc LR: c0000000005d0f9c CTR: 0000000000100000
>>>     REGS: c0000000f31bb400 TRAP: 0300   Not tainted  (4.19.0-rc3-gcc7x-g98c847323b3a)
>>>     MSR:  0000000080029000 <CE,EE,ME>  CR: 24000224  XER: 00000000
>>>     DEAR: 8000080080080000 ESR: 0000000000800000 IRQMASK: 0
>>>     GPR00: c0000000005d0f84 c0000000f31bb688 c00000000117dc00 8000080080080000
>>>     GPR04: 0000000000000000 0000000000400000 00000ffbff241010 c0000000f31b8000
>>>     GPR08: 0000000000000000 0000000000100000 0000000000000000 c0000000012d4710
>>>     GPR12: 0000000084000422 c0000000012ff000 c000000000002774 0000000000000000
>>>     GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>>     GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>>     GPR24: 0000000000000000 0000000000000000 8000080080080000 c0000000ffff89a8
>>>     GPR28: c0000000f3576400 c0000000f3576410 0000000000400000 c0000000012ecc98
>>>     NIP [c0000000000192cc] ._memset_io+0x6c/0x9c
>>>     LR [c0000000005d0f9c] .fsl_qman_probe+0x198/0x928
>>>     Call Trace:
>>>     [c0000000f31bb688] [c0000000005d0f84] .fsl_qman_probe+0x180/0x928 (unreliable)
>>>     [c0000000f31bb728] [c0000000006432ec] .platform_drv_probe+0x60/0xb4
>>>     [c0000000f31bb7a8] [c00000000064083c] .really_probe+0x294/0x35c
>>>     [c0000000f31bb848] [c000000000640d2c] .__driver_attach+0x148/0x14c
>>>     [c0000000f31bb8d8] [c00000000063d7dc] .bus_for_each_dev+0xb0/0x118
>>>     [c0000000f31bb988] [c00000000063ff28] .driver_attach+0x34/0x4c
>>>     [c0000000f31bba08] [c00000000063f648] .bus_add_driver+0x174/0x2bc
>>>     [c0000000f31bbaa8] [c0000000006418bc] .driver_register+0x90/0x180
>>>     [c0000000f31bbb28] [c000000000643270] .__platform_driver_register+0x60/0x7c
>>>     [c0000000f31bbba8] [c000000000ee2a70] .fsl_qman_driver_init+0x24/0x38
>>>     [c0000000f31bbc18] [c0000000000023fc] .do_one_initcall+0x64/0x2b8
>>>     [c0000000f31bbcf8] [c000000000e9f480] .kernel_init_freeable+0x3a8/0x494
>>>     [c0000000f31bbda8] [c000000000002798] .kernel_init+0x24/0x148
>>>     [c0000000f31bbe28] [c0000000000009e8] .ret_from_kernel_thread+0x58/0x70
>>>     Instruction dump:
>>>     4e800020 2ba50003 40dd003c 3925fffc 5488402e 7929f082 7d082378 39290001
>>>     550a801e 7d2903a6 7d4a4378 794a0020 <91430000> 38630004 4200fff8 70a50003
>>>
>>>
>>> Comparing a working vs broken kernel, it seems to boil down to the fact
>>> that we're filtering out more PTE bits now that we use pte_pgprot() in
>>> ioremap_prot().
>>>
>>> With the old code we get:
>>>     ioremap_prot: addr 0xff800000 flags 0x241215
>>>     ioremap_prot: addr 0xff800000 flags 0x241215
>>>     map_kernel_page: ea 0x8000080080080000 pa 0xff800000 pte 0xff800241215
>>>
>>>
>>> And now we get:
>>>     ioremap_prot: addr 0xff800000 flags 0x241215 pte 0x241215
>>>     ioremap_prot: addr 0xff800000 pte 0x241215
>>>     ioremap_prot: addr 0xff800000 prot 0x241014
>>>     map_kernel_page: ea 0x8000080080080000 pa 0xff800000 pte 0xff800241014
>>>
>>> So we're losing 0x201, which for nohash book3e is:
>>>
>>>     #define _PAGE_PRESENT	0x000001 /* software: pte contains a translation */
>>>     #define _PAGE_PSIZE_4K	0x000200
>>>
>>>
>>> I haven't worked out if it's one or both of those that matter.
>>
>> At least missing _PAGE_PRESENT is an issue I believe.
>>>
>>> The question is what's the right way to fix it? Should pte_pgprot() not
>>> be filtering those bits out on book3e?
>>
>> I think we should not use pte_pggrot() for that then. What about the
>> below fix ?
>>
>> Christophe
>>
>> From: Christophe Leroy <christophe.leroy@c-s.fr>
>> Date: Wed, 17 Oct 2018 05:56:25 +0000
>> Subject: [PATCH] powerpc/mm: don't use pte_pgprot() in ioremap_prot()
>>
>> pte_pgprot() filters out some required flags like _PAGE_PRESENT.
>>
>> This patch replaces pte_pgprot() by __pgprot(pte_val())
>> in ioremap_prot()
>>
>> Fixes: 26973fa5ac0e ("powerpc/mm: use pte helpers in generic code")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>    arch/powerpc/mm/pgtable_32.c | 3 ++-
>>    arch/powerpc/mm/pgtable_64.c | 4 ++--
>>    2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index 5877f5aa8f5d..a606e2f4937b 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -122,7 +122,8 @@ ioremap_prot(phys_addr_t addr, unsigned long size,
>> unsigned long flags)
>>    	pte = pte_exprotect(pte);
>>    	pte = pte_mkprivileged(pte);
>>
>> -	return __ioremap_caller(addr, size, pte_pgprot(pte),
>> __builtin_return_address(0));
>> +	return __ioremap_caller(addr, size, __pgprot(pte_val(pte)),
>> +				__builtin_return_address(0));
> 
> 
> That means we pass the pfn bits also to __ioremap_caller right? How about
> 
>  From b4d5e0f24f8482375b2dd86afaced26ebf716600 Mon Sep 17 00:00:00 2001
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Date: Wed, 17 Oct 2018 14:07:50 +0530
> Subject: [PATCH] powerpc/mm: Make pte_pgprot return all pte bits
> 
> Other archs do the same and instead of adding required pte bits (which got
> masked out) in __ioremap_at, make sure we filter only pfn bits out.
> 
> Fixes: 26973fa5ac0e ("powerpc/mm: use pte helpers in generic code")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Looks good for me.

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/include/asm/book3s/32/pgtable.h       |  6 ------
>   arch/powerpc/include/asm/book3s/64/pgtable.h       |  8 --------
>   arch/powerpc/include/asm/nohash/32/pte-40x.h       |  5 -----
>   arch/powerpc/include/asm/nohash/32/pte-44x.h       |  5 -----
>   arch/powerpc/include/asm/nohash/32/pte-8xx.h       |  5 -----
>   arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h |  5 -----
>   arch/powerpc/include/asm/nohash/pgtable.h          |  1 -
>   arch/powerpc/include/asm/nohash/pte-book3e.h       |  5 -----
>   arch/powerpc/include/asm/pgtable.h                 | 10 ++++++++++
>   9 files changed, 10 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 0fbd4c642b51..e61dd3ae5bc0 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -48,11 +48,6 @@ static inline bool pte_user(pte_t pte)
>   #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HASHPTE | _PAGE_DIRTY | \
>   			 _PAGE_ACCESSED | _PAGE_SPECIAL)
>   
> -/* Mask of bits returned by pte_pgprot() */
> -#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
> -			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
> -			 _PAGE_RW | _PAGE_DIRTY)
> -
>   /*
>    * We define 2 sets of base prot bits, one for basic pages (ie,
>    * cacheable kernel and user pages) and one for non cacheable
> @@ -396,7 +391,6 @@ static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSE
>   static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
>   static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
>   static inline bool pte_exec(pte_t pte)		{ return true; }
> -static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
>   
>   static inline int pte_present(pte_t pte)
>   {
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index c34a161dc651..cb5dd4078d42 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -128,13 +128,6 @@
>   
>   #define H_PTE_PKEY  (H_PTE_PKEY_BIT0 | H_PTE_PKEY_BIT1 | H_PTE_PKEY_BIT2 | \
>   		     H_PTE_PKEY_BIT3 | H_PTE_PKEY_BIT4)
> -/*
> - * Mask of bits returned by pte_pgprot()
> - */
> -#define PAGE_PROT_BITS  (_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT | \
> -			 H_PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
> -			 _PAGE_READ | _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
> -			 _PAGE_SOFT_DIRTY | H_PTE_PKEY)
>   /*
>    * We define 2 sets of base prot bits, one for basic pages (ie,
>    * cacheable kernel and user pages) and one for non cacheable
> @@ -496,7 +489,6 @@ static inline bool pte_exec(pte_t pte)
>   	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_EXEC));
>   }
>   
> -static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
>   
>   #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>   static inline bool pte_soft_dirty(pte_t pte)
> diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
> index 7a8b3c94592f..661f4599f2fc 100644
> --- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
> +++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
> @@ -73,11 +73,6 @@
>   /* Until my rework is finished, 40x still needs atomic PTE updates */
>   #define PTE_ATOMIC_UPDATES	1
>   
> -/* Mask of bits returned by pte_pgprot() */
> -#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_NO_CACHE | \
> -			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
> -			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | _PAGE_EXEC)
> -
>   #define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
>   #define _PAGE_BASE	(_PAGE_BASE_NC)
>   
> diff --git a/arch/powerpc/include/asm/nohash/32/pte-44x.h b/arch/powerpc/include/asm/nohash/32/pte-44x.h
> index 8d6b268a986f..78bc304f750e 100644
> --- a/arch/powerpc/include/asm/nohash/32/pte-44x.h
> +++ b/arch/powerpc/include/asm/nohash/32/pte-44x.h
> @@ -93,11 +93,6 @@
>   #define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW)
>   #define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
>   
> -/* Mask of bits returned by pte_pgprot() */
> -#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
> -			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
> -			 _PAGE_RW | _PAGE_DIRTY | _PAGE_EXEC)
> -
>   /* TODO: Add large page lowmem mapping support */
>   #define _PMD_PRESENT	0
>   #define _PMD_PRESENT_MASK (PAGE_MASK)
> diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> index 1c57efac089d..6bfe041ef59d 100644
> --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> @@ -55,11 +55,6 @@
>   #define _PAGE_KERNEL_RW		(_PAGE_SH | _PAGE_DIRTY)
>   #define _PAGE_KERNEL_RWX	(_PAGE_SH | _PAGE_DIRTY | _PAGE_EXEC)
>   
> -/* Mask of bits returned by pte_pgprot() */
> -#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_NO_CACHE | \
> -			 _PAGE_ACCESSED | _PAGE_RO | _PAGE_NA | \
> -			 _PAGE_SH | _PAGE_DIRTY | _PAGE_EXEC)
> -
>   #define _PMD_PRESENT	0x0001
>   #define _PMD_PRESENT_MASK	_PMD_PRESENT
>   #define _PMD_BAD	0x0fd0
> diff --git a/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h b/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
> index 1ecf60fe0909..0fc1bd42bb3e 100644
> --- a/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
> +++ b/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
> @@ -39,11 +39,6 @@
>   /* No page size encoding in the linux PTE */
>   #define _PAGE_PSIZE		0
>   
> -/* Mask of bits returned by pte_pgprot() */
> -#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
> -			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
> -			 _PAGE_RW | _PAGE_DIRTY | _PAGE_EXEC)
> -
>   #define _PMD_PRESENT	0
>   #define _PMD_PRESENT_MASK (PAGE_MASK)
>   #define _PMD_BAD	(~PAGE_MASK)
> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
> index 04e9f0922ad4..70ff23974b59 100644
> --- a/arch/powerpc/include/asm/nohash/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
> @@ -52,7 +52,6 @@ static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK)
>   static inline bool pte_hashpte(pte_t pte)	{ return false; }
>   static inline bool pte_ci(pte_t pte)		{ return pte_val(pte) & _PAGE_NO_CACHE; }
>   static inline bool pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_EXEC; }
> -static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
>   
>   #ifdef CONFIG_NUMA_BALANCING
>   /*
> diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
> index 58eef8cb569d..f95ab6eaf441 100644
> --- a/arch/powerpc/include/asm/nohash/pte-book3e.h
> +++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
> @@ -82,11 +82,6 @@
>   #define _PTE_NONE_MASK	0
>   #endif
>   
> -/* Mask of bits returned by pte_pgprot() */
> -#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
> -			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
> -			 _PAGE_PRIVILEGED | _PAGE_RW | _PAGE_DIRTY | _PAGE_EXEC)
> -
>   /*
>    * We define 2 sets of base prot bits, one for basic pages (ie,
>    * cacheable kernel and user pages) and one for non cacheable
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index fb4b85bba110..9679b7519a35 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -46,6 +46,16 @@ struct mm_struct;
>   /* Keep these as a macros to avoid include dependency mess */
>   #define pte_page(x)		pfn_to_page(pte_pfn(x))
>   #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
> +/*
> + * Select all bits except the pfn
> + */
> +static inline pgprot_t pte_pgprot(pte_t pte)
> +{
> +	unsigned long pte_flags;
> +
> +	pte_flags = pte_val(pte) & ~PTE_RPN_MASK;
> +	return __pgprot(pte_flags);
> +}
>   
>   /*
>    * ZERO_PAGE is a global shared page that is always zero: used
> 
