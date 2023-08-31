Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A5C83F12
	for <linux-block@archiver.kernel.org>; Thu, 31 Aug 2023 12:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjHaMTT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Aug 2023 08:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbjHaMTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2023 08:19:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F91A4
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OWmDNwwePly+4BgqN7rUa/YuiOuhZXZGxvk276Wt7m0=; b=cRWPq0HlGJaP2jtkEpSNzAiByU
        ac7W2qBlS1J2EOqLSTC4at0yw35ZOiX/db/fKSdM/PuXAe3lKnYqhIsTYWyhbxZzCFQSXEbDIrjB9
        C0WrWs5ZdDeK26w9zdt2oSLeaRpqnQb8lB9xH8n0Y1TwZozsBid0A35ottZovHB6ewc2KL8PqihAM
        d9fi0iuAaK8Aqd8g3f3BgcxAqze8BlldJvMWs+0omYY9oKGFu4e6RZH8ESPHhAtaP7Vlr+GV1UNkh
        lPmIs76n97vXxN5mYFrbO6Iu5xd599+2wnDicuhFHp6oT9xtjnr+9GRKCdi8BkdiL+wbxsuJvkzjD
        g1GClWsg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qbgdn-00FGmV-04;
        Thu, 31 Aug 2023 12:19:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: remove the call to file_remove_privs in blkdev_write_iter
Date:   Thu, 31 Aug 2023 14:19:11 +0200
Message-Id: <20230831121911.280155-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

file_remove_privs instantly returns 0 when not called for regular files,
so don't bother.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index a24a624d3bf71a..acff3d5d22d461 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -671,10 +671,6 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iov_iter_truncate(from, size);
 	}
 
-	ret = file_remove_privs(file);
-	if (ret)
-		return ret;
-
 	ret = file_update_time(file);
 	if (ret)
 		return ret;
-- 
2.39.2

