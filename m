Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFF9C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 19:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D522077D
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591297446;
	bh=eulf8YWx/Madi2SxQ2AuCbVjnYllknbaJpYGNL3tLwM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MINAcb1ZECZDUWsxLgglOQkJjWv7/OIhT20n+o00X0B6pY7+LQejpxapgzQVRCGsM
	 BDaoo1PPUd6+w7xe9ffWYNqmUd4PZsajFmwMaq0oR1PDRrF6CIhdSMVYgMivymUDl/
	 1DM7y9MGHBfZNfXgPkyYFQuxpctf2wyyTipsb8Nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgFDTEF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbgFDTEE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jun 2020 15:04:04 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBF17206C3;
        Thu,  4 Jun 2020 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591297443;
        bh=eulf8YWx/Madi2SxQ2AuCbVjnYllknbaJpYGNL3tLwM=;
        h=From:To:Cc:Subject:Date:From;
        b=h/RVHQI4PXglXk0M2xhL6qwhLDoqz7/50ASkfljg46CDbi0KUi9z27WnbcxAXvdxr
         yyrwgBKw9IkjJu3OoMnnLx1SyjsGcnXTpD/LhPejIGS0WtiUxSX6/mz3UXrvEBUXEi
         Dp2lH0Ism1XCs6Kbhg+szqPDx4YVqHBDqFd8vtAY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH] dm crypt: avoid truncating the logical block size
Date:   Thu,  4 Jun 2020 12:01:26 -0700
Message-Id: <20200604190126.15735-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

queue_limits::logical_block_size got changed from unsigned short to
unsigned int, but it was forgotten to update crypt_io_hints() to use the
new type.  Fix it.

Fixes: ad6bf88a6c19 ("block: fix an integer overflow in logical block size")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/md/dm-crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 3df90daba89e..a1dcb8675484 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3274,7 +3274,7 @@ static void crypt_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	limits->max_segment_size = PAGE_SIZE;
 
 	limits->logical_block_size =
-		max_t(unsigned short, limits->logical_block_size, cc->sector_size);
+		max_t(unsigned, limits->logical_block_size, cc->sector_size);
 	limits->physical_block_size =
 		max_t(unsigned, limits->physical_block_size, cc->sector_size);
 	limits->io_min = max_t(unsigned, limits->io_min, cc->sector_size);
-- 
2.27.0.278.ge193c7cf3a9-goog

