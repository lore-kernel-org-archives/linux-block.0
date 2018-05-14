Return-Path: <jcmvbkbc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180514184634.2160-2-bart.vanassche@wdc.com>
References: <20180514184634.2160-1-bart.vanassche@wdc.com> <20180514184634.2160-2-bart.vanassche@wdc.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 14 May 2018 11:50:20 -0700
Message-ID: <CAMo8Bf+Wgm2VrZiY+CfjN=CM=ysYBpRyTMdozV+6A8Brk4DKDQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	"David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, May 14, 2018 at 11:46 AM, Bart Van Assche
<bart.vanassche@wdc.com> wrote:
> The next patch in this series introduces a call to cmpxchg64()
> in the block layer core for those architectures on which this
> functionality is available. Make it possible to test whether
> cmpxchg64() is available by introducing CONFIG_ARCH_HAVE_CMPXCHG64.
>
> ---

[...]

> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index c921e8bccdc8..8234278a821d 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -23,6 +23,7 @@ config XTENSA
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_EXIT_THREAD
>         select HAVE_FUNCTION_TRACER
> +       select ARCH_HAVE_CMPXCHG64

This breaks alphabetical sorting of Kconfig entries.

>         select HAVE_FUTEX_CMPXCHG if !MMU
>         select HAVE_HW_BREAKPOINT if PERF_EVENTS
>         select HAVE_IRQ_TIME_ACCOUNTING

-- 
Thanks.
-- Max
