Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802339;
	b=OomSxjzl5JT7YKsMNfTHlVfEIVZbSKeUv798F3IZveGO7p4FMHRyLtmhAunGrP30/b9E
	 4GMEN1lveinuQ6iJoMWi3rhpnFDCmh/mKLDdzSOZepJcECte5n4AsjiT3p0vrBJH4HurA
	 X291KFP/ycCh3GalEa3DQdycHqRSAqyOFGrYhwlwXePVavq5WTLIHSF5Vc1asrdB76sAM
	 Lt5W7mdFyXm0v8YmL+Oyy9hoZxNZKU46izZ/KtkG+qkcAA6CT/5eURe3h2yAI3xFTDhl7
	 KpDQpPSwU+jcV4/DC53M1psSwdtommZCId0jlhoWMOdr0cR1fWjIE95TL+RSPSZhATw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802339;
	h=DMARC-Filter:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Rspamd-Pre-Result:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action;
	bh=8J0r9IOW1mj4uBZqobUrjHp00LkGbd4UFVk4MIUl4nE=;
	b=Z+QXjYAKoU1EhWPA3w8AxGSnXgoYbCWBgPNCNxyehZAsa+09A2ATJzJy46tBbw3TzE0K
	 ermYt4gfJx3ByEKgTBiCDCGukDlnhwkZzytf8yFSeEhRksfl/8YAeimchzgosLMJ2A+QT
	 P1KoWQJFT2x2+UxNlS1Oc12SiOcCwuwSo7fnosluOdyFEkNbb8zw//IduUhh6/EAyKEaP
	 4uU8Cv6XRwXr8mlkODmOkQup3BLXpCaLg15QCQtc1z4DU6SmnHFKPxIIBJ0W2faeZ4/Bv
	 UsMKUenGBRT9T97m4Y3QmWjnbrAxhP2OR6LfddZDPQBPzAhKrrdKymNfES66stf0zTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D5606A326
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 14:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E5D5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 888F821F44;
	Wed,  4 Nov 2026 14:25:37 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47F27134F0;
	Wed,  4 Nov 2026 14:25:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y53MCGFA62qLagAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 14:25:37 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 15:25:16 +0100
Subject: [PATCH blktests v2 4/6] nvme/rc: add helpers to count the commands
 on a queue
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
Message-Id: <20261104-nvme-isolcpu-v2-4-2d59f622a2c8@suse.de>
References: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
In-Reply-To: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
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
X-Rspamd-Queue-Id: 888F821F44
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

Tests for the queue mapping need to know which I/O queue the commands of
a CPU are sent on. Add helpers which trace the nvme_setup_cmd event for
one queue of a controller and count the commands.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 8abd14eeb112..ea4cd500af9a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -640,3 +640,36 @@ _nvme_ctrl_tls_key() {
 
 	cat /sys/class/nvme/"$ctrl"/tls_key 2>/dev/null
 }
+
+# Check that the trace instance $1 has the nvme_setup_cmd event.
+_nvme_have_setup_cmd_event() {
+	local trace_dir="$1"
+
+	if [[ ! -d "${trace_dir}/events/nvme/nvme_setup_cmd" ]]; then
+		SKIP_REASONS+=("tracepoint nvme/nvme_setup_cmd does not exist")
+		return 1
+	fi
+	return 0
+}
+
+# Start tracing the commands sent on queue $3 of controller $2 in the trace
+# instance $1.
+_nvme_trace_qid_start() {
+	local trace_dir="$1"
+	local ctrl_id="$2"
+	local qid="$3"
+	local event="${trace_dir}/events/nvme/nvme_setup_cmd"
+
+	_set_attr "" "${trace_dir}/trace"
+	_set_attr "ctrl_id == ${ctrl_id} && qid == ${qid}" "${event}/filter"
+	_set_attr 1 "${event}/enable"
+}
+
+# Stop tracing in the trace instance $1 and print the number of traced
+# commands.
+_nvme_trace_qid_stop() {
+	local trace_dir="$1"
+
+	_set_attr 0 "${trace_dir}/events/nvme/nvme_setup_cmd/enable"
+	grep -c "nvme_setup_cmd:" "${trace_dir}/trace"
+}

-- 
2.56.0

