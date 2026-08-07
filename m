Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B76463B75
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093968; cv=none; b=LWGSQ94YDPVs0yX5K6XmHzhG9QekU0eYj9Ha6foTAhSaiiPaTzIG4ml8EJhl1k7dYjs/TfiFPdZniX4uhdi6F7oA4LAGTTMOYXJHdhGy7RYhTYheMvy9OKw0xR6Y/cN53GJHqvgNj3HdIIr+8j2/uzl5ekV83JLrAnvZbuPa0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093968; c=relaxed/simple;
	bh=fPS8VtnMteQ2MErt/lzUTCbGDmgobsd0GKTwT4A7SJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKuS3ZAmsj8qRZ7sLflzYsBLaE9qLjwuUOaR5ba8W15uBCkkqcuyQ0R9JqUvCvMN46KZgfIMFj89nNgVfT99JEdqX0nHGChMCEE1EUB5IkwLv6FOlTNZqMNK5sNRtKkNG2UVTCWsk/qTIgubgallDOc6c8r6g8ZrHv5LWdAxYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qSP/jH+B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fjHEtCvD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RiX/UEOc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fXknKNj2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qSP/jH+B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fjHEtCvD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RiX/UEOc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fXknKNj2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E39CD3E1B;
	Fri,  7 Aug 2026 09:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786093958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4qaBi4bMhBRIAtd5y4gMTJSGgQXnzMZGrcAhYY39y0=;
	b=qSP/jH+BOpFHAamAIne44vgZ7aCeq4RtShck3atk+UyX12Zu/gx9qFlPF7yCaRlitjgCui
	e7ik5gv5fPmj0k30rAlEjsZtyiIcpzIPah+JGFxHhl8/L2JTPSvoBKOVEBZS79CQu0HNvX
	OANb/q57bp/RnmSeSimVznQW5qLE6vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786093958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4qaBi4bMhBRIAtd5y4gMTJSGgQXnzMZGrcAhYY39y0=;
	b=fjHEtCvDVGKZ+OECio+vqOPktEYy7Mc54HpgZIeCgca6OKJ6vYuNmGhIzbtO9LU2VDdRoo
	ZZ1YHHjxLgrr6IDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="RiX/UEOc";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fXknKNj2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786093953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4qaBi4bMhBRIAtd5y4gMTJSGgQXnzMZGrcAhYY39y0=;
	b=RiX/UEOcq+8vLZl9WtZ8kaRZ3O6gC9SWk95hU1wWlu6QpGVa9+gvdx5ATQBVwQPo846quO
	u7/iTWELkCUfkq8ekHXrd8BsHVZvSZbthCADvU5Yw7ByDAeSGS4I2UWJDGv3xNwKpEJ/ge
	IXukP3FcJrWqzh5GKsd6DWG4XYJfPdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786093953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4qaBi4bMhBRIAtd5y4gMTJSGgQXnzMZGrcAhYY39y0=;
	b=fXknKNj2gV1hVsba4Pb2Obe3sEHzq8inLcgXQ6y/+tLEao1ScklZA9K3f5BsSnNwp+vTKt
	DpZiM+Bk+vdGz/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6898779B6;
	Fri,  7 Aug 2026 09:12:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A/3RM4GhdWpxeAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Aug 2026 09:12:33 +0000
Message-ID: <9d8e5e68-ba48-4404-a42b-d705279d1ae6@suse.de>
Date: Fri, 7 Aug 2026 11:12:33 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] block: refactor bdev_zone_is_seq()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-6-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260806160445.848337-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E39CD3E1B
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 8/6/26 6:04 PM, Damien Le Moal wrote:
> Define the helper function disk_zone_is_seq() and use it to refactor
> bdev_zone_is_seq(). disk_zone_is_seq() is also used in
> blk_zone_wplug_handle_write().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 38 +++++++++++++++++++++++++-------------
>   1 file changed, 25 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
