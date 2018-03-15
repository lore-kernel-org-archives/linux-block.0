Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46680 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbeCOPIa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:30 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 11/16] bcache: Check the d->disk pointer before using it
Date: Thu, 15 Mar 2018 08:08:09 -0700
Message-Id: <20180315150814.9412-12-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since bcache_device_free() checks the d->disk pointer I think that
means that that pointer can be NULL. Hence test that pointer before
using it. This was detected by smatch.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index d19a44cd1fd7..39bec137f636 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -742,7 +742,7 @@ static void bcache_device_free(struct bcache_device *d)
 {
 	lockdep_assert_held(&bch_register_lock);
 
-	pr_info("%s stopped", d->disk->disk_name);
+	pr_info("%s stopped", d->disk ? d->disk->disk_name : "(?)");
 
 	if (d->c)
 		bcache_device_detach(d);
-- 
2.16.2
