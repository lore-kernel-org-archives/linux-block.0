Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49939 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755780AbcIKODN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Sep 2016 10:03:13 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/3] bio.h: remove a very outdated comment
Date: Sun, 11 Sep 2016 16:03:03 +0200
Message-Id: <1473602584-11744-3-git-send-email-hch@lst.de>
In-Reply-To: <1473602584-11744-1-git-send-email-hch@lst.de>
References: <1473602584-11744-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 23ddf4b..e00721a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -1,6 +1,4 @@
 /*
- * 2.5 block I/O model
- *
  * Copyright (C) 2001 Jens Axboe <axboe@suse.de>
  *
  * This program is free software; you can redistribute it and/or modify
-- 
2.1.4

