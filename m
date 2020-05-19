Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF4EC433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF4C2070A
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgESEHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 00:07:51 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34368 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgESEHv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 00:07:51 -0400
Received: by mail-pj1-f65.google.com with SMTP id l73so712197pjb.1
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 21:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcfnQojx/doFhHpkvlqZHsi2lSxiHoLu3RvZ54XPUTs=;
        b=mJwgjQ4C40dCo4GUIZ99DkWFUK4YlQFiHXbIoAvcA5QGcvuD39/z6wi3TppfqOSWf9
         hs+vvVJugyNNucc5bv+mtrrxbPjsgBysVRywPtVxnEekMfiniWv62U5fQo2ORAMM/3yt
         2wcp97oY7ZXD2qN5oEeFMm8Q4mzzOncK6sxorQ4eO79/iqSfAxFzq/7tvwqLFRPLZ2Ku
         Ym93YprjvfSDdEctDNrpsUW7ScEbgfMG7/x0iHb541krzoyf+iAipa+D9KaAe/PcoJQv
         0+tTVHw7xQk7b16eXW2VFS3BdfrboGpfkT0Ks5JbrmX2ipuj23VXZ3wuc1fuaKZHiApa
         Ylxw==
X-Gm-Message-State: AOAM532kZ8H/ScvoLY0CgFJOSqL5Jmyu2KdclsxXpMznfy4fnoYBA72+
        Xb6Gq55bkLy22E+gY1Qubzk=
X-Google-Smtp-Source: ABdhPJyniqUJlDXbSnNdmETy6cpri24fl/Nprr48hTRMBdCp01/7yRkJe/ve4dREQOhEiFNtgCY11A==
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr13284206pll.281.1589861268955;
        Mon, 18 May 2020 21:07:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:dc5d:b628:d57b:164])
        by smtp.gmail.com with ESMTPSA id l3sm823479pju.38.2020.05.18.21.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 21:07:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v3 2/4] bio.h: Declare the arguments of the bio iteration functions const
Date:   Mon, 18 May 2020 21:07:35 -0700
Message-Id: <20200519040737.4531-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519040737.4531-1-bvanassche@acm.org>
References: <20200519040737.4531-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This change makes it possible to pass 'const struct bio *' arguments to
these functions.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/bio.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0ee494a6329..950c9dc44c4f 100644
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
+				    struct bvec_iter *iter, unsigned int bytes)
 {
 	iter->bi_sector += bytes >> 9;
 
