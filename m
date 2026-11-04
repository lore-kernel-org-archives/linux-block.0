Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810728;
	b=oSuHlQ6ypTVm0dnocPUwtEjf3st/YWc1oRw/CaYoeAvEYpOJJIpKGUrv/nih/bL0txoB
	 8Weu76LeKeYWIjnF+EYqodnadN4DGHs5BmduNEeOkc+BeJaW4zyD2TaT7H8VrADPV7oiK
	 zmwNJHgf96BgOcTqfSaiclattQESwqjrmiGtpWwPGXmXnqCB7c+ex+CbbfrA4uGivGrBU
	 ynOE0abfJx+HG8Frh61NeM1R7PBNEOH2cYMnCue1oUaoTgD4JZPMI5mzUSIMyx8XD/qi8
	 ruZ1QP1v0LI6u2kL/oTuOpm988cqP0SjJMknKkHii12Vy6bsNXHb4f/R+KG8pMQVo5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810728;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=q/4zBZoHHs1EZnDPEpeUnUPfc1sphMsvROEGtcmrDbI=;
	b=kGJfRuvN/RKtZ2Y1pY3VgyIXIelgvIqNZ6vQhQ3GiedDPtdifNmpe+AAhAhWCaiHEXBd
	 lV0cmHk0orOgZz8ZxORCg5L89TwJkSKuWDacsZpfgh6pmlT1HKbFrxDgU+FbS2gdUSDbD
	 eIwxkaN82NnqL5gK5h62SLI7EZKWgquOeLPmgAaEb/8e09GdmNzKI9TA3q3qSg2jZWsrE
	 5I8VkKy+Wrg2d15AOBd+cRFD3Y8Cn2QVPW8GxLGPDotQafBxrj1sFaaL3wZhpa+TBLXaO
	 gxyyzxmq/6O1i8QVnXraw4sG8kyGnB7O99lvV5AK+X8ZaFl6ICzZbf+AAVNLCDKezxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fzaW+DNC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zgI2yHXv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fzaW+DNC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zgI2yHXv;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391D8606D806
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 16:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 391D8606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fzaW+DNC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zgI2yHXv;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fzaW+DNC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zgI2yHXv
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 371EF21FC8;
	Wed,  4 Nov 2026 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/4zBZoHHs1EZnDPEpeUnUPfc1sphMsvROEGtcmrDbI=;
	b=fzaW+DNC6d1uiFLZwy+mEhNZjuoF34mrBdVCPFOJ9/Kp6jaTKYtIdyorJGkE8/QRmnm0to
	P0EjaqEpu3sl7MPg5Pr3q8m38xnrQMlQrTW+7X43ne4VkkyIhSPPQ942Xclm6Rj/+L0sdo
	GtTmKBrCR4pMjRniHxJmhAxkqasAKjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/4zBZoHHs1EZnDPEpeUnUPfc1sphMsvROEGtcmrDbI=;
	b=zgI2yHXvucmTnHc565iY7y/RfCUvj3oT4eTj+evg6fAcbHsEkiXqRoohbbvJTq7QS79EEL
	Eg7QKHopBgHtXvBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fzaW+DNC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zgI2yHXv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/4zBZoHHs1EZnDPEpeUnUPfc1sphMsvROEGtcmrDbI=;
	b=fzaW+DNC6d1uiFLZwy+mEhNZjuoF34mrBdVCPFOJ9/Kp6jaTKYtIdyorJGkE8/QRmnm0to
	P0EjaqEpu3sl7MPg5Pr3q8m38xnrQMlQrTW+7X43ne4VkkyIhSPPQ942Xclm6Rj/+L0sdo
	GtTmKBrCR4pMjRniHxJmhAxkqasAKjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/4zBZoHHs1EZnDPEpeUnUPfc1sphMsvROEGtcmrDbI=;
	b=zgI2yHXvucmTnHc565iY7y/RfCUvj3oT4eTj+evg6fAcbHsEkiXqRoohbbvJTq7QS79EEL
	Eg7QKHopBgHtXvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 049931350A;
	Wed,  4 Nov 2026 16:45:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1u2KMyVh62qSfQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:45:26 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:47 +0100
Subject: [PATCH blktests 08/10] nvme/rc: change the host keys on a remote
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
Message-Id: <20261104-nvme-target-control-v1-8-b31b40537bb4@suse.de>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,running-tests.md:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 371EF21FC8

The authentication tests change the DH-CHAP keys, hash and DH group of
the host with _set_nvmet_hostkey, _set_nvmet_ctrlkey, _set_nvmet_hash
and _set_nvmet_dhgroup. They write to the local nvmet configfs. With
NVME_TARGET_CONTROL the host is configured on the remote target, the
writes fail and the target keeps the old values. nvme/042 to nvme/045
fail on the write errors. nvme/045 renews the keys and changes the DH
group, and the re-authentication with the new values fails.

Change the values on the target with the set-host command of the
script. Document the command in running-tests.md.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md |  9 +++++++++
 tests/nvme/rc                  | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 9ca01e6893ec..847792cec240 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -288,6 +288,15 @@ set-ana: set the state of an ANA group on the port
 
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
index 8abd14eeb112..3c3ed680e416 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -247,6 +247,11 @@ _set_nvmet_hostkey() {
 	local nvmet_hostkey="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-host --hostnqn "${nvmet_hostnqn}" \
+			--hostkey "${nvmet_hostkey}"
+		return
+	fi
 	_set_attr "${nvmet_hostkey}" "${cfs_path}/dhchap_key"
 }
 
@@ -255,6 +260,11 @@ _set_nvmet_ctrlkey() {
 	local nvmet_ctrlkey="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-host --hostnqn "${nvmet_hostnqn}" \
+			--ctrlkey "${nvmet_ctrlkey}"
+		return
+	fi
 	_set_attr "${nvmet_ctrlkey}" "${cfs_path}/dhchap_ctrl_key"
 }
 
@@ -263,6 +273,11 @@ _set_nvmet_hash() {
 	local nvmet_hash="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-host --hostnqn "${nvmet_hostnqn}" \
+			--hash "${nvmet_hash}"
+		return
+	fi
 	_set_attr "${nvmet_hash}" "${cfs_path}/dhchap_hash"
 }
 
@@ -271,6 +286,11 @@ _set_nvmet_dhgroup() {
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
2.56.0

