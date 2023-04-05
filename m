Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F58BC76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 15:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjDEPrn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbjDEPrm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 11:47:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C846E91
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 08:47:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4DCE422893;
        Wed,  5 Apr 2023 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680709596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIeIMkrYSH4FNMiLKJvp4Em6z97tlF+da5PMaEbCD6I=;
        b=WO9e2CmB7uyv65n64fs8d0x8PNZBMeIVuOSWWQEfSMSE3XrQd+0JXlyMqulrWgRRIbGayG
        Ffhgla7GD7A1f4k5BNI/MRa9bu3nzE8fWn3zUKo0SEWFtD3jhiETpb5un59mrHe4roCU/t
        rlaDqlr9mFNMUlp7pMyJ+4eR74ZMaBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680709596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIeIMkrYSH4FNMiLKJvp4Em6z97tlF+da5PMaEbCD6I=;
        b=DfSSw8RIzVphuRxt8gkv6wHPmecMZGu5vOKl2lXtd0aH69V5Zw8R5xg9JyDQ5M85AX3IRs
        mUBheuWAvEQ6/uAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F0E513A10;
        Wed,  5 Apr 2023 15:46:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ISpkD9yXLWTcNgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 05 Apr 2023 15:46:36 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v5 2/4] nvme/rc: Add nvmet attribute feature detection function
Date:   Wed,  5 Apr 2023 17:46:28 +0200
Message-Id: <20230405154630.16298-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405154630.16298-1-dwagner@suse.de>
References: <20230405154630.16298-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In order to detect if the target supports a attribute, we have to setup
a target and check if the attribute file appears.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index ec7678dbe09e..e720a35113aa 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -627,6 +627,31 @@ _set_nvmet_attr_qid_max() {
 	fi
 }
 
+_detect_nvmet_subsys_attr() {
+	local attr="$1"
+	local file_path="${TMPDIR}/img"
+	local subsys_name="blktests-feature-detect"
+	local cfs_path="${NVMET_CFS}/subsystems/${subsys_name}"
+	local port
+
+	truncate -s 1M "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+		"b92842df-a394-44b1-84a4-92ae7d112332"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+
+	local val=1
+	[[ -f "${cfs_path}/${attr}" ]] && val=0
+
+	_remove_nvmet_subsystem "${subsys_name}"
+
+	_remove_nvmet_port "${port}"
+
+	rm "${file_path}"
+
+	return "${val}"
+}
+
 _find_nvme_dev() {
 	local subsys=$1
 	local subsysnqn
-- 
2.40.0

