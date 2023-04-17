Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9568C77B76
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 19:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDQTMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDQTMx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 15:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB9F59EE
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681758722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=J3CbznqNeX4k5gfBl/por4zkotI1j8zz1N4+FYt2z3s=;
        b=gEIik2cK9DO28IQOBGUrNdl2TTkexIN56cv1KuUtsirUSstYpnnZM9W6WKcMuluehyWtoG
        Bzu/dX+lBFi8t5hzRgkhMT3y29P38x7HcCsufGFb/xSEE8LR56wWOkFD2dNMc2MPtKQmUP
        Ecpq7rxn8f1WcP8U5MCxTsWW8W/m1fg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-jmjybXY9M2iJCHi_f1s6Mw-1; Mon, 17 Apr 2023 15:11:58 -0400
X-MC-Unique: jmjybXY9M2iJCHi_f1s6Mw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58880185A7BA;
        Mon, 17 Apr 2023 19:11:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B7C1492B0C;
        Mon, 17 Apr 2023 19:11:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 33HJBwvl020263;
        Mon, 17 Apr 2023 15:11:58 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 33HJBvCi020259;
        Mon, 17 Apr 2023 15:11:57 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 17 Apr 2023 15:11:57 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
cc:     Mike Snitzer <msnitzer@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH] block: fix a crash when bio_for_each_folio_all iterates over
 an empty bio
Message-ID: <alpine.LRH.2.21.2304171433370.17217@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we use bio_for_each_folio_all on an empty bio, it will access the first
bio vector unconditionally (it is uninitialized) and it may crash
depending on the uninitialized data.

This patch fixes it by checking the parameter "i" against "bio->bi_vcnt"
and returning NULL fi->folio if it is out of range.

The patch also drops the test "if (fi->_i + 1 < bio->bi_vcnt)" from
bio_next_folio because the same condition is already being checked in
bio_first_folio.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 include/linux/bio.h |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

Index: linux-2.6/include/linux/bio.h
===================================================================
--- linux-2.6.orig/include/linux/bio.h
+++ linux-2.6/include/linux/bio.h
@@ -279,15 +279,19 @@ struct folio_iter {
 static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
 				   int i)
 {
-	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
+	if (i < bio->bi_vcnt) {
+		struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
 
-	fi->folio = page_folio(bvec->bv_page);
-	fi->offset = bvec->bv_offset +
-			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
-	fi->_seg_count = bvec->bv_len;
-	fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
-	fi->_next = folio_next(fi->folio);
-	fi->_i = i;
+		fi->folio = page_folio(bvec->bv_page);
+		fi->offset = bvec->bv_offset +
+				PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
+		fi->_seg_count = bvec->bv_len;
+		fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
+		fi->_next = folio_next(fi->folio);
+		fi->_i = i;
+	} else {
+		fi->folio = NULL;
+	}
 }
 
 static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
@@ -298,10 +302,8 @@ static inline void bio_next_folio(struct
 		fi->offset = 0;
 		fi->length = min(folio_size(fi->folio), fi->_seg_count);
 		fi->_next = folio_next(fi->folio);
-	} else if (fi->_i + 1 < bio->bi_vcnt) {
-		bio_first_folio(fi, bio, fi->_i + 1);
 	} else {
-		fi->folio = NULL;
+		bio_first_folio(fi, bio, fi->_i + 1);
 	}
 }
 

