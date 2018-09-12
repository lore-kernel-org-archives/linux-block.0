Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <cover.1536692743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 00/24] ban the use of _PAGE_XXX flags outside platform specific code
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Wed, 12 Sep 2018 15:58:13 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

Today flags like for instance _PAGE_RW or _PAGE_USER are used through
common parts of code.
Using those directly in common parts of code have proven to lead to
mistakes or misbehaviour, because their use is not always as trivial
as one could think.

For instance, (flags & _PAGE_USER) == 0 isn't enough to tell
that a page is a kernel page, because some targets are using
_PAGE_PRIVILEDGED and not _PAGE_USER, so the test has to be 
(flags & (_PAGE_USER | _PAGE_PRIVILEDGED)) == _PAGE_PRIVILEDGED
This has too (bad) consequences:

 - All targets must define every bit, even the unsupported ones,
   leading to a lot of useless #define _PAGE_XXX 0
 - If someone forgets to take into account all possible _PAGE_XXX bits
   for the case, we can get unexpected behaviour on some targets.

This becomes even more complex when we come to using _PAGE_RW.
Testing (flags & _PAGE_RW) is not enough to test whether a page
if writable or not, because:

 - Some targets have _PAGE_RO instead, which has to be unset to tell
   a page is writable
 - Some targets have _PAGE_R and _PAGE_W, in which case
   _PAGE_RW = _PAGE_R | _PAGE_W
 - Even knowing whether a page is readable is not always trivial because:
   - Some targets requires to check that _PAGE_R is set to ensure page
   is readable
   - Some targets requires to check that _PAGE_NA is not set
   - Some targets requires to check that _PAGE_RO or _PAGE_RW is set

Etc ....

In order to work around all those issues and minimise the risks of errors,
this serie aims at removing all use of _PAGE_XXX flags from powerpc code
and always use pte_xxx() and pte_mkxxx() accessors instead. Those accessors
are then defined in platform specific parts of the kernel code.

Compared to the RFC, v2 adds three things:
- A work on ioremap() alike functions: properly set the base flags
  by all callers and removed the hack which sets the base flags when
  the caller don't give them.
- _PAGE_EXEC flag is replaced by a bool in the call to hash_preload()
- Optimisation of pte_mkXXX() helpers on book3s64 to avoid multiple
endian conversions.

v2 compilation test result: http://kisskb.ellerman.id.au/kisskb/head/51b7f5d55900688c7c07cdb945d34b3314befa36/

