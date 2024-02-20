Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E515C5EC
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416819; cv=none; b=ruqVU16Cekq92ppFxL9l79iltKuf1rzP1iIJFijAGvcajLsNZLBt227hJG6ZnQz9FRRkAwINbvoMIwFW+w1YTVGNkTtu9fPkqDqvWVIMM+eDU5sBOG2k5S8wOYrbPvqpJY8GQk21xA8vGD4GcpEKu8dABjgFwQ0GW1h7Svjn2PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416819; c=relaxed/simple;
	bh=FOo1/TMsWjyzA33527jKuvBJwDWX2/CF/GtoxILGmIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jc2iBquRaXlV8RTJ1flcSN92IZc9Nr1nMVFyjOQ+sxolCne0D1zF3h3vcGULqUtf3QJpzljCWtTwwT9Irr3f2k6fIftUSqGqHuUESlLlbB0Kt1OQuNHpoE2eyjj5rWeiBh7JcmdXUzrak1ru6xQep0bKdTB1N7uUKrUJKENPebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0DXvI9nV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T9f60PER; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0DXvI9nV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T9f60PER; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0DXvI9nV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T9f60PER";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0DXvI9nV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T9f60PER"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EAFE21FB3;
	Tue, 20 Feb 2024 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708416815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8ArKXd5Da3QQgvrP2qUS7pkWAAPgb5vYtzOfZCo64Bc=;
	b=0DXvI9nVC3SpmF2wQunUI86aHGQgWALGhfLFW8A//001DSVlpv1wCcqQJU/9EXb0eMytco
	rylA+Zlh9CzXPTOHVF0rp2z1zAI3xSZ1W4qR5WtEEA6jX4FiswUpR7F80v+kfpQ8kUQuAA
	r4YcqIYbk1T3Yb0YF4LYK8aW9ABMblc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708416815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8ArKXd5Da3QQgvrP2qUS7pkWAAPgb5vYtzOfZCo64Bc=;
	b=T9f60PERMhdLlCfByaT70aJ4eEHEzgDKdcw35SL5WGdRdKoiG/AscvpnYP4Moc8VgtgXq3
	FHhnPSlfE3Jx8rDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708416815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8ArKXd5Da3QQgvrP2qUS7pkWAAPgb5vYtzOfZCo64Bc=;
	b=0DXvI9nVC3SpmF2wQunUI86aHGQgWALGhfLFW8A//001DSVlpv1wCcqQJU/9EXb0eMytco
	rylA+Zlh9CzXPTOHVF0rp2z1zAI3xSZ1W4qR5WtEEA6jX4FiswUpR7F80v+kfpQ8kUQuAA
	r4YcqIYbk1T3Yb0YF4LYK8aW9ABMblc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708416815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8ArKXd5Da3QQgvrP2qUS7pkWAAPgb5vYtzOfZCo64Bc=;
	b=T9f60PERMhdLlCfByaT70aJ4eEHEzgDKdcw35SL5WGdRdKoiG/AscvpnYP4Moc8VgtgXq3
	FHhnPSlfE3Jx8rDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C38B1358A;
	Tue, 20 Feb 2024 08:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mJfJIC9f1GV6VgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 20 Feb 2024 08:13:35 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH blktests v0] nvme/029: reserve hugepages for lager allocations
Date: Tue, 20 Feb 2024 09:13:27 +0100
Message-ID: <20240220081327.2678-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0DXvI9nV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T9f60PER
X-Spamd-Result: default: False [4.69 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: 9EAFE21FB3
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

The test is issuing larger IO workload. This depends on being able to
allocate larger chucks of linear memory. nvme-cli used to use libhugetbl
to automatically allocate the HugeTBL pool. Though nvme-cli dropped the
dependency on the library, thus the test needs to provision the system
accordingly.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/029 | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/nvme/029 b/tests/nvme/029
index db6e8b91f707..7833fd29e235 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -54,6 +54,7 @@ test() {
 	_setup_nvmet
 
 	local nvmedev
+	local reset_nr_hugepages=false
 
 	_nvmet_target_setup
 
@@ -62,6 +63,11 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
+	if [[ "$(cat /proc/sys/vm/nr_hugepages)" -eq 0 ]]; then
+		echo 20 > /proc/sys/vm/nr_hugepages
+		reset_nr_hugepages=true
+	fi
+
 	local dev="/dev/${nvmedev}n1"
 	test_user_io "$dev" 1 512 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 1 511 > "$FULL" 2>&1 || echo FAIL
@@ -70,6 +76,10 @@ test() {
 	test_user_io "$dev" 511 1023 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 511 1025 > "$FULL" 2>&1 || echo FAIL
 
+	if [[ ${reset_nr_hugepages} = true ]]; then
+		echo 0 > /proc/sys/vm/nr_hugepages
+	fi
+
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
-- 
2.43.1

