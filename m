Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B9745F4
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458855; cv=none; b=bWyyUBYV4ZZTGkdsVEfTAwokbwDMEpldje9Fw3CKJZxw3+3yDeUQ515MEhn1reVoUzgqHSd9KKqT0WhwQyTSfIBxDmx5SQN5luwuyw6tyW66p6/aFTSmu1D9UTC02/bOHN9NSZ6eSSkH3zo1eqzOKSKGRonq6hfWktt1tklBtfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458855; c=relaxed/simple;
	bh=gsNU7h7keSEkO72yj8qqSUmR9M8p6D1Zx0HQ1kQW7Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUl5FdwQ5mYUU6N0hyMHwVDCNGlv0ZwNFk9GzHA8dDKHDiR8Mc9K235LHFpVm6BOPwTFfDB0NpVQAra/5OCYGayUN4AbGTI93vqVVzlgM5HIRrq5Hicoddxv3ilAPc9LqZST7pYfGnrEz3mAveYfXS+vdFmS40/fbRggmVT5QVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HAeAza5P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ENftepJ0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HAeAza5P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ENftepJ0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HAeAza5P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ENftepJ0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HAeAza5P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ENftepJ0"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A65C5D65D;
	Tue, 26 Mar 2024 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=HAeAza5P8hjdX5I4zpTXSTQVnn2A2DavwNKz6T/d8O9vj2cgwj/kfZqyr+yGS6OiNm/a7W
	5h9kg+korVml+8uUsQdHksW91vPzaegLFjGkxWxHsUHEgPBhKrnNvrzoUdjjXhtpp/zF/V
	kmUyIdBjm2JjUqkXgr80rDHOOxXCToY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=ENftepJ0w6kVH0jY+Avzth5tZyskKUdWYWjoEXwm0p6r6YSA2VUuiRg2CqX2vR3kIgvW3A
	9TzhA7Caopj8IvCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=HAeAza5P8hjdX5I4zpTXSTQVnn2A2DavwNKz6T/d8O9vj2cgwj/kfZqyr+yGS6OiNm/a7W
	5h9kg+korVml+8uUsQdHksW91vPzaegLFjGkxWxHsUHEgPBhKrnNvrzoUdjjXhtpp/zF/V
	kmUyIdBjm2JjUqkXgr80rDHOOxXCToY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=ENftepJ0w6kVH0jY+Avzth5tZyskKUdWYWjoEXwm0p6r6YSA2VUuiRg2CqX2vR3kIgvW3A
	9TzhA7Caopj8IvCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 685E813587;
	Tue, 26 Mar 2024 13:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OxoSGCTKAmYUNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:12 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 11/20] nvme/rc: do not cleanup external managed loop device
Date: Tue, 26 Mar 2024 14:13:53 +0100
Message-ID: <20240326131402.5092-12-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: **
X-Spam-Score: 2.26
X-Spamd-Result: default: False [2.26 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.44)[91.23%]
X-Spam-Flag: NO

If the test setups a loop device itself (not created by
_nvmet_target_setup), _nvmet_target_cleanup should not cleanup the block
device automatically.

Because _nvmet_target_cleanup has no way to figure this out by itself if
it is managed or not, the caller needs to pass in the block device type.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4ad6cb640627..9d47c737f9b0 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -855,9 +855,14 @@ _nvmet_target_cleanup() {
 	local port
 	local blkdev
 	local subsysnqn="${def_subsysnqn}"
+	local blkdev_type=""
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
+			--blkdev)
+				blkdev_type="$2"
+				shift 2
+				;;
 			--subsysnqn)
 				subsysnqn="$2"
 				shift 2
@@ -878,7 +883,9 @@ _nvmet_target_cleanup() {
 	_remove_nvmet_subsystem "${subsysnqn}"
 	_remove_nvmet_host "${def_hostnqn}"
 
-	_cleanup_blkdev
+	if [[ "${blkdev_type}" == "device" ]]; then
+		_cleanup_blkdev
+	fi
 }
 
 _nvmet_passthru_target_setup() {
-- 
2.44.0

