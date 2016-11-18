Return-Path: <ozgur.root@gmail.com>
Return-Path: <ozgur.root@gmail.com>
From: Ozgur Karatas <ozgur.root@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ozgur Karatas <mueddib@openldap.org>
Subject: [PATCH] block: bio-integrity fixed a Oracle Copyright year.
Date: Fri, 18 Nov 2016 14:54:47 +0300
Message-Id: <1479470087-7654-1-git-send-email-mueddib@goosey.org>
List-ID: <linux-block@vger.kernel.org>

From: Ozgur Karatas <mueddib@openldap.org>

Fixed a on the github request issue.

Signed-off-by: Ozgur Karatas <mueddib@goosey.org>
---
 block/bio-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 5384713..775d83e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -1,7 +1,7 @@
 /*
  * bio-integrity.c - bio data integrity extensions
  *
- * Copyright (C) 2007, 2008, 2009 Oracle Corporation
+ * Copyright (C) 2007, 2008, 2009, 2010, 2011, 2012 Oracle Corporation
  * Written by: Martin K. Petersen <martin.petersen@oracle.com>
  *
  * This program is free software; you can redistribute it and/or
-- 
2.1.4
