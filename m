Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEFC3F9EC
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560112; cv=none; b=LZ+HM4Aht6g38WYgmxKlF0ZygsD47/HRFDZXM3r1Myn9MGw4iqsVX1i1jdMJH9ox8qp8UgtYIXKh9x+h1JMECc4OmBuxYXAmJ9feQOLzPe88TWvJ1dacp42xPHCrcb2wvqKKUaIPI7iOA2gubRfXKpqmWuhZ9onWeLjpYoUmxxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560112; c=relaxed/simple;
	bh=hgaBbvbo+0mgxP4QC+7wWAAa5uJIPz58RJN/7gCeoGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyxkxazWjp1qfMxj6wiMsium6PzmQCYft+3evuytoXUJ2n1Lu5nVguC4svFJv0FAgGfvx5vHspFWvG9RODvYnoygyiVbSVsydNlLih7RfRDQ/g6rFxV+doSvHoCUnpVTp1XiPY4w6Piq2x049xoYqcELR3FoxeYmxve90GeRP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bogOyDTO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YkHjq6L9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bogOyDTO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YkHjq6L9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bogOyDTO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YkHjq6L9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bogOyDTO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YkHjq6L9"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 085FD76062;
	Mon,  4 Mar 2024 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709560109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dxdbCkVkX4T7z0yhU/0/V65EvjCfxxvaq6BgKKlMoI=;
	b=bogOyDTO92rQxumAgFFVWmUwAt0G2SXjj8XyWkRDSvQ/XlfhknzRmFyLhIA8gcLpBuLtU6
	9ckrz/akdIy/L+k6HjFHfmbqdaHcX1fMNwCziO6NLrENsmBO/MCIsakVJgyMkqKkPYcv2E
	W7kq0sHQLZSjrQS6jTv7kuHXW1qmWH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709560109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dxdbCkVkX4T7z0yhU/0/V65EvjCfxxvaq6BgKKlMoI=;
	b=YkHjq6L9M2yA/vrXrZW+jE6dS3rOC1qhmhoKpkfJjzgi+Zd3osTjYed5i0OcDrbZpPv1rT
	pou7/VApKDXFCtBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709560109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dxdbCkVkX4T7z0yhU/0/V65EvjCfxxvaq6BgKKlMoI=;
	b=bogOyDTO92rQxumAgFFVWmUwAt0G2SXjj8XyWkRDSvQ/XlfhknzRmFyLhIA8gcLpBuLtU6
	9ckrz/akdIy/L+k6HjFHfmbqdaHcX1fMNwCziO6NLrENsmBO/MCIsakVJgyMkqKkPYcv2E
	W7kq0sHQLZSjrQS6jTv7kuHXW1qmWH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709560109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dxdbCkVkX4T7z0yhU/0/V65EvjCfxxvaq6BgKKlMoI=;
	b=YkHjq6L9M2yA/vrXrZW+jE6dS3rOC1qhmhoKpkfJjzgi+Zd3osTjYed5i0OcDrbZpPv1rT
	pou7/VApKDXFCtBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E996E139C6;
	Mon,  4 Mar 2024 13:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ibSSNyzR5WUkUwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 13:48:28 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 2/2] nvme/048: make queue count check retry-able
Date: Mon,  4 Mar 2024 14:48:26 +0100
Message-ID: <20240304134826.31965-3-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304134826.31965-1-dwagner@suse.de>
References: <20240304134826.31965-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.09
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.79)[99.07%]
X-Spam-Flag: NO

We are racing with the reset path of the controller. That means, when we
set a new queue count, we might not observe the resetting state in time.
Thus, first check if we see the correct queue count and then the
controller state.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/048 | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/048 b/tests/nvme/048
index 8c314fae9620..393dbc2a07d5 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -47,11 +47,25 @@ nvmf_check_queue_count() {
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
+			echo "expected queue count ${queue_count} not set"
+			return 1
+		fi
+
+		sleep 1
+
+		retries=$((retries - 1))
+		queue_count_file=$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue_count)
+	done
 
-	queue_count=$((queue_count + 1))
 	if [[ "${queue_count}" -ne "${queue_count_file}" ]]; then
 		echo "expected queue count ${queue_count} not set"
 		return 1
@@ -73,8 +87,8 @@ set_qid_max() {
 	local qid_max="$2"
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
-	nvmf_wait_for_state "${subsys_name}" "live" || return 1
 	nvmf_check_queue_count "${subsys_name}" "${qid_max}" || return 1
+	nvmf_wait_for_state "${subsys_name}" "live" || return 1
 
 	return 0
 }
-- 
2.44.0

