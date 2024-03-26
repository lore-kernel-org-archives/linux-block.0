Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7C70CC2
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458850; cv=none; b=pe6LXjnHHcUgZikFKOY/gSD9a18k2lPlAZvij0DJ/DXAj+5aVInrvJFI+pvbCEl1QrDVc9vOkaqlRZAVQggdjiFtdb8k4U7QXcBmyz8oPuhrccQ0AYl2pKEEl0ribPLECQ7tVFG8Ua4uxlCJ/ha7qSwamTB3C7a54/LUzI7nVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458850; c=relaxed/simple;
	bh=yxJTSy44pomhLuSDVY/mRkxYY7Xj8swq2I/e8ZsN748=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=assmzc4EZem9WNDNe1GWS2JkBiRR23cOB5SZ6Ys11cn0YN2ZNwP2s9jLAE/5R4frbPWiGQt6u6TdZJDRpRZQWsLFIyDopSE23m+XlAtfaWLOYC3q0b5JIWBm8Dm01q6UAeQzn//+KymiqVYxDqZyRrJLj5MUTzHKl9RrpCU+rFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fsNqn/7/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=agBAe3ii; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fsNqn/7/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=agBAe3ii; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fsNqn/7/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="agBAe3ii";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fsNqn/7/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="agBAe3ii"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BBFA75D653;
	Tue, 26 Mar 2024 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+x2HhGHovkIJQBaW5/2RylIdYKd8QrSoc4gIjkjyCU=;
	b=fsNqn/7/SKnyClIh31X0uEVtypET93PbKfJNbLbfRUDeN3pPV29vSGNTLEtJOofWMDGmxP
	/YekVgHPR7cWhJR2O7P9w8oCTFUK1Wq3tB02ESvwwE4ZzrAPRZSFSDbsy1k+ayD1IHNJpz
	dJ8jd9U49sYfeONgsTbUvEge3srj+Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+x2HhGHovkIJQBaW5/2RylIdYKd8QrSoc4gIjkjyCU=;
	b=agBAe3iixFE0Q2rzCP1TMZbOVVOxwpKH8u5duFBDfkj8el9sDODQHo+pte1OrVaNxJCYUp
	Rong/rW1OKlu1CBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+x2HhGHovkIJQBaW5/2RylIdYKd8QrSoc4gIjkjyCU=;
	b=fsNqn/7/SKnyClIh31X0uEVtypET93PbKfJNbLbfRUDeN3pPV29vSGNTLEtJOofWMDGmxP
	/YekVgHPR7cWhJR2O7P9w8oCTFUK1Wq3tB02ESvwwE4ZzrAPRZSFSDbsy1k+ayD1IHNJpz
	dJ8jd9U49sYfeONgsTbUvEge3srj+Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+x2HhGHovkIJQBaW5/2RylIdYKd8QrSoc4gIjkjyCU=;
	b=agBAe3iixFE0Q2rzCP1TMZbOVVOxwpKH8u5duFBDfkj8el9sDODQHo+pte1OrVaNxJCYUp
	Rong/rW1OKlu1CBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A9CB213587;
	Tue, 26 Mar 2024 13:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YwcBKB7KAmb+NgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 02/20] nvme/rc: silence fcloop cleanup failures
Date: Tue, 26 Mar 2024 14:13:44 +0100
Message-ID: <20240326131402.5092-3-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 2.72
X-Spamd-Result: default: False [2.72 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.98)[86.90%]
X-Spam-Level: **
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

When the ctl file is missing we are logging

  tests/nvme/rc: line 265: /sys/class/fcloop/ctl/del_target_port: No such file or directory
  tests/nvme/rc: line 257: /sys/class/fcloop/ctl/del_local_port: No such file or directory
  tests/nvme/rc: line 249: /sys/class/fcloop/ctl/del_remote_port: No such file or directory

because the first redirect operator fails. Also it's not possible to
redirect the 'echo' error to /dev/null, because it's a builtin command
which escapes the stderr redirect operator (why?).

Anyway, the simplest way to catch this error is to first check if the
control file exists before attempting to write to it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 78d84af72e73..865c8c351159 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -234,7 +234,10 @@ _nvme_fcloop_del_rport() {
 	local remote_wwpn="$4"
 	local loopctl=/sys/class/fcloop/ctl
 
-	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > ${loopctl}/del_remote_port 2> /dev/null
+	if [[ ! -f "${loopctl}/del_remote_port" ]]; then
+		return
+	fi
+	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > "${loopctl}/del_remote_port"
 }
 
 _nvme_fcloop_del_lport() {
@@ -242,7 +245,10 @@ _nvme_fcloop_del_lport() {
 	local wwpn="$2"
 	local loopctl=/sys/class/fcloop/ctl
 
-	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_local_port 2> /dev/null
+	if [[ ! -f "${loopctl}/del_local_port" ]]; then
+		return
+	fi
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > "${loopctl}/del_local_port"
 }
 
 _nvme_fcloop_del_tport() {
@@ -250,7 +256,10 @@ _nvme_fcloop_del_tport() {
 	local wwpn="$2"
 	local loopctl=/sys/class/fcloop/ctl
 
-	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_target_port 2> /dev/null
+	if [[ ! -f "${loopctl}/del_target_port" ]]; then
+		return
+	fi
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > "${loopctl}/del_target_port"
 }
 
 _cleanup_fcloop() {
-- 
2.44.0

