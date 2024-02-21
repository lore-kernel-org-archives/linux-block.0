Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4841C3AC1B
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501442; cv=none; b=eZyrLL3ENe3Mqec0V7cZT1aam1Fm3ElF+N/X6GgyOKaouFfaIZTjuPuczdquzn/8/wAHc4x7PWt/F0sYMnraW7PSL1aMfZyndztm/vKugo/5TTexozwPonv3T5+AiiVZ1kFgsn6N4Q0i6RLF15M1mvKciL0tUuJXHS7nIWreWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501442; c=relaxed/simple;
	bh=+ICRVLdWxEciQT8lt5v2WfrxcXn83vUuLQhADxFOdV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ue2g0BBRWFhfRYohZRBtAX4NBYhJ2KhvQ13ugv+qkTEX3hSkfuGFB7YRR9izhascHgUT995m4u7yuscgeWqmo03gnJNX8Tkc26OJue46FsilD2CP2Z0vKxV4vddOhJOzSauPTE4IemXT1dNIvm+rVjjH8xntgyoYfpxA/fnRTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0B91yPq5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HPYBsRlt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0B91yPq5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HPYBsRlt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0B91yPq5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HPYBsRlt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0B91yPq5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HPYBsRlt"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61C9D1FB46;
	Wed, 21 Feb 2024 07:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708501438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AnTV3I+14a8T/tI2unD6gCJsXG8Br/+R1KCiFA583MA=;
	b=0B91yPq5c2ldfpXzsq19LsHReBKcH0SwIJgiWPjxonElw3WOvtr00Jmr3iBDZjSB238tin
	mLPWoqFn+KFsnAzSgNKCbmhUUpKt5NeUDOGnyovXjOD/XevuA6L8EiPcTcGSfZdefl0rbU
	PRn0Er0tjZWzzVbwFh9BQWcNGKDQ9CE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708501438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AnTV3I+14a8T/tI2unD6gCJsXG8Br/+R1KCiFA583MA=;
	b=HPYBsRltBZkbMaHl4Oiu8k5DvL/KNT+CfRPJa+PeUv3xfKwaLJmNp9ivHD/19lfjOKmrRi
	fW030eYC6pEMyrCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708501438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AnTV3I+14a8T/tI2unD6gCJsXG8Br/+R1KCiFA583MA=;
	b=0B91yPq5c2ldfpXzsq19LsHReBKcH0SwIJgiWPjxonElw3WOvtr00Jmr3iBDZjSB238tin
	mLPWoqFn+KFsnAzSgNKCbmhUUpKt5NeUDOGnyovXjOD/XevuA6L8EiPcTcGSfZdefl0rbU
	PRn0Er0tjZWzzVbwFh9BQWcNGKDQ9CE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708501438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AnTV3I+14a8T/tI2unD6gCJsXG8Br/+R1KCiFA583MA=;
	b=HPYBsRltBZkbMaHl4Oiu8k5DvL/KNT+CfRPJa+PeUv3xfKwaLJmNp9ivHD/19lfjOKmrRi
	fW030eYC6pEMyrCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B57413A25;
	Wed, 21 Feb 2024 07:43:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Fi4PEr6p1WXqcAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 07:43:58 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH blktests v1] nvme/029: reserve hugepages for lager allocations
Date: Wed, 21 Feb 2024 08:43:53 +0100
Message-ID: <20240221074353.27646-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0B91yPq5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HPYBsRlt
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 61C9D1FB46
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

The test is issuing larger IO workload. This depends on being able to
allocate larger chunks of linear memory. nvme-cli used to use libhugetlb
to automatically allocate the HugeTLB pool. Though nvme-cli dropped the
dependency on the library, thus the test should try to provision the
system accordingly.

Link: https://github.com/linux-nvme/nvme-cli/issues/2218
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/029 | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/nvme/029 b/tests/nvme/029
index db6e8b91f707..a4f0cb1402b1 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -54,6 +54,7 @@ test() {
 	_setup_nvmet
 
 	local nvmedev
+	local reset_nr_hugepages=false
 
 	_nvmet_target_setup
 
@@ -62,6 +63,15 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
+	# nvme-cli may fail to allocate linear memory for rather large IO buffers.
+	# Increase nr_hugepages to allow nvme-cli to try the linear memory allocation
+	# from HugeTLB pool.
+	if [[  -r /proc/sys/vm/nr_hugepages &&
+		       "$(cat /proc/sys/vm/nr_hugepages)" -eq 0 ]]; then
+		echo 20 > /proc/sys/vm/nr_hugepages
+		reset_nr_hugepages=true
+	fi
+
 	local dev="/dev/${nvmedev}n1"
 	test_user_io "$dev" 1 512 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 1 511 > "$FULL" 2>&1 || echo FAIL
@@ -70,6 +80,10 @@ test() {
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

