Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34630 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942602AbcJ2IN6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:13:58 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 27/60] block: introduce BIO_SP_MAX_SECTORS
Date: Sat, 29 Oct 2016 16:08:26 +0800
Message-Id: <1477728600-12938-28-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This macro is needed when one multipage bvec based bio is
converted to singlepage bvec based bio, for example, bio bounce
requires singlepage bvec.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bio.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8634bd24984c..fa71f6a57f81 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -40,6 +40,9 @@
 
 #define BIO_MAX_PAGES		256
 
+/* Max sectors of bio with singlepage bvec */
+#define BIO_SP_MAX_SECTORS     (BIO_MAX_PAGES * (PAGE_SIZE >> 9))
+
 #define bio_prio(bio)			(bio)->bi_ioprio
 #define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
 
-- 
2.7.4

