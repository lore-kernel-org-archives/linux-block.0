Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BB5C10F12
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 19:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCA520880
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356200;
	bh=WVeBqYPgdfpR+mnim3L5Wgt9NBJzLhKP1/afZf0EBUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pGKOBaaw7xF0NqAaQfOvztlqB9cvmVs0ZkZ4+jjMPGT03H+Vz4TV4lbV38JcEJUVA
	 1kSSrtQHoCv2FlJjHZfXnIUPsXBfwTDG8nlq+K2/UAxecUDbx4/R3WKjQrggYLJI+V
	 cJvkeJTdWD9OoINJ53D18uIXuL5FH//itQqRKcPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfDOTHl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730252AbfDOTHl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 15:07:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2442087C;
        Mon, 15 Apr 2019 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355260;
        bh=WVeBqYPgdfpR+mnim3L5Wgt9NBJzLhKP1/afZf0EBUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8d6RlI72ZTDGU1bHCgqO8JbvRdh73yitBVKMeLNIhydszt5gPAH56rd9KpoeFtqr
         DnmRqQxElUhYGdK7AK3So85VTjZcOIcqqjjaY8g5VSY8d08BwwleuGiHxZztXI1Xd5
         g5HRS9F4jj0R2r714Y9EQNy65kxC8cWbSUD27MFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 071/101] block: do not leak memory in bio_copy_user_iov()
Date:   Mon, 15 Apr 2019 20:59:09 +0200
Message-Id: <20190415183744.225068525@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
@@ -1240,8 +1240,11 @@ struct bio *bio_copy_user_iov(struct req
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


