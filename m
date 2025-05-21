Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E9E482EB;
	Wed, 21 May 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849979; cv=none; b=QZk3KGG8zer+EJVbh3+tv/ynjy3Ruj3JHfQQdmlP9pAb5iQYxMkT0IIEgszn8K9iNA2EJK4LQUT1jMc8EsizgDuJ4uC28IgTSXhQc0nEupOyhKyNv5PoxuB28bpmI95qY0+IUl3aZYXMg2+r0w1YMA+AXozxoemduYSz+j/LAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849979; c=relaxed/simple;
	bh=ck7QO7Tkzrcu8Mua4xD9wFeA2GEWKuWofSfQBv1C58E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgHrP5DY+Z2VNtagqs8eXv+N5QZojQBk4elobSooZjAZEvF7ID1aXSkExku4OPTyVo06QEszERyhBs8nuY5J8bc47rj0/wZW9Ia++qGlvbZns47AX2y2uE2SZeWc4jqIPgnokAEbn9IUulrHHxVaM/9MxTyJXv/eBL9jQe2xcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LG5x+gZy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LG5x+gZy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747849978; x=1779385978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ck7QO7Tkzrcu8Mua4xD9wFeA2GEWKuWofSfQBv1C58E=;
  b=LG5x+gZyfPAoc5OEY1tn4XrtHZ99xK+2d6rvEUnj8jFgwzWeBOcO6asG
   tYeOkD6F3F1Fo1NrnjqjxdJOnH2aNKO/6/c7W6s+ynWO2jyejcHHNGE3j
   +YLpkca2Wfdt368jgx7FGcxh/VNkRoqFZsfvyfoUnmkYXIcU6avpoZwF9
   kuNmUVB+3ELJouEO8w+IQe7nLkmVLweS56A6rUDjbVgGNZNhki/+uv9//
   rw8WkjqRehzao8WzIcqL0dDrqzzmgGarNUYt7srlCQncinKozToE/jdvF
   6fQm//+quBd6Ij6AnRMs7XzjsLzaeHwW2qmCcF4fIYIulXFnM11NKu70l
   g==;
X-CSE-ConnectionGUID: JSEXTBHKSYqsfnWFtGk3ew==
X-CSE-MsgGUID: UmkPSB3MR22cGrbuPMPk0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="53511758"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="53511758"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 10:52:57 -0700
X-CSE-ConnectionGUID: lrlcPFBWQKmmWfCcdpzpSQ==
X-CSE-MsgGUID: jy1ohMqXTrWggEDhB6C8Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140029698"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 21 May 2025 10:52:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9CF50368; Wed, 21 May 2025 20:52:52 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v1 1/1] floppy: Replace custom SZ_64K constant
Date: Wed, 21 May 2025 20:50:56 +0300
Message-ID: <20250521175246.1351596-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are only two headers using the K_64 custom constant. Moreover,
its usage tangles a code because the constant is defined in the C
file, while users are in the headers. Replace it with well defined
SZ_64K from sizes.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

This should be placed on top of
https://lore.kernel.org/r/20250521174152.1339379-1-andriy.shevchenko@linux.intel.com
for the dependency reason. In case some changes are needed there,
this one may be attached to v2 of the series.

 arch/parisc/include/asm/floppy.h | 5 +++--
 arch/x86/include/asm/floppy.h    | 3 ++-
 drivers/block/floppy.c           | 2 --
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/parisc/include/asm/floppy.h b/arch/parisc/include/asm/floppy.h
index df20dbef3ada..f15b69fea901 100644
--- a/arch/parisc/include/asm/floppy.h
+++ b/arch/parisc/include/asm/floppy.h
@@ -8,9 +8,9 @@
 #ifndef __ASM_PARISC_FLOPPY_H
 #define __ASM_PARISC_FLOPPY_H
 
+#include <linux/sizes.h>
 #include <linux/vmalloc.h>
 
-
 /*
  * The DMA channel used by the floppy controller cannot access data at
  * addresses >= 16MB
@@ -20,7 +20,8 @@
  * floppy accesses go through the track buffer.
  */
 #define _CROSS_64KB(a,s,vdma) \
-(!(vdma) && ((unsigned long)(a)/K_64 != ((unsigned long)(a) + (s) - 1) / K_64))
+	(!(vdma) && \
+	 ((unsigned long)(a) / SZ_64K != ((unsigned long)(a) + (s) - 1) / SZ_64K))
 
 #define SW fd_routine[use_virtual_dma&1]
 #define CSW fd_routine[can_use_virtual_dma & 1]
diff --git a/arch/x86/include/asm/floppy.h b/arch/x86/include/asm/floppy.h
index e76cb74bbed2..e7a244051c62 100644
--- a/arch/x86/include/asm/floppy.h
+++ b/arch/x86/include/asm/floppy.h
@@ -10,6 +10,7 @@
 #ifndef _ASM_X86_FLOPPY_H
 #define _ASM_X86_FLOPPY_H
 
+#include <linux/sizes.h>
 #include <linux/vmalloc.h>
 
 /*
@@ -22,7 +23,7 @@
  */
 #define _CROSS_64KB(a, s, vdma)						\
 	(!(vdma) &&							\
-	 ((unsigned long)(a)/K_64 != ((unsigned long)(a) + (s) - 1) / K_64))
+	 ((unsigned long)(a) / SZ_64K != ((unsigned long)(a) + (s) - 1) / SZ_64K))
 
 #define SW fd_routine[use_virtual_dma & 1]
 #define CSW fd_routine[can_use_virtual_dma & 1]
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index e97432032f01..f4dc46fd25ea 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -233,8 +233,6 @@ static unsigned short virtual_dma_port = 0x3f0;
 irqreturn_t floppy_interrupt(int irq, void *dev_id);
 static int set_dor(int fdc, char mask, char data);
 
-#define K_64	0x10000		/* 64KB */
-
 /* the following is the mask of allowed drives. By default units 2 and
  * 3 of both floppy controllers are disabled, because switching on the
  * motor of these drives causes system hangs on some PCI computers. drive
-- 
2.47.2

