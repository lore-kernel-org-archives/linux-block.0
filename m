Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810709;
	b=WaXE/a7Ln2x7FPKB2XzXzf2TIs6ITZg6Th0y83i2AEJb62NV6CfC0ZYj3tC1BaXv2XbZ
	 cCN97yV21AjCCt5tA8gwQvxvzDQaFPTbWTx2BdzeHuZOC0j+XscFyMngRPHsBoxE6S8lu
	 rlAH44ywFmLJGuyKMJdLImjXmmTljuy4USzfT5k2Ft9WHgjvv9KsyjeSQ9SmJbf8qC3/D
	 PHWNNStjFcgl5OuGJ0fbzY9gD+eNZmIEQ6rWg3D1+u5t6FPfo/F8gXgQVgNHSTKK7obVN
	 /tqnRNx5yG7ggwAS4a1vJI806rYQZyT7w14C7Cq1dQ6OIspMWLQx29Vc4OjR+zMbUQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810709;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=FXE670AngxzfkBHD5HKJlrTeUL/akM3t4YTYMvxU6cg=;
	b=rZYeMeRUsrz6tLMtI0Y22A99S1cFPiWmc6RC9U4AaovGRe1bndk6Vq7XjZQIqhhGpE/H
	 9ijqP834Xh3RQga0tKaTFsTkS9fxl9lA/9bar3l3Kh5PYZHybnPv3rNKjV0AvRSUjiZph
	 NKki2+eHQ3zzUNhITQQ4Zi0b7636hcX2fcYtestL5dnArCnzr9ES7jfXV2Bn+OpGYjm2q
	 +8sXAim/JhFPqMfdUi98Een/mc/8GW0QIwQKP/KflnWZ31ZQL04LqDbbMSfmqxql3oHID
	 B4+ltysh7NGtwTHc82pBj3uzJfNhwMFuxK2IjaJuVdQo/19LufYiIr3FE25mVzNNFsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zH65qRvb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="c/18D3lb";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zH65qRvb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="c/18D3lb";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932E606A32C
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 16:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6932E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zH65qRvb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c/18D3lb;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zH65qRvb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c/18D3lb
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B592221FB6;
	Wed,  4 Nov 2026 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXE670AngxzfkBHD5HKJlrTeUL/akM3t4YTYMvxU6cg=;
	b=zH65qRvbzg2bIGPKIF3G6QyhutB9uACooX7Xo5Xj32tG7mg60n9cAYICzU/hoRZqjPXJie
	KQDkAG+2kc3Xrl9Yk1mZPwo4xrHnjqtJmdmUWKklHHx0jCK9bypMbr1Nre3VzWWHLCE7wO
	fGY1NKPnGXFk1P7von7TNQHKclX5QEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXE670AngxzfkBHD5HKJlrTeUL/akM3t4YTYMvxU6cg=;
	b=c/18D3lbsYQ1PwrS0oVzPIuWde0ckOJFouJgHpu3lg0KEeb3QOtYbSXijFi/KfxXkcE3/z
	fzcFYB7VzRJVcwBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXE670AngxzfkBHD5HKJlrTeUL/akM3t4YTYMvxU6cg=;
	b=zH65qRvbzg2bIGPKIF3G6QyhutB9uACooX7Xo5Xj32tG7mg60n9cAYICzU/hoRZqjPXJie
	KQDkAG+2kc3Xrl9Yk1mZPwo4xrHnjqtJmdmUWKklHHx0jCK9bypMbr1Nre3VzWWHLCE7wO
	fGY1NKPnGXFk1P7von7TNQHKclX5QEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXE670AngxzfkBHD5HKJlrTeUL/akM3t4YTYMvxU6cg=;
	b=c/18D3lbsYQ1PwrS0oVzPIuWde0ckOJFouJgHpu3lg0KEeb3QOtYbSXijFi/KfxXkcE3/z
	fzcFYB7VzRJVcwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 818A8134F0;
	Wed,  4 Nov 2026 16:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1kIhFxNh62plfQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:45:07 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:42 +0100
Subject: [PATCH blktests 03/10] common/nvme: check the subsystem in
 _nvmet_target_add_ports
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
Message-Id: <20261104-nvme-target-control-v1-3-b31b40537bb4@suse.de>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
In-Reply-To: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Flag: NO

_nvmet_target_add_ports checks that the subsystem exists before it adds
ports to it. It checks the configfs directory of ${subsystem}, which is
not set. The path is then the subsystems directory, which always exists,
so the check never fails.

It also appends the keys to ARGS, which it doesn't declare local. They
end up in the ARGS of the caller.

Check the directory of ${subsysnqn} and declare ARGS local, as
_nvmet_target_setup does.

Fixes: db623ee8039f ("nvme: Add _nvmet_target_add_ports")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/nvme | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/nvme b/common/nvme
index 93782d07dc78..dfe85b6e281f 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1668,6 +1668,7 @@ _nvmet_target_add_ports() {
 	local host_port=0
 	local tls="none"
 	local cfs_path
+	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -1734,7 +1735,7 @@ _nvmet_target_add_ports() {
 		return
 	fi
 
-	cfs_path="${NVMET_CFS}/subsystems/${subsystem}"
+	cfs_path="${NVMET_CFS}/subsystems/${subsysnqn}"
 	if [[ ! -d "${cfs_path}" ]]; then
 		echo "Can not add ports to a non-existent subsystem. subsystem not found"
 		return 1;

-- 
2.56.0

