Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994007;
	b=UAX9RVXR2RY5gaVT5zpmy4YoeRri/i+wiMnIPn8Z5d9gSauKWELiRDEoxB3b2/ZeAnig
	 G4t34VHb4FgODK+r70Tx+UqnzD8m7o85J84RAdcahzNx3IpLN1u4JQXL22cu3ne1S3tzp
	 sd7Dke/LsvI6EqOuCdJiXkVDy42Q5byiq6KJLzDEetyyO3E0hPy4vBhqMGwA7cSDz8Q5X
	 5zvBLFtbLSRUTWWjzI0615EMUhtVRr2LHrIz3MKenmox7+biXcwiH6yAHr5k4lEiYfcHj
	 0pM3xMrTu1ZjIIts+bveGZpiHLwKBdqU6MgarrqQHeYSeglGAlkjMPZObi0tGYk8KDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994007;
	h=DMARC-Filter:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Rspamd-Pre-Result:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action;
	bh=n0+WD7MnmNpawjURDbchI2+bOPOVbb2oYCqZjNWipHg=;
	b=JnkQUJz9t1de7d2IdBRBMS85/fGCDnWeDG1zczWxf45GXKgXWHK+IQemRZ0XZj6NkEE6
	 MnD4c2hX368qegheM2JMWqyoGJ5bNwQ1yG6z23XPJtdCTuzsaph5Ah/+VrvTno4+jcPnu
	 Th1E0kDkH0ud6PtlYCD1MDWHx1om5Ibjbv9Y4ANciXqmpCR1/gyZQX/5ns0oZFY6JqPRw
	 2qsbGMpinZ7911dsQc0pj9g0wM+uQJOknQd+s8+qL0ntQWEQQ/1I4/sCJnSFOh4aIHzdi
	 lpsF4kb/YiJCxyKB+FFiBTn0ouMihIjhq9Z/nNS352v22c0owHFqsNydn5B36oPy9mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1AC606A31C
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 09:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB1AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE34C1F387;
	Wed, 18 Nov 2026 09:26:44 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B74B1334C;
	Wed, 18 Nov 2026 09:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6FyuFFRv/Wo8fgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:44 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:40 +0100
Subject: [PATCH blktests v2 2/9] contrib/nvme-target-control: pick a free
 service ID for new nvmet ports
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
Message-Id: <20261118-nvme-target-control-v2-2-d191bbbf5dd6@suse.de>
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
X-Rspamd-Queue-Id: BE34C1F387
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

The nvmet target derives the service ID from the port ID. On a target
that already has ports this clashes with existing ports, and nvme/003
connects to a service ID nothing listens on. Use the lowest free
service ID starting at trsvid instead.

Fixes: 79c32fb31b7b ("contrib: make nvme-target-control a standalone project")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 contrib/nvme-target-control/README.md                       | 13 +++++++------
 .../nvme_target_control/targets/nvmet.sh                    |  7 ++++++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/contrib/nvme-target-control/README.md b/contrib/nvme-target-control/README.md
index dc421b00b788..9abd7f30932d 100644
--- a/contrib/nvme-target-control/README.md
+++ b/contrib/nvme-target-control/README.md
@@ -61,12 +61,13 @@ is set, the namespace is a loop device on an image file in
 subsystem, the ports which don't export another subsystem, the hosts no
 other subsystem allows, and the loop device and image file.
 
-A new port gets the lowest free nvmet port ID N, starting at 1, and listens
-on `traddr` at service ID `trsvid` + N - 1. The first port of a target
-without other ports listens on `trsvid`. The nvmet target implements all
-port commands: `add-ports`, `add-port`, `remove-port`, `list-ports`,
-`show-port` and `set-ana`, and `set-host`, which changes the DH-CHAP keys,
-hash and DH group of the host.
+A new port gets the lowest free nvmet port ID, starting at 1, and the
+lowest service ID from `trsvid` up which no other port uses: the first
+port listens on `traddr` at `trsvid` unless another port of the target
+does. The nvmet target implements all port commands: `add-ports`,
+`add-port`, `remove-port`, `list-ports`, `show-port` and `set-ana`, and
+`set-host`, which changes the DH-CHAP keys, hash and DH group of the
+host.
 
 | Option | Meaning |
 | --- | --- |
diff --git a/contrib/nvme-target-control/nvme_target_control/targets/nvmet.sh b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.sh
index 33f383eb17f0..7d6e9cd40da0 100644
--- a/contrib/nvme-target-control/nvme_target_control/targets/nvmet.sh
+++ b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.sh
@@ -59,6 +59,11 @@ add_port() {
 	while [ -e "${cfs}/ports/${port}" ]; do
 		port=$((port + 1))
 	done
+	# The target may have other ports, take the first free service ID.
+	while cat "${cfs}"/ports/*/addr_trsvcid 2> /dev/null |
+			grep -qx "${trsvcid}"; do
+		trsvcid=$((trsvcid + 1))
+	done
 	case "${traddr}" in
 	*:*)	adrfam=ipv6 ;;
 	*)	adrfam=ipv4 ;;
@@ -68,7 +73,7 @@ add_port() {
 	echo "${trtype}" > "${cfs}/ports/${port}/addr_trtype"
 	echo "${adrfam}" > "${cfs}/ports/${port}/addr_adrfam"
 	echo "${traddr}" > "${cfs}/ports/${port}/addr_traddr"
-	echo $((trsvcid + port - 1)) > "${cfs}/ports/${port}/addr_trsvcid"
+	echo "${trsvcid}" > "${cfs}/ports/${port}/addr_trsvcid"
 	case "${tls}" in
 	none)
 		;;

-- 
2.56.1