Christophe Leroy (24):
  powerpc/32: Add ioremap_wt() and ioremap_coherent()
  drivers/video/fbdev: use ioremap_wc/wt() instead of __ioremap()
  drivers/block/z2ram: use ioremap_wt() instead of
    __ioremap(_PAGE_WRITETHRU)
  soc/fsl/qbman: use ioremap_cache() instead of ioremap_prot(0)
  powerpc: don't use ioremap_prot() nor __ioremap() unless really
    needed.
  powerpc/mm: properly set PAGE_KERNEL flags in ioremap()
  powerpc: handover page flags with a pgprot_t parameter
  powerpc/mm: don't use _PAGE_EXEC in book3s/32
  powerpc/mm: move some nohash pte helpers in nohash/[32:64]/pgtable.h
  powerpc/mm: add pte helpers to query and change pte flags
  powerpc/mm: don't use _PAGE_EXEC for calling hash_preload()
  powerpc/mm: use pte helpers in generic code
  powerpc/mm: Split dump_pagelinuxtables flag_array table
  powerpc/mm: drop unused page flags
  powerpc/mm: move __P and __S tables in the common pgtable.h
  powerpc/book3s/32: do not include pte-common.h
  powerpc/mm: Move pte_user() into nohash/pgtable.h
  powerpc/mm: Distribute platform specific PAGE and PMD flags and
    definitions
  powerpc/nohash/64: do not include pte-common.h
  powerpc/mm: Allow platforms to redefine some helpers
  powerpc/mm: Define platform default caches related flags
  powerpc/mm: Get rid of pte-common.h
  powerpc/8xx: change name of a few page flags to avoid confusion
  powerpc/book3s64: Avoid multiple endian conversion in pte helpers

 arch/powerpc/include/asm/book3s/32/pgtable.h       | 146 ++++++++++++--
 arch/powerpc/include/asm/book3s/64/hash.h          |   3 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       | 128 ++++++------
 arch/powerpc/include/asm/fixmap.h                  |   2 +-
 arch/powerpc/include/asm/io.h                      |  13 +-
 arch/powerpc/include/asm/machdep.h                 |   2 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  66 ++++++-
 arch/powerpc/include/asm/nohash/32/pte-40x.h       |  48 +++++
 arch/powerpc/include/asm/nohash/32/pte-44x.h       |  35 ++++
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |  92 ++++++++-
 arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h |  38 ++++
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  40 +++-
 arch/powerpc/include/asm/nohash/pgtable.h          |  93 ++++++---
 arch/powerpc/include/asm/nohash/pte-book3e.h       |  30 +++
 arch/powerpc/include/asm/pgtable.h                 |  19 ++
 arch/powerpc/include/asm/pte-common.h              | 219 ---------------------
 arch/powerpc/kernel/btext.c                        |   2 +-
 arch/powerpc/kernel/crash_dump.c                   |   2 +-
 arch/powerpc/kernel/head_8xx.S                     |   6 +-
 arch/powerpc/kernel/io-workarounds.c               |   4 +-
 arch/powerpc/kernel/isa-bridge.c                   |   6 +-
 arch/powerpc/kernel/pci_64.c                       |   2 +-
 arch/powerpc/lib/code-patching.c                   |   3 +-
 arch/powerpc/mm/8xx_mmu.c                          |   5 +-
 arch/powerpc/mm/Makefile                           |   7 +
 arch/powerpc/mm/dma-noncoherent.c                  |   2 +-
 arch/powerpc/mm/dump_linuxpagetables-8xx.c         |  82 ++++++++
 arch/powerpc/mm/dump_linuxpagetables-book3s64.c    | 115 +++++++++++
 arch/powerpc/mm/dump_linuxpagetables-generic.c     |  82 ++++++++
 arch/powerpc/mm/dump_linuxpagetables.c             | 155 +--------------
 arch/powerpc/mm/dump_linuxpagetables.h             |  19 ++
 arch/powerpc/mm/hash_utils_64.c                    |   3 +-
 arch/powerpc/mm/mem.c                              |  13 +-
 arch/powerpc/mm/mmu_decl.h                         |   2 +-
 arch/powerpc/mm/pgtable-book3e.c                   |   9 +-
 arch/powerpc/mm/pgtable-hash64.c                   |   7 +-
 arch/powerpc/mm/pgtable.c                          |  25 +--
 arch/powerpc/mm/pgtable_32.c                       |  70 ++++---
 arch/powerpc/mm/pgtable_64.c                       |  55 +++---
 arch/powerpc/mm/ppc_mmu_32.c                       |   2 +-
 arch/powerpc/platforms/4xx/ocm.c                   |   7 +-
 arch/powerpc/platforms/85xx/smp.c                  |   4 +-
 arch/powerpc/platforms/pasemi/dma_lib.c            |   2 +-
 arch/powerpc/platforms/ps3/spu.c                   |   3 +-
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c          |   8 +-
 arch/powerpc/xmon/xmon.c                           |  12 +-
 drivers/block/z2ram.c                              |   3 +-
 drivers/pcmcia/electra_cf.c                        |   2 +-
 drivers/soc/fsl/qbman/qman_ccsr.c                  |   2 +-
 drivers/video/fbdev/chipsfb.c                      |   3 +-
 drivers/video/fbdev/controlfb.c                    |   5 +-
 drivers/video/fbdev/platinumfb.c                   |   5 +-
 drivers/video/fbdev/valkyriefb.c                   |  12 +-
 53 files changed, 1078 insertions(+), 642 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/pte-common.h
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-8xx.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-book3s64.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-generic.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables.h

-- 
2.13.3
