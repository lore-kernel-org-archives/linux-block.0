Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: jglisse@redhat.com
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [RFC PATCH 76/79] mm/ksm: have ksm select PAGE_RONLY config.
Date: Wed,  4 Apr 2018 15:18:28 -0400
Message-Id: <20180404191831.5378-39-jglisse@redhat.com>
In-Reply-To: <20180404191831.5378-1-jglisse@redhat.com>
References: <20180404191831.5378-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

From: Jérôme Glisse <jglisse@redhat.com>

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index aeffb6e8dd21..6994a1fdf847 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -308,6 +308,7 @@ config MMU_NOTIFIER
 config KSM
 	bool "Enable KSM for page merging"
 	depends on MMU
+	select PAGE_RONLY
 	help
 	  Enable Kernel Samepage Merging: KSM periodically scans those areas
 	  of an application's address space that an app has advised may be
-- 
2.14.3
