Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B285482CA
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115433; cv=none; b=kaHe/oHQQT/JBnrortrbRilkaaoTcKdRmUlF+9VO33Jfno3/9pgsgOtAzqOG2G5SBBT2uAGXvXqlvUGGX8Gt77ISqSO24x1M+lQiZ3ylT5Ko/HItjpK/RpDnuO2xH33Xy8xkxNg+acpKufPDh+XGUh4ffUDLB6Uh9Wwz4CKxZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115433; c=relaxed/simple;
	bh=JqKE2N8SMV1Emk1mDNVMBkXmRjUMBJQkCJuJmbGqV9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl8JWA6n6u+AJ+cbIqnnLGQ3sRQNbX5UrQRhp1bXm+X+Xrz5xxumodhNgoi1ml05kqSA92Qt0HdjAYVZpA4ac2vEzj9HXo+3fOsNK5KOkBzlydmPjXllNUrW4qA97q84tRWxidDviSoI/RB1bDbyMeDgtViOD3xr6S9NoXnnEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 744913856D;
	Fri, 22 Mar 2024 13:50:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62B32136AD;
	Fri, 22 Mar 2024 13:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k8CrFqaM/WWvJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:30 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 18/18] nvme/028: drop unused nvmedev
Date: Fri, 22 Mar 2024 14:50:15 +0100
Message-ID: <20240322135015.14712-19-dwagner@suse.de>
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
X-Rspamd-Queue-Id: 744913856D
X-Spam-Flag: NO

Nothing uses nvmedev, so just remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/028 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/nvme/028 b/tests/nvme/028
index 4710bba1f416..9f4a90581984 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -20,15 +20,10 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
-
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
-
 	if ! nvme list-subsys 2>> "$FULL" | grep -q "${nvme_trtype}"; then
 		echo "ERROR: list-subsys"
 	fi
-- 
2.44.0

