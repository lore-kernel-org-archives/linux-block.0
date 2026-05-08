Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170F40DFB4
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261985; cv=none; b=ZUbrch5H9xi3rGytIbXKLQ3IqlJufkMbcDf5XHUqDuU1Zuoti1fr0o+HC3/EJVKhkPkdrBSnCIbqDubm8gvbEgBbPbX2VS8ZPbqrhdb4SvJntKvY3D1c4CA8tZEFH5yS3yHORSS+T5EupBRRzXSBN924Vh3+QlFbIGwD5nxCZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261985; c=relaxed/simple;
	bh=vSBYQVIA+rQwzFyrgpx0CxNbtsi8+Pbx2fIH2Lv9VLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNeDD4KCcZl8HzfnIsDxkRTW7ZEXWPl2ny+wyEX/W3bIczF3QBC5SQR4ij3LJkMQv27Fa2vA3wveuOtE3j2QHlcK1SS8frz1nUCw4Zv9epiDPfYfBvR91YioRm3enmO3EogZTBeVEaPgZYaIf+qdP0U0wzUuDdE6x2DRVYGTsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AICJOGjY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SSlm4Mld; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AICJOGjY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SSlm4Mld; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AICJOGjY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SSlm4Mld";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AICJOGjY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SSlm4Mld"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 049095BF33;
	Fri,  8 May 2026 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778261982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eu2MXanMcUWOX6c4NsMX9eTwndGe7lRX0AO/HQk+0D4=;
	b=AICJOGjY4d5S8Tpu00+SwWntPx6AzDj/F7p0FeLNY3hfTVNTDDDiIe7FzL6QDug1cYIv8F
	73Z0zixtJUa4WxmbBRJv/1Q5Gq9cNwR+QV2ASrjkihC/I+/pmHJ0x1Eb6j777ONKyrawcS
	eJ9efftoxTeFs1gSrJbxYZpjc695XF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778261982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eu2MXanMcUWOX6c4NsMX9eTwndGe7lRX0AO/HQk+0D4=;
	b=SSlm4Mldk8OfDWj48ffb3qgk1KXmSHZISqZDNSMMp4C5HWyD4Z4EQFWa8GSVPUwlJ38BlA
	jeEG9vdaW+n3FEDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AICJOGjY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SSlm4Mld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778261982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eu2MXanMcUWOX6c4NsMX9eTwndGe7lRX0AO/HQk+0D4=;
	b=AICJOGjY4d5S8Tpu00+SwWntPx6AzDj/F7p0FeLNY3hfTVNTDDDiIe7FzL6QDug1cYIv8F
	73Z0zixtJUa4WxmbBRJv/1Q5Gq9cNwR+QV2ASrjkihC/I+/pmHJ0x1Eb6j777ONKyrawcS
	eJ9efftoxTeFs1gSrJbxYZpjc695XF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778261982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eu2MXanMcUWOX6c4NsMX9eTwndGe7lRX0AO/HQk+0D4=;
	b=SSlm4Mldk8OfDWj48ffb3qgk1KXmSHZISqZDNSMMp4C5HWyD4Z4EQFWa8GSVPUwlJ38BlA
	jeEG9vdaW+n3FEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF979593A7;
	Fri,  8 May 2026 17:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mc75NN0f/mm7CAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 08 May 2026 17:39:41 +0000
Date: Fri, 8 May 2026 19:39:37 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] blktrace/001: Skip test when kernel lockdown is
 enabled
Message-ID: <440d1e82-e54f-4709-829b-24d8fb16246e@flourine.local>
References: <20260424141143.64528-1-disgoel@linux.ibm.com>
 <afIGq_uV-l9_98Px@shinmob>
 <f3617b18-526e-4006-a692-b704925de24b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3617b18-526e-4006-a692-b704925de24b@linux.ibm.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,raw.githubusercontent.com:url];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 049095BF33
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Fri, May 08, 2026 at 04:51:41PM +0530, Disha Goel wrote:
> After further investigation, I've identified the root cause. This
> failure is seen on SLES 16.x and RHEL 10.x with 6.12-based kernels when
> Secure Boot is enabled (kernel lockdown active).

SLES ships an bunch of additional patches which hardens the lockdown
feature a bit more. IIRC these are the same as RHEL uses. Not sure if
this is the source of the problem though.

https://raw.githubusercontent.com/openSUSE/kernel-source/refs/heads/SL-16.1/series.conf

	# Lock down functions for secure boot
	patches.suse/0001-security-lockdown-expose-a-hook-to-lock-the-kernel-down.patch
	patches.suse/lockdown-fix-kernel-lockdown-enforcement-issue-when-secure.patch
	patches.suse/0002-efi-Add-an-EFI_SECURE_BOOT-flag-to-indicate-secure-boot-mode.patch
	patches.suse/0003-efi-Lock-down-the-kernel-if-booted-in-secure-boot-mode.patch
	patches.suse/0004-efi-Lock-down-the-kernel-at-the-integrity-level-if-b.patch

The patches are in https://github.com/openSUSE/kernel-source/tree/SL-16.1/patches.suse
