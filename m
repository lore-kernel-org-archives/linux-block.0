Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5806AC7EE2A
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 13:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbjELNjR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 09:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbjELNjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 09:39:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EBD124BA
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DzQgIv/qb6Wfu9ri4F2baSqhzwQuWj9dIDs/FEyxeRY=; b=X9dEQdLmbGkVIEDlN6wirUiu0X
        KR5ywD1vPC5cZvpMz/JzLTyfm+MtomnvbxXC1j+0mhQrhOjNX5pf8zBc96LOMWufvxbgehBwT8tzX
        nHiCaOUMAn4QLmSc1wmmfI08O0stysRF6W4/hUkvr3/kPKOXdKBB3OjxFK4W4sfpHiWczUpYLdrgU
        2vt/2wvPSUGiZEZDniV05kuxPWjuTf0tcfuXCEgmjjPXUzMa2PqNqYvcCx7DlfYcYGQ4IBqdG8zaP
        Lsm7JQljHBwcfFIHKZI5BSwsxC2JjewSQ4OLrriACi0mBkL6gIo/I9T+w1Gy4q+W3b4EZo5tspXPc
        o50WWmGA==;
Received: from [204.239.251.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSzK-00C2i5-02;
        Fri, 12 May 2023 13:39:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 3/8] block: move the BIO_CLONED checks out of __bio_try_merge_page
Date:   Fri, 12 May 2023 06:38:56 -0700
Message-Id: <20230512133901.1053543-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512133901.1053543-1-hch@lst.de>
References: <20230512133901.1053543-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__bio_try_merge_page is a way too low-level helper to assert that the
bio is not cloned.  Move the check into bio_add_page and
bio_iov_iter_get_pages instead, which are the high level entry points
that should enforce this variant.  bio_add_hw_page already this
check, coverig the third (indirect) caller of __bio_try_merge_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d020065e613cc8..c7bf20a779ebed 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -945,9 +945,6 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 static bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page)
 {
-	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
-		return false;
-
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
@@ -1127,6 +1124,9 @@ int bio_add_page(struct bio *bio, struct page *page,
 {
 	bool same_page = false;
 
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
+		return 0;
+
 	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
 		if (bio_full(bio, len))
 			return 0;
@@ -1328,6 +1328,9 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	int ret = 0;
 
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
+		return -EIO;
+
 	if (iov_iter_is_bvec(iter)) {
 		bio_iov_bvec_set(bio, iter);
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
-- 
2.39.2

