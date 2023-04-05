Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E93EC76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 15:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbjDEPrN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbjDEPrM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 11:47:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D695FC0
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 08:46:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A47EA1FD64;
        Wed,  5 Apr 2023 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680709595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQWWvyVOMNwg10qqrGRlHZ3xI6T1/nnXbHNP0F4OczA=;
        b=he8paOLy12grTI42eoR4LxgQ4eciguZHWMo+4M+xpoV2HRqjd1rz80539nibOfw09JsjmS
        JhV7QLcYqU23WW9l751NrmfqhgJLguIi99Q5NCdYfxSYyxaUXuhbQf8bfl6dy/S7i6DGd0
        tPzn0/Ktyq/CKyFNlWso5s/7wAe6SNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680709595;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQWWvyVOMNwg10qqrGRlHZ3xI6T1/nnXbHNP0F4OczA=;
        b=dypq+NkheZxu3UIuQaAWUJoE1BcJzHM0SFkJO3Y5nKLUIMoS2Txw5N0hjtMSNbZgXnHlHT
        /fUdeAluOJwn++Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9510913A10;
        Wed,  5 Apr 2023 15:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5E9jJNuXLWTaNgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 05 Apr 2023 15:46:35 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v5 1/4] nvme/rc: Add setter for attr_qid_max
Date:   Wed,  5 Apr 2023 17:46:27 +0200
Message-Id: <20230405154630.16298-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405154630.16298-1-dwagner@suse.de>
References: <20230405154630.16298-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index a3c9b42d91e6..ec7678dbe09e 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -617,6 +617,16 @@ _set_nvmet_dhgroup() {
 	     "${cfs_path}/dhchap_dhgroup"
 }
 
+_set_nvmet_attr_qid_max() {
+	local nvmet_subsystem="$1"
+	local qid_max="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	if [[ -f "${cfs_path}/attr_qid_max" ]]; then
+		echo $qid_max > "${cfs_path}/attr_qid_max"
+	fi
+}
+
 _find_nvme_dev() {
 	local subsys=$1
 	local subsysnqn
-- 
2.40.0

