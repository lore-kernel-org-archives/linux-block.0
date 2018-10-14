Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 06/24] powerpc/mm: properly set PAGE_KERNEL flags in ioremap()
In-Reply-To: <87d0sd19vm.fsf@concordia.ellerman.id.au>
References: <cover.1539092111.git.christophe.leroy@c-s.fr> <52bd80b06bae0d854d04501e1e136575b77fa9fa.1539092111.git.christophe.leroy@c-s.fr> <87d0sd19vm.fsf@concordia.ellerman.id.au>
Date: Sun, 14 Oct 2018 18:02:45 +1100
Message-ID: <87a7nh104q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> Set PAGE_KERNEL directly in the caller and do not rely on a
>> hack adding PAGE_KERNEL flags when _PAGE_PRESENT is not set.
>>
>> As already done for PPC64, use pgprot_cache() helpers instead of
>> _PAGE_XXX flags in PPC32 ioremap() derived functions.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> Something in here is breaking my p5020ds (both 32-bit and 64-bit):

Oh duh.

That's because I didn't take patch 4.

It didn't have any acks, but I guess I'll just merge it rather than
breaking things.

cheers
