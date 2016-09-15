Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60344 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754934AbcIOLzc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 07:55:32 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org,
        Matthew Wilcox <willy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 01/41] tools: Add WARN_ON_ONCE
Date: Thu, 15 Sep 2016 14:54:43 +0300
Message-Id: <20160915115523.29737-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20160915115523.29737-1-kirill.shutemov@linux.intel.com>
References: <20160915115523.29737-1-kirill.shutemov@linux.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Matthew Wilcox <willy@linux.intel.com>

The radix tree uses its own buggy WARN_ON_ONCE.  Replace it with the
definition from asm-generic/bug.h

Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 tools/include/asm/bug.h              | 11 +++++++++++
 tools/testing/radix-tree/Makefile    |  2 +-
 tools/testing/radix-tree/linux/bug.h |  2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/include/asm/bug.h b/tools/include/asm/bug.h
index 9e5f4846967f..beda1a884b50 100644
--- a/tools/include/asm/bug.h
+++ b/tools/include/asm/bug.h
@@ -12,6 +12,17 @@
 	unlikely(__ret_warn_on);		\
 })
 
+#define WARN_ON_ONCE(condition) ({			\
+	static int __warned;				\
+	int __ret_warn_once = !!(condition);		\
+							\
+	if (unlikely(__ret_warn_once && !__warned)) {	\
+		__warned = true;			\
+		WARN_ON(1);				\
+	}						\
+	unlikely(__ret_warn_once);			\
+})
+
 #define WARN_ONCE(condition, format...)	({	\
 	static int __warned;			\
 	int __ret_warn_once = !!(condition);	\
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 3b530467148e..20d8bb37017a 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -1,5 +1,5 @@
 
-CFLAGS += -I. -g -Wall -D_LGPL_SOURCE
+CFLAGS += -I. -I../../include -g -Wall -D_LGPL_SOURCE
 LDFLAGS += -lpthread -lurcu
 TARGETS = main
 OFILES = main.o radix-tree.o linux.o test.o tag_check.o find_next_bit.o \
diff --git a/tools/testing/radix-tree/linux/bug.h b/tools/testing/radix-tree/linux/bug.h
index ccbe444977df..23b8ed52f8c8 100644
--- a/tools/testing/radix-tree/linux/bug.h
+++ b/tools/testing/radix-tree/linux/bug.h
@@ -1 +1 @@
-#define WARN_ON_ONCE(x)		assert(x)
+#include "asm/bug.h"
-- 
2.9.3

