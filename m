Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35894 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161219AbcE3Ngn (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 30 May 2016 09:36:43 -0400
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@canonical.com>,
	Keith Busch <keith.busch@intel.com>,
	NeilBrown <neilb@suse.com>, Tejun Heo <tj@kernel.org>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH v6 6/8] block: bio: remove BIO_MAX_SECTORS
Date: Mon, 30 May 2016 21:34:34 +0800
Message-Id: <1464615294-9946-7-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

No one need this macro, so remove it. The motivation is
for supporting multipage bvecs, in which we only know
what the max count of bvecs is supported in the bio,
instead of max size or max sectors.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/bio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8555b90..fb59a06 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -42,7 +42,6 @@
 
 #define BIO_MAX_PAGES		256
 #define BIO_MAX_SIZE		(BIO_MAX_PAGES << PAGE_SHIFT)
-#define BIO_MAX_SECTORS		(BIO_MAX_SIZE >> 9)
 
 /*
  * upper 16 bits of bi_rw define the io priority of this bio
-- 
1.9.1

