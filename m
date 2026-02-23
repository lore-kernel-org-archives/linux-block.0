Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71D34B1A6
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849795; cv=none; b=Q16j0x1SDueCX5VWAoHwTPKrxJimVsIwFDkp4/c6WJtlvOvgNOgn6pOoDtuAguzw61cuxGhUe0vFBF+hEHFOIGg1OBHfkHlTpEtid09xjLTZaF87K5GBDGRvW0fIqR5YhkuZV93v+2E1eN2Ac7AwfRX9fqDa2uvFwHbQjiU663c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849795; c=relaxed/simple;
	bh=380o1PihYFB2G/1AHwQhcW2h85oXOBv5I9PSkJbQfr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTdh5AY/K8UHyvTeyDEMW1UwBpOolzh+2lrJVdUVw9oiTTrUSmdFTjZ/hgFpbinElN2xiyBMw5Kka/Gp4j0M2PUGB7dJ5tBchF975pW1VUpHrLC0d7smHCXKTDTJFqhabkEmbWJDG3v90el41eObSlSyxgeZfX/MDWS5lCOpRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sMkTQB3+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U8JV5NWW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IqS+mE3N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RqeAgs83; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sMkTQB3+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U8JV5NWW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IqS+mE3N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RqeAgs83"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37C545BD16;
	Mon, 23 Feb 2026 12:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771849792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGbjSXTaIUxUuKJiaIXGdFVRRXGtSZZlSA0bhJBLriY=;
	b=sMkTQB3+KvusT8BAYpuz3NQg6xo53qHy18LkB3RFYAsRE9z3raC0K9R3tZjYAOTatSdbU/
	BHYpSXhTFiGiiBL5H5NTDuRnQTiHX7hNAzF5WV7/QEBkzzxLmbgwx5I2/3n3kzr78jJfCQ
	FHKxC/kXyVy0h0CCph5NAaT+LaCud34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771849792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGbjSXTaIUxUuKJiaIXGdFVRRXGtSZZlSA0bhJBLriY=;
	b=U8JV5NWWUbECGs9sioKVLfjdgYCQJCuCtfFp6AyrhNYZyP4pPPQ9v2+ObeDbjYsDQUoa4x
	UqADXk8dUNo9f1Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IqS+mE3N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RqeAgs83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771849790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGbjSXTaIUxUuKJiaIXGdFVRRXGtSZZlSA0bhJBLriY=;
	b=IqS+mE3NElxUXobkQQ9yM8DvfPrkCQTF+CFxh6CESYKmk2I07/4pxkKrJTbsmSmH3IQ6tN
	Xv71DbSf6ZSJDW6tBLDNVEmXbbunpsBCPWQMH/5n/4LsinKRvAPWoYIzm2y94k2HpC61YZ
	3u8FlJJJItSgJ0dH3zvDjyfU0nD+wyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771849790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGbjSXTaIUxUuKJiaIXGdFVRRXGtSZZlSA0bhJBLriY=;
	b=RqeAgs83h53cgeSj0mRKhnieh3PjHQAjKa551xsjOqMXOmMEVvG8D0XxVMEAVpZVgc1AZD
	f89yZCRE3JbCK5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F18523EA68;
	Mon, 23 Feb 2026 12:29:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5l7FNj1InGn/aAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 12:29:49 +0000
Message-ID: <60659f21-a52d-4dbb-a776-6952ce5362be@suse.de>
Date: Mon, 23 Feb 2026 13:29:49 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] selftests: ublk: rework partitions tests for new
 flags
To: Alexander Atanasov <alex@zazolabs.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260223121515.3296983-1-alex@zazolabs.com>
 <20260223121515.3296983-3-alex@zazolabs.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260223121515.3296983-3-alex@zazolabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,zazolabs.com:email];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,zazolabs.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 37C545BD16

On 2/23/26 13:15, Alexander Atanasov wrote:
> To support reworked flags - UBLK_F_PARTITIONS and UBLK_F_AUTO_PART_SCAN
> update kublk.
> Remove old argument --no_auto_part_scan
> Add arguments:
> -p, --with-partitions - enable partitions on trusted devices
> -P, --auto_part_scan  - enable partitions and perform auto scan
> 
> Update test cases to use the new arguments
> 
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>   tools/testing/selftests/ublk/kublk.c           | 18 ++++++++++++------
>   .../selftests/ublk/test_integrity_01.sh        |  9 +++++----
>   tools/testing/selftests/ublk/test_part_01.sh   | 14 +++++++-------
>   tools/testing/selftests/ublk/test_part_02.sh   |  6 ++++--
>   4 files changed, 28 insertions(+), 19 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
