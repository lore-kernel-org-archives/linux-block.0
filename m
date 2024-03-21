Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E0356B81
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014464; cv=none; b=SbhZg5tKJ25llF25cMtY+xWG6WnMoI72Xi57/LrXa3gIO+BMC1wJNDkFvGE92G3P1bGyiEId78rMP/bpNvtOtEpixke8B4J1l6GVgDPOOZeVuLCzOOhlBVu8B5yLl84Q2avvPc9cX+6ms/W1iDRyV2ZspJx+vWycZ1nNlqMZlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014464; c=relaxed/simple;
	bh=Hd17UTXLiTFtGZhS+jD1GZ5+9g1LAPbBU16B3h2G6as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXZLRWGvDtZdgnMoTq2/SvDKLQmKZlvBnWgk7gJQg32fjzye1IXc6TkOCteJFAN6UYfgFCKd6IQSwY71OTTUh0ossJbtFd7ymNzIOPJuTfbVO+ZkhGWxOC0brMcaIufK4biyA06qg1etXAuMLLPDkqw27c6gr+fHBcD1jM0rbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0cmKEI7U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W2my15Io; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0cmKEI7U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W2my15Io; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0cmKEI7U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W2my15Io";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0cmKEI7U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W2my15Io"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E22D43715C;
	Thu, 21 Mar 2024 09:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZcGbnt0fhlsTjFbNnKLHG6/NSKQHZB9rpGpSAbjui4=;
	b=0cmKEI7UyZJ05DbJvjaXoEnXX6Dh8fNCaN89lXPk4A2c3yHye4AnpmIHO40Za9kQwY2ru0
	f2YntIU+4/VDu45j7dU5lGVCjrZJfw9/q1eSRYJpuy/FJt8IgVKfFQ0x1X9btmao1wMbiq
	/VT/8ciVAmQV5iI/nQMXu8vtNkcjaeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZcGbnt0fhlsTjFbNnKLHG6/NSKQHZB9rpGpSAbjui4=;
	b=W2my15IoeLaWyQCCDptKvDuFE2M060ct9FM57Pnvqax5ToYKXvudtEqmDs1u1oTCCI/sZn
	liZC0ViibvQXYKAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZcGbnt0fhlsTjFbNnKLHG6/NSKQHZB9rpGpSAbjui4=;
	b=0cmKEI7UyZJ05DbJvjaXoEnXX6Dh8fNCaN89lXPk4A2c3yHye4AnpmIHO40Za9kQwY2ru0
	f2YntIU+4/VDu45j7dU5lGVCjrZJfw9/q1eSRYJpuy/FJt8IgVKfFQ0x1X9btmao1wMbiq
	/VT/8ciVAmQV5iI/nQMXu8vtNkcjaeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZcGbnt0fhlsTjFbNnKLHG6/NSKQHZB9rpGpSAbjui4=;
	b=W2my15IoeLaWyQCCDptKvDuFE2M060ct9FM57Pnvqax5ToYKXvudtEqmDs1u1oTCCI/sZn
	liZC0ViibvQXYKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D014413976;
	Thu, 21 Mar 2024 09:47:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N7lPMTcC/GXLDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:35 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 09/18] nvme/rc: add nqn/uuid args to target setup/cleanup helper
Date: Thu, 21 Mar 2024 10:47:18 +0100
Message-ID: <20240321094727.6503-10-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321094727.6503-1-dwagner@suse.de>
References: <20240321094727.6503-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.72
X-Spamd-Result: default: False [3.72 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-0.98)[-0.977];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[47.47%]
X-Spam-Flag: NO

Make these helper a bit more flexible, so that the caller
can setup not just the default subsysnqn.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1cd4833bae7d..bcc936549689 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -817,6 +817,8 @@ _nvmet_target_setup() {
 	local blkdev
 	local ctrlkey=""
 	local hostkey=""
+	local subsysnqn="${def_subsysnqn}"
+	local subsys_uuid="${def_subsys_uuid}"
 	local port
 
 	while [[ $# -gt 0 ]]; do
@@ -833,6 +835,14 @@ _nvmet_target_setup() {
 				hostkey="$2"
 				shift 2
 				;;
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			--subsys-uuid)
+				subsys_uuid="$2"
+				shift 2
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -847,11 +857,11 @@ _nvmet_target_setup() {
 		blkdev="$(_nvme_def_file_path)"
 	fi
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${blkdev}" \
-				"${def_subsys_uuid}"
+	_create_nvmet_subsystem "${subsysnqn}" "${blkdev}" \
+				"${subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" \
+	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
+	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}" \
 			"${hostkey}" "${ctrlkey}"
 }
 
@@ -859,14 +869,28 @@ _nvmet_target_cleanup() {
 	local ports
 	local port
 	local blkdev
+	local subsysnqn="${def_subsysnqn}"
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
 
 	_get_nvmet_ports "${def_subsysnqn}" ports
 
 	for port in "${ports[@]}"; do
-		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
 		_remove_nvmet_port "${port}"
 	done
-	_remove_nvmet_subsystem "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${subsysnqn}"
 	_remove_nvmet_host "${def_hostnqn}"
 
 	_cleanup_blkdev
-- 
2.44.0

