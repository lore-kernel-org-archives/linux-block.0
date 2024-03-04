Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF43F9EA
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560111; cv=none; b=b3qgtvDhVYwMHghm+fPbZIyoFFqciPsgz/ONJ6fePxKY3wrWXi04/CQIZd3oAJB4JUwwj3IYq+0Vw9R0dV1rjBNz6hNRWo8SwRk2G3Wcjk+KCLAkQwB2FNT7OLJkLrzfZtPnZAvA3ojco0/m0cSRmDBvxpGrlRXf4XgD4siu8D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560111; c=relaxed/simple;
	bh=XdGKAOg5nbRQSIkADfnp1r/Nt85TszdDXCGS5RX8AUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSETCmgRK/xlWZkAgEmEgfwhRuXgGDHRvYEN7oHSwmTf2qfy3sYgtvQdUg95ppFVX9pRbGrCbRU4Gko09S4RjGOGJ2OS4VyY3K0g2WiFDbrh5PDaXFKpsic1L8ZTzqgzgoB5evX6qDhFbqPUXpw40m5kydLjKWqeFE9ndPikpHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qxGkpvWi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mjUNwmOY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qxGkpvWi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mjUNwmOY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qxGkpvWi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mjUNwmOY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qxGkpvWi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mjUNwmOY"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62D394E7DC;
	Mon,  4 Mar 2024 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709560108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ1SI0mbz4h5Vn5T//4nAvwe9OPKAH5fbQqIup2U10o=;
	b=qxGkpvWiSDda2YkCnjdFTnDrweiPtz038gfwqGXd2F76EbXk9DtgGbSWuk645jVm9BOlQz
	16XZHr6iB3Jg7e0FUcnya4gWHYLB0U5xh5JaWSvAi8jMVNLuGzZe3JrSDmrBeLKG6uCz/5
	CtHp1cX+N2pIwdXEGldi68nnnkDafqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709560108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ1SI0mbz4h5Vn5T//4nAvwe9OPKAH5fbQqIup2U10o=;
	b=mjUNwmOYMlqtKy27AX+nxfE/5OOuVNLaVQxtofONXUPXTOMhzmWKezc/xfoqQ9DBvU7JZw
	VdsGYKNn2CphBaBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709560108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ1SI0mbz4h5Vn5T//4nAvwe9OPKAH5fbQqIup2U10o=;
	b=qxGkpvWiSDda2YkCnjdFTnDrweiPtz038gfwqGXd2F76EbXk9DtgGbSWuk645jVm9BOlQz
	16XZHr6iB3Jg7e0FUcnya4gWHYLB0U5xh5JaWSvAi8jMVNLuGzZe3JrSDmrBeLKG6uCz/5
	CtHp1cX+N2pIwdXEGldi68nnnkDafqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709560108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ1SI0mbz4h5Vn5T//4nAvwe9OPKAH5fbQqIup2U10o=;
	b=mjUNwmOYMlqtKy27AX+nxfE/5OOuVNLaVQxtofONXUPXTOMhzmWKezc/xfoqQ9DBvU7JZw
	VdsGYKNn2CphBaBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5043F139C6;
	Mon,  4 Mar 2024 13:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GGIkEizR5WUiUwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 13:48:28 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 1/2] nvme/048: remove unused argument for set_qid_max
Date: Mon,  4 Mar 2024 14:48:25 +0100
Message-ID: <20240304134826.31965-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304134826.31965-1-dwagner@suse.de>
References: <20240304134826.31965-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.24
X-Spamd-Result: default: False [-2.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.94)[94.67%]
X-Spam-Flag: NO

The port is argument is unsed, thus remove it.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/048 | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/048 b/tests/nvme/048
index 1e5a7a1bcb99..8c314fae9620 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -69,9 +69,8 @@ set_nvmet_attr_qid_max() {
 }
 
 set_qid_max() {
-	local port="$1"
-	local subsys_name="$2"
-	local qid_max="$3"
+	local subsys_name="$1"
+	local qid_max="$2"
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
 	nvmf_wait_for_state "${subsys_name}" "live" || return 1
@@ -100,8 +99,8 @@ test() {
 		if ! nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
 			echo FAIL
 		else
-			set_qid_max "${port}" "${def_subsysnqn}" 1 || echo FAIL
-			set_qid_max "${port}" "${def_subsysnqn}" 2 || echo FAIL
+			set_qid_max "${def_subsysnqn}" 1 || echo FAIL
+			set_qid_max "${def_subsysnqn}" 2 || echo FAIL
 		fi
 
 		_nvme_disconnect_subsys "${def_subsysnqn}"
-- 
2.44.0

