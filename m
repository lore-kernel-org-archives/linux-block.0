Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: damien.lemoal@wdc.com
Cc: hare@suse.de, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH dm-zoned-tools 1/2] README: fix small typo host-manmaged --> host-managed
Date: Mon, 30 Apr 2018 12:45:19 -0700
Message-Id: <20180430194520.9065-1-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Small typo fix.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 61830dd..7762694 100644
--- a/README
+++ b/README
@@ -23,7 +23,7 @@ http://www.t13.org/Documents/UploadedDocuments/docs2015/
 di537r05-Zoned_Device_ATA_Command_Set_ZAC.pdf
 
 dm-zoned implementation focused on simplicity and on minimizing overhead (CPU,
-memory and storage overhead). For a 10TB host-manmaged disk with 256 MB zones,
+memory and storage overhead). For a 10TB host-managed disk with 256 MB zones,
 dm-zoned memory usage per disk instance is at most 4.5 MB and as little as 5
 zones will be used internally for storing metadata and performaing reclaim
 operations.
-- 
2.17.0
