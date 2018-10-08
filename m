Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 05/15] bcache: fix typo in code comments of closure_return_with_destructor()
Date: Mon,  8 Oct 2018 20:41:11 +0800
Message-Id: <20181008124121.20192-6-colyli@suse.de>
In-Reply-To: <20181008124121.20192-1-colyli@suse.de>
References: <20181008124121.20192-1-colyli@suse.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

The code comments of closure_return_with_destructor() in closure.h makrs
function name as closure_return(). This patch fixes this type with the
correct name - closure_return_with_destructor.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/closure.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
index eca0d496b686..c88cdc4ae4ec 100644
--- a/drivers/md/bcache/closure.h
+++ b/drivers/md/bcache/closure.h
@@ -345,7 +345,8 @@ do {									\
 } while (0)
 
 /**
- * closure_return - finish execution of a closure, with destructor
+ * closure_return_with_destructor - finish execution of a closure,
+ *				    with destructor
  *
  * Works like closure_return(), except @destructor will be called when all
  * outstanding refs on @cl have been dropped; @destructor may be used to safely
-- 
2.19.0
