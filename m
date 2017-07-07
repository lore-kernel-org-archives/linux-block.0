Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35770 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752987AbdGGAWm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Jul 2017 20:22:42 -0400
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [GIT PULL] libnvdimm for 4.13
Date: Fri, 7 Jul 2017 00:22:38 +0000
Message-ID: <1499386957.6081.29.camel@intel.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.13

to receive, libnvdimm updates for the latest ACPI and UEFI
specifications. This pull request also includes new 'struct
dax+AF8-operations' enabling to undo the abuse +AFs-1+AF0- of copy+AF8-user+AF8-nocache()
for copy operations to pmem. The dax work originally missed 4.12 to
address concerns raised by Al.

+AFs-1+AF0-: https://lists.01.org/pipermail/linux-nvdimm/2017-January/008364.html

All of the commits in this pull request have appeared in one or more
-next releases with no errors reported, however, Stephen did report a
late merge conflict between nvdimm.git and the vfs.git tree. Stephen's
merge resolution is here:+AKA-http://marc.info/?l+AD0-linux-kernel+ACY-m+AD0-1499064115
07301+ACY-w+AD0-2, but to match Al's changes we appear to also need the
incremental change below.

Please pull, I believe any straggling +AF8-flushcache() feedback at this
point can be fixed up post -rc1. I include commit 0aed55af8834 +ACI-x86,
uaccess: introduce copy+AF8-from+AF8-iter+AF8-flushcache for pmem / cache-bypass
operations+ACI- at the end of this message for reference.

---

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 2f46f8d4b508..073bb1feb0d0 100644
--- a/include/linux/uio.h
+-+-+- b/include/linux/uio.h
+AEAAQA- -97,6 +-97,7 +AEAAQA- size+AF8-t +AF8-copy+AF8-to+AF8-iter(const void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
 size+AF8-t +AF8-copy+AF8-from+AF8-iter(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
 bool +AF8-copy+AF8-from+AF8-iter+AF8-full(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
 size+AF8-t +AF8-copy+AF8-from+AF8-iter+AF8-nocache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
+-size+AF8-t +AF8-copy+AF8-from+AF8-iter+AF8-flushcache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
 bool +AF8-copy+AF8-from+AF8-iter+AF8-full+AF8-nocache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
 
 static +AF8AXw-always+AF8-inline +AF8AXw-must+AF8-check
+AEAAQA- -151,7 +-152,14 +AEAAQA- bool copy+AF8-from+AF8-iter+AF8-full+AF8-nocache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)
  +ACo- IS+AF8-ENABLED(CONFIG+AF8-ARCH+AF8-HAS+AF8-UACCESS+AF8-FLUSHCACHE) before assuming that the
  +ACo- destination is flushed from the cache on return.
  +ACo-/
-size+AF8-t copy+AF8-from+AF8-iter+AF8-flushcache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
+-static +AF8AXw-always+AF8-inline +AF8AXw-must+AF8-check
+-size+AF8-t copy+AF8-from+AF8-iter+AF8-flushcache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)
+-+AHs-
+-	if (unlikely(+ACE-check+AF8-copy+AF8-size(addr, bytes, false)))
+-		return bytes+ADs-
+-	else
+-		return +AF8-copy+AF8-from+AF8-iter+AF8-flushcache(addr, bytes, i)+ADs-
+-+AH0-
 +ACM-else
 static inline size+AF8-t copy+AF8-from+AF8-iter+AF8-flushcache(void +ACo-addr, size+AF8-t bytes,
 				       struct iov+AF8-iter +ACo-i)
diff --git a/lib/iov+AF8-iter.c b/lib/iov+AF8-iter.c
index ee82300d98b9..0d18ede56a36 100644
--- a/lib/iov+AF8-iter.c
+-+-+- b/lib/iov+AF8-iter.c
+AEAAQA- -642,7 +-642,7 +AEAAQA- size+AF8-t +AF8-copy+AF8-from+AF8-iter+AF8-nocache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)
 EXPORT+AF8-SYMBOL(+AF8-copy+AF8-from+AF8-iter+AF8-nocache)+ADs-
 
 +ACM-ifdef CONFIG+AF8-ARCH+AF8-HAS+AF8-UACCESS+AF8-FLUSHCACHE
-size+AF8-t copy+AF8-from+AF8-iter+AF8-flushcache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)
+-size+AF8-t +AF8-copy+AF8-from+AF8-iter+AF8-flushcache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)
 +AHs-
 	char +ACo-to +AD0- addr+ADs-
 	if (unlikely(i-+AD4-type +ACY- ITER+AF8-PIPE)) +AHs-
+AEAAQA- -660,7 +-660,7 +AEAAQA- size+AF8-t copy+AF8-from+AF8-iter+AF8-flushcache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)
 
 	return bytes+ADs-
 +AH0-
-EXPORT+AF8-SYMBOL+AF8-GPL(copy+AF8-from+AF8-iter+AF8-flushcache)+ADs-
+-EXPORT+AF8-SYMBOL+AF8-GPL(+AF8-copy+AF8-from+AF8-iter+AF8-flushcache)+ADs-
 +ACM-endif
 
 bool +AF8-copy+AF8-from+AF8-iter+AF8-full+AF8-nocache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)

---

