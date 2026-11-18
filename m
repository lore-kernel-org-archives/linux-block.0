Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991351;
	b=S/5OwdaFOgZjlJESpsxrCyg4Nw0FGYZpc6xqQ98oy0B0Yl/qcwT1wJHTpbeCbx/tSu9Y
	 bQxgGpDZeeGILsER/PRjJGLEI98wyJGFBkjXWb06axCfKpFXPviAP4cJMYSBYUK/w7ol5
	 l5mIxM4IYVGkTwqSoGhLokqNeF7MwWcFSsZ/fvBwHulRVe7YdilbkMauW0N9a8sX56OMw
	 TUIf/zcQ0rEeMntM+BS9zq1RusRp4ZJfSG9R4O78ndm+4vxLVy8Fq9k6tKolJqe+Vxqcl
	 wm31jtc8ST8/MP/enlKeqdlhKPZz8x7i0y6Ex8vj24dxaqj2HViVa5Xr7tI8iN/IRWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991351;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=a1YPWFMKE00PRC6TOIauNDgZuf8CjJ2RnM7+Ewvov0s=;
	b=fajzM60NKhlSV4Es9zesFyOboa/i4mk72f1XFOYEOb5mMjY3T79trA/Kqx6irtquQgmy
	 EPGFLcQ+lPvgD/V6qoP/yRABLey71pF0CRnPpZiW2wNrTVMDj2OVCslrqm63FlLlxJGc8
	 Np5enQAlXDoN1X1n2n9xEQMU7qESMy6NUwAI6RixTmLntozA3vQp5t56n7D0tMupQ5gQ+
	 QdnwCKW6oNRefRv344gwGXww3/pvv0hIdT8JrJB9tGH4WEA6LFLmu9kdMWSkAfgGT/jDr
	 tbpqINB0z/f2dXmpImGRGFHNfp7G2tYkIEHO0gI+zHCZTA8tR42lzvr8COX1Sl8gkxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kUEhRR1v;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=t7EzEsFb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kUEhRR1v;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=t7EzEsFb;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A98606A897
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A98606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kUEhRR1v;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=t7EzEsFb;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kUEhRR1v;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=t7EzEsFb
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78F101F7CC;
	Wed, 18 Nov 2026 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1YPWFMKE00PRC6TOIauNDgZuf8CjJ2RnM7+Ewvov0s=;
	b=kUEhRR1vZLFRIa5n2iA+AXa5lsLdysD2DzzJOqakSbPcMM7JOFUb7zzlUKixENSWyON6bS
	pGanODuWwxjnV71sRrUKGbpGZohofxy5trrWCPTbXFcUHtPuqKYyLFDz15KSoZvicA/h9m
	Th08GZglExi6qeiAxvcBM4tnQd7W8jE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1YPWFMKE00PRC6TOIauNDgZuf8CjJ2RnM7+Ewvov0s=;
	b=t7EzEsFbUe8jjwy84MogHvgt9tTmwkBCY6YPO6X0j26rDTRMjLndpbGRfk4v9qPrCEXDpF
	TG9TeFFf6xpK6oBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1YPWFMKE00PRC6TOIauNDgZuf8CjJ2RnM7+Ewvov0s=;
	b=kUEhRR1vZLFRIa5n2iA+AXa5lsLdysD2DzzJOqakSbPcMM7JOFUb7zzlUKixENSWyON6bS
	pGanODuWwxjnV71sRrUKGbpGZohofxy5trrWCPTbXFcUHtPuqKYyLFDz15KSoZvicA/h9m
	Th08GZglExi6qeiAxvcBM4tnQd7W8jE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1YPWFMKE00PRC6TOIauNDgZuf8CjJ2RnM7+Ewvov0s=;
	b=t7EzEsFbUe8jjwy84MogHvgt9tTmwkBCY6YPO6X0j26rDTRMjLndpbGRfk4v9qPrCEXDpF
	TG9TeFFf6xpK6oBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ECBD134E9;
	Wed, 18 Nov 2026 08:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x3q5AvBk/WrOTgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 08:42:24 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 09:42:21 +0100
Subject: [PATCH 1/5] check: unload modules when a test with a fallback
 device is skipped
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
Message-Id: <20261118-skip-missing-deps-v1-1-a9b4a5a7cc94@suse.de>
References: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
In-Reply-To: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30

The requirement checks load modules, e.g. _have_scsi_debug loads
scsi_debug. When a test with a fallback device is skipped before the
fallback device is created, the modules stay loaded, and the next tests
that need to load the module themselves skip. A missing xfs_io for
scsi/009 skips the scsi and zbd tests that follow it.

Unload the modules on these early returns as well.

Fixes: 1967331d6667 ("check: do not create fallback device when other requirements are not met")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 check | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check b/check
index e8613936554e..a0ce930942d8 100755
--- a/check
+++ b/check
@@ -761,6 +761,7 @@ _check_and_call_test_device() {
 		if [[ $TEST_DEV == fallback ]]; then
 			if [[ -v SKIP_REASONS ]]; then
 				_output_notrun "$TEST_NAME"
+				_unload_modules
 				return 0
 			fi
 
@@ -768,6 +769,7 @@ _check_and_call_test_device() {
 			fb_dev_file="${OUTPUT}/${TEST_NAME/\//_}_fallback_dev"
 			if ! fallback_device > "$fb_dev_file"; then
 				_warning "$TEST_NAME: fallback_device call failure"
+				_unload_modules
 				return 0
 			fi
 			TEST_DEV=$(<"$fb_dev_file")
@@ -776,6 +778,7 @@ _check_and_call_test_device() {
 			if ! _find_sysfs_dirs "$TEST_DEV"; then
 				_warning "$TEST_NAME: could not find sysfs directory for ${TEST_DEV}"
 				cleanup_fallback_device
+				_unload_modules
 				return 0
 			fi
 			fallback=1

-- 
2.56.1

