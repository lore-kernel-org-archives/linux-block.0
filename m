Return-Path: <aneesh.kumar@linux.ibm.com>
Subject: Re: Crash on FSL Book3E due to pte_pgprot()? (was Re: [PATCH v3
 12/24] powerpc/mm: use pte helpers in generic code)
To: Christophe Leroy <christophe.leroy@c-s.fr>,
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
 <236d72cd-e6d7-61e5-2c80-e4311e41b4f6@c-s.fr>
 <87efcoeudx.fsf@concordia.ellerman.id.au>
 <6ec9cf4b-abd2-8244-4780-4564a7ffb1ad@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 17 Oct 2018 17:23:38 +0530
MIME-Version: 1.0
In-Reply-To: <6ec9cf4b-abd2-8244-4780-4564a7ffb1ad@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e3b03750-f76a-0a70-69ff-3767382859c6@linux.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On 10/17/18 4:42 PM, Christophe Leroy wrote:
> 
> 
> On 10/17/2018 10:32 AM, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> On 10/17/2018 12:59 AM, Michael Ellerman wrote:
>> ...
>>>> The question is what's the right way to fix it? Should pte_pgprot() not
>>>> be filtering those bits out on book3e?
>>>
>>> I think we should not use pte_pggrot() for that then. What about the
>>> below fix ?
>>
>> Thanks, that almost works.
>>
>> pte_mkprivileged() also needs to not strip _PAGE_BAP_SR.
> 
> Oops, I missed it allthough I knew it. Patch below.
> 
> From: Christophe Leroy <christophe.leroy@c-s.fr>
> Date: Wed, 17 Oct 2018 10:46:24 +0000
> Subject: [PATCH] powerpc/book3e: redefine pte_mkprivileged() and 
> pte_mkuser()
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras 
> <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
> 
> Book3e defines both _PAGE_USER and _PAGE_PRIVILEGED, so the nohash
> default pte_mkprivileged() and pte_mkuser() are not usable.
> 
> This patch redefines them for book3e.
> 
> Fixes: a0da4bc166f2 ("powerpc/mm: Allow platforms to redefine some 
> helpers")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/nohash/pte-book3e.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h 
> b/arch/powerpc/include/asm/nohash/pte-book3e.h
> index 58eef8cb569d..fb4297dff3e2 100644
> --- a/arch/powerpc/include/asm/nohash/pte-book3e.h
> +++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
> @@ -109,5 +109,19 @@
>   #define PAGE_READONLY    __pgprot(_PAGE_BASE | _PAGE_USER)
>   #define PAGE_READONLY_X    __pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
> 
> +static inline pte_t pte_mkprivileged(pte_t pte)
> +{
> +    return __pte((pte_val(pte) & ~_PAGE_USER) | _PAGE_PRIVILEGED);
> +}
> +
> +#define pte_mkprivileged pte_mkprivileged
> +
> +static inline pte_t pte_mkuser(pte_t pte)
> +{
> +    return __pte((pte_val(pte) & ~_PAGE_PRIVILEGED) | _PAGE_USER);
> +}
> +
> +#define pte_mkuser pte_mkuser
> +

I was build testing a similar patch. We would need to put #ifndef 
__ASSEMBLY__ around it.



-aneesh
