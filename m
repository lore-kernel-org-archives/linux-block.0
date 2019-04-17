Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D22DC282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 11:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E99920835
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 11:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/HX4jmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfDQLwN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:52:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35691 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731996AbfDQLwM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 07:52:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so3267074wmd.0;
        Wed, 17 Apr 2019 04:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wNrUcFXZtZVOpOyjGHVxelfd7oqF6M4NUvr3N76BLC4=;
        b=N/HX4jmJ6mNx9A/ZtPcvByfjkkCNexHqkNgZWEcbC3vhY9IINFczfICav80NpdO7KO
         eYoKZzGwmUs5MpzzcreVc9QaxErQFBSmjklzteyZhjh71weKPpSo9dfBIHEWbQ3wppBu
         A6ollH9X8rsIDrrYD7lA5MK43zKag7v1sZ4t6SUibHqsPRSJBmadeP575kIssnFa6tox
         i31QP2hKKg0qVGFN561OupXywjADrKnGe4X/6EOBjm3gSw7CE/tOGyRd2mF1RJK2d0r6
         nQD/mN7hsp7MKzlSvbaMf/W7cmsIN1k16K+8iBB+psdPp1PG0TXPRYWS9wINDNCdJgBT
         iPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wNrUcFXZtZVOpOyjGHVxelfd7oqF6M4NUvr3N76BLC4=;
        b=slo8g1teIqCvWxKyfMX6DsZtQ2RCojG/RiyTBNfx+m1kiK0Uf7VQg7JV+EYLTLK7qI
         3nzOqckG648y5iyTYLiVEBltzi/GBu7OegxdkX0uoNCIj3T91fPGl6NEphZ9qQBZiZL7
         q8xO6fE7RgLnogKTrIaZ4YYI2njWhK8TZjNoIbkVLEavIXT97jMdCv3d8fh9LE3WmeOV
         4YuaU/O8KePemxkePxrOSoeOU/fJx/DRA8NLyPpbApJIyHeCAenAjsUOlkFizeggDz1Z
         Q6Dq0SEwseWopr2wlW20FmAv4GX8zcykWEqyaJgOb02PudpENuZljJgtH5eSLQ54MJ7f
         Vuyw==
X-Gm-Message-State: APjAAAW1hw2ne1Btld2u9lUbQ5SvCawvyiH6vwPPHJNVZr2frO3eOw90
        jbt2gr050w3OB9yRQSf1VqYcWPtP
X-Google-Smtp-Source: APXvYqzEK0bXLo8zt4+Vm2BuGbzWGQ0BGCgPHPI0eeLvJ+scl218SPAMItrdv8c8H1K0YmZJUCMnug==
X-Received: by 2002:a1c:a7c5:: with SMTP id q188mr30657080wme.126.1555501930041;
        Wed, 17 Apr 2019 04:52:10 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:ac27:aac4:c65c:6eb])
        by smtp.gmail.com with ESMTPSA id y1sm153840247wrd.34.2019.04.17.04.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 04:52:09 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     stefanha@redhat.com, stable@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH v2] block: bio_map_user_iov should not be limited to BIO_MAX_PAGES
Date:   Wed, 17 Apr 2019 13:52:07 +0200
Message-Id: <20190417115207.30202-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Because bio_kmalloc uses inline iovecs, the limit on the number of entries
is not BIO_MAX_PAGES but rather UIO_MAXIOV, which indeed is already checked
in bio_kmalloc.  This could cause SG_IO requests to be truncated and the HBA
to report a DMA overrun.

Note that if the argument to iov_iter_npages were changed to UIO_MAXIOV,
we would still truncate SG_IO requests beyond UIO_MAXIOV pages.  Changing
it to UIO_MAXIOV + 1 instead ensures that bio_kmalloc notices that the
request is too big and blocks it.

Cc: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: b282cc766958 ("bio_map_user_iov(): get rid of the iov_for_each()", 2017-10-11)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

---
	v1->v2: now with "git commit"
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 4db1008309ed..0914ae4adae9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1299,7 +1299,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 	if (!iov_iter_count(iter))
 		return ERR_PTR(-EINVAL);
 
-	bio = bio_kmalloc(gfp_mask, iov_iter_npages(iter, BIO_MAX_PAGES));
+	bio = bio_kmalloc(gfp_mask, iov_iter_npages(iter, UIO_MAXIOV + 1));
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.21.0

