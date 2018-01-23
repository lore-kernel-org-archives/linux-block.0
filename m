Return-Path: <prvs=5540a0381=luisbg@amazon.com>
From: Luis de Bethencourt <luisbg@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH] block/sed-opal: Fix trailing semicolon
Date: Tue, 23 Jan 2018 13:16:03 +0000
Message-Id: <20180123131603.19919-1-luisbg@kernel.org>
List-ID: <linux-block@vger.kernel.org>

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---

Hi,

Similar to the other drivers/clocksource/ patch [0].

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [1].

Best regards 
Luis


[0] https://lkml.org/lkml/2018/1/23/213
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[2] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

 block/sed-opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9ed51d0c6b1d..e4929eec547f 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -490,7 +490,7 @@ static int opal_discovery0_end(struct opal_dev *dev)
 
 	if (!found_com_id) {
 		pr_debug("Could not find OPAL comid for device. Returning early\n");
-		return -EOPNOTSUPP;;
+		return -EOPNOTSUPP;
 	}
 
 	dev->comid = comid;
-- 
2.15.1
