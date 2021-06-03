Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324EAC47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 18:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14FAC613F9
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 18:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFCSsb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 14:48:31 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44924 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCSsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 14:48:31 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 5FFF320B7178; Thu,  3 Jun 2021 11:46:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FFF320B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1622746006;
        bh=HI4zlfdxf8GbN+8OyNNKD0rxn8LbKNH+lRJ/OymYueI=;
        h=From:To:Cc:Subject:Date:From;
        b=IRGvEIjlLgf/5GppIFX+W/58cmOR91g3sDWw+p/rEYy8weYEmvc9vot3Diu2cOecX
         eRUIGcemNFSdlsyjD2XZwusIG9LayjjtQAFxtlVf4i2ijwjV03iNIBTr5Ol1isJGE7
         2AsU+uEhgZsyC5vzFqQuXITLiuumw5k95eTqdDcs=
From:   longli@linuxonhyperv.com
To:     linux-block@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] block: return the correct first bvec when checking for gaps
Date:   Thu,  3 Jun 2021 11:46:45 -0700
Message-Id: <1622746005-10785-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Long Li <longli@microsoft.com>

After commit 07173c3ec276 ("block: enable multipage bvecs"), a bvec can
have multiple pages. But bio_will_gap() still assumes one page bvec while
checking for merging. This causes data corruption on drivers relying on
the correct merging on virt_boundary_mask.

Fix this by returning the bvec for multi-page bvec.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 07173c3ec276 ("block: enable multipage bvecs")
Signed-off-by: Long Li <longli@microsoft.com>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0b4cfdf62a4..e89242a53bbc 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -271,7 +271,7 @@ static inline void bio_clear_flag(struct bio *bio, unsigned int bit)
 
 static inline void bio_get_first_bvec(struct bio *bio, struct bio_vec *bv)
 {
-	*bv = bio_iovec(bio);
+	*bv = mp_bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
 }
 
 static inline void bio_get_last_bvec(struct bio *bio, struct bio_vec *bv)
-- 
2.17.1

