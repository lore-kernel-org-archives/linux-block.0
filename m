Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CECC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4376264EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhBBFhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:37:47 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14105 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhBBFhr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244266; x=1643780266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1JgN/d1M6nHcg9iqAe9HY4ryEam4iSXfnWjESknWn20=;
  b=SRFNh6E/tB1pkX4Wjq0bWbkyaPI+AEVELy+lscmaPmW8lBfuWj4DQxZ5
   VJ+TfIDrvM0VS00sQha0q8MT90v6CNS26dYMnNH5Pj5nddhtSvGywRBCV
   og+3e4UWfHSrv8dSUE8WyqedsulMzlwo/zsa3bQ3Rk8EpB/2uVapCo0YF
   /lkszMvXoeEeon/vz/AlmpFyYlw0QdoLeMJMZUCoFcLZe/r/PzHshknGS
   o3QxvPr34BZ/OAApeBBCqm67no2rHiPHPlCGmettiApy9OxJ/VjSnhgyD
   5MH4fZ6jZXiTP1bXlf0cX5j3VXPmL8OUNX6iHhPARXo1QlXADSIW/Srpg
   A==;
IronPort-SDR: 01sqTRMDd+13s9BoX+quS/rxKqDiXQqgu4usdntQPwh5cENSpqv+ul38WFOgfDtRKVeLnM27HV
 UWFDV62oBfQM8Pj73BlYP4V04F1Ldg1OUJ5OcjdxAzn7FBGT7LcLv+KNd8v+JcVjrGoNcbjfLD
 BytIxUdmRRzUWR/CfdOydZgfQsbPaU3iwM06EKAvLz56m0OcOEPjFtvJRZh1eK8R4CdxituexQ
 wGUaVfpXTMWyfI+M7KQ3jDnroPx4DWJ3orffFygSOMrbPwXM9wswtrnD24qmckqsc219OKOuR5
 ecs=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158885717"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:36:48 +0800
IronPort-SDR: weYrxflmWXRPdmPKcF+agFJO5qdCWe8UFVA668LOgU51u3Y35GTOIbnlik9s6CanqPPI73sO7T
 HiQFWle85KGVTbTkLN7kW7zOWQZgZr09ITwUApLXmfQpQO3LKd3itKa8OeBae/YLg0rASGlZNd
 9vJ1FeqIRXwPoDvlDFqQJnegXR1/IVn/ayi+PtjBVDG5SPOj4y/6JhqlgH5+tmtXDaVwX/rzNE
 eQ8a2Im7uFfOGdrMxq5Nd903gZBIOiwJKkLtuXa2rfIzor22+53EkgnswyogaR0saqwKSzC1a1
 9+5FAr4pdBBZNrDtYfDMhU0f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:20:57 -0800
IronPort-SDR: YCCvhJVoTC5tvKSCZAipI9AL3Z1GCxEWARz269+mc54Ul566BYpLNxVq1AWptF/ZtUJRcaYsxk
 R19Daxlf1Fu8z5Gy0bBWXnLuXnzZV/ko83iaRQu2wN6ilsBD7iKeEQf1nPDsqW6IA5BHDv1qZs
 1c8EDSKxWNkR4svRo6JtjWP/lCfcIhAjfhKVGibHGi4DHxaU6yCaeIeBWB5MyTnUpk/BKeU+iG
 +9nI3E5aYTueY0w24rEQzr+fP79nsrI6bCtLkKLBdCFWHnzii9nwhOTIbyn3ADaHUGlycE1bLy
 +0k=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:36:48 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 07/20] loop: use uniform variable declaration style
Date:   Mon,  1 Feb 2021 21:35:39 -0800
Message-Id: <20210202053552.4844-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The mixing of two different styles of variable declaration cretes
confusion for the new developer when adding the code. since this is
a block driver use standard variable declaration present in the block
layer.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9e59adfd11ff..c4458b3f1dab 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -669,8 +669,8 @@ static inline int is_loop_device(struct file *file)
 
 static int loop_validate_file(struct file *file, struct block_device *bdev)
 {
-	struct inode	*inode = file->f_mapping->host;
-	struct file	*f = file;
+	struct inode *inode = file->f_mapping->host;
+	struct file *f = file;
 
 	/* Avoid recursion */
 	while (is_loop_device(f)) {
@@ -701,9 +701,9 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 			  unsigned int arg)
 {
-	struct file	*file = NULL, *old_file;
-	int		error;
-	bool		partscan;
+	struct file *file = NULL, *old_file;
+	bool partscan;
+	int error;
 
 	error = mutex_lock_killable(&lo->lo_mutex);
 	if (error)
@@ -1069,13 +1069,13 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 			  struct block_device *bdev,
 			  const struct loop_config *config)
 {
-	struct file	*file;
-	struct inode	*inode;
+	struct file *file;
+	struct inode *inode;
 	struct address_space *mapping;
-	int		error;
-	loff_t		size;
-	bool		partscan;
-	unsigned short  bsize;
+	int error;
+	loff_t size;
+	bool partscan;
+	unsigned short bsize;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
-- 
2.22.1

