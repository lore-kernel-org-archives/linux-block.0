Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759F6A8C7
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286511; cv=none; b=aFHR/lzSEAJ1w4NGQiM8tQjsJZP/qNmHLOqWMaKFSAHEht1F9RbkD55ldtl4UyhWBDPlBBJ19sFGTsAddgqPu8fMrzumnXvjgN5SvUv5P8VeGoJdpN0mITFRoCJy0BEBrZRB6L742Zz1udn+ZfcI2IYjEudNDSBN6AGxP9KVaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286511; c=relaxed/simple;
	bh=ubVZ20yTe+dTK4e7zXMP8LvK5OxCKNtu9hPOBpC/e9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ea6BddlM9lWo6JS0U1JBzwLC2wC8bWKhKvfUdbC/GZB6/HJxtJvS3npS+JEQMLwLuGWafUd2e0/zzHopUycGT0Ovy2INp8M0VCA33NwYjdU+e2tF2CUuGbodnZNzwtszIALpCeaG1e08Jss730Rl3Pxrt1RKyfrM8q0u45HWTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y/dPDSJ0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+wjU3R7z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y/dPDSJ0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+wjU3R7z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y/dPDSJ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+wjU3R7z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y/dPDSJ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+wjU3R7z"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29A4222D88;
	Fri,  1 Mar 2024 09:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0V7CjIwX35H7mnUrzMLBYfjuQ51EtGtIz8Hd5Mehis=;
	b=y/dPDSJ0Y0O7PN7/g/7ZTsXC5hWZMPw2EskVN5Xxo/rofgwJoc7pueImvhgha2jPHQMr+C
	8s4uWEatKY3y3EpseBc1jTYpBxXO1JWa9zKzTespOW6CXb/pRoZh2pKfgkz0gqmfpZ7k+x
	LAlJiBKW2ZalAq0BtxaT1Ix9qeBNa08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0V7CjIwX35H7mnUrzMLBYfjuQ51EtGtIz8Hd5Mehis=;
	b=+wjU3R7z3LmtROz/5gZvcEUgnMfLCDJFCGoRE3+GeKKKP1uGAI5Bc54yDwDDk+D7g+QYyZ
	W1TtKyFKUc1nt8AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0V7CjIwX35H7mnUrzMLBYfjuQ51EtGtIz8Hd5Mehis=;
	b=y/dPDSJ0Y0O7PN7/g/7ZTsXC5hWZMPw2EskVN5Xxo/rofgwJoc7pueImvhgha2jPHQMr+C
	8s4uWEatKY3y3EpseBc1jTYpBxXO1JWa9zKzTespOW6CXb/pRoZh2pKfgkz0gqmfpZ7k+x
	LAlJiBKW2ZalAq0BtxaT1Ix9qeBNa08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0V7CjIwX35H7mnUrzMLBYfjuQ51EtGtIz8Hd5Mehis=;
	b=+wjU3R7z3LmtROz/5gZvcEUgnMfLCDJFCGoRE3+GeKKKP1uGAI5Bc54yDwDDk+D7g+QYyZ
	W1TtKyFKUc1nt8AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1788913581;
	Fri,  1 Mar 2024 09:48:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BApMBGmk4WXnGQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 01 Mar 2024 09:48:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests 1/2] nvme/048: remove unused argument for set_qid_max
Date: Fri,  1 Mar 2024 10:48:16 +0100
Message-ID: <20240301094817.29491-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301094817.29491-1-dwagner@suse.de>
References: <20240301094817.29491-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="y/dPDSJ0";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+wjU3R7z
X-Spamd-Result: default: False [2.32 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.37)[97.09%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.32
X-Rspamd-Queue-Id: 29A4222D88
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

The port is argument is unsed, thus remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/048 | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/048 b/tests/nvme/048
index 1e5a7a1bcb99..8c314fae9620 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -69,9 +69,8 @@ set_nvmet_attr_qid_max() {
 }
 
 set_qid_max() {
-	local port="$1"
-	local subsys_name="$2"
-	local qid_max="$3"
+	local subsys_name="$1"
+	local qid_max="$2"
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
 	nvmf_wait_for_state "${subsys_name}" "live" || return 1
@@ -100,8 +99,8 @@ test() {
 		if ! nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
 			echo FAIL
 		else
-			set_qid_max "${port}" "${def_subsysnqn}" 1 || echo FAIL
-			set_qid_max "${port}" "${def_subsysnqn}" 2 || echo FAIL
+			set_qid_max "${def_subsysnqn}" 1 || echo FAIL
+			set_qid_max "${def_subsysnqn}" 2 || echo FAIL
 		fi
 
 		_nvme_disconnect_subsys "${def_subsysnqn}"
-- 
2.43.2

