Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: jglisse@redhat.com
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [RFC PATCH 74/79] mm/page_ronly: add config option for generic read only page framework.
Date: Wed,  4 Apr 2018 15:18:26 -0400
Message-Id: <20180404191831.5378-37-jglisse@redhat.com>
In-Reply-To: <20180404191831.5378-1-jglisse@redhat.com>
References: <20180404191831.5378-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

From: Jérôme Glisse <jglisse@redhat.com>

It's really just a config option patch.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index c782e8fb7235..aeffb6e8dd21 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -149,6 +149,9 @@ config NO_BOOTMEM
 config MEMORY_ISOLATION
 	bool
 
+config PAGE_RONLY
+	bool
+
 #
 # Only be set on architectures that have completely implemented memory hotplug
 # feature. If you are not sure, don't touch it.
-- 
2.14.3
