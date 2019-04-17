Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351E7C282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 11:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA49C20872
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 11:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhnWIa34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfDQLuN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:50:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33711 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfDQLuN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 07:50:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so31586701wrp.0;
        Wed, 17 Apr 2019 04:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mPc+rLGtFeShrb0NQ1VnJOvf7hMU5u7hz3TLKvs7VSA=;
        b=JhnWIa34ZX+ewwDaPDuBxOLxF/KlF12lkxwqMaYTTdKXSjkIWeJxkJXTgKemuQNuTw
         t4QyB0iRsIkbu+Jzkch48mJd1UEG4jOK0bXKppoBAE25hzyziTJQZK0glllS1WBeD8MA
         mPyomeojLypP1+TcoKWLNJ9rESBhC2Vfne3zJBhOHme6+Iq7ouxbnlNPzblWkQoVZE28
         n6qe6Qfr1eME48D7bTxLVRYl6fYh4PlhAZK5BuPcTWifed0G9888YH3CSsyzNTdtVLRv
         p4ZTSoMzIDVAef4jXE83YychJjE769ZxaQQtQvJooXY7qD316uGlzyWGMCieLfUe33aM
         MSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mPc+rLGtFeShrb0NQ1VnJOvf7hMU5u7hz3TLKvs7VSA=;
        b=QGyN6vyTUOqUVfHoZ4nrnzlO+59KSMFgQ+v3wX5FeYalAvbUe7ZrSDU764jfVwO5Xp
         2eASqLdxojYBWImj3QPqPESpA9COw9D28rSHyEjUw8khPfRGW9tigL/3nHYuoOGak4Js
         bikN9XCtgmPJtASvyBvQG9AveOhYHISuaWgJ6iEu8qJ8h9zA3RMR36UzYWiqOENxnYyG
         +8BEMFN0t5up58wBMVGoHkuyoLPg9ooIdCcpYEF26iBEoAMjkUZ+5PiIDt/A4luEq8F7
         FKDZIQKkW8abjC6/qGFYaCt/csv/AEafDLZbQokCuOuVlNut4Dc6QcTH71DKsO3QaZ1D
         np0w==
X-Gm-Message-State: APjAAAUpP5VavPBMDtxwFsZ5J9+8eT9IKrPXUCN+MwJOGXRcAwyOMTXs
        ZuuGnkAoNRNzg9QBJmLxes8djtPL
X-Google-Smtp-Source: APXvYqzdLg1sDcxaHwiixmBll9VvGdN4B20V6G3PjTbzpUQdDL3qQszSiElv0SZfkmkNQcPvartT+A==
X-Received: by 2002:adf:ed86:: with SMTP id c6mr56341931wro.146.1555501810758;
        Wed, 17 Apr 2019 04:50:10 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:ac27:aac4:c65c:6eb])
        by smtp.gmail.com with ESMTPSA id z14sm78431101wrv.78.2019.04.17.04.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 04:50:10 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     stefanha@redhat.com, stable@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH] block: bio_map_user_iov should not be limited to BIO_MAX_PAGES
Date:   Wed, 17 Apr 2019 13:50:08 +0200
Message-Id: <20190417115008.27516-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Because bio_kmalloc uses inline iovecs, the limit on the number of entries
is not BIO_MAX_PAGES but rather UIO_MAX_IOV, which indeed is already checked
in bio_kmalloc.  This could cause SG_IO requests to be truncated and the HBA
to report a DMA overrun.

Note that if the argument to iov_iter_npages were changed to UIO_MAX_IOV,
we would still truncate SG_IO requests beyond UIO_MAX_IOV pages.  Changing
it to UIO_MAX_IOV + 1 instead ensures that bio_kmalloc notices that the
request is too big and blocks it.

Cc: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: b282cc766958 ("bio_map_user_iov(): get rid of the iov_for_each()", 2017-10-11)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 4db1008309ed..cc1195f5af7a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1299,7 +1299,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 	if (!iov_iter_count(iter))
 		return ERR_PTR(-EINVAL);
 
-	bio = bio_kmalloc(gfp_mask, iov_iter_npages(iter, BIO_MAX_PAGES));
+	bio = bio_kmalloc(gfp_mask, iov_iter_npages(iter, UIO_MAX_IOV + 1));
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.21.0

