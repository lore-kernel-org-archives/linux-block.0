Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25A2C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 08:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjDSIsF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 04:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjDSIsE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 04:48:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ADE3C32;
        Wed, 19 Apr 2023 01:48:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 84E301FD8B;
        Wed, 19 Apr 2023 08:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681894082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QiWi7xEJCHdkqRRP7ZvqBGwdGpiUG8vH8kiotRokzk=;
        b=sqVWNsJVUjiYb2VzNHizjNmqeNLQlqmarcx3NSnHE26XF92d6u3XLIvXHIH0ew5yONpe6G
        YlZIgnisan2J/iH7obtvt0j6SFBsN9wphlq+BvYq9TZzFY+ZU05s+Jb+ckEasTUBI3ZQVZ
        ZEaQh26OZbecg/F5RPbOy5pFezbfrXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681894082;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QiWi7xEJCHdkqRRP7ZvqBGwdGpiUG8vH8kiotRokzk=;
        b=BTEsn7kckP73UTb6IJD67Y1DsdfIczHtODopk79FLqTb4vLl5abEG1zMBlE/PKXXq/l8qh
        Mq3D2X36dTLJWHAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 762A91390E;
        Wed, 19 Apr 2023 08:48:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XB5YHMKqP2S5dQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 08:48:02 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 1/2] nvme-rc: Cleanup fc ports in reverse order
Date:   Wed, 19 Apr 2023 10:47:56 +0200
Message-Id: <20230419084757.24846-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230419084757.24846-1-dwagner@suse.de>
References: <20230419084757.24846-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to free the resources in the opposite order as we allocate them.

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

