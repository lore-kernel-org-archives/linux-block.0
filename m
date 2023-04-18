Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECB0C77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 13:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjDRNC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjDRNCX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 09:02:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A79AC140;
        Tue, 18 Apr 2023 06:02:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 583772198D;
        Tue, 18 Apr 2023 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681822932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZY9sxvj6D4iXpgx1qxODzCgmh0MIsy7/YXUSzF3Zq2Y=;
        b=m4dN3zHb/zbBb6KD/8nwFZcUptHzIHM08HbBQITK+/s96hkdRAB8nTZxX1aOgwx4lUeGur
        rOXTUaHfqzGXqbxfpy+R/0muoO2/CuvHblkltgBf+iAAcjqEyduK2UybDRbja++lnzOwYQ
        N7hUtYxA2i4yoA2+3ZikUumbAF+BwOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681822932;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZY9sxvj6D4iXpgx1qxODzCgmh0MIsy7/YXUSzF3Zq2Y=;
        b=Eu5bdJz+i0cTxM/ZzsknJ8+gQU297t32ycgeZ12JWAIvPnhulke5ZodY5vqscwKpKsB0NJ
        bnlqu005LfMEBUAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49D58139CC;
        Tue, 18 Apr 2023 13:02:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CtbPEdSUPmSVJwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 13:02:12 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 4/4] nvmet-fc: Release reference on target port
Date:   Tue, 18 Apr 2023 15:01:59 +0200
Message-Id: <20230418130159.11075-5-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418130159.11075-1-dwagner@suse.de>
References: <20230418130159.11075-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case we return early out of __nvmet_fc_finish_ls_req() we still have
to release the reference on the target port.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1ab6601fdd5c..df7d84aff843 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -359,6 +359,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
+		nvmet_fc_tgtport_put(tgtport);
 		return;
 	}
 
-- 
2.40.0

