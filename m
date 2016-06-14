Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2on0099.outbound.protection.outlook.com ([65.55.169.99]:32024
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750985AbcFNPEo (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 11:04:44 -0400
Subject: [PATCH 3/3] block/blk-cgroup.c: Declare local symbols static
To: Jens Axboe <axboe@fb.com>
References: <25262742-283b-fc4d-30df-d6a9196c85a5@sandisk.com>
CC: Tejun Heo <tj@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <298984df-eb0b-4643-5f2b-b19f8bd9c3d9@sandisk.com>
Date: Tue, 14 Jun 2016 17:04:32 +0200
MIME-Version: 1.0
In-Reply-To: <25262742-283b-fc4d-30df-d6a9196c85a5@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Detected by sparse.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 66e6f1a..dd38e5c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -905,7 +905,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	return 0;
 }
 
-struct cftype blkcg_files[] = {
+static struct cftype blkcg_files[] = {
 	{
 		.name = "stat",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -914,7 +914,7 @@ struct cftype blkcg_files[] = {
 	{ }	/* terminate */
 };
 
-struct cftype blkcg_legacy_files[] = {
+static struct cftype blkcg_legacy_files[] = {
 	{
 		.name = "reset_stats",
 		.write_u64 = blkcg_reset_stats,
-- 
2.8.4

