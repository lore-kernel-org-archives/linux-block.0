Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CE55C3B
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014460; cv=none; b=ei4oNNMj0v7/vjx2V+oudCgPDALBlO4VZkuuP/uRG52eYlaQKfjjSLT1q8vBhGNLX/CT0nTCRcqy56O+dR8DSZo+6WbVKu0APcuSl2lfj/SXaBWvUQJVDH7/zCtk6bXr1BQPfNG6oyrVi0hlZnwORbHrCI4A1JKuhhH5J6GS89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014460; c=relaxed/simple;
	bh=ozF3ZTTja91AckWUISY211uyUv57rz31GfG7VAp6N44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUS11SZz66XOWpkj8Krqa9INyZpL2FSYmma45TGueQ4jbd4KEjxNMWd/gnNDnMQSBipyxzqobzbjIQfBKhxa4NuPF9xcnx+05SD6qTGQhn4/WYw7ttQteMznvTPyKW/ULtdsLsLp+6boMGt44TeYn2do3U19DZP0NBxYuPSisco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y6I8OlI3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4SzaR9+i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y6I8OlI3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4SzaR9+i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y6I8OlI3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4SzaR9+i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y6I8OlI3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4SzaR9+i"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EA9F5CBC7;
	Thu, 21 Mar 2024 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qESwvGMvANqaY3Icr9sfur8OsYwyqrb2vJVNIQj9xio=;
	b=y6I8OlI3eiohxtV9+4OabLjUsNVYQFPtcY/cZSM0fE93nI1JGa7KGXmjEH7h3kycPbQ4K+
	DdD1OAOf8EbkpvDXWeM/jwPNUnmBhWEDP1hikf+kdhvn0h9lkMFOsc1MOixO4vaovbmWUN
	iDAbe80TQRCDqvn6PPEmkv4XMsSh0II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qESwvGMvANqaY3Icr9sfur8OsYwyqrb2vJVNIQj9xio=;
	b=4SzaR9+i/cqhcvNAYXzw7L6HWU0TvFTHlcBAKYkHycl+bWZo9j14ubjQV95/MFBx6JBSI/
	tkUfK693sAvnG6Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qESwvGMvANqaY3Icr9sfur8OsYwyqrb2vJVNIQj9xio=;
	b=y6I8OlI3eiohxtV9+4OabLjUsNVYQFPtcY/cZSM0fE93nI1JGa7KGXmjEH7h3kycPbQ4K+
	DdD1OAOf8EbkpvDXWeM/jwPNUnmBhWEDP1hikf+kdhvn0h9lkMFOsc1MOixO4vaovbmWUN
	iDAbe80TQRCDqvn6PPEmkv4XMsSh0II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qESwvGMvANqaY3Icr9sfur8OsYwyqrb2vJVNIQj9xio=;
	b=4SzaR9+i/cqhcvNAYXzw7L6HWU0TvFTHlcBAKYkHycl+bWZo9j14ubjQV95/MFBx6JBSI/
	tkUfK693sAvnG6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C9C113976;
	Thu, 21 Mar 2024 09:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XNGuATkC/GXbDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 11/18] nvme/rc: remove correct port from target
Date: Thu, 21 Mar 2024 10:47:20 +0100
Message-ID: <20240321094727.6503-12-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321094727.6503-1-dwagner@suse.de>
References: <20240321094727.6503-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.68
X-Spamd-Result: default: False [3.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.11%]
X-Spam-Level: ***
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

Remove the port from the subsystem the test wants to remove.

Fixes: a12281b8320f ("nvme: introduce nvmet_target_{setup/cleanup} common code")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index ba83f32febb8..d74a5418557d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -869,7 +869,7 @@ _nvmet_target_cleanup() {
 		esac
 	done
 
-	_get_nvmet_ports "${def_subsysnqn}" ports
+	_get_nvmet_ports "${subsysnqn}" ports
 
 	for port in "${ports[@]}"; do
 		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
-- 
2.44.0

