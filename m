Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89AFC433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 15:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiKAPIm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiKAPIO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:08:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918722B12
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rm/IRbGeMyvZjy9/i6jToMGsSHuJMehfKODHL4Mhra0=; b=P6YQMMwxgbRqoCVh28US5cnadX
        oHHufJqdT7y3Al9m/vYuJUdawzkTwPvAn/gG8WHHLniixMVt1Z4h7kWssAM6k+zB36hwT7AuhNUwT
        zwm36LHv44MywKhCFUb+AFtu7ZKvx8VqEZAY6kLLdfjTyw78sU5NiyOqekKiiGu5+NE347cOZggcK
        N/2h9nKb+1P1qoQ/pco19u2vJqjVHMz2mYo/+W2Qnx8Zc668GfWg+E9x1KVTx7I2vmqcirVaEBVWF
        jd8iD2zA8lbkHC2c8UsEAv+4SHBNiBevggM99q1dSkvccaoabjixDeJt7SrFZryhac+rFv3Dr0dA2
        Z43R9jSg==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opslW-005gov-Tt; Tue, 01 Nov 2022 15:01:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 09/14] nvme-apple: don't unquiesce the I/O queues in apple_nvme_reset_work
Date:   Tue,  1 Nov 2022 16:00:45 +0100
Message-Id: <20221101150050.3510-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

apple_nvme_reset_work schedules apple_nvme_remove, to be called, which
will call apple_nvme_disable and unquiesce the I/O queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/apple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 6c09703ffe922..24e224c279a41 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1154,7 +1154,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	nvme_get_ctrl(&anv->ctrl);
 	apple_nvme_disable(anv, false);
 	nvme_mark_namespaces_dead(&anv->ctrl);
-	nvme_start_queues(&anv->ctrl);
 	if (!queue_work(nvme_wq, &anv->remove_work))
 		nvme_put_ctrl(&anv->ctrl);
 }
-- 
2.30.2

