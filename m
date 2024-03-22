Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946247A55
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115425; cv=none; b=fybEpnDlv/inBZ8Bdl18G54KHvnUvUVMTOJeQYUJEXg38lxeinBkk6W3Vfs9fK+4vHhFD7GWQkATj/OG/b5yNCxz4nUQU37dlJBVd7qEvLKcD8q6eVa9KXnu929qAKNJgYSoSW0wvCFqfMaDm+RjToqvUWbhjZY37A5CN6x6uGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115425; c=relaxed/simple;
	bh=DnVwCt5EWeuVuNmxdizQCr7Wj4BTezqAxCx2nVwmcu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcdsGghy8/uzXvG3L1ivcDQma3Wr4F9ZCaPpmYLX4Wgf0f1drcanBjMe552bN7pEhsjG+HiLrOL22b+FsPkmIbc1qHq/TlxEvSKeFGrx1Y76DXFfjXI1dbQMI3S/bHI6iQlaC9U+hJ3qK1VLYKfh8j2mIJravP+Mc/01wmI1STo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F11eDfqa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xNR7D7Su; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F11eDfqa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xNR7D7Su; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F11eDfqa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xNR7D7Su";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F11eDfqa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xNR7D7Su"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCFFB5FE1B;
	Fri, 22 Mar 2024 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=F11eDfqa9I33Gq/KFQGIN64y6G+xrIB+C4yXoKjNFJCCS0W6pYmqhsn/grJA9JIYs0UaUk
	8PIL2OwIEPqV6SajDdDq/y0Yvq2XLQ5P+9L21PKKDB89nCpl+fFemxzBbCNJpOdV2Kyj/4
	ZmA5194nvXQXK1QoL6vIh9JZ2zlfeVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=xNR7D7SuF6974Cqsat31O9ynJAjzScF//Tf+rZvUINs6YMGrBynGyllMQH/kUuqKmpvWcx
	tsOjpg88sCy3TiCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=F11eDfqa9I33Gq/KFQGIN64y6G+xrIB+C4yXoKjNFJCCS0W6pYmqhsn/grJA9JIYs0UaUk
	8PIL2OwIEPqV6SajDdDq/y0Yvq2XLQ5P+9L21PKKDB89nCpl+fFemxzBbCNJpOdV2Kyj/4
	ZmA5194nvXQXK1QoL6vIh9JZ2zlfeVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=xNR7D7SuF6974Cqsat31O9ynJAjzScF//Tf+rZvUINs6YMGrBynGyllMQH/kUuqKmpvWcx
	tsOjpg88sCy3TiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCA47136AD;
	Fri, 22 Mar 2024 13:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AfmiMJyM/WWAJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:20 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 03/18] nvme/rc: log error if stale configuration is found
Date: Fri, 22 Mar 2024 14:50:00 +0100
Message-ID: <20240322135015.14712-4-dwagner@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.82
X-Spamd-Result: default: False [-0.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.52)[80.41%]
X-Spam-Flag: NO

It's possible that a previous run of blktest left some stale
configuration left. E.g. when the module unload doesn't work (the bug
might in the kernel we are testing). In this case error out and avoid
confusion.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 865c8c351159..e67bb846ab77 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -658,6 +658,11 @@ _create_nvmet_host() {
 	local nvmet_ctrlkey="$4"
 	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -d "${host_path}" ]]; then
+		echo "FAIL target setup failed. stale host configuration found"
+		return 1;
+	fi
+
 	mkdir "${host_path}"
 	_add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
 	if [[ "${nvmet_hostkey}" ]] ; then
-- 
2.44.0

