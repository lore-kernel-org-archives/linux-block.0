Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD29C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4A02190A
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126380;
	bh=D76A1ySB+8eO8FGFcUmmQ1fOyjwLiufIX3E7qdFvaWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dd3nBfB5JiTT0unp7zVNHZ68oUkosOyRxFrnH2LJLSXkcSf6c0Qsn6+ARNzbecsOZ
	 Cnf0X/YUoBiJIVnglcJ72gTl5jWZx/0hee9I3tSYUJBdxtSbxwk1oJFdjrARramUZF
	 EuaeflEaEw3v2aDlEP1fFQP/2OOROwfKQck7zGNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbfDXRTj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389033AbfDXRTi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:38 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0221621909;
        Wed, 24 Apr 2019 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126377;
        bh=D76A1ySB+8eO8FGFcUmmQ1fOyjwLiufIX3E7qdFvaWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTOLUKj4/r1WujGJA7LCoqUuFn+LS9VaiguJRga8YuLtuTthJp90aIj4cuJkCQtHe
         fPqZhaZ2PDlwymzNFHUa+oh03tuh4AHVN41LA4QtsMNZLKBGGTjrA7Y0JXqNz+udh+
         cS0qCdr83tRuNWIlhBhxIRNmoc/qKMBLZn6AJWrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 090/168] block: do not leak memory in bio_copy_user_iov()
Date:   Wed, 24 Apr 2019 19:08:54 +0200
Message-Id: <20190424170929.084490771@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

commit a3761c3c91209b58b6f33bf69dd8bb8ec0c9d925 upstream.

When bio_add_pc_page() fails in bio_copy_user_iov() we should free
the page we just allocated otherwise we are leaking it.

Cc: linux-block@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bio.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/block/bio.c
+++ b/block/bio.c
@@ -1216,8 +1216,11 @@ struct bio *bio_copy_user_iov(struct req
 			}
 		}
 
-		if (bio_add_pc_page(q, bio, page, bytes, offset) < bytes)
+		if (bio_add_pc_page(q, bio, page, bytes, offset) < bytes) {
+			if (!map_data)
+				__free_page(page);
 			break;
+		}
 
 		len -= bytes;
 		offset = 0;


