Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47772125A0
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849844; cv=none; b=atGfPTOe3i8vAZdMx/c+QUW4sP2kxNqbLWkHp/fq96aHbKQVI7rhlW2jUQf9WpsFHD/egcpEa4vRTI45bCu0zYMgfrIVyqo5d8wErC/d+S5JeRlbGeDhFdn3lX7NRMfe3u0ohPcrFf3HWlHDAfR0OffnbX8q/SCH86KMCyE+H0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849844; c=relaxed/simple;
	bh=dfN42u8JKJdb31Kg7d5qHOKoPCKlF5RRNQJFdXku2w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8DVFHWSLdXa1rVD48u/64lrLVarRc0QOe3xcgm2bhviH1e3Bw9GzZbRqLAbaLiC0MZPUhH1Z6mbe8pAFotexyVWm7DockWEY2TqofkZygZFhWUAXbjdEMC8UdcxcrvNRmI9+hNOBFc9kq53Tio4Xt0S5n485hkPknLvg8QhA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JYuBWmGP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xR10Lizj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JYuBWmGP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xR10Lizj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JYuBWmGP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xR10Lizj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JYuBWmGP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xR10Lizj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 848D25BD1E;
	Mon, 23 Feb 2026 12:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771849841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBxvZJoNJECkddsj2zXQFM97QnmgPgA6D9bUap0+Cvc=;
	b=JYuBWmGPz2Og15VMQQIk1vF+AqsYPd8SG14qnm2947Lp6MzfxXwQKwelLJYbRtBu0LNybd
	GA5jWaUNxVT+VIWJmLk2IbBbxKbzusb6Ii71sPz9ABuNaE6BecOnurbF58NtBjLacthO6u
	0gFJz3rHREcz44+0JK7BqMGaVWOlymg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771849841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBxvZJoNJECkddsj2zXQFM97QnmgPgA6D9bUap0+Cvc=;
	b=xR10Lizj8IUwBlogHugKgNsP/WUVqXVt7WXY+zRNtoKREfj4KHpobTtpIZe765qTWOLs34
	Hd8RpKiCc0unNhBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JYuBWmGP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xR10Lizj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771849841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBxvZJoNJECkddsj2zXQFM97QnmgPgA6D9bUap0+Cvc=;
	b=JYuBWmGPz2Og15VMQQIk1vF+AqsYPd8SG14qnm2947Lp6MzfxXwQKwelLJYbRtBu0LNybd
	GA5jWaUNxVT+VIWJmLk2IbBbxKbzusb6Ii71sPz9ABuNaE6BecOnurbF58NtBjLacthO6u
	0gFJz3rHREcz44+0JK7BqMGaVWOlymg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771849841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBxvZJoNJECkddsj2zXQFM97QnmgPgA6D9bUap0+Cvc=;
	b=xR10Lizj8IUwBlogHugKgNsP/WUVqXVt7WXY+zRNtoKREfj4KHpobTtpIZe765qTWOLs34
	Hd8RpKiCc0unNhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 699B03EA68;
	Mon, 23 Feb 2026 12:30:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zQoNGXFInGnqaQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 12:30:41 +0000
Message-ID: <21d3a583-0f65-4538-9d21-7fab22964da2@suse.de>
Date: Mon, 23 Feb 2026 13:30:41 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests: ublk: cleanup kublk.h
To: Alexander Atanasov <alex@zazolabs.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260223121515.3296983-1-alex@zazolabs.com>
 <20260223121515.3296983-5-alex@zazolabs.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260223121515.3296983-5-alex@zazolabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,zazolabs.com:email,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: 848D25BD1E
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/23/26 13:15, Alexander Atanasov wrote:
> Arguments are handled via flags so
> remove unused no_auto_part_scan bitfield.
> 
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>   tools/testing/selftests/ublk/kublk.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
> index 1faeccaaecae..3379e49449b4 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -79,7 +79,6 @@ struct dev_ctx {
>   	unsigned int	per_io_tasks:1;
>   	unsigned int	no_ublk_fixed_fd:1;
>   	unsigned int	safe_stop:1;
> -	unsigned int	no_auto_part_scan:1;
>   	__u32 integrity_flags;
>   	__u8 metadata_size;
>   	__u8 pi_offset;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
