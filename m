Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Rafael Antognolli <rafael.antognolli@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block/sed-opal: fix spelling mistake: "Lifcycle" -> "Lifecycle"
Date: Thu, 30 Mar 2017 10:58:08 +0100
Message-Id: <20170330095808.19574-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in pr_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/sed-opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 14035f826b5e..6736c7873d4a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1831,7 +1831,7 @@ static int get_lsp_lifecycle_cont(struct opal_dev *dev)
 	/* 0x08 is Manufacured Inactive */
 	/* 0x09 is Manufactured */
 	if (lc_status != OPAL_MANUFACTURED_INACTIVE) {
-		pr_err("Couldn't determine the status of the Lifcycle state\n");
+		pr_err("Couldn't determine the status of the Lifecycle state\n");
 		return -ENODEV;
 	}
 
-- 
2.11.0
