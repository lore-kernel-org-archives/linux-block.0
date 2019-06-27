Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C71C48BD6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 00:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC37F2082F
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 00:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596661;
	bh=O0ULjoFzCNvZzXuW9GRqTXu/TYfN84Zp6g+9mIEnPNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SBRSMfVoRu/Y13q/bEAjYkRasI86TMxdPOKKvsAuuS4z3R7LVlV2gbL2hEZ/a5TgV
	 Ix3Q9ZziiAGnvTbnOXDhoNIQQdprfdUkkMbjjRUI/JSXdvT6DsDLhB+L7/6/lQvIgN
	 GvYyUkQA0d48pkEt6OaQO/HAXZ+oULrMNadyLwpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfF0Aen (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbfF0Aem (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 20:34:42 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EDD92184B;
        Thu, 27 Jun 2019 00:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595681;
        bh=O0ULjoFzCNvZzXuW9GRqTXu/TYfN84Zp6g+9mIEnPNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQ+veMiCv2CNdGUElw8IUrjpKyELQByVsj50ff3eAOo/XhZl0mDywPKnsWW1gs+cH
         xfPzFnziegwHU8JPyHOJyC5I5HwOQ9QmXmB0K0Mxt/rXwLKTrRVXeXVwGhAPZcb0Fv
         HX4OUGED34OjsfIHs8LkiA4Swg9vvHnfgGkl1EF0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 77/95] block: fix page leak when merging to same page
Date:   Wed, 26 Jun 2019 20:30:02 -0400
Message-Id: <20190627003021.19867-77-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 4569180495600ac59f5cd27f67242a6cb51254f3 ]

When multiple iovecs reference the same page, each get_user_page call
will add a reference to the page.  But once we've created the bio that
information gets lost and only a single reference will be dropped after
I/O completion.  Use the same_page information returned from
__bio_try_merge_page to drop additional references to pages that were
already present in the bio.

Based on a patch from Ming Lei.

Link: https://lkml.org/lkml/2019/4/23/64
Fixes: 576ed913 ("block: use bio_add_page in bio_iov_iter_get_pages")
Reported-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a3c80a6c1fe5..80a25c245109 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -884,6 +884,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
+	bool same_page = false;
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
@@ -904,8 +905,15 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		struct page *page = pages[i];
 
 		len = min_t(size_t, PAGE_SIZE - offset, left);
-		if (WARN_ON_ONCE(bio_add_page(bio, page, len, offset) != len))
-			return -EINVAL;
+
+		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
+			if (same_page)
+				put_page(page);
+		} else {
+			if (WARN_ON_ONCE(bio_full(bio)))
+                                return -EINVAL;
+			__bio_add_page(bio, page, len, offset);
+		}
 		offset = 0;
 	}
 
-- 
2.20.1

