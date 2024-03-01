Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D96A8C8
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286512; cv=none; b=AYUwDZqx5AyBwNbLl+xT23YU1NeJu/6mECXI1diRArzwDrBazFTLpPgqvffX3h4bXN3BMoLB08wp1OeiTEoq7je790wjLMZ/5jOzeWo8AUV1cVvf8Mw9gDkqfCxlwblPf2/UrSpn1ajKQz7XwzrqxpLDWeTxxnQtdniVr/8Peko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286512; c=relaxed/simple;
	bh=whp2272Uhu/Un7+F7dgfdRKC80MGy07CXVKpE0EYd+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=assmCkuK+fZaRtROmeQ8xckft+X2HqDSELGAA8ma5HNn3ksaPnyI7fWvT5qnl2FXO30qifYkP4bBXlQAy4iie2qoMNstkp2E3s2s1ipUTg3naldfQe2VSe+Kjak5lxZSEPJAPbmGRvSvZ4NH330qiWGxBGFwr6ncO8DDTfifjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pqjez5Ry; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L3YyxBmi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pqjez5Ry; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L3YyxBmi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pqjez5Ry";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L3YyxBmi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pqjez5Ry";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L3YyxBmi"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE65A22DB1;
	Fri,  1 Mar 2024 09:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYz7i8/k2trzZXHeovD+sfA2ZBXbvyt0ndQH31Mx2Ys=;
	b=Pqjez5Ry6jKUV6CKdwzjeGV2Qsrlx83uZIBtUjgRgNjyPNwujQ57rrWjA2PM/Zz9FvUmP8
	n8gyegiK4WnhibbJcJjRKoYqgbbSz89Pl+je+l6hoNTu0Dj1s46E/tiaywnP1LhhbVYjUY
	+eRz9cIMOr40qc5l6Ci7b+pGnBVJ98Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYz7i8/k2trzZXHeovD+sfA2ZBXbvyt0ndQH31Mx2Ys=;
	b=L3YyxBmibakQz0Nr7m9RguHu3CS9/xZ8oL7Dd7mQn/I4BWlBAXGhfef1ktWdRuBEYjENq1
	kPvR/ss24Fu4/pBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYz7i8/k2trzZXHeovD+sfA2ZBXbvyt0ndQH31Mx2Ys=;
	b=Pqjez5Ry6jKUV6CKdwzjeGV2Qsrlx83uZIBtUjgRgNjyPNwujQ57rrWjA2PM/Zz9FvUmP8
	n8gyegiK4WnhibbJcJjRKoYqgbbSz89Pl+je+l6hoNTu0Dj1s46E/tiaywnP1LhhbVYjUY
	+eRz9cIMOr40qc5l6Ci7b+pGnBVJ98Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYz7i8/k2trzZXHeovD+sfA2ZBXbvyt0ndQH31Mx2Ys=;
	b=L3YyxBmibakQz0Nr7m9RguHu3CS9/xZ8oL7Dd7mQn/I4BWlBAXGhfef1ktWdRuBEYjENq1
	kPvR/ss24Fu4/pBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BB98E13581;
	Fri,  1 Mar 2024 09:48:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hpIfLGmk4WXpGQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 01 Mar 2024 09:48:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests 2/2] nvme/048: make queue count check retry-able
Date: Fri,  1 Mar 2024 10:48:17 +0100
Message-ID: <20240301094817.29491-3-dwagner@suse.de>
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
	none
X-Spamd-Result: default: False [2.13 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.77)[98.99%]
X-Spam-Level: **
X-Spam-Score: 2.13
X-Spam-Flag: NO

We are racing with the reset path of the controller. That means, when we
set a new queue count, we might not observe the resetting state in time.
Thus, first check if we see the correct queue count and then the
controller state.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/048 | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/048 b/tests/nvme/048
index 8c314fae9620..3b9a30bcca89 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -47,11 +47,23 @@ nvmf_check_queue_count() {
 	local queue_count="$2"
 	local nvmedev
 	local queue_count_file
+	local retries
 
 	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	queue_count=$((queue_count + 1))
+	retries=5
+
 	queue_count_file=$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue_count)
+	while [[ "${queue_count}" -ne "${queue_count_file}" ]]; do
+		if [[ "${retries}" == 0 ]]; then
+			    break;
+		fi
+		retries=$((retries - 1))
+		sleep 1
+
+		queue_count_file=$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue_count)
+	done
 
-	queue_count=$((queue_count + 1))
 	if [[ "${queue_count}" -ne "${queue_count_file}" ]]; then
 		echo "expected queue count ${queue_count} not set"
 		return 1
@@ -73,8 +85,8 @@ set_qid_max() {
 	local qid_max="$2"
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
-	nvmf_wait_for_state "${subsys_name}" "live" || return 1
 	nvmf_check_queue_count "${subsys_name}" "${qid_max}" || return 1
+	nvmf_wait_for_state "${subsys_name}" "live" || return 1
 
 	return 0
 }
-- 
2.43.2

