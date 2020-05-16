Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC42C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 00:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0512078B
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 00:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgEPATZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 20:19:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39130 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgEPATZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 20:19:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id s20so1570704plp.6
        for <linux-block@vger.kernel.org>; Fri, 15 May 2020 17:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJHLVSR8d4dv8IVyQEiXwc3ArTGq9TVZ6by8a5LIyaQ=;
        b=bemnlOmu0iXamwpyp+lqLafF6JhCNrQpaP29AbIEtQqWks6tdBJc7X+Gip7c63o4+m
         KBOk+X/r2qdSgi3iVUbiMaOcnIFYmW1YbyB3ST48ZHYzGocZQtXIph9YhRlyzrUrtf9J
         HoQW4oEkFmnQT0hP33LXBWNVKmhvB34AFOA6Mo92excSR99wR3nJmtriaMHanMxcg2sD
         3/O6Gr06TbH29CDv5TjVSaeqG6rR5qJxI+dLeC7eNzP+VRzMJmVSJFh5aa2EhRf+OCGU
         aVogFJ8H9o7R3NK33BGxcN9p3/iuzrzGfzwuDJg8PlqX4xoz06BXVWbIS3DL28a4lgwX
         j72A==
X-Gm-Message-State: AOAM530dlM+w2e0X0tXtsj6LaxERhkcHkRbTPGH+ULYTetrLjByTMs0v
        W2jX7PA/pZlM4B23sk5/QWU=
X-Google-Smtp-Source: ABdhPJxBSz4yuHmpasSIawMgnzZB5XnLxYgEdsMWlODn0RQMacWl5zcBZDcupc6L1rRuRI/L8dkyew==
X-Received: by 2002:a17:902:82c1:: with SMTP id u1mr6182399plz.10.1589588364501;
        Fri, 15 May 2020 17:19:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:f99a:ee92:9332:42a])
        by smtp.gmail.com with ESMTPSA id 30sm2542383pgp.38.2020.05.15.17.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 17:19:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH 2/5] bio.h: Declare the arguments of bio iteration functions const
Date:   Fri, 15 May 2020 17:19:11 -0700
Message-Id: <20200516001914.17138-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516001914.17138-1-bvanassche@acm.org>
References: <20200516001914.17138-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This change makes it possible to pass 'const struct bio *' arguments to
these functions.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/bio.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0ee494a6329..58e6134b1c05 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -70,7 +70,7 @@ static inline bool bio_has_data(struct bio *bio)
 	return false;
 }
 
-static inline bool bio_no_advance_iter(struct bio *bio)
+static inline bool bio_no_advance_iter(const struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
@@ -138,8 +138,8 @@ static inline bool bio_next_segment(const struct bio *bio,
 #define bio_for_each_segment_all(bvl, bio, iter) \
 	for (bvl = bvec_init_iter_all(&iter); bio_next_segment((bio), &iter); )
 
-static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
-				    unsigned bytes)
+static inline void bio_advance_iter(const struct bio *bio,
+				    struct bvec_iter *iter, unsigned bytes)
 {
 	iter->bi_sector += bytes >> 9;
 
