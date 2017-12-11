Return-Path: <gomonovych@gmail.com>
Return-Path: <gomonovych@gmail.com>
From: Vasyl Gomonovych <gomonovych@gmail.com>
To: scott.bauer@intel.com,
	jonathan.derrick@intel.com,
	rafael.antognolli@intel.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	gomonovych@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] block/sed-opal: Fix warnings never less than zero
Date: Mon, 11 Dec 2017 16:45:15 +0100
Message-Id: <1513007115-32102-1-git-send-email-gomonovych@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Fixed following smatch warnings in sed-opal.c
block/sed-opal.c:2311 opal_set_new_pw()
warn: unsigned 'opal_pw->session.who' is never less than zero.

Unless enum opal_user interface will remain stable warning could be fixed
in mentioned way by removing unnecessary check

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 block/sed-opal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9ed51d0c..a5f0fa2 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2222,8 +2222,7 @@ static int opal_lock_unlock(struct opal_dev *dev,
 {
 	int ret;
 
-	if (lk_unlk->session.who < OPAL_ADMIN1 ||
-	    lk_unlk->session.who > OPAL_USER9)
+	if (lk_unlk->session.who > OPAL_USER9)
 		return -EINVAL;
 
 	mutex_lock(&dev->dev_lock);
@@ -2308,9 +2307,7 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 	};
 	int ret;
 
-	if (opal_pw->session.who < OPAL_ADMIN1 ||
-	    opal_pw->session.who > OPAL_USER9  ||
-	    opal_pw->new_user_pw.who < OPAL_ADMIN1 ||
+	if (opal_pw->session.who > OPAL_USER9  ||
 	    opal_pw->new_user_pw.who > OPAL_USER9)
 		return -EINVAL;
 
-- 
1.9.1
