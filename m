Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4011F4E3B
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313866; cv=none; b=QkjaOhMcDnUU0Pxgizx0L22MU0qL/AfCyA5HWGL7xtrmmY65GRvdyNIwaMrDebH/0FkHl4uQ0zfBbPbJPb/VII+M8UcpcJ1FQDowzgtKEgsT+lckHup4S7i0z8YAsckiqW0Q+5FWPubs/F8eBgKGPMn4CbRzxb4absvLMJC1was=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313866; c=relaxed/simple;
	bh=YjzGJYKDR8GSliRtsfhokpFt+f/7hBMep54v7jzCkmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKuT7llZ9kjCCA77wzMh9hINTJZCZUF8Jk7dkY704cAntsuWpFfD4PD7srs8z5Fzp8rMo1W6xICuEByqwj/pWAehCTvQkGmYVXpm03jNhzD1YX7ht+eWqJaav6R9D3UwH6PMHEQEIAw2H756/qbQ/GYjs5m/eNvDVYNDtoCVGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n/lqLfY7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nOVJmTJ3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n/lqLfY7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nOVJmTJ3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n/lqLfY7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nOVJmTJ3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n/lqLfY7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nOVJmTJ3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1173E1F38D;
	Tue, 22 Apr 2025 09:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745313856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eJDPxAtsQhOmaWzcbXInOXHn+63WTBZwv6vANY14Ec=;
	b=n/lqLfY7CYE6eGRNmaE7CS9+TbpXulx4FFr+zpYt+gHKaZTJy/QUR1N7YtY2m8Ofv3EeOF
	ilIfEBPn4Dv0rOxfoQCU3EVQDB6IemZyImeJy1IWKBXvIPuQ2JoKpjnHvDzNkZdubIB0Gw
	/4CGG2ZxJtHZ6YQmwYENPhJsr1jbYVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745313856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eJDPxAtsQhOmaWzcbXInOXHn+63WTBZwv6vANY14Ec=;
	b=nOVJmTJ3w0GcyTrX0uFK50RzeNMfDNwOITF/b5ctaluTqsQSaPXy9hCbWkrPAnwHep/l+F
	+pqN3s7/xSxVa9AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="n/lqLfY7";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nOVJmTJ3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745313856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eJDPxAtsQhOmaWzcbXInOXHn+63WTBZwv6vANY14Ec=;
	b=n/lqLfY7CYE6eGRNmaE7CS9+TbpXulx4FFr+zpYt+gHKaZTJy/QUR1N7YtY2m8Ofv3EeOF
	ilIfEBPn4Dv0rOxfoQCU3EVQDB6IemZyImeJy1IWKBXvIPuQ2JoKpjnHvDzNkZdubIB0Gw
	/4CGG2ZxJtHZ6YQmwYENPhJsr1jbYVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745313856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eJDPxAtsQhOmaWzcbXInOXHn+63WTBZwv6vANY14Ec=;
	b=nOVJmTJ3w0GcyTrX0uFK50RzeNMfDNwOITF/b5ctaluTqsQSaPXy9hCbWkrPAnwHep/l+F
	+pqN3s7/xSxVa9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0366139D5;
	Tue, 22 Apr 2025 09:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UhocOj9gB2gCYgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 09:24:15 +0000
Message-ID: <7ef0f26f-a689-49c0-bf64-37c1d8ccb343@suse.de>
Date: Tue, 22 Apr 2025 11:24:15 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] brd; pass a bvec pointer to brd_do_bvec
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-2-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250421072641.1311040-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1173E1F38D
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,lst.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/21/25 09:26, Christoph Hellwig wrote:
> Pass the bvec to brd_do_bvec instead of marshalling the information into
> individual arguments.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/brd.c | 35 +++++++++++++----------------------
>   1 file changed, 13 insertions(+), 22 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
