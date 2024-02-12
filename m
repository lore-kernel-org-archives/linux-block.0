Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE72BAEA
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734454; cv=none; b=SNdFqtxvckDw+TPqnl40EV9WIvcSn1TjyegUHNctgxH6zdEF2oyFou6On/G/J+0XXviaSIg5i8BQ3Bvq8A8b2/G9kAqbmm6DY27872MepUJmLOiCZp5zv7U5nmAwx9r8jscUQkDdumyWOUeVxHUctXhEt0Ca16CgIV+Fh45bR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734454; c=relaxed/simple;
	bh=QQX/gFLZw0E3ZbYXUfbyjG/vXICMOAV3CegaXTLpnWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5p2JwWix9gzdUujaTavcjEVjiNOPDhYsI3cWbCauJsCiArYO5E3XiOvWGhIoslxPUO7htP9+WuQ0KjCbIUJWTqdc3dNaIZKQ/eB8Imrwv6lPybI+rxDz7qqH6/0Y+j/w5bhuPpKMR4+NPSm5lce+cHimVm2js2hJKqj6NpViKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M0kUZE9s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hva6xSIA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M0kUZE9s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hva6xSIA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M0kUZE9s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hva6xSIA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M0kUZE9s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hva6xSIA"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E3391F7B5;
	Mon, 12 Feb 2024 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/YGKQaQ+HjwGpY382o6YRw3SpaQ9+GiCV7RLR8wcCM=;
	b=M0kUZE9sziBJ/3Jiy0/i9HB6TY1U5hJYb3fyf725qhiOKq/PNMUMfK8QFpCkOOH63+DvUm
	reRWOAK1xNyw6cK+Kq+7uDpf1I3/7LYnNA09WcJgcyd8GlqQR7oevCgJojcApuPx6WsI5u
	nyusMOs+Uk0k1cW3YcqkwSoOsSDizpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/YGKQaQ+HjwGpY382o6YRw3SpaQ9+GiCV7RLR8wcCM=;
	b=hva6xSIAnJ/VMIFQ8q95GlvRdSulHH0bRDgcX78kCKVOc6thez649+QcwjFEdQDjvBDbag
	LauaxQ6ithR4oRCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/YGKQaQ+HjwGpY382o6YRw3SpaQ9+GiCV7RLR8wcCM=;
	b=M0kUZE9sziBJ/3Jiy0/i9HB6TY1U5hJYb3fyf725qhiOKq/PNMUMfK8QFpCkOOH63+DvUm
	reRWOAK1xNyw6cK+Kq+7uDpf1I3/7LYnNA09WcJgcyd8GlqQR7oevCgJojcApuPx6WsI5u
	nyusMOs+Uk0k1cW3YcqkwSoOsSDizpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/YGKQaQ+HjwGpY382o6YRw3SpaQ9+GiCV7RLR8wcCM=;
	b=hva6xSIAnJ/VMIFQ8q95GlvRdSulHH0bRDgcX78kCKVOc6thez649+QcwjFEdQDjvBDbag
	LauaxQ6ithR4oRCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BEDE13A0E;
	Mon, 12 Feb 2024 10:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UCddBbP1yWXrCwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:40:51 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 1/5] nvme/029: fix local variable declarations
Date: Mon, 12 Feb 2024 11:40:42 +0100
Message-ID: <20240212104046.13127-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212104046.13127-1-dwagner@suse.de>
References: <20240212104046.13127-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.17%]
X-Spam-Level: ****
X-Spam-Score: 4.81
X-Spam-Flag: NO

The syntax for local variables declarations uses whitespace as separator
and not commas:

tests/nvme/029: line 24: local: `bs,': not a valid identifier
tests/nvme/029: line 24: local: `size,': not a valid identifier
tests/nvme/029: line 24: local: `img,': not a valid identifier

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/029 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/029 b/tests/nvme/029
index caed0f7ec476..db6e8b91f707 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -21,7 +21,7 @@ test_user_io()
 	local disk="$1"
 	local start=$2
 	local cnt=$3
-	local bs, size, img, img1
+	local bs size img img1
 
 	bs="$(blockdev --getss "$disk")"
 	size=$((cnt * bs))
-- 
2.43.0

