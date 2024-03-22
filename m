Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10646558
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115423; cv=none; b=EnE+iBjhSGBfDJHZa0u2GT0yDGqsEsZt08J96B59Am+WTFA4NyrA52EwHv6doTLhw8tRsTTS35n8bl2/QLAfT18zKc9GrGOY5A2Z6YxNeO1sxEFqktBOung8zgNGTp084q8RjjQkcgsd6Irk32y1WcQhnLn92N30WIeGCjMkm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115423; c=relaxed/simple;
	bh=yxJTSy44pomhLuSDVY/mRkxYY7Xj8swq2I/e8ZsN748=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITuAzEJbyHDJx7DXzVw+ggiZP+yX59UCiGW2Q3/5VqH0wRt9jQ+x0ZIAQwp+t0c66HZ1Fo3/3zrZl8uh7Ss6N9njBK3qX/AbRU2hN1W2g1kN14dui5kJs4+jPgX+MCtnz7tU6DBdQ7IYUMyC6sXY8t1ykXK/Foyf3BIYymJLYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48ECD3855D;
	Fri, 22 Mar 2024 13:50:20 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38AFC136AD;
	Fri, 22 Mar 2024 13:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8EyEDJyM/WV+JAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:20 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 02/18] nvme/rc: silence fcloop cleanup failures
Date: Fri, 22 Mar 2024 14:49:59 +0100
Message-ID: <20240322135015.14712-3-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322135015.14712-1-dwagner@suse.de>
References: <20240322135015.14712-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 48ECD3855D
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