The following changes since commit 87085ff2e90ecfa91f8bb0cb0ce19ea661bd6f83:

  thermal: int340x+AF8-thermal: fix compile after the UUID API switch (2017-06-09 16:37:31 +-0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.13

for you to fetch changes up to 9d92573fff3ec70785ef1815cc80573f70e7a921:

  Merge branch 'for-4.13/dax' into libnvdimm-for-next (2017-07-03 16:54:58 -0700)

----------------------------------------------------------------
libnvdimm for 4.13

+ACo- Introduce the +AF8-flushcache() family of memory copy helpers and use them
  for persistent memory write operations on x86. The +AF8-flushcache()
  semantic indicates that the cache is either bypassed for the copy
  operation (movnt) or any lines dirtied by the copy operation are
  written back (clwb, clflushopt, or clflush).

+ACo- Extend dax+AF8-operations with -+AD4-copy+AF8-from+AF8-iter() and -+AD4-flush()
  operations. These operations and other infrastructure updates allow
  all persistent memory specific dax functionality to be pushed into
  libnvdimm and the pmem driver directly. It also allows dax-specific
  sysfs attributes to be linked to a host device, for example:
      /sys/block/pmem0/dax/write+AF8-cache

+ACo- Add support for the new NVDIMM platform/firmware mechanisms introduced
  in ACPI 6.2 and UEFI 2.7. This support includes the v1.2 namespace
  label format, extensions to the address-range-scrub command set, new
  error injection commands, and a new BTT (block-translation-table)
  layout. These updates support inter-OS and pre-OS compatibility.

+ACo- Fix a longstanding memory corruption bug in nfit+AF8-test.

+ACo- Make the pmem and nvdimm-region 'badblocks' sysfs files poll(2)
  capable.

+ACo- Miscellaneous fixes and small updates across libnvdimm and the nfit
  driver.

Acknowledgements that came after the branch was pushed:

commit 6aa734a2f38e +ACI-libnvdimm, region, pmem: fix 'badblocks'
  sysfs+AF8-get+AF8-dirent() reference lifetime+ACI-
Reviewed-by: Toshi Kani +ADw-toshi.kani+AEA-hpe.com+AD4-

----------------------------------------------------------------
Arvind Yadav (1):
      acpi, nfit: constify +ACoAXw-attribute+AF8-group

Dan Williams (29):
      x86, uaccess: introduce copy+AF8-from+AF8-iter+AF8-flushcache for pmem / cache-bypass operations
      dm: add -+AD4-copy+AF8-from+AF8-iter() dax operation support
      libnvdimm, label: add v1.2 nvdimm label definitions
      libnvdimm, label: add v1.2 interleave-set-cookie algorithm
      libnvdimm, label: honor the lba size specified in v1.2 labels
      libnvdimm, label: populate the type+AF8-guid property for v1.2 namespaces
      libnvdimm, label: populate 'isetcookie' for blk-aperture namespaces
      libnvdimm, label: update 'nlabel' and 'position' handling for local namespaces
      libnvdimm, label: add v1.2 label checksum support
      libnvdimm, label: add address abstraction identifiers
      libnvdimm, label: switch to using v1.2 labels by default
      filesystem-dax: convert to dax+AF8-copy+AF8-from+AF8-iter()
      dax, pmem: introduce an optional 'flush' dax+AF8-operation
      dm: add -+AD4-flush() dax operation support
      filesystem-dax: convert to dax+AF8-flush()
      x86, dax: replace clear+AF8-pmem() with open coded memset +- dax+AF8-ops-+AD4-flush
      x86, dax, libnvdimm: remove wb+AF8-cache+AF8-pmem() indirection
      x86, libnvdimm, pmem: move arch+AF8-invalidate+AF8-pmem() to libnvdimm
      x86, libnvdimm, pmem: remove global pmem api
      libnvdimm, pmem: fix persistence warning
      libnvdimm, nfit: enable support for volatile ranges
      dax: remove default copy+AF8-from+AF8-iter fallback
      dax: convert to bitmask for flags
      libnvdimm, pmem, dax: export a cache control attribute
      libnvdimm, pmem: disable dax flushing when pmem is fronting a volatile region
      acpi, nfit: quiet invalid block-aperture-region warnings
      libnvdimm, region, pmem: fix 'badblocks' sysfs+AF8-get+AF8-dirent() reference lifetime
      libnvdimm, namespace: record 'lbasize' for pmem namespaces
      Merge branch 'for-4.13/dax' into libnvdimm-for-next

Jerry Hoemann (5):
      libnvdimm: passthru functions clear to send
      acpi, nfit: Enable DSM pass thru for root functions.
      libnvdimm, acpi, nfit: Add bus level dsm mask for pass thru.
      acpi, nfit: Show bus+AF8-dsm+AF8-mask in sysfs
      libnvdimm: New ACPI 6.2 DSM functions

Toshi Kani (3):
      libnvdimm, pmem: Add sysfs notifications to badblocks
      acpi/nfit: Add support of NVDIMM memory error notification in ACPI 6.2
      acpi/nfit: Issue Start ARS to retrieve existing records

Vishal Verma (4):
      libnvdimm, btt: BTT updates for UEFI 2.7 format
      libnvdimm, btt: fix btt+AF8-rw+AF8-page not returning errors
      libnvdimm: fix the clear-error check in nsio+AF8-rw+AF8-bytes
      libnvdimm, btt: convert some info messages to warn/err

Yasunori Goto (1):
      tools/testing/nvdimm: fix nfit+AF8-test buffer overflow

 MAINTAINERS                       +AHw-   4 +--
 arch/powerpc/sysdev/axonram.c     +AHw-   8 +-+-
 arch/x86/Kconfig                  +AHw-   1 +-
 arch/x86/include/asm/pmem.h       +AHw- 136 ------------------
 arch/x86/include/asm/string+AF8-64.h  +AHw-   5 +-
 arch/x86/include/asm/uaccess+AF8-64.h +AHw-  11 +-+-
 arch/x86/lib/usercopy+AF8-64.c        +AHw- 134 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
 arch/x86/mm/pageattr.c            +AHw-   6 +-
 drivers/acpi/nfit/core.c          +AHw- 167 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-----
 drivers/acpi/nfit/mce.c           +AHw-   2 +--
 drivers/acpi/nfit/nfit.h          +AHw-   4 +--
 drivers/block/brd.c               +AHw-   8 +-+-
 drivers/dax/super.c               +AHw- 118 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+--
 drivers/md/dm-linear.c            +AHw-  30 +-+-+-+-
 drivers/md/dm-stripe.c            +AHw-  40 +-+-+-+-+-+-
 drivers/md/dm.c                   +AHw-  45 +-+-+-+-+-+-
 drivers/nvdimm/btt.c              +AHw-  45 +-+-+-+---
 drivers/nvdimm/btt.h              +AHw-   2 +-
 drivers/nvdimm/btt+AF8-devs.c         +AHw-  54 +-+-+-+-+-+-+--
 drivers/nvdimm/bus.c              +AHw-  15 +--
 drivers/nvdimm/claim.c            +AHw-  38 +-+-+-+--
 drivers/nvdimm/core.c             +AHw-   5 +--
 drivers/nvdimm/dax+AF8-devs.c         +AHw-  10 +--
 drivers/nvdimm/dimm+AF8-devs.c        +AHw-  10 +--
 drivers/nvdimm/label.c            +AHw- 251 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-----
 drivers/nvdimm/label.h            +AHw-  21 +-+--
 drivers/nvdimm/namespace+AF8-devs.c   +AHw- 282 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-------
 drivers/nvdimm/nd-core.h          +AHw-   9 +-+-
 drivers/nvdimm/nd.h               +AHw-  17 +-+--
 drivers/nvdimm/pfn+AF8-devs.c         +AHw-  12 +--
 drivers/nvdimm/pmem.c             +AHw-  63 +-+-+-+-+-+-+-+--
 drivers/nvdimm/pmem.h             +AHw-  15 +-+-
 drivers/nvdimm/region.c           +AHw-  17 +-+--
 drivers/nvdimm/region+AF8-devs.c      +AHw-  88 +-+-+-+-+-+-+-+-----
 drivers/s390/block/dcssblk.c      +AHw-   8 +-+-
 fs/dax.c                          +AHw-   9 +--
 include/linux/dax.h               +AHw-  12 +-+-
 include/linux/device-mapper.h     +AHw-   6 +-
 include/linux/libnvdimm.h         +AHw-  11 +--
 include/linux/nd.h                +AHw-  13 +-+-
 include/linux/pmem.h              +AHw- 142 -------------------
 include/linux/string.h            +AHw-   6 +-
 include/linux/uio.h               +AHw-  15 +-+-
 include/uapi/linux/ndctl.h        +AHw-  42 +-+-+-+-+--
 lib/Kconfig                       +AHw-   3 +-
 lib/iov+AF8-iter.c                    +AHw-  22 +-+-+-
 tools/testing/nvdimm/test/nfit.c  +AHw-   2 +--
 47 files changed, 1504 insertions(+-), 460 deletions(-)
 delete mode 100644 arch/x86/include/asm/pmem.h
 delete mode 100644 include/linux/pmem.h

---

commit 0aed55af88345b5d673240f90e671d79662fb01e
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:   Mon May 29 12:22:50 2017 -0700

    x86, uaccess: introduce copy+AF8-from+AF8-iter+AF8-flushcache for pmem / cache-bypass operations
    
    The pmem driver has a need to transfer data with a persistent memory
    destination and be able to rely on the fact that the destination writes are not
    cached. It is sufficient for the writes to be flushed to a cpu-store-buffer
    (non-temporal / +ACI-movnt+ACI- in x86 terms), as we expect userspace to call fsync()
    to ensure data-writes have reached a power-fail-safe zone in the platform. The
    fsync() triggers a REQ+AF8-FUA or REQ+AF8-FLUSH to the pmem driver which will turn
    around and fence previous writes with an +ACI-sfence+ACI-.
    
    Implement a +AF8AXw-copy+AF8-from+AF8-user+AF8-inatomic+AF8-flushcache, memcpy+AF8-page+AF8-flushcache, and
    memcpy+AF8-flushcache, that guarantee that the destination buffer is not dirty in
    the cpu cache on completion. The new copy+AF8-from+AF8-iter+AF8-flushcache and sub-routines
    will be used to replace the +ACI-pmem api+ACI- (include/linux/pmem.h +-
    arch/x86/include/asm/pmem.h). The availability of copy+AF8-from+AF8-iter+AF8-flushcache()
    and memcpy+AF8-flushcache() are gated by the CONFIG+AF8-ARCH+AF8-HAS+AF8-UACCESS+AF8-FLUSHCACHE
    config symbol, and fallback to copy+AF8-from+AF8-iter+AF8-nocache() and plain memcpy()
    otherwise.
    
    This is meant to satisfy the concern from Linus that if a driver wants to do
    something beyond the normal nocache semantics it should be something private to
    that driver +AFs-1+AF0-, and Al's concern that anything uaccess related belongs with
    the rest of the uaccess code +AFs-2+AF0-.
    
    The first consumer of this interface is a new 'copy+AF8-from+AF8-iter' dax operation so
    that pmem can inject cache maintenance operations without imposing this
    overhead on other dax-capable drivers.
    
    +AFs-1+AF0-: https://lists.01.org/pipermail/linux-nvdimm/2017-January/008364.html
    +AFs-2+AF0-: https://lists.01.org/pipermail/linux-nvdimm/2017-April/009942.html
    
    Cc: +ADw-x86+AEA-kernel.org+AD4-
    Cc: Jan Kara +ADw-jack+AEA-suse.cz+AD4-
    Cc: Jeff Moyer +ADw-jmoyer+AEA-redhat.com+AD4-
    Cc: Ingo Molnar +ADw-mingo+AEA-redhat.com+AD4-
    Cc: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4-
    Cc: Toshi Kani +ADw-toshi.kani+AEA-hpe.com+AD4-
    Cc: +ACI-H. Peter Anvin+ACI- +ADw-hpa+AEA-zytor.com+AD4-
    Cc: Al Viro +ADw-viro+AEA-zeniv.linux.org.uk+AD4-
    Cc: Thomas Gleixner +ADw-tglx+AEA-linutronix.de+AD4-
    Cc: Matthew Wilcox +ADw-mawilcox+AEA-microsoft.com+AD4-
    Reviewed-by: Ross Zwisler +ADw-ross.zwisler+AEA-linux.intel.com+AD4-
    Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4ccfacc7232a..bb273b2f50b5 100644
--- a/arch/x86/Kconfig
+-+-+- b/arch/x86/Kconfig
+AEAAQA- -54,6 +-54,7 +AEAAQA- config X86
 	select ARCH+AF8-HAS+AF8-KCOV			if X86+AF8-64
 	select ARCH+AF8-HAS+AF8-MMIO+AF8-FLUSH
 	select ARCH+AF8-HAS+AF8-PMEM+AF8-API		if X86+AF8-64
+-	select ARCH+AF8-HAS+AF8-UACCESS+AF8-FLUSHCACHE	if X86+AF8-64
 	select ARCH+AF8-HAS+AF8-SET+AF8-MEMORY
 	select ARCH+AF8-HAS+AF8-SG+AF8-CHAIN
 	select ARCH+AF8-HAS+AF8-STRICT+AF8-KERNEL+AF8-RWX
diff --git a/arch/x86/include/asm/string+AF8-64.h b/arch/x86/include/asm/string+AF8-64.h
index 733bae07fb29..1f22bc277c45 100644
--- a/arch/x86/include/asm/string+AF8-64.h
+-+-+- b/arch/x86/include/asm/string+AF8-64.h
+AEAAQA- -109,6 +-109,11 +AEAAQA- memcpy+AF8-mcsafe(void +ACo-dst, const void +ACo-src, size+AF8-t cnt)
 	return 0+ADs-
 +AH0-
 
+-+ACM-ifdef CONFIG+AF8-ARCH+AF8-HAS+AF8-UACCESS+AF8-FLUSHCACHE
+-+ACM-define +AF8AXw-HAVE+AF8-ARCH+AF8-MEMCPY+AF8-FLUSHCACHE 1
+-void memcpy+AF8-flushcache(void +ACo-dst, const void +ACo-src, size+AF8-t cnt)+ADs-
+-+ACM-endif
+-
 +ACM-endif /+ACo- +AF8AXw-KERNEL+AF8AXw- +ACo-/
 
 +ACM-endif /+ACo- +AF8-ASM+AF8-X86+AF8-STRING+AF8-64+AF8-H +ACo-/
diff --git a/arch/x86/include/asm/uaccess+AF8-64.h b/arch/x86/include/asm/uaccess+AF8-64.h
index c5504b9a472e..b16f6a1d8b26 100644
--- a/arch/x86/include/asm/uaccess+AF8-64.h
+-+-+- b/arch/x86/include/asm/uaccess+AF8-64.h
+AEAAQA- -171,6 +-171,10 +AEAAQA- unsigned long raw+AF8-copy+AF8-in+AF8-user(void +AF8AXw-user +ACo-dst, const void +AF8AXw-user +ACo-src, unsigne
 extern long +AF8AXw-copy+AF8-user+AF8-nocache(void +ACo-dst, const void +AF8AXw-user +ACo-src,
 				unsigned size, int zerorest)+ADs-
 
+-extern long +AF8AXw-copy+AF8-user+AF8-flushcache(void +ACo-dst, const void +AF8AXw-user +ACo-src, unsigned size)+ADs-
+-extern void memcpy+AF8-page+AF8-flushcache(char +ACo-to, struct page +ACo-page, size+AF8-t offset,
+-			   size+AF8-t len)+ADs-
+-
 static inline int
 +AF8AXw-copy+AF8-from+AF8-user+AF8-inatomic+AF8-nocache(void +ACo-dst, const void +AF8AXw-user +ACo-src,
 				  unsigned size)
+AEAAQA- -179,6 +-183,13 +AEAAQA- +AF8AXw-copy+AF8-from+AF8-user+AF8-inatomic+AF8-nocache(void +ACo-dst, const void +AF8AXw-user +ACo-src,
 	return +AF8AXw-copy+AF8-user+AF8-nocache(dst, src, size, 0)+ADs-
 +AH0-
 
+-static inline int
+-+AF8AXw-copy+AF8-from+AF8-user+AF8-flushcache(void +ACo-dst, const void +AF8AXw-user +ACo-src, unsigned size)
+-+AHs-
+-	kasan+AF8-check+AF8-write(dst, size)+ADs-
+-	return +AF8AXw-copy+AF8-user+AF8-flushcache(dst, src, size)+ADs-
+-+AH0-
+-
 unsigned long
 copy+AF8-user+AF8-handle+AF8-tail(char +ACo-to, char +ACo-from, unsigned len)+ADs-
 
diff --git a/arch/x86/lib/usercopy+AF8-64.c b/arch/x86/lib/usercopy+AF8-64.c
index 3b7c40a2e3e1..f42d2fd86ca3 100644
--- a/arch/x86/lib/usercopy+AF8-64.c
+-+-+- b/arch/x86/lib/usercopy+AF8-64.c
+AEAAQA- -7,6 +-7,7 +AEAAQA-
  +ACo-/
 +ACM-include +ADw-linux/export.h+AD4-
 +ACM-include +ADw-linux/uaccess.h+AD4-
+-+ACM-include +ADw-linux/highmem.h+AD4-
 
 /+ACo-
  +ACo- Zero Userspace
+AEAAQA- -73,3 +-74,130 +AEAAQA- copy+AF8-user+AF8-handle+AF8-tail(char +ACo-to, char +ACo-from, unsigned len)
 	clac()+ADs-
 	return len+ADs-
 +AH0-
+-
+-+ACM-ifdef CONFIG+AF8-ARCH+AF8-HAS+AF8-UACCESS+AF8-FLUSHCACHE
+-/+ACoAKg-
+- +ACo- clean+AF8-cache+AF8-range - write back a cache range with CLWB
+- +ACo- +AEA-vaddr:	virtual start address
+- +ACo- +AEA-size:	number of bytes to write back
+- +ACo-
+- +ACo- Write back a cache range using the CLWB (cache line write back)
+- +ACo- instruction. Note that +AEA-size is internally rounded up to be cache
+- +ACo- line size aligned.
+- +ACo-/
+-static void clean+AF8-cache+AF8-range(void +ACo-addr, size+AF8-t size)
+-+AHs-
+-	u16 x86+AF8-clflush+AF8-size +AD0- boot+AF8-cpu+AF8-data.x86+AF8-clflush+AF8-size+ADs-
+-	unsigned long clflush+AF8-mask +AD0- x86+AF8-clflush+AF8-size - 1+ADs-
+-	void +ACo-vend +AD0- addr +- size+ADs-
+-	void +ACo-p+ADs-
+-
+-	for (p +AD0- (void +ACo-)((unsigned long)addr +ACY- +AH4-clflush+AF8-mask)+ADs-
+-	     p +ADw- vend+ADs- p +-+AD0- x86+AF8-clflush+AF8-size)
+-		clwb(p)+ADs-
+-+AH0-
+-
+-long +AF8AXw-copy+AF8-user+AF8-flushcache(void +ACo-dst, const void +AF8AXw-user +ACo-src, unsigned size)
+-+AHs-
+-	unsigned long flushed, dest +AD0- (unsigned long) dst+ADs-
+-	long rc +AD0- +AF8AXw-copy+AF8-user+AF8-nocache(dst, src, size, 0)+ADs-
+-
+-	/+ACo-
+-	 +ACo- +AF8AXw-copy+AF8-user+AF8-nocache() uses non-temporal stores for the bulk
+-	 +ACo- of the transfer, but we need to manually flush if the
+-	 +ACo- transfer is unaligned. A cached memory copy is used when
+-	 +ACo- destination or size is not naturally aligned. That is:
+-	 +ACo-   - Require 8-byte alignment when size is 8 bytes or larger.
+-	 +ACo-   - Require 4-byte alignment when size is 4 bytes.
+-	 +ACo-/
+-	if (size +ADw- 8) +AHs-
+-		if (+ACE-IS+AF8-ALIGNED(dest, 4) +AHwAfA- size +ACEAPQ- 4)
+-			clean+AF8-cache+AF8-range(dst, 1)+ADs-
+-	+AH0- else +AHs-
+-		if (+ACE-IS+AF8-ALIGNED(dest, 8)) +AHs-
+-			dest +AD0- ALIGN(dest, boot+AF8-cpu+AF8-data.x86+AF8-clflush+AF8-size)+ADs-
+-			clean+AF8-cache+AF8-range(dst, 1)+ADs-
+-		+AH0-
+-
+-		flushed +AD0- dest - (unsigned long) dst+ADs-
+-		if (size +AD4- flushed +ACYAJg- +ACE-IS+AF8-ALIGNED(size - flushed, 8))
+-			clean+AF8-cache+AF8-range(dst +- size - 1, 1)+ADs-
+-	+AH0-
+-
+-	return rc+ADs-
+-+AH0-
+-
+-void memcpy+AF8-flushcache(void +ACoAXw-dst, const void +ACoAXw-src, size+AF8-t size)
+-+AHs-
+-	unsigned long dest +AD0- (unsigned long) +AF8-dst+ADs-
+-	unsigned long source +AD0- (unsigned long) +AF8-src+ADs-
+-
+-	/+ACo- cache copy and flush to align dest +ACo-/
+-	if (+ACE-IS+AF8-ALIGNED(dest, 8)) +AHs-
+-		unsigned len +AD0- min+AF8-t(unsigned, size, ALIGN(dest, 8) - dest)+ADs-
+-
+-		memcpy((void +ACo-) dest, (void +ACo-) source, len)+ADs-
+-		clean+AF8-cache+AF8-range((void +ACo-) dest, len)+ADs-
+-		dest +-+AD0- len+ADs-
+-		source +-+AD0- len+ADs-
+-		size -+AD0- len+ADs-
+-		if (+ACE-size)
+-			return+ADs-
+-	+AH0-
+-
+-	/+ACo- 4x8 movnti loop +ACo-/
+-	while (size +AD4APQ- 32) +AHs-
+-		asm(+ACI-movq    (+ACU-0), +ACUAJQ-r8+AFw-n+ACI-
+-		    +ACI-movq   8(+ACU-0), +ACUAJQ-r9+AFw-n+ACI-
+-		    +ACI-movq  16(+ACU-0), +ACUAJQ-r10+AFw-n+ACI-
+-		    +ACI-movq  24(+ACU-0), +ACUAJQ-r11+AFw-n+ACI-
+-		    +ACI-movnti  +ACUAJQ-r8,   (+ACU-1)+AFw-n+ACI-
+-		    +ACI-movnti  +ACUAJQ-r9,  8(+ACU-1)+AFw-n+ACI-
+-		    +ACI-movnti +ACUAJQ-r10, 16(+ACU-1)+AFw-n+ACI-
+-		    +ACI-movnti +ACUAJQ-r11, 24(+ACU-1)+AFw-n+ACI-
+-		    :: +ACI-r+ACI- (source), +ACI-r+ACI- (dest)
+-		    : +ACI-memory+ACI-, +ACI-r8+ACI-, +ACI-r9+ACI-, +ACI-r10+ACI-, +ACI-r11+ACI-)+ADs-
+-		dest +-+AD0- 32+ADs-
+-		source +-+AD0- 32+ADs-
+-		size -+AD0- 32+ADs-
+-	+AH0-
+-
+-	/+ACo- 1x8 movnti loop +ACo-/
+-	while (size +AD4APQ- 8) +AHs-
+-		asm(+ACI-movq    (+ACU-0), +ACUAJQ-r8+AFw-n+ACI-
+-		    +ACI-movnti  +ACUAJQ-r8,   (+ACU-1)+AFw-n+ACI-
+-		    :: +ACI-r+ACI- (source), +ACI-r+ACI- (dest)
+-		    : +ACI-memory+ACI-, +ACI-r8+ACI-)+ADs-
+-		dest +-+AD0- 8+ADs-
+-		source +-+AD0- 8+ADs-
+-		size -+AD0- 8+ADs-
+-	+AH0-
+-
+-	/+ACo- 1x4 movnti loop +ACo-/
+-	while (size +AD4APQ- 4) +AHs-
+-		asm(+ACI-movl    (+ACU-0), +ACUAJQ-r8d+AFw-n+ACI-
+-		    +ACI-movnti  +ACUAJQ-r8d,   (+ACU-1)+AFw-n+ACI-
+-		    :: +ACI-r+ACI- (source), +ACI-r+ACI- (dest)
+-		    : +ACI-memory+ACI-, +ACI-r8+ACI-)+ADs-
+-		dest +-+AD0- 4+ADs-
+-		source +-+AD0- 4+ADs-
+-		size -+AD0- 4+ADs-
+-	+AH0-
+-
+-	/+ACo- cache copy for remaining bytes +ACo-/
+-	if (size) +AHs-
+-		memcpy((void +ACo-) dest, (void +ACo-) source, size)+ADs-
+-		clean+AF8-cache+AF8-range((void +ACo-) dest, size)+ADs-
+-	+AH0-
+-+AH0-
+-EXPORT+AF8-SYMBOL+AF8-GPL(memcpy+AF8-flushcache)+ADs-
+-
+-void memcpy+AF8-page+AF8-flushcache(char +ACo-to, struct page +ACo-page, size+AF8-t offset,
+-		size+AF8-t len)
+-+AHs-
+-	char +ACo-from +AD0- kmap+AF8-atomic(page)+ADs-
+-
+-	memcpy+AF8-flushcache(to, from +- offset, len)+ADs-
+-	kunmap+AF8-atomic(from)+ADs-
+-+AH0-
+-+ACM-endif
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 656acb5d7166..cbd5596e7562 100644
--- a/drivers/acpi/nfit/core.c
+-+-+- b/drivers/acpi/nfit/core.c
+AEAAQA- -1842,8 +-1842,7 +AEAAQA- static int acpi+AF8-nfit+AF8-blk+AF8-single+AF8-io(struct nfit+AF8-blk +ACo-nfit+AF8-blk,
 		+AH0-
 
 		if (rw)
-			memcpy+AF8-to+AF8-pmem(mmio-+AD4-addr.aperture +- offset,
-					iobuf +- copied, c)+ADs-
+-			memcpy+AF8-flushcache(mmio-+AD4-addr.aperture +- offset, iobuf +- copied, c)+ADs-
 		else +AHs-
 			if (nfit+AF8-blk-+AD4-dimm+AF8-flags +ACY- NFIT+AF8-BLK+AF8-READ+AF8-FLUSH)
 				mmio+AF8-flush+AF8-range((void +AF8AXw-force +ACo-)
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 7ceb5fa4f2a1..b8b9c8ca7862 100644
--- a/drivers/nvdimm/claim.c
+-+-+- b/drivers/nvdimm/claim.c
+AEAAQA- -277,7 +-277,7 +AEAAQA- static int nsio+AF8-rw+AF8-bytes(struct nd+AF8-namespace+AF8-common +ACo-ndns,
 			rc +AD0- -EIO+ADs-
 	+AH0-
 
-	memcpy+AF8-to+AF8-pmem(nsio-+AD4-addr +- offset, buf, size)+ADs-
+-	memcpy+AF8-flushcache(nsio-+AD4-addr +- offset, buf, size)+ADs-
 	nvdimm+AF8-flush(to+AF8-nd+AF8-region(ndns-+AD4-dev.parent))+ADs-
 
 	return rc+ADs-
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index c544d466ea51..2f3aefe565c6 100644
--- a/drivers/nvdimm/pmem.c
+-+-+- b/drivers/nvdimm/pmem.c
+AEAAQA- -29,6 +-29,7 +AEAAQA-
 +ACM-include +ADw-linux/pfn+AF8-t.h+AD4-
 +ACM-include +ADw-linux/slab.h+AD4-
 +ACM-include +ADw-linux/pmem.h+AD4-
+-+ACM-include +ADw-linux/uio.h+AD4-
 +ACM-include +ADw-linux/dax.h+AD4-
 +ACM-include +ADw-linux/nd.h+AD4-
 +ACM-include +ACI-pmem.h+ACI-
+AEAAQA- -80,7 +-81,7 +AEAAQA- static void write+AF8-pmem(void +ACo-pmem+AF8-addr, struct page +ACo-page,
 +AHs-
 	void +ACo-mem +AD0- kmap+AF8-atomic(page)+ADs-
 
-	memcpy+AF8-to+AF8-pmem(pmem+AF8-addr, mem +- off, len)+ADs-
+-	memcpy+AF8-flushcache(pmem+AF8-addr, mem +- off, len)+ADs-
 	kunmap+AF8-atomic(mem)+ADs-
 +AH0-
 
+AEAAQA- -235,8 +-236,15 +AEAAQA- static long pmem+AF8-dax+AF8-direct+AF8-access(struct dax+AF8-device +ACo-dax+AF8-dev,
 	return +AF8AXw-pmem+AF8-direct+AF8-access(pmem, pgoff, nr+AF8-pages, kaddr, pfn)+ADs-
 +AH0-
 
+-static size+AF8-t pmem+AF8-copy+AF8-from+AF8-iter(struct dax+AF8-device +ACo-dax+AF8-dev, pgoff+AF8-t pgoff,
+-		void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)
+-+AHs-
+-	return copy+AF8-from+AF8-iter+AF8-flushcache(addr, bytes, i)+ADs-
+-+AH0-
+-
 static const struct dax+AF8-operations pmem+AF8-dax+AF8-ops +AD0- +AHs-
 	.direct+AF8-access +AD0- pmem+AF8-dax+AF8-direct+AF8-access,
+-	.copy+AF8-from+AF8-iter +AD0- pmem+AF8-copy+AF8-from+AF8-iter,
 +AH0AOw-
 
 static void pmem+AF8-release+AF8-queue(void +ACo-q)
+AEAAQA- -294,7 +-302,8 +AEAAQA- static int pmem+AF8-attach+AF8-disk(struct device +ACo-dev,
 	dev+AF8-set+AF8-drvdata(dev, pmem)+ADs-
 	pmem-+AD4-phys+AF8-addr +AD0- res-+AD4-start+ADs-
 	pmem-+AD4-size +AD0- resource+AF8-size(res)+ADs-
-	if (nvdimm+AF8-has+AF8-flush(nd+AF8-region) +ADw- 0)
+-	if (+ACE-IS+AF8-ENABLED(CONFIG+AF8-ARCH+AF8-HAS+AF8-UACCESS+AF8-FLUSHCACHE)
+-			+AHwAfA- nvdimm+AF8-has+AF8-flush(nd+AF8-region) +ADw- 0)
 		dev+AF8-warn(dev, +ACI-unable to guarantee persistence of writes+AFw-n+ACI-)+ADs-
 
 	if (+ACE-devm+AF8-request+AF8-mem+AF8-region(dev, res-+AD4-start, resource+AF8-size(res),
diff --git a/drivers/nvdimm/region+AF8-devs.c b/drivers/nvdimm/region+AF8-devs.c
index b550edf2571f..985b0e11bd73 100644
--- a/drivers/nvdimm/region+AF8-devs.c
+-+-+- b/drivers/nvdimm/region+AF8-devs.c
+AEAAQA- -1015,8 +-1015,8 +AEAAQA- void nvdimm+AF8-flush(struct nd+AF8-region +ACo-nd+AF8-region)
 	 +ACo- The first wmb() is needed to 'sfence' all previous writes
 	 +ACo- such that they are architecturally visible for the platform
 	 +ACo- buffer flush.  Note that we've already arranged for pmem
-	 +ACo- writes to avoid the cache via arch+AF8-memcpy+AF8-to+AF8-pmem().  The
-	 +ACo- final wmb() ensures ordering for the NVDIMM flush write.
+-	 +ACo- writes to avoid the cache via memcpy+AF8-flushcache().  The final
+-	 +ACo- wmb() ensures ordering for the NVDIMM flush write.
 	 +ACo-/
 	wmb()+ADs-
 	for (i +AD0- 0+ADs- i +ADw- nd+AF8-region-+AD4-ndr+AF8-mappings+ADs- i+-+-)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 5ec1f6c47716..bbe79ed90e2b 100644
--- a/include/linux/dax.h
+-+-+- b/include/linux/dax.h
+AEAAQA- -16,6 +-16,9 +AEAAQA- struct dax+AF8-operations +AHs-
 	 +ACo-/
 	long (+ACo-direct+AF8-access)(struct dax+AF8-device +ACo-, pgoff+AF8-t, long,
 			void +ACoAKg-, pfn+AF8-t +ACo-)+ADs-
+-	/+ACo- copy+AF8-from+AF8-iter: dax-driver override for default copy+AF8-from+AF8-iter +ACo-/
+-	size+AF8-t (+ACo-copy+AF8-from+AF8-iter)(struct dax+AF8-device +ACo-, pgoff+AF8-t, void +ACo-, size+AF8-t,
+-			struct iov+AF8-iter +ACo-)+ADs-
 +AH0AOw-
 
 +ACM-if IS+AF8-ENABLED(CONFIG+AF8-DAX)
diff --git a/include/linux/string.h b/include/linux/string.h
index 537918f8a98e..7439d83eaa33 100644
--- a/include/linux/string.h
+-+-+- b/include/linux/string.h
+AEAAQA- -122,6 +-122,12 +AEAAQA- static inline +AF8AXw-must+AF8-check int memcpy+AF8-mcsafe(void +ACo-dst, const void +ACo-src,
 	return 0+ADs-
 +AH0-
 +ACM-endif
+-+ACM-ifndef +AF8AXw-HAVE+AF8-ARCH+AF8-MEMCPY+AF8-FLUSHCACHE
+-static inline void memcpy+AF8-flushcache(void +ACo-dst, const void +ACo-src, size+AF8-t cnt)
+-+AHs-
+-	memcpy(dst, src, cnt)+ADs-
+-+AH0-
+-+ACM-endif
 void +ACo-memchr+AF8-inv(const void +ACo-s, int c, size+AF8-t n)+ADs-
 char +ACo-strreplace(char +ACo-s, char old, char new)+ADs-
 
diff --git a/include/linux/uio.h b/include/linux/uio.h
index f2d36a3d3005..55cd54a0e941 100644
--- a/include/linux/uio.h
+-+-+- b/include/linux/uio.h
+AEAAQA- -95,6 +-95,21 +AEAAQA- size+AF8-t copy+AF8-to+AF8-iter(const void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
 size+AF8-t copy+AF8-from+AF8-iter(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
 bool copy+AF8-from+AF8-iter+AF8-full(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
 size+AF8-t copy+AF8-from+AF8-iter+AF8-nocache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
+-+ACM-ifdef CONFIG+AF8-ARCH+AF8-HAS+AF8-UACCESS+AF8-FLUSHCACHE
+-/+ACo-
+- +ACo- Note, users like pmem that depend on the stricter semantics of
+- +ACo- copy+AF8-from+AF8-iter+AF8-flushcache() than copy+AF8-from+AF8-iter+AF8-nocache() must check for
+- +ACo- IS+AF8-ENABLED(CONFIG+AF8-ARCH+AF8-HAS+AF8-UACCESS+AF8-FLUSHCACHE) before assuming that the
+- +ACo- destination is flushed from the cache on return.
+- +ACo-/
+-size+AF8-t copy+AF8-from+AF8-iter+AF8-flushcache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
+-+ACM-else
+-static inline size+AF8-t copy+AF8-from+AF8-iter+AF8-flushcache(void +ACo-addr, size+AF8-t bytes,
+-				       struct iov+AF8-iter +ACo-i)
+-+AHs-
+-	return copy+AF8-from+AF8-iter+AF8-nocache(addr, bytes, i)+ADs-
+-+AH0-
+-+ACM-endif
 bool copy+AF8-from+AF8-iter+AF8-full+AF8-nocache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)+ADs-
 size+AF8-t iov+AF8-iter+AF8-zero(size+AF8-t bytes, struct iov+AF8-iter +ACo-)+ADs-
 unsigned long iov+AF8-iter+AF8-alignment(const struct iov+AF8-iter +ACo-i)+ADs-
diff --git a/lib/Kconfig b/lib/Kconfig
index 0c8b78a9ae2e..2d1c4b3a085c 100644
--- a/lib/Kconfig
+-+-+- b/lib/Kconfig
+AEAAQA- -548,6 +-548,9 +AEAAQA- config ARCH+AF8-HAS+AF8-SG+AF8-CHAIN
 config ARCH+AF8-HAS+AF8-PMEM+AF8-API
 	bool
 
+-config ARCH+AF8-HAS+AF8-UACCESS+AF8-FLUSHCACHE
+-	bool
+-
 config ARCH+AF8-HAS+AF8-MMIO+AF8-FLUSH
 	bool
 
diff --git a/lib/iov+AF8-iter.c b/lib/iov+AF8-iter.c
index f835964c9485..c9a69064462f 100644
--- a/lib/iov+AF8-iter.c
+-+-+- b/lib/iov+AF8-iter.c
+AEAAQA- -615,6 +-615,28 +AEAAQA- size+AF8-t copy+AF8-from+AF8-iter+AF8-nocache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)
 +AH0-
 EXPORT+AF8-SYMBOL(copy+AF8-from+AF8-iter+AF8-nocache)+ADs-
 
+-+ACM-ifdef CONFIG+AF8-ARCH+AF8-HAS+AF8-UACCESS+AF8-FLUSHCACHE
+-size+AF8-t copy+AF8-from+AF8-iter+AF8-flushcache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)
+-+AHs-
+-	char +ACo-to +AD0- addr+ADs-
+-	if (unlikely(i-+AD4-type +ACY- ITER+AF8-PIPE)) +AHs-
+-		WARN+AF8-ON(1)+ADs-
+-		return 0+ADs-
+-	+AH0-
+-	iterate+AF8-and+AF8-advance(i, bytes, v,
+-		+AF8AXw-copy+AF8-from+AF8-user+AF8-flushcache((to +-+AD0- v.iov+AF8-len) - v.iov+AF8-len,
+-					 v.iov+AF8-base, v.iov+AF8-len),
+-		memcpy+AF8-page+AF8-flushcache((to +-+AD0- v.bv+AF8-len) - v.bv+AF8-len, v.bv+AF8-page,
+-				 v.bv+AF8-offset, v.bv+AF8-len),
+-		memcpy+AF8-flushcache((to +-+AD0- v.iov+AF8-len) - v.iov+AF8-len, v.iov+AF8-base,
+-			v.iov+AF8-len)
+-	)
+-
+-	return bytes+ADs-
+-+AH0-
+-EXPORT+AF8-SYMBOL+AF8-GPL(copy+AF8-from+AF8-iter+AF8-flushcache)+ADs-
+-+ACM-endif
+-
 bool copy+AF8-from+AF8-iter+AF8-full+AF8-nocache(void +ACo-addr, size+AF8-t bytes, struct iov+AF8-iter +ACo-i)
 +AHs-
 	char +ACo-to +AD0- addr+ADs-
