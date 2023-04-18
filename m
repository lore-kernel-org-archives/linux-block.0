Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE8BC77B78
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 12:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjDRMdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjDRMda (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 08:33:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDDE10243;
        Tue, 18 Apr 2023 05:33:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 899EE1FD65;
        Tue, 18 Apr 2023 12:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681821186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TKANE2bTfIsb9mX4f2a9ewBTW7h0uoTrVWYzSg0VVIE=;
        b=AaCaJCo36MWVmb5P4KbEspPvTBse5UObHptMB3rNppGTDR0aDEcmAWuOCrjkJkXkBW9uRM
        mWCf/u7WUzNTz/u1Fi7wV0jQvNYOfyzftIgfhsWsGA1IxTwmYH6grMyZs8r4AMk8QEqE2Z
        vxphRCzZvUAtEOz5MLpap436Uc6z6fM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681821186;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TKANE2bTfIsb9mX4f2a9ewBTW7h0uoTrVWYzSg0VVIE=;
        b=8SNKKT7SExK2ZZZ1METk30iTpWGh8sQdgOh6sVDpIZRILkMI3vNPgm0YPeP/zUGJQ5GixI
        NdvmvxpiC/YZzJBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77ECA139CC;
        Tue, 18 Apr 2023 12:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PTU9HQKOPmROFgAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 12:33:06 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests] nvme-rc: Cleanup fcloop resources in reverse order
Date:   Tue, 18 Apr 2023 14:32:52 +0200
Message-Id: <20230418123252.3725-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to free the resources in the opposite order as we allocate them.
The deleting the rport first will also free the other resources. When
we try to release lport and tport they are already gone.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index b44239446dcf..ec0cc2d8d8cc 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -204,10 +204,10 @@ _cleanup_fcloop() {
 	local remote_wwnn="${3:-$def_remote_wwnn}"
 	local remote_wwpn="${4:-$def_remote_wwpn}"
 
-	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
-			       "${remote_wwnn}" "${remote_wwpn}"
 	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
 	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
+	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
+			       "${remote_wwnn}" "${remote_wwpn}"
 }
 
 _cleanup_nvmet() {
-- 
2.40.0

