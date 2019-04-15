Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239E2C282DA
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEE52075B
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355793;
	bh=dSUqKLsUGPrQYI0Al1HAvRpDZ3Lm2KrHaDo5WhTSiIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sphiaw0mo4t/uS/5wBiYcVskIe8NnyVbTasjlcHfOWrO+aBSgTl9Gjal4bgI72H6i
	 g9eFCs+wUtyRsjg2ZUFsEcVxkeFr2A/gmGdQNQH02zAvqkcAL6uvUL/vfM0KEKUuhr
	 vrQpvPa9c5JqVWTWn56kkVkVINA3TNUSwdJJcvIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfDOTNM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731512AbfDOTNM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F6A7218FE;
        Mon, 15 Apr 2019 19:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355591;
        bh=dSUqKLsUGPrQYI0Al1HAvRpDZ3Lm2KrHaDo5WhTSiIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnXVxZGa8vQbRvMyLxrzh/o9f69buTPJ4r1cKTpCsfZi8SEYee73BIUxekFliVxyQ
         TaYvHwlAmelM0thJWHRliUNs2JPWJkMYuiZiqkOyz6nT2SZ3wvIuYj9X6aPWolXi9b
         Smig1mdZJlyaGXJAtg6GbQ/w/oZLg/zXcV0dg/No=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.0 079/117] block: do not leak memory in bio_copy_user_iov()
Date:   Mon, 15 Apr 2019 21:00:49 +0200
Message-Id: <20190415183748.977883156@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
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
@@ -1238,8 +1238,11 @@ struct bio *bio_copy_user_iov(struct req
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


