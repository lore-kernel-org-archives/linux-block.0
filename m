Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810719;
	b=zCPBad+0TqDaNgdMpqrVM6mhfT7cYOo79hrAtzPAC7qonzwlBDMFgfWCSh/ZnGYtZVFp
	 C6ySJhESJumfKZXjoECauL2+9hBdt6RAX5aalpfL9jtVf8AFZSqe9VDdxfeBGo/B+abWH
	 FHfFlOOe1s8Q33ZHyv7c611eFqCF1oU3S6mfq7tnn8RqrdXVSZczRoWqr5ARUnfSJlarW
	 p7J2oDp15Wg7AwYoZsBFuKQpIQznMi78j7gQmPdUHOdR3fHt9drpRrS9OhS+1D09VnGkE
	 hTgviK/3FVxhLpCP049sW/DieJNTi/26xV1kspDb2vm6JvGStmQoYUIicXT2JFn18nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810719;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=1jts9GtRrXj66UQAWUkQhHpe+3yRF/xRSj5W4gyNbBY=;
	b=ahuMIvjp56jyZ9hZg1ylQg5csambX0rv7sPi6muxuZ3ZnoGA7CyUDNljfxIaB0Tn2Fwz
	 CqfuteAj1o2gqvpjEE8kmpTs6AVNj3uNw/shtXWm5KfqNeCiPeXsAkqznfmCDEjgSfhBS
	 rLjrZqwsGfCFyCOf9cKFIWTtzmaKcPhOeRHqKgHuaOXm0eb3WC/HGgk5Ih4PmF8lJMxgT
	 oUMWTXWP5+Hb0DZFUbqeUmiQiU4RILe+ooDn7Kbw81sRwnp+NHzqSH3M1+Wrg5/s2mSl4
	 l95kABdQByqiqKST71fLhAXvbv1ZaST7wlEtBMrxX7Ztt2Cx5sCbB1xNwrHPnusaQvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gVPBmfGu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zSRTt2hi;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gVPBmfGu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zSRTt2hi;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A13606A326
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 16:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34A13606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gVPBmfGu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zSRTt2hi;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gVPBmfGu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zSRTt2hi
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F0CD21FC8;
	Wed,  4 Nov 2026 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jts9GtRrXj66UQAWUkQhHpe+3yRF/xRSj5W4gyNbBY=;
	b=gVPBmfGum8j9qNTHBHOLZDtgX+BuGC9x4E/LykuwCBxQjEw94bRx2gCod5J1/+rLKaejO8
	5a2IUcVpZEmJIAKpRno/1CXXoudg1E/Ttlldiv35jIBhyrJaPgv/x0D7BdryaPBdfwtzN0
	dR6ZumfWryj24pni41nyo0yjfVfNAlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jts9GtRrXj66UQAWUkQhHpe+3yRF/xRSj5W4gyNbBY=;
	b=zSRTt2hi7PZKoK4n3mpa+TMhZ7delxTWqc8rBvTL43XaJmuBAEPqPTAyPBdctJMtM2/VY3
	438UKGxXeo2ZvwCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gVPBmfGu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zSRTt2hi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jts9GtRrXj66UQAWUkQhHpe+3yRF/xRSj5W4gyNbBY=;
	b=gVPBmfGum8j9qNTHBHOLZDtgX+BuGC9x4E/LykuwCBxQjEw94bRx2gCod5J1/+rLKaejO8
	5a2IUcVpZEmJIAKpRno/1CXXoudg1E/Ttlldiv35jIBhyrJaPgv/x0D7BdryaPBdfwtzN0
	dR6ZumfWryj24pni41nyo0yjfVfNAlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jts9GtRrXj66UQAWUkQhHpe+3yRF/xRSj5W4gyNbBY=;
	b=zSRTt2hi7PZKoK4n3mpa+TMhZ7delxTWqc8rBvTL43XaJmuBAEPqPTAyPBdctJMtM2/VY3
	438UKGxXeo2ZvwCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C952134F0;
	Wed,  4 Nov 2026 16:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GtFqCh1h62p0fQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:45:17 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:44 +0100
Subject: [PATCH blktests 05/10] nvme/029: skip if the I/O exceeds the
 maximum transfer size
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-target-control-v1-5-b31b40537bb4@suse.de>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
In-Reply-To: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 7F0CD21FC8

nvme/029 reads and writes up to 1025 blocks with one passthrough
command. The test was written for 512 byte blocks, where this is 512
KiB. A namespace with 4 KiB blocks needs 4 MiB per command. If the
controller's maximum transfer size is smaller, the kernel rejects the
command with EINVAL and the test fails, e.g. against a target with a
1 MiB MDTS.

Skip the test if 1025 blocks don't fit the maximum transfer size of the
queue.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/029 | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/029 b/tests/nvme/029
index 59f87144e95a..a757cb9915b0 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -63,6 +63,19 @@ test() {
 
 	_nvme_connect_subsys
 
+	local ns dev max_bytes
+	ns="$(_find_nvme_ns "${def_subsys_uuid}")"
+	dev="/dev/${ns}"
+
+	# The largest I/O is 1025 blocks, it must fit the maximum transfer size.
+	max_bytes=$(($(cat "/sys/block/${ns}/queue/max_hw_sectors_kb") * 1024))
+	if ((1025 * $(blockdev --getss "$dev") > max_bytes)); then
+		SKIP_REASONS+=("max transfer size ${max_bytes} is smaller than 1025 blocks")
+		_nvme_disconnect_subsys >> "$FULL" 2>&1
+		_nvmet_target_cleanup
+		return 1
+	fi
+
 	# nvme-cli may fail to allocate linear memory for rather large IO buffers.
 	# Increase nr_hugepages to allow nvme-cli to try the linear memory allocation
 	# from HugeTLB pool.
@@ -72,8 +85,6 @@ test() {
 		reset_nr_hugepages=true
 	fi
 
-	local dev
-	dev="/dev/$(_find_nvme_ns "${def_subsys_uuid}")"
 	test_user_io "$dev" 1 512 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 1 511 >> "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 1 513 >> "$FULL" 2>&1 || echo FAIL

-- 
2.56.0

