Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991353;
	b=nNNViD/m23WZ+F0QRb/GZlLZyuB8e6WJdFBooKPYAv9tvSSl2q0CbtNf+3KqwD82kLvw
	 /p40YspDXTEgqeS/bn+WXaPvQZ0+24en/xkyp3Sqdbx0LQ/qLi7/yuYcv06d9Z5QypVC8
	 uNntrD3b0vt8/khNLDg06crQVYrDeRMOc29h4936z6GSISc1h2htonNejkDl8RGBACClF
	 Q18BduUokuLjMtBjTa6JyR6dio1vE5k/r1d/EAgzlX/CwcmgAHb0bJF/S/2A9xFxXhXLW
	 EUjn2K55A8DCTv3CfN1FH7IwS2is6aEEWiqeatMTKB1jZuuVBm4r2gq5Jhvi4KpWavw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991353;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=DlkZTfp97ILjzk2q8amVabxZhUPgms7wRTorDxz7C4U=;
	b=KQGdgv6A/xErnljjd2egX4oMDo7tkPjmC6OWMvBS9+lZRtSk3UMWeANadNjyA+rIrF9w
	 pt8H2jUPwBv5X5G7oG9cJlvA5UxNogP8vlFprGJRDgGk4S4iSoQoLD44St8V/mqNVVdaq
	 QE6ns5SlGhf8BBklv6Z0QoAbnyeVlZTWLB3UEsnNi1MiY5KK8tGqFqK7VIhEWigtmcIA1
	 TFYkNyIVQf4h+8qo30i1W56EcgI+5GxX0ghKhI6u/2c/H0bWr+PGDVCgyrsI4EwVOLDI2
	 U8lko0nyGbI4OW00yfjTdYPBfrR3nkTwSl+i07XUr7QvYUenv+KECzmCFw9Q98dze5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AwVeDQNh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a17L9MAu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AwVeDQNh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a17L9MAu;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F1606A335
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C3F1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AwVeDQNh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a17L9MAu;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AwVeDQNh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a17L9MAu
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0EC1223A6;
	Wed, 18 Nov 2026 08:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlkZTfp97ILjzk2q8amVabxZhUPgms7wRTorDxz7C4U=;
	b=AwVeDQNhkolSDopcaCmSL7ky31LBuGW9DQ2cSzaTenf78XiFiLIx6bYhnfFW6eQQr397WI
	HWUbQ9chrOPZhAKm9UfS3A8BGwfHkxj4TdVZZ+mjekoOZupX2Z8Nj3vnpaYEWM/PJn/Hma
	5rChsZ17iz2f9cHAXoo6AcsqQpZ9IUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlkZTfp97ILjzk2q8amVabxZhUPgms7wRTorDxz7C4U=;
	b=a17L9MAuHeOaUvk/UPkX+zk/r//LpsLe+BPy6kTDdYLQzzXe+wx249MZXl1+RDJjKb7GmS
	266JQsMYD7dcHmCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlkZTfp97ILjzk2q8amVabxZhUPgms7wRTorDxz7C4U=;
	b=AwVeDQNhkolSDopcaCmSL7ky31LBuGW9DQ2cSzaTenf78XiFiLIx6bYhnfFW6eQQr397WI
	HWUbQ9chrOPZhAKm9UfS3A8BGwfHkxj4TdVZZ+mjekoOZupX2Z8Nj3vnpaYEWM/PJn/Hma
	5rChsZ17iz2f9cHAXoo6AcsqQpZ9IUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlkZTfp97ILjzk2q8amVabxZhUPgms7wRTorDxz7C4U=;
	b=a17L9MAuHeOaUvk/UPkX+zk/r//LpsLe+BPy6kTDdYLQzzXe+wx249MZXl1+RDJjKb7GmS
	266JQsMYD7dcHmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81029134E9;
	Wed, 18 Nov 2026 08:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IaGSFvFk/WrbTgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 08:42:25 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 09:42:22 +0100
Subject: [PATCH 2/5] nvme/053, nvme/068: skip if fio or xfs_io is missing
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
Message-Id: <20261118-skip-missing-deps-v1-2-a9b4a5a7cc94@suse.de>
References: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
In-Reply-To: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30

nvme/053 runs fio and nvme/068 runs xfs_io without checking for them, so
they fail instead of being skipped on a host without the tools. Check
for them in requires().

Fixes: ed9b60a05a3f ("nvme: add test for controller rescan under I/O load")
Fixes: ca59dfcce4ef ("nvme/068: add a test for multipath delayed removal")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/053 | 4 ++++
 tests/nvme/068 | 1 +
 2 files changed, 5 insertions(+)

diff --git a/tests/nvme/053 b/tests/nvme/053
index 99dbd3880edd..255cff177c0f 100755
--- a/tests/nvme/053
+++ b/tests/nvme/053
@@ -12,6 +12,10 @@ DESCRIPTION="test controller rescan under I/O load"
 TIMED=1
 : "${TIMEOUT:=60}"
 
+requires() {
+	_have_fio
+}
+
 get_sleep_time() {
 	local duration=$((RANDOM % 50 + 1))
 
diff --git a/tests/nvme/068 b/tests/nvme/068
index cab57cd62969..b9d28a50d03e 100755
--- a/tests/nvme/068
+++ b/tests/nvme/068
@@ -15,6 +15,7 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_have_module_param_value nvme_core multipath Y
+	_have_program xfs_io
 	_require_nvme_trtype_is_fabrics
 }
 

-- 
2.56.1

