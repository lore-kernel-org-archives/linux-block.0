Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994005;
	b=uHkv9BklrrCOAD/RHRMTjJB0OQM6WFcc93CO9XWPBvuV4sFcXbeFRvZmK6PJKu/3lAvJ
	 r7M9YGlfgS1EHRMQAXi0m1H6CL18041EAapcRvxbCSQ1vqEtMju7d3IQ/O3semZP+UM7Q
	 usCBhkIC3kZtxfCsYgBXToZhfT7BN0+t+s4nzMffO8YhiHLTxrFgyinwxxYIIUAONUB1G
	 xRyPng6yfqK6E++jnsJ4b9k9OCXFAL8bvGj6HNhtzNodD7ay0T3KaEdQHpHeoMeDbodax
	 Wt3ccthVnLVh9jze1cMzgSUFmnZGGZO7rYS9XWPpfp5aikBbSmWMX5wVwcfw3/6icIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994005;
	h=DMARC-Filter:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Rspamd-Pre-Result:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action;
	bh=JAN09A4NdRS/dWBT+5quorGPx38n8JUk5SBa8hafTS0=;
	b=fIS16tmbm8mU6rsS1e9nGitp45xj20mXKFzN3w7OyBYHLu29EDWQNflrJObPhokSBPbk
	 ElvDPcFa5q9tZsaGv0Yolt33sZX0DyrIsrC+IYTD/UzR1THLjjTPjSwfWYMM4WO0CpDJe
	 etmZtl5g3/x0OkPoZu25XkdJDUuSTstJzTAIysYWdL4O3Z5J9fSvddlXQUp4CWPgFncgp
	 vw5uZIxqrM6K8z7DOJ5paJTMv7R4Vzf2210Sc6gJgB4tIamYfu3bkVxnFe4zQ75W9z6W1
	 ERSRTgSkjwXAssfBnNL/xebo0Hk1gvmNYMbb8YEFLjee/CMnEsNpj4/q+ze9YOTTXiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F8606A320
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 09:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E02F8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6673722258;
	Wed, 18 Nov 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 237CB1334C;
	Wed, 18 Nov 2026 09:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kUIjO1Jv/Wo6fgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:43 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:39 +0100
Subject: [PATCH blktests v2 1/9] nvme/047: look up the namespace again
 after reconnecting
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
Message-Id: <20261118-nvme-target-control-v2-1-d191bbbf5dd6@suse.de>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 6673722258
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

nvme/047 keeps using the namespace name from the first connect after
reconnecting. The name can change when other controllers come and go,
and fio then fails to open the device. Look it up again after the
second connect.

Fixes: 7497d8b45817 ("nvme/047: Test different queue types for fabrics transports")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/047 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nvme/047 b/tests/nvme/047
index 433090f2d6f2..2aeee2f0f1aa 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -42,6 +42,8 @@ test() {
 
 	_nvme_connect_subsys --nr-write-queues 1 --nr-poll-queues 1
 
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+
 	_run_fio_rand_io --filename="/dev/${ns}" --size="${rand_io_size}"
 
 	_nvme_disconnect_subsys >> "$FULL" 2>&1

-- 
2.56.1

