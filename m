Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA42C6BD
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754752; cv=none; b=aIy+wyyaKOAmC8NUc6qlAoYpP/uPyMM0JzwvY79jOPLm7WaCsToWnD4PAUpixOohLKK8b0YIL0LgmCintDUS/0fCqcgtE9fw9QYfc4sVPWknferfs8CkYEU+Axr8KyPOensezVfIjmUHzhwl6cqkr1O3hPORGp5GKbijjT5aaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754752; c=relaxed/simple;
	bh=OKzMb5ozxqRR6CUtmkUsBmnnROUUQv42L0MiInZGNaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKgeMg2x8hkPuwbJyZKGXXDKQLBBz+JhrawmzNRmXYfREUW2iLtORV5oxSuVrylS5kvsoa1uVKWgrDSsNc3m9H0ep5dYsHsNpAz530TXq4tnUvQ7fE6isCPy05A3YWd/8Hl7kbfZU3/fXtkMgh3k8wnGnfBuwiJIZ6oyzLTbNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gVPRvdEr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mTvV69dE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gVPRvdEr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mTvV69dE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gVPRvdEr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mTvV69dE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gVPRvdEr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mTvV69dE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 611CA5C33F;
	Mon, 18 Mar 2024 09:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNdgZ0KOXj5YcXW3/Y+UBg6zuD6sXcymWHlu4OqOa/U=;
	b=gVPRvdErrFPa76fM1f+4opOHgU2BI42ArX0rUaZdzan8DH2GDIKUAy7+HRKK8dQQU0jWCI
	9KuAP/ukhFUni2ooiT/nUXWoUu0k5/3qwWCC3KbF8sctgSSUjWThkYI3zZ78KozD0AhNMu
	0G1f5wbK38SgrMu0/mgKQnoaeStl/UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNdgZ0KOXj5YcXW3/Y+UBg6zuD6sXcymWHlu4OqOa/U=;
	b=mTvV69dE9kCu/3Hff5hIkOLRY9aQd0Q30le7aB081wCmP+mmHYw09dXOVkGwqOgifjDtA5
	H7CUqHOWSCHUOSAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNdgZ0KOXj5YcXW3/Y+UBg6zuD6sXcymWHlu4OqOa/U=;
	b=gVPRvdErrFPa76fM1f+4opOHgU2BI42ArX0rUaZdzan8DH2GDIKUAy7+HRKK8dQQU0jWCI
	9KuAP/ukhFUni2ooiT/nUXWoUu0k5/3qwWCC3KbF8sctgSSUjWThkYI3zZ78KozD0AhNMu
	0G1f5wbK38SgrMu0/mgKQnoaeStl/UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNdgZ0KOXj5YcXW3/Y+UBg6zuD6sXcymWHlu4OqOa/U=;
	b=mTvV69dE9kCu/3Hff5hIkOLRY9aQd0Q30le7aB081wCmP+mmHYw09dXOVkGwqOgifjDtA5
	H7CUqHOWSCHUOSAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F8141349D;
	Mon, 18 Mar 2024 09:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pc4xEr0L+GXAUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 07/10] nvme/rc: add nqn/uuid args to target setup/cleanup helper
Date: Mon, 18 Mar 2024 10:38:53 +0100
Message-ID: <20240318093856.22307-9-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318093856.22307-1-dwagner@suse.de>
References: <20240318093856.22307-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 6.88
X-Spamd-Result: default: False [6.88 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.49)[0.830];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[47.48%]
X-Spam-Level: ******
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

Make these helper a bit more flexible, so that the caller
can setup not just the default subsysnqn.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index af48593e2cb7..2e9a0860c0e7 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -823,6 +823,8 @@ _nvmet_target_setup() {
 	local blkdev
 	local ctrlkey=""
 	local hostkey=""
+	local subsysnqn="${def_subsysnqn}"
+	local subsys_uuid="${def_subsys_uuid}"
 	local port
 
 	while [[ $# -gt 0 ]]; do
@@ -839,6 +841,14 @@ _nvmet_target_setup() {
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
@@ -853,11 +863,11 @@ _nvmet_target_setup() {
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
 
@@ -865,14 +875,28 @@ _nvmet_target_cleanup() {
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

