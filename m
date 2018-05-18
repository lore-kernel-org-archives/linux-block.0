Return-Path: <palmer@sifive.com>
Return-Path: <palmer@sifive.com>
Date: Fri, 18 May 2018 13:33:13 -0700 (PDT)
Subject: Re: [PATCH v10 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
In-Reply-To: <20180515225124.20428-2-bart.vanassche@wdc.com>
CC: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
  Christoph Hellwig <hch@lst.de>, bart.vanassche@wdc.com, catalin.marinas@arm.com,
  Will Deacon <will.deacon@arm.com>, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org,
  jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
  schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, davem@davemloft.net, tglx@linutronix.de,
  mingo@redhat.com, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
  Arnd Bergmann <arnd@arndb.de>, corbet@lwn.net
From: Palmer Dabbelt <palmer@sifive.com>
To: bart.vanassche@wdc.com
Message-ID: <mhng-26ddbf89-8276-47a4-9235-e900f91fa575@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On Tue, 15 May 2018 15:51:20 PDT (-0700), bart.vanassche@wdc.com wrote:
> The next patch in this series introduces a call to cmpxchg64()
> in the block layer core for those architectures on which this
> functionality is available. Make it possible to test whether
> cmpxchg64() is available by introducing CONFIG_ARCH_HAVE_CMPXCHG64.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  .../features/locking/cmpxchg64/arch-support.txt    | 33 ++++++++++++++++++++++
>  arch/Kconfig                                       |  3 ++
>  arch/alpha/Kconfig                                 |  1 +
>  arch/arm/Kconfig                                   |  1 +
>  arch/arm64/Kconfig                                 |  1 +
>  arch/ia64/Kconfig                                  |  1 +
>  arch/m68k/Kconfig                                  |  1 +
>  arch/mips/Kconfig                                  |  1 +
>  arch/parisc/Kconfig                                |  1 +
>  arch/powerpc/Kconfig                               |  1 +
>  arch/riscv/Kconfig                                 |  1 +
>  arch/s390/Kconfig                                  |  1 +
>  arch/sparc/Kconfig                                 |  1 +
>  arch/x86/Kconfig                                   |  1 +
>  arch/xtensa/Kconfig                                |  1 +
>  15 files changed, 49 insertions(+)
>  create mode 100644 Documentation/features/locking/cmpxchg64/arch-support.txt

[...]

> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -8,6 +8,7 @@ config RISCV
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select OF_IRQ
> +	select ARCH_HAVE_CMPXCHG64
>  	select ARCH_WANT_FRAME_POINTERS
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK

If I understand correctly, we should only have ARCH_HAVE_CMPXCHG64 on 64-bit 
RISC-V systems so this should look something like

   select ARCH_HAVE_CMPXCHG64 if 64BIT

Of course, the RV32I port is broken right now so it's not a big deal, but we're 
working through making it less broken...
