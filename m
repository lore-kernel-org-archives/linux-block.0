Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4F7C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4531E60F6F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhHYQlh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbhHYQlh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 12:41:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E658C061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HJY1+vaQAHzPlwSluEOdaLYpzyAqL2TCkEk9c36C1dA=; b=LhkdMk+nrIZyL4kn89F0fvwdkr
        BOer+/75eNECOFgk76gWMrjtFt2Wp/C8UpJS3febCh2JnqGzXIJ55j9r/YiPd/MX9Y+4RdNfNua5+
        zf2R195fdtcpXS2E+lJNtnFPgS+x8396z5WsjH00cnhG7vuhCOOlO/kkkAIfuQzrX9zb/sCXAr/nc
        KDIosvRf33wGRubD7S7DlUC7WnGi0CKgJ4se8r6xcA23XO0r977Ghidz11OpZzQIeVKh8/2hLm/W8
        3zPUG3HFxyaZNa1EZ15BdNSbFzisjlv3exl0NU3QcKu32YBes1XFjMSelfpG70ot4cOqXLYi9T1H3
        QvWPHP8w==;
Received: from [2001:4bb8:193:fd10:a3f9:5689:21a4:711f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIvuv-00CU4d-Mp; Wed, 25 Aug 2021 16:38:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Xiubo Li <xiubli@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 4/6] nbd: set nbd->index before releasing nbd_index_mutex
Date:   Wed, 25 Aug 2021 18:31:06 +0200
Message-Id: <20210825163108.50713-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825163108.50713-1-hch@lst.de>
References: <20210825163108.50713-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

Set nbd->index before releasing nbd_index_mutex, as populate_nbd_status()
might access nbd->index as soon as nbd_index_mutex is released.

Fixes: 6e4df4c64881 ("nbd: reduce the nbd_index_mutex scope")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index dfaa95df8d6c..042af761d3a4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1724,10 +1724,10 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 		if (err >= 0)
 			index = err;
 	}
+	nbd->index = index;
 	mutex_unlock(&nbd_index_mutex);
 	if (err < 0)
 		goto out_free_tags;
-	nbd->index = index;
 
 	disk = blk_mq_alloc_disk(&nbd->tag_set, NULL);
 	if (IS_ERR(disk)) {
-- 
2.30.2

