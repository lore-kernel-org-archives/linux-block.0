Return-Path: <SRS0=t9QE=7D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFDCC433E1
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 02:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0202075F
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 02:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590028112;
	bh=j/Om0BT7uCN//ljCy9QOiKpXlEEQpdCYJ69i2h4VBpg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=01veVeN/zew3tW688LMSXqiW2gGmzPu0mABQMuQPlPsQNt3dyRZpSFNpus5ahekxK
	 +pjk27iMYYKyjYaw3v6LFbOhSRYikXd7KjXBnYH8xXd9wh6/+xwPV3G6zn18oTP7fs
	 V4j/zY/rpEueIW/SN6W4F/vRYznP195ukQQpI1xU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgEUC2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 22:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgEUC2b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 22:28:31 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBD820748;
        Thu, 21 May 2020 02:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590028110;
        bh=j/Om0BT7uCN//ljCy9QOiKpXlEEQpdCYJ69i2h4VBpg=;
        h=From:To:Cc:Subject:Date:From;
        b=OniVzvBfiUdT7nNNv8Ww5AMKYMyqYQr7peEAa2yETGT5BWH/6MV+cDY0lo5ZMptZb
         VCP7EheUqlomagf6OIYzZN5+RZLwbSVzzzBRtu4bgpxLEC3TVwvsqTLeHFD7dNCL+s
         wAfcNFyWcVUUsc/oqwzE9c1W1u6kqJJHdLeJz+98=
From:   Keith Busch <kbusch@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] iov_iter: fix gap alignment check
Date:   Wed, 20 May 2020 19:28:26 -0700
Message-Id: <20200521022826.3268432-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer uses the queue's virt_boundary to enforce alignment between
vectors, but iov_iter_gap_alignment() returned the starting address or'ed
with all but the last the length. Fix it to return alignment for each
vector's starting address except the first, and each vector's ending
address except the last.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 lib/iov_iter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 51595bf3af85..9cfaf2fd5cfd 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1252,12 +1252,12 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	}
 
 	iterate_all_kinds(i, size, v,
-		(res |= (!res ? 0 : (unsigned long)v.iov_base) |
-			(size != v.iov_len ? size : 0), 0),
-		(res |= (!res ? 0 : (unsigned long)v.bv_offset) |
-			(size != v.bv_len ? size : 0)),
-		(res |= (!res ? 0 : (unsigned long)v.iov_base) |
-			(size != v.iov_len ? size : 0))
+		(res |= (size == i->count ? 0 : (unsigned long)v.iov_base) |
+			(size == v.iov_len ? 0 : (unsigned long)v.iov_base + v.iov_len), 0),
+		res |= (size == i->count ? 0 : v.bv_offset) |
+		       (size == v.bv_len ? 0 : v.bv_offset + v.bv_len),
+		res |= (size == i->count ? 0 : (unsigned long)v.iov_base) |
+		       (size == v.iov_len ? 0 : (unsigned long)v.iov_base + v.iov_len)
 		);
 	return res;
 }
-- 
2.24.1

