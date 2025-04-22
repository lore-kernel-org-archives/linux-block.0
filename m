Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4E1F4CB2
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313885; cv=none; b=g+ddSsIIA8lAXog+eDghirXbe5+YLdWYcDfHtMV9KPW8meay4HKvlnW2+XD6momuBNZ8Kpq45jkR0ypyFNsonY9PT0jBwREqgghH/CT7Qjh9K93KK996txx9d5lUm1bJwr7+jVqCqOqFz44vDRhcGbNx+3V3lezxoKOJ5wzpFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313885; c=relaxed/simple;
	bh=phsl7u2TXszUdt2gyTIndUL6RdXfZX+cCCX5GQUAfNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQbvL6oNtaAT5j0krnXCXZ3jhXcgvNieKqLwn6TWkTemLREXI1NCfuhBX9QEa1WMkDgZdHypyxq2Qx8N+na0I7rl/XVUuKeoN1/nd8lWxg3e2vsv6SCCgOwFBxPFGXUsH0dsEP7vrpeENOFBcCNuQbjabjVqZ5hW0kO6KoESJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a7HdsRbQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gobr84C7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a7HdsRbQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gobr84C7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a7HdsRbQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gobr84C7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a7HdsRbQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gobr84C7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1920E211EC;
	Tue, 22 Apr 2025 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745313882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1SIHHY1pC4QQZHLba3ThiUi3IKl3Wzoj1VSS6QlZuI=;
	b=a7HdsRbQmm72BcONcujCHsKx84YEC1rA8I2N/AmGSWwWemyjvbcoi67i/PU/iA7PznlKgm
	OtP40I14TYKtlYRpXr+MBRR8GIBn8dtFUJKGy5bxcYD8UktI/KZGDSIG5zJ/WCpnEAysw7
	BgoMfGRKaRa9rXiwsu17t+PRt+la6VE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745313882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1SIHHY1pC4QQZHLba3ThiUi3IKl3Wzoj1VSS6QlZuI=;
	b=gobr84C7T8vWSdu7vNYavO6q2O7DcNnFegQwULZYF43sGWVNP3p+DHhrM0qRXD1BcT+Pph
	HmP7gLyvoXSVEaAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a7HdsRbQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gobr84C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745313882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1SIHHY1pC4QQZHLba3ThiUi3IKl3Wzoj1VSS6QlZuI=;
	b=a7HdsRbQmm72BcONcujCHsKx84YEC1rA8I2N/AmGSWwWemyjvbcoi67i/PU/iA7PznlKgm
	OtP40I14TYKtlYRpXr+MBRR8GIBn8dtFUJKGy5bxcYD8UktI/KZGDSIG5zJ/WCpnEAysw7
	BgoMfGRKaRa9rXiwsu17t+PRt+la6VE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745313882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1SIHHY1pC4QQZHLba3ThiUi3IKl3Wzoj1VSS6QlZuI=;
	b=gobr84C7T8vWSdu7vNYavO6q2O7DcNnFegQwULZYF43sGWVNP3p+DHhrM0qRXD1BcT+Pph
	HmP7gLyvoXSVEaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01142139D5;
	Tue, 22 Apr 2025 09:24:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F8BvN1lgB2hAYgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 09:24:41 +0000
Message-ID: <b8c58ba9-cd4d-4b31-8b08-4f96262dc86e@suse.de>
Date: Tue, 22 Apr 2025 11:24:41 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] brd: remove the sector variable in brd_submit_bio
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-3-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250421072641.1311040-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1920E211EC
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/21/25 09:26, Christoph Hellwig wrote:
> The bvec iter iterates over the sector already, no need to duplicate the
> work.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/brd.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
