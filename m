Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33572 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbcFJD1a (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2016 23:27:30 -0400
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@canonical.com>,
	Mike Christie <mchristi@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Keith Busch <keith.busch@intel.com>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH] block: bio: kill BIO_MAX_SIZE
Date: Fri, 10 Jun 2016 11:27:12 +0800
Message-Id: <1465529234-31195-1-git-send-email-ming.lei@canonical.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

No one need this macro now, so remove it. Basically
only how many bvecs in one bio matters instead
of how many bytes in this bio.

The motivation is for supporting multipage bvecs, in
which we only know what the max count of bvecs is supported
in the bio.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/bio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index b64a3d9..b7e1a008 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -41,7 +41,6 @@
 #endif
 
 #define BIO_MAX_PAGES		256
-#define BIO_MAX_SIZE		(BIO_MAX_PAGES << PAGE_SHIFT)
 
 #define bio_prio(bio)			(bio)->bi_ioprio
 #define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
-- 
1.9.1

