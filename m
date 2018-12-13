Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB07CC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCBA20870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCBA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeLMOzO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:55:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:51452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729063AbeLMOzN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:55:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2977AADDD;
        Thu, 13 Dec 2018 14:55:12 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Shenghui Wang <shhuiw@foxmail.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 04/12] bcache: update comment in sysfs.c
Date:   Thu, 13 Dec 2018 22:53:49 +0800
Message-Id: <20181213145357.38528-5-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181213145357.38528-1-colyli@suse.de>
References: <20181213145357.38528-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

We have struct cached_dev allocated by kzalloc in register_bcache(), which
initializes all the fields of cached_dev with 0s. And commit ce4c3e19e520
("bcache: Replace bch_read_string_list() by __sysfs_match_string()") has
remove the string "default".

Update the comment.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 26f035a0c5b9..d2e5c9892d4d 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -16,7 +16,7 @@
 #include <linux/sort.h>
 #include <linux/sched/clock.h>
 
-/* Default is -1; we skip past it for struct cached_dev's cache mode */
+/* Default is 0 ("writethrough") */
 static const char * const bch_cache_modes[] = {
 	"writethrough",
 	"writeback",
@@ -25,7 +25,7 @@ static const char * const bch_cache_modes[] = {
 	NULL
 };
 
-/* Default is -1; we skip past it for stop_when_cache_set_failed */
+/* Default is 0 ("auto") */
 static const char * const bch_stop_on_failure_modes[] = {
 	"auto",
 	"always",
-- 
2.16.4

