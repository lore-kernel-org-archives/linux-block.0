Return-Path: <prvs=672e5e3bd=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v12 1/2] ARM: cmpxchg64: Only define cmpxchg64() if not using the Thumb instruction set
Date: Mon, 21 May 2018 10:16:51 -0700
Message-Id: <20180521171652.3021-2-bart.vanassche@wdc.com>
In-Reply-To: <20180521171652.3021-1-bart.vanassche@wdc.com>
References: <20180521171652.3021-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since the implementation of cmpxchg64() uses instructions that are not
Thumb instructions, only define cmpxchg64() if not building in Thumb
mode. This patch allows the next patch in this series to check for
cmpxchg64() support using #if defined(cmpxchg64).

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/include/asm/cmpxchg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 8b701f8e175c..41ab99bc04ca 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -141,7 +141,9 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 					        sizeof(*(ptr)));	\
 })
 
+#ifndef CONFIG_THUMB2_KERNEL
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#endif /* CONFIG_THUMB2_KERNEL */
 
 #include <asm-generic/cmpxchg.h>
 
@@ -241,6 +243,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 				        sizeof(*(ptr)));		\
 })
 
+#ifndef CONFIG_THUMB2_KERNEL
 static inline unsigned long long __cmpxchg64(unsigned long long *ptr,
 					     unsigned long long old,
 					     unsigned long long new)
@@ -273,6 +276,7 @@ static inline unsigned long long __cmpxchg64(unsigned long long *ptr,
 })
 
 #define cmpxchg64_local(ptr, o, n) cmpxchg64_relaxed((ptr), (o), (n))
+#endif /* CONFIG_THUMB2_KERNEL */
 
 #endif	/* __LINUX_ARM_ARCH__ >= 6 */
 
-- 
2.16.3
