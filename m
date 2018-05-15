Return-Path: <andrea.parri@amarulasolutions.com>
Return-Path: <andrea.parri@amarulasolutions.com>
Date: Tue, 15 May 2018 10:15:36 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Message-ID: <20180515081536.GA4901@andrea>
References: <20180514184634.2160-1-bart.vanassche@wdc.com>
 <20180514184634.2160-2-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180514184634.2160-2-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hi Bart,

On Mon, May 14, 2018 at 11:46:33AM -0700, Bart Van Assche wrote:

[...]

> diff --git a/Documentation/features/locking/cmpxchg64/arch-support.txt b/Documentation/features/locking/cmpxchg64/arch-support.txt
> new file mode 100644
> index 000000000000..65b3290ce5d5
> --- /dev/null
> +++ b/Documentation/features/locking/cmpxchg64/arch-support.txt
> @@ -0,0 +1,31 @@
> +#
> +# Feature name:          cmpxchg64
> +#         Kconfig:       ARCH_HAVE_CMPXCHG64
> +#         description:   arch supports the cmpxchg64() API
> +#
> +    -----------------------
> +    |         arch |status|
> +    -----------------------
> +    |       alpha: |  ok  |
> +    |         arc: | TODO |
> +    |         arm: |!thumb|
> +    |       arm64: |  ok  |
> +    |         c6x: | TODO |
> +    |       h8300: | TODO |
> +    |     hexagon: | TODO |
> +    |        ia64: |  ok  |
> +    |        m68k: |  ok  |
> +    |  microblaze: | TODO |
> +    |        mips: |64-bit|
> +    |       nios2: | TODO |
> +    |    openrisc: | TODO |
> +    |      parisc: |  ok  |
> +    |     powerpc: |64-bit|
> +    |        s390: |  ok  |
> +    |          sh: | TODO |
> +    |       sparc: |  ok  |
> +    |          um: | TODO |
> +    |   unicore32: | TODO |
> +    |         x86: |  ok  |
> +    |      xtensa: |  ok  |
> +    -----------------------

nds32 and riscv seem to be missing from the table. I'd also suggest
sticking to the three entries documented in

  Documentation/features/arch-support.txt
  
and using the header comment to provide any additional information.

A script that refreshes the arch support status file in place (from
the Kconfig files) is currently available in linux-next: c.f.,

  Documentation/features/scripts/features-refresh.sh

  Andrea
