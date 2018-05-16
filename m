Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v10 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
In-Reply-To: <20180515225124.20428-2-bart.vanassche@wdc.com>
References: <20180515225124.20428-1-bart.vanassche@wdc.com> <20180515225124.20428-2-bart.vanassche@wdc.com>
Date: Wed, 16 May 2018 14:15:03 +1000
Message-ID: <87eficnsmw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Bart Van Assche <bart.vanassche@wdc.com> writes:

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c32a181a7cbb..901365d12dcd 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -149,6 +149,7 @@ config PPC
>  	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
> +	select ARCH_HAVE_CMPXCHG64		if PPC64
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_MIGHT_HAVE_PC_SERIO

LGTM. Thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
