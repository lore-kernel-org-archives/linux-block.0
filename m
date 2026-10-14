Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B4C47CA64
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964321; cv=none; b=N4ZVpt5pMtp4Ps4Mm6TJ4dD5C2AagOWGx7TLdEmwJgJxjjeIg6nhJns+guDbI8nbjC2gVi3AC6TD7JnsvaJl5VACKxfyf1v1El7GD796qpfPB6YpSFnd/eYpSDWbvBfk2YcRcAGSGq9aHy62LKVWLpivRku8MLgEZQVfKm76RRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964321; c=relaxed/simple;
	bh=D5MJMkCmD7Tl1fbdJbTOJoMUaIN1QRA87Qo0XM1Ts7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npM071S/42QPvAB5q4B6MTKqvt2ZYGwBydZxMz6s+GJdLy2g5BEvQ2ou9Riv8wpFuSYgzXQ3CDnIXkMsd7Qt82JqvjAcjiIHzto9EbW7Raq37gGdiLwmErNP7p8fN4o/KXze9UFsRMt+hY6tmfYcrVuH+e0xEtW8mWZwGzO+aI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lcDLe7vU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lMLwIjW5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lcDLe7vU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lMLwIjW5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lcDLe7vU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lMLwIjW5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lcDLe7vU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lMLwIjW5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4611622040;
	Wed, 14 Oct 2026 07:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqwTexX+VXE68Tycj26rp0GL/wtyxBPhiwxd7aT+dGc=;
	b=lcDLe7vU64XBzCD6VpO+DsETtxa259KI8aJ2Q49HCEhAKIAJZQZMcBBbWQ6179KYJB6B/Y
	JbL13tRdSg7pwQkMUZRQ3hHvmuHwc0aic4xxTmbffvKat6nSTyj3TvZ30YraeT4MVGl8bp
	upfPBq9Yo4xA/7lRs54wvQOHZ5wq42A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqwTexX+VXE68Tycj26rp0GL/wtyxBPhiwxd7aT+dGc=;
	b=lMLwIjW5JmOjfdKIgg4qQrtBmFhT6FdD316YFlIWP8G+N7lmfBVVWTEY7A8d9Erez7VNcp
	S2gzZXkGb+s0R9Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lcDLe7vU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lMLwIjW5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqwTexX+VXE68Tycj26rp0GL/wtyxBPhiwxd7aT+dGc=;
	b=lcDLe7vU64XBzCD6VpO+DsETtxa259KI8aJ2Q49HCEhAKIAJZQZMcBBbWQ6179KYJB6B/Y
	JbL13tRdSg7pwQkMUZRQ3hHvmuHwc0aic4xxTmbffvKat6nSTyj3TvZ30YraeT4MVGl8bp
	upfPBq9Yo4xA/7lRs54wvQOHZ5wq42A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqwTexX+VXE68Tycj26rp0GL/wtyxBPhiwxd7aT+dGc=;
	b=lMLwIjW5JmOjfdKIgg4qQrtBmFhT6FdD316YFlIWP8G+N7lmfBVVWTEY7A8d9Erez7VNcp
	S2gzZXkGb+s0R9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 158991368E;
	Wed, 14 Oct 2026 07:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2W/uOJs0z2rLPwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:51:56 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:51:47 +0200
Subject: [PATCH blktests 1/5] common/nvme: don't truncate the full log when
 disconnecting
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-isolcpu-v1-1-2fd175a8ef00@kernel.org>
References: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
In-Reply-To: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.16.0
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Level: 
X-Rspamd-Queue-Id: 4611622040
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

From: Daniel Wagner <wagi@kernel.org>

_nvme_disconnect_ctrl and _nvme_disconnect_subsys redirect the output
of nvme disconnect with '&>' into $FULL. This truncates the file and
everything a test logged before the disconnect is lost, e.g. the fio
command lines logged by _run_fio.

Append to $FULL instead.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 common/nvme | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/nvme b/common/nvme
index 8c907c34910d..1b3090e0a5da 100644
--- a/common/nvme
+++ b/common/nvme
@@ -290,7 +290,7 @@ _nvme_disconnect_ctrl() {
 	if [[ -d "${ctrl_dir}" ]]; then
 		local ret
 
-		nvme disconnect --device "${ctrl}" &> "${FULL}"
+		nvme disconnect --device "${ctrl}" &>> "${FULL}"
 		ret=$?
 		if [[ ${ret} -ne 0 ]]; then
 			echo "FAIL: nvme disconnect returned error code: ${ret}"
@@ -574,7 +574,7 @@ _nvme_disconnect_subsys() {
 		esac
 	done
 
-	nvme disconnect --nqn "${subsysnqn}" &> "${FULL}"
+	nvme disconnect --nqn "${subsysnqn}" &>> "${FULL}"
 	ret=$?
 	if [[ ${ret} -ne 0 ]]; then
 		echo "FAIL: nvme disconnect returned error code: ${ret}"

-- 
2.56.0

