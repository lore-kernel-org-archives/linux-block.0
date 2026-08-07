Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1D40A956
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098282; cv=none; b=UJ6zEyHIE76KnbLV548mW+JKc+FjW1rKwhIFSBbIqysJLvDeeRduaP7YRvHXddaKJhkDpy8OcHq4inDX3mKJ5wdcATCnN8thN1FIg2359+dkPtfF4rfP48lWyc2W1QYDr6CiUqDXjsfczjpYzp7Ck7yA0LOnG7NETCgVHguN7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098282; c=relaxed/simple;
	bh=YmwqSah5XaGggOC+sIxCbD6KKg3PuHmkEuSxutwElKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUVBpF33ddgP/68cj47fgCbAOPdvtQn/wJ1nS1pbn/57XG6i8/cYFuHFTSLjExCd/3NSopJpLl9m4SpcNeCzZBqasEGkdHrZ3BQ2km0ZtYhupV7LMzeXXUYBGGhxMy6HbHJ61MILq4TGP+0AE/4SQdQXHH0RZXRCJjOaS8keUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TL+8yf33; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2vpt+/D2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AfUoqk3E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UYieytDr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TL+8yf33";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2vpt+/D2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AfUoqk3E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UYieytDr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D416180567;
	Fri,  7 Aug 2026 10:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786098275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zb51889hfm5SERv9efoQch+0Lrxa1pqLxhlw+dKXEY=;
	b=TL+8yf33+EwqohAzPCwFZlTP1yaPXB9l9TAwaTmr+wEiwIjNYr0JO7IIif13PlZUK2IdIz
	AWrT6mS4VJADUB7r17WnrDYoTaK7xt8qBqbzQJ48R8xt3ZuZnLb+XKBDGvmwAOYZgq4ygZ
	B0k/3xDU6nFvFTIDa78VUSMjTIgDS+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786098275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zb51889hfm5SERv9efoQch+0Lrxa1pqLxhlw+dKXEY=;
	b=2vpt+/D2XPOhUmSmbrYjvMaLAb/HECwF5rNlmnfFybvnHmtSY1tvgJdLktx4IvLN0XUb02
	mMQKsXUkrfcW6nCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AfUoqk3E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UYieytDr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786098270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zb51889hfm5SERv9efoQch+0Lrxa1pqLxhlw+dKXEY=;
	b=AfUoqk3EWOKkgthOs0Eozig95XWJl6ZTf8G8X7bJTvoIoQ92tvLV+o5B+2QjtT9hL3EDq/
	AJD3JHEnFNCYOsCs4I9DFP7QXhITIij2D0vRkGrB/Se4fImU/7KRmXAbNg+1XliCPSrQOs
	inw8B+oNDZsp3ypuZrn3Zp7I6KcN0Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786098270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zb51889hfm5SERv9efoQch+0Lrxa1pqLxhlw+dKXEY=;
	b=UYieytDrJhQDP/ymu/BLTzcnzSWmO7t3RV+2sg1YJBBbnpcY8lzINUuwQW/5m4G9w1Ez1+
	SzaRXSrhftMvduBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5F76779B6;
	Fri,  7 Aug 2026 10:24:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x7byL16ydWpTQAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Aug 2026 10:24:30 +0000
Message-ID: <80d6a196-6a6a-4880-be4d-be35415abc12@suse.de>
Date: Fri, 7 Aug 2026 12:24:30 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] block: drop all zone write plugs on capacity
 changes
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-8-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260806160445.848337-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: D416180567
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/6/26 6:04 PM, Damien Le Moal wrote:
> If during revalidation, we detect a capacity change for a zoned block
> device, e.g. due to a storage element removal on an HDD, we can assume
> that the device was reformatted, which implies that all sequential zones
> are empty. For such case, we can remove and free all zone write plugs in
> the gendisk hash table by marking them as dead, thus avoiding also to
> leave zone write plugs for zones that are beyond the new device capacity
> in the disk hash table.
> 
> Introduce the function disk_revalidate_capacity() to do this and call this
> new function at the beginning of blk_revalidate_disk_zones(), so that the
> zone revalidation process can re-create, if needed, any zone write plug
> for sequential zones that are not empty.
> 
> The checks on the capacity and zone size that were in
> blk_revalidate_disk_zones() are moved to disk_revalidate_capacity() and
> if true, also trigger dropping all zone write plugs.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 71 ++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 55 insertions(+), 16 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
