Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org, aneesh.kumar@linux.vnet.ibm.com, Scott Wood <oss@buserror.net>, Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>, Li Yang <leoyang.li@nxp.com>, Kumar Gala <galak@kernel.crashing.org>, Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 06/24] powerpc/mm: properly set PAGE_KERNEL flags in ioremap()
In-Reply-To: <20181014115810.Horde.99_1JiRv0nxT_Jq3cbpMhw1@messagerie.si.c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr> <52bd80b06bae0d854d04501e1e136575b77fa9fa.1539092111.git.christophe.leroy@c-s.fr> <87d0sd19vm.fsf@concordia.ellerman.id.au> <87a7nh104q.fsf@concordia.ellerman.id.au> <20181014115810.Horde.99_1JiRv0nxT_Jq3cbpMhw1@messagerie.si.c-s.fr>
Date: Mon, 15 Oct 2018 20:25:41 +1100
Message-ID: <87zhvfzhm2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

LEROY Christophe <christophe.leroy@c-s.fr> writes:
> Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> Set PAGE_KERNEL directly in the caller and do not rely on a
>>>> hack adding PAGE_KERNEL flags when _PAGE_PRESENT is not set.
>>>>
>>>> As already done for PPC64, use pgprot_cache() helpers instead of
>>>> _PAGE_XXX flags in PPC32 ioremap() derived functions.
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>
>>> Something in here is breaking my p5020ds (both 32-bit and 64-bit):
>>
>> Oh duh.
>>
>> That's because I didn't take patch 4.
>>
>> It didn't have any acks, but I guess I'll just merge it rather than
>> breaking things.
>
> Yes indeed. Maybe should I have followed it more carrefully to ensure=20=
=20
> it gets an ack.

That's OK, I should have paid more attention to what it was actually
doing, I thought it was just a cleanup.

cheers
