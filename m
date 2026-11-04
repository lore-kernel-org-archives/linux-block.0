Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810701;
	b=48duI6DQqYxq+x7r1f/Tg/KijGAeHa1XYYQKJE4uSGdvOwPD6Q4xuAv7KTJBSJb1Z+qt
	 hdTY/BuH5RrIpxGqwSG4c9Ncs5x33AdRAjcWw/T988Y7Am1unbPmLkUsygsaalnT9CqlO
	 jIBqZ08UcvsmBjOe5kxRSk1d4KENafNGeVLmPmZ6YqaULSBfyJ16VGiK1Yl4+tRlCDOEd
	 Xp9Wsn1dL0NkFdHOyy/qc9mwmebJnpXsk0tYpf4rTOsVaoRRCt6qZ+e2e9HORQjEyc1G5
	 A6D/a+1MFAaLY3Fmwfp8kasfX9bGVNJxd1cAYclZuW9zsDUolYlC5f7/fK2YbhOHhPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810701;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=yDDuJEEniFFNN320ZoGrolyDRJHNQrk9l92mg/vdmiw=;
	b=burGOLiLCflTIXVo5Cb2DlL+m1aIaKWLjprjpe30V0CMs+RKGMJ0/+qPj3Qz6TQ0FL+n
	 SL4+kxBPB+Dq33cIhO+UHesZlhGJjbQgxFfaEOiuy9qOBGmFBoKsxqO3hk45AaKfqu18g
	 Mn+8WM1HnlnyM3DGY+QuMD6sZXgj6S9oLy7N68jfB/SJ1Z8DcrKBkHNL4e4rDXAiOxfg4
	 H4oRPkK6/Lpm1ABV0He874IjSmm88i7q+DkXZZBpBPP9NKNzJ/FoBiVaLM6rf9WomhA9Q
	 3+/8tDeNbI7YqkDdyFBo+aprIiXo10M+A4Odfu9QjpsQh0lqTAEHAe6xM4P11UPqrXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pyqoohjc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BOAYAjE4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZPWv75aj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tvPePDnC;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C9606A326
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 16:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB0C9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pyqoohjc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BOAYAjE4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZPWv75aj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tvPePDnC
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EBB361F45B;
	Wed,  4 Nov 2026 16:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDDuJEEniFFNN320ZoGrolyDRJHNQrk9l92mg/vdmiw=;
	b=pyqoohjccBtq9YUbBbSDn11zd/veNKvy2lkl1cGJD2XUZ1yvafbRNDkuBuK5XJjxE32oID
	OsvlorWeML3s8dTUGgDpy0QgK4cQVcczu3chxUwqoAi/hK7sHOVcK5zIxSRp/nMcujHCMN
	QIeJg0r/0jz4scMl3wecXzmeUighYDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDDuJEEniFFNN320ZoGrolyDRJHNQrk9l92mg/vdmiw=;
	b=BOAYAjE4UmRo8sQAAMM++hArJfiPDqCfH+rIInQjrPO7uX6/0erPg5wnDdQ5hnGJxI82EQ
	1DV+qi2CJ9CLQgAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDDuJEEniFFNN320ZoGrolyDRJHNQrk9l92mg/vdmiw=;
	b=ZPWv75ajykyMIvPDAjValtCErogwitu8mFeRdCg346Y+5KbeOIMAwE6NR4+9teLXR5UJts
	935ktXejRaOiYcCvsODgLTOey5hNcPaI3qo7CRlOSk4SFRtpPRagh+wN+uWPh2F5nzjG9U
	ptsQBpz6Nl3Xe7lbXox+993QIrJcXF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDDuJEEniFFNN320ZoGrolyDRJHNQrk9l92mg/vdmiw=;
	b=tvPePDnCflZQdXNLHJWS3V267A+ZVTnfsvZsLs7IBgmyH8zwqlr9NRyeVdTD9RDTX6bwzV
	nrnlbo1bfcX4JVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6B25134F0;
	Wed,  4 Nov 2026 16:44:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bwDxIwlh62pGfQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:44:57 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:40 +0100
Subject: [PATCH blktests 01/10] common/nvme: pass --ctrlkey to the target
 control script
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
Message-Id: <20261104-nvme-target-control-v1-1-b31b40537bb4@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,running-tests.md:url]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Flag: NO

_nvmet_target_setup and _nvmet_target_add_ports pass the controller key
to the NVME_TARGET_CONTROL script as --ctrkey. running-tests.md and
contrib/nvme_target_control.py name the option --ctrlkey. The script
rejects --ctrkey, so the setup fails for the tests with a controller
key, nvme/044 and nvme/045.

Pass --ctrlkey.

Fixes: 5b6d89ced118 ("nvme/rc: introduce remote target support")
Fixes: db623ee8039f ("nvme: Add _nvmet_target_add_ports")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/nvme | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/nvme b/common/nvme
index ad3d140a8811..a8c7634ec2b8 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1611,7 +1611,7 @@ _nvmet_target_setup() {
 			ARGS+=(--hostkey "${hostkey}")
 		fi
 		if [[ -n "${ctrlkey}" ]]; then
-			ARGS+=(--ctrkey "${ctrlkey}")
+			ARGS+=(--ctrlkey "${ctrlkey}")
 		fi
 
 		"${nvme_target_control}" setup \
@@ -1708,7 +1708,7 @@ _nvmet_target_add_ports() {
 			ARGS+=(--hostkey "${hostkey}")
 		fi
 		if [[ -n "${ctrlkey}" ]]; then
-			ARGS+=(--ctrkey "${ctrlkey}")
+			ARGS+=(--ctrlkey "${ctrlkey}")
 		fi
 
 		"${nvme_target_control}" add-ports \

-- 
2.56.0

