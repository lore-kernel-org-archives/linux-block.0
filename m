Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994020;
	b=o/Kap5ZeQTYV5xuJh/4Yt31QSI5UzznZ2D+q0CKgCc6suWtErHQj+EzVZo3L01ZiZQY6
	 /4vKblbJZjGPRnmj3fbF1O34MV58lbasHJiYqsM99M1/dDj15U3C6kA65uR+OhsIzJpPc
	 w4aVPNsjik2mNqcOAgn9zazAIpIh3SQYpDpHBQpzxNed8GWe856piA4eYdvzX9L3TP/a7
	 2ZATLLW7EqnWTCaIxWdaOAGmrpD/da7iarDVfGnaGGXNhFkSvAfjne1rtKWi+0DAOIVO3
	 Ea+9aKrXStjUSnyV0mJK9WP9rn1z0+Z+RZJHL0ugjN6MI119/vihZoPtDduMFYRDbpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994020;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=h761RMndxgOojiHI0yfEQhOUWEyCFrsuMNP4Yd/Fwao=;
	b=oAgRr/uKmQZseOovRWFbayuGQsCC58HwnWwmlcaq4tcq81ftzRTfn2EUO13I4u7Zf4xE
	 IrEIADC1y2wtVjPPoIO0iejIuiaEWYwVloYXqK2bmYf0QjRS3hFKLBOcr8zBe/PkljBDP
	 AgqWDbpnK6g105BHwwYOLzmiOnQIgRUybK4xxDt+x2U+uWgOUpjQV26gW8bIZNOyDc7fS
	 20XJdvB59cNDo0syZfIHhCf0xVjBQSSio8kfPv/SBr8vmhy+6fckVoAt3jWvYLFfQg+Hm
	 e6tWKxoYb49kldWJ4nIR0lt+zf4+wRtnJsCgEuwPRxcYnXSDB9Awo3JopgkL6j9a5wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lYFHtoWI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dAxAIRxo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lYFHtoWI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dAxAIRxo;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54E606A31C
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 09:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA54E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lYFHtoWI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dAxAIRxo;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lYFHtoWI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dAxAIRxo
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41AA41F769;
	Wed, 18 Nov 2026 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h761RMndxgOojiHI0yfEQhOUWEyCFrsuMNP4Yd/Fwao=;
	b=lYFHtoWIBpE3YFqefH0ha99gNesdH0cGI2PUtKDhnJY3kar4/H7cRyPqZZLLx4xznFqFzS
	PxCj4PizSOo3uYvqjiZUJ8l4zdnfyeRKgDHQcKy32sJZfysBAT+CpNyD2Izgvs1f2GoJ9d
	UABnxOIBTBQkOwIIrcT4+ME2NWghuEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h761RMndxgOojiHI0yfEQhOUWEyCFrsuMNP4Yd/Fwao=;
	b=dAxAIRxojwDYFkJn7ABB+6Gf52qxSgDe7XY34NjyEGmytZe8K/4laSitHcYhuaRy4FIfR5
	vfdsTXlMawdPbPDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h761RMndxgOojiHI0yfEQhOUWEyCFrsuMNP4Yd/Fwao=;
	b=lYFHtoWIBpE3YFqefH0ha99gNesdH0cGI2PUtKDhnJY3kar4/H7cRyPqZZLLx4xznFqFzS
	PxCj4PizSOo3uYvqjiZUJ8l4zdnfyeRKgDHQcKy32sJZfysBAT+CpNyD2Izgvs1f2GoJ9d
	UABnxOIBTBQkOwIIrcT4+ME2NWghuEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h761RMndxgOojiHI0yfEQhOUWEyCFrsuMNP4Yd/Fwao=;
	b=dAxAIRxojwDYFkJn7ABB+6Gf52qxSgDe7XY34NjyEGmytZe8K/4laSitHcYhuaRy4FIfR5
	vfdsTXlMawdPbPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1EAB1334C;
	Wed, 18 Nov 2026 09:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LfbVMWFv/WpWfgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:57 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:46 +0100
Subject: [PATCH blktests v2 8/9] nvme/rc: change the host keys on a remote
 target
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
Message-Id: <20261118-nvme-target-control-v2-8-d191bbbf5dd6@suse.de>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-17.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -17.30
X-Spam-Level: 
X-Spam-Flag: NO

The helpers that change the DH-CHAP settings of the host write to the
local nvmet configfs, so a remote target never sees the new values. Use
the set-host command of the target control script instead and document
it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md |  9 +++++++++
 tests/nvme/rc                  | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 8300d9aa4842..149b3656d7c8 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -296,6 +296,15 @@ set-ana: set the state of an ANA group on the port
 
 If list-ports prints nothing, blktests connects to the address config shows.
 
+The authentication tests change the DH-CHAP attributes of the host:
+
+set-host:
+  --hostnqn HOSTNQN
+  --hostkey HOSTKEY
+  --ctrlkey CTRLKEY
+  --hash HASH
+  --dhgroup DHGROUP
+
 contrib/nvme-target-control implements this interface. It configures a Linux
 nvmet target over ssh and can be extended for other targets, see
 contrib/nvme-target-control/README.md.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 0d74c427313c..47710efc5096 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -285,6 +285,11 @@ _set_nvmet_hostkey() {
 	local nvmet_hostkey="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-host --hostnqn "${nvmet_hostnqn}" \
+			--hostkey "${nvmet_hostkey}"
+		return
+	fi
 	_set_attr "${nvmet_hostkey}" "${cfs_path}/dhchap_key"
 }
 
@@ -293,6 +298,11 @@ _set_nvmet_ctrlkey() {
 	local nvmet_ctrlkey="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-host --hostnqn "${nvmet_hostnqn}" \
+			--ctrlkey "${nvmet_ctrlkey}"
+		return
+	fi
 	_set_attr "${nvmet_ctrlkey}" "${cfs_path}/dhchap_ctrl_key"
 }
 
@@ -301,6 +311,11 @@ _set_nvmet_hash() {
 	local nvmet_hash="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-host --hostnqn "${nvmet_hostnqn}" \
+			--hash "${nvmet_hash}"
+		return
+	fi
 	_set_attr "${nvmet_hash}" "${cfs_path}/dhchap_hash"
 }
 
@@ -309,6 +324,11 @@ _set_nvmet_dhgroup() {
 	local nvmet_dhgroup="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-host --hostnqn "${nvmet_hostnqn}" \
+			--dhgroup "${nvmet_dhgroup}"
+		return
+	fi
 	_set_attr "${nvmet_dhgroup}" "${cfs_path}/dhchap_dhgroup"
 }
 

-- 
2.56.1

