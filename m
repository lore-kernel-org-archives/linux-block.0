Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3991CC77B7F
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 08:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjECIkG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 04:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjECIjc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 04:39:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69373524F;
        Wed,  3 May 2023 01:39:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 511E02246F;
        Wed,  3 May 2023 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683103100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1K7B1ulTvYgPG7Sie5nMsi4gf4h2tfGpVQJI7Dvefpg=;
        b=XIXDrIli9pt2V82t801AL6ofsvdrmgk5MOQRGziqjipJ6gsLBnzlXuQJ2RQGnFI1whska4
        dq0VPixIH5VqZY6Q+tnmkSufhSWthnDa9HQLat9Cc+YofgDlO0kF7Y1Wbaph1unYEWa8ds
        3NqmKYxfCqyzRtBXIf+2NtOqC4GDb6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683103100;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1K7B1ulTvYgPG7Sie5nMsi4gf4h2tfGpVQJI7Dvefpg=;
        b=QUr0MSESnCfRUDUbjDlYjtBOkz69rCIadklZK/oE4PQUcF5U2GWnexHAtz54vdgZTP/1ZA
        OJLkAExOz8XEGUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43908139F8;
        Wed,  3 May 2023 08:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Uvp7EHwdUmS5dQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:38:20 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 2/2] nvme/rc: Cleanup fc resource before module unloading
Date:   Wed,  3 May 2023 10:38:16 +0200
Message-Id: <20230503083816.18792-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503083816.18792-1-dwagner@suse.de>
References: <20230503083816.18792-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cleanup all fc resources before unloading the module, so it the
operations are in reverse order how we setup them.

Also unload the nvme-fcloop after usage.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index ec0cc2d8d8cc..24803afe8879 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -260,6 +260,11 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	trap SIGINT
 
+	if [[ "${nvme_trtype}" == "fc" ]]; then
+		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
+			        "${def_remote_wwnn}" "${def_remote_wwpn}"
+		modprobe -rq nvme-fcloop
+	fi
 	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
 	if [[ "${nvme_trtype}" != "loop" ]]; then
 		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
@@ -268,10 +273,6 @@ _cleanup_nvmet() {
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		stop_soft_rdma
 	fi
-	if [[ "${nvme_trtype}" == "fc" ]]; then
-		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
-			        "${def_remote_wwnn}" "${def_remote_wwpn}"
-	fi
 }
 
 _setup_nvmet() {
-- 
2.40.0

