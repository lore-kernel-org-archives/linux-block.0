Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC72C61CE8
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 18:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFDD2084C
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 18:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+YzevEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfASSFM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:05:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36779 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfASSFM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 13:05:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so18822897qtn.3
        for <linux-block@vger.kernel.org>; Sat, 19 Jan 2019 10:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BR2RmhJOTJBgiIJ2i7GuBYcM1SLipDerQvNJepDZqU0=;
        b=j+YzevElnuEqVQd1o7IebbbTSeKspM9GLKZGLAUyOVQdZf8q9dGbOtFKOW5arK6fS0
         4nuiJWPe5PZqkWGRhZ0EZ0ZSqREvi87I9mmmPJJT2jAwoYUVh7Keg2dwLRv9ZiEtiftq
         F1tAM/2yGQ+b7+FbLpcNhTwDRyquoEGq/nXHa6W9C39tg3yXJuBA77z3eKzQa2jOKK12
         6GAP9hTTnCzR077gMCCC6LWex1GcDQxHZ80xVVzstpyWdI2RCWeusfypZbujxsvrX18i
         Kp+8pX4NHNrEozPN5OPP3tuyTrIb/hBeNsDAPb6crJEqwxhONTtp0OtWlFyRWXX6Gucd
         RY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=BR2RmhJOTJBgiIJ2i7GuBYcM1SLipDerQvNJepDZqU0=;
        b=ousjcDQtNSe/OpCu8DVh/Wkih0AMsVcvLs/V+jYyA2i7Jn7Shb1Tt7bVG9orOmIUL/
         hg8XXB60tCHWxYi+n391KjevxLRKC+61uQai4K344nWyWb4LDL+cvekAqjPs3HUDPz6b
         teLKWqIyMhhw8a8mc8vozUFJQAYgcrQ6uHbDSNXFoJKt9W+vCvWQcRAZRxYdNy9y/srh
         i5cDSMbE4g2GQf4QNXZPqmlsJlFkZ+gxW/3rBqYyQ3qtua1NJMjhRSsH0iXYNRWXp7SS
         S5IBjt+VBaCMDW0EIQ0KZNcqT9/ckiM5v4ZR6BMCGt8WuBND8gYXPLIw5qDfQor9g1aq
         sjuA==
X-Gm-Message-State: AJcUukeuhtCklos3txxCnF8b6nhSk/7u0Zmk6fUBWBoTQK/eYYXIqnBH
        9yD/3fv3wtflkWb6unjzmn2dSRYm
X-Google-Smtp-Source: ALg8bN6rF26fAXwED76Ky/dp8SbPaXma5vLYjoMAt+C29uJ477vS5yYWyJtZPRlx5hL01UDFozcJiA==
X-Received: by 2002:aed:36c1:: with SMTP id f59mr20597598qtb.250.1547921111218;
        Sat, 19 Jan 2019 10:05:11 -0800 (PST)
Received: from localhost (pool-68-160-176-113.bstnma.fios.verizon.net. [68.160.176.113])
        by smtp.gmail.com with ESMTPSA id t5sm35550589qkl.14.2019.01.19.10.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 10:05:10 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     NeilBrown <neilb@suse.com>, Ming Lei <ming.lei@redhat.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH 1/4] dm: fix clone_bio() to trigger blk_recount_segments()
Date:   Sat, 19 Jan 2019 13:05:03 -0500
Message-Id: <20190119180506.1300-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190119180506.1300-1-snitzer@redhat.com>
References: <20190119180506.1300-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DM's clone_bio() now benefits from using bio_trim() by fixing the fact
that clone_bio() wasn't clearing BIO_SEG_VALID like bio_trim() does;
which triggers blk_recount_segments() via bio_phys_segments().

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d67c95ef8d7e..fcb97b0a5743 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1320,7 +1320,7 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 
 	__bio_clone_fast(clone, bio);
 
-	if (unlikely(bio_integrity(bio) != NULL)) {
+	if (bio_integrity(bio)) {
 		int r;
 
 		if (unlikely(!dm_target_has_integrity(tio->ti->type) &&
@@ -1336,11 +1336,7 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 			return r;
 	}
 
-	bio_advance(clone, to_bytes(sector - clone->bi_iter.bi_sector));
-	clone->bi_iter.bi_size = to_bytes(len);
-
-	if (unlikely(bio_integrity(bio) != NULL))
-		bio_integrity_trim(clone);
+	bio_trim(clone, sector - clone->bi_iter.bi_sector, len);
 
 	return 0;
 }
-- 
2.15.0

