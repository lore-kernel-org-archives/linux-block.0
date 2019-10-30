Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC79CA9EC6
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 16:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9392621906
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572451220;
	bh=3hErLc/j4wh/06DciMIpf4VuVIV1x9qJcn9Z8UiL7z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KrlT5fK0axByWZmfu8P7oVAAMSnJWWaCOluq+1pZOuDrwLgQHUylSvcEsgEKEbCE9
	 5DjaZVGizx85HVqyTzD29WA04O6zTZNUF22F5D8rupvkZsP7psGIIzXq30/91ukYq7
	 qKBNO7thSvPQnDkpl5RxsD+Aj2V3czXXNt0g6W9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfJ3Pzt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfJ3Pzs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 11:55:48 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 402DB20656;
        Wed, 30 Oct 2019 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450947;
        bh=3hErLc/j4wh/06DciMIpf4VuVIV1x9qJcn9Z8UiL7z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPvdp35SIe5MPj39VtNtMsRa3d3ndC268eecl7f+Oo3T8pTV9WEBfXnQMTdVsXAJT
         AWFKftQbE2SmH5WUO9zoEo0e8BBOPruLAHkdCUEMmmu30XxPnyu72pnDY9fapg7H51
         aceZ4z/MIB2Iyxj67urccqx+n/zQybz4jBWV9kS8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Mike Christie <mchristi@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 4.19 36/38] nbd: protect cmd->status with cmd->lock
Date:   Wed, 30 Oct 2019 11:54:04 -0400
Message-Id: <20191030155406.10109-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155406.10109-1-sashal@kernel.org>
References: <20191030155406.10109-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit de6346ecbc8f5591ebd6c44ac164e8b8671d71d7 ]

We already do this for the most part, except in timeout and clear_req.
For the timeout case we take the lock after we grab a ref on the config,
but that isn't really necessary because we're safe to touch the cmd at
this point, so just move the order around.

For the clear_req cause this is initiated by the user, so again is safe.

Reviewed-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index bc2fa4e85f0ca..46cd52d1d6537 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -349,17 +349,16 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	struct nbd_device *nbd = cmd->nbd;
 	struct nbd_config *config;
 
+	if (!mutex_trylock(&cmd->lock))
+		return BLK_EH_RESET_TIMER;
+
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		cmd->status = BLK_STS_TIMEOUT;
+		mutex_unlock(&cmd->lock);
 		goto done;
 	}
 	config = nbd->config;
 
-	if (!mutex_trylock(&cmd->lock)) {
-		nbd_config_put(nbd);
-		return BLK_EH_RESET_TIMER;
-	}
-
 	if (config->num_connections > 1) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out, retrying (%d/%d alive)\n",
@@ -745,7 +744,10 @@ static void nbd_clear_req(struct request *req, void *data, bool reserved)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 
+	mutex_lock(&cmd->lock);
 	cmd->status = BLK_STS_IOERR;
+	mutex_unlock(&cmd->lock);
+
 	blk_mq_complete_request(req);
 }
 
-- 
2.20.1

