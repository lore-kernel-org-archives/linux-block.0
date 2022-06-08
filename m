Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1570DCCA481
	for <linux-block@archiver.kernel.org>; Wed,  8 Jun 2022 06:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiFHGoV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jun 2022 02:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiFHGe1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2022 02:34:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BB81124C1
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5N8rks/VHjkMGWyiLxmxppfeU8oBlBsPR4sAbRItpP4=; b=VIQT3Qt4kg8DxyVE1LE4M3uMoj
        pCrRSCYGtiuIWGCtQB06h69qpyo9nQwzH0GDL132NKrniGhz4ldsG9W4aNQTxtsv7acOsMCwfDXcY
        sLdElfaTa3fAnW+bFe5hkY1pHnhZAzFCuo5UCpHdPjoCTXzgHkDZxun8VG996Ik7ZsrzOL94vPkYm
        Dp7dm89Wj2eq5PzoEWbMrQyYFRttRgSzgEX1mMU+LD8TrG8OjIHXQOjgP/pn3tanW8he020BiZOjy
        OJl4UVn44DUnon2ZwqTUDHJOURi61o8yTP2BFdmZve6UqJxVEixKXrNHGhSp84uCdaUk/YFHIP1qe
        zdBT5IxQ==;
Received: from [2001:4bb8:190:726c:66c4:f635:4b37:bdda] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nypGm-00BJUG-8D; Wed, 08 Jun 2022 06:34:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 3/4] dm: unexport dm_get_reserved_rq_based_ios
Date:   Wed,  8 Jun 2022 08:34:08 +0200
Message-Id: <20220608063409.1280968-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608063409.1280968-1-hch@lst.de>
References: <20220608063409.1280968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dm_get_reserved_rq_based_ios is only used in the core dm code, so
remove the export.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-rq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index a83b98a8d2a99..4f49bbcce4f1a 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -43,7 +43,6 @@ unsigned dm_get_reserved_rq_based_ios(void)
 	return __dm_get_module_param(&reserved_rq_based_ios,
 				     RESERVED_REQUEST_BASED_IOS, DM_RESERVED_MAX_IOS);
 }
-EXPORT_SYMBOL_GPL(dm_get_reserved_rq_based_ios);
 
 static unsigned dm_get_blk_mq_nr_hw_queues(void)
 {
-- 
2.30.2

