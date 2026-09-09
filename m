Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD449AA31
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945100; cv=none; b=Px1zgNIO4K1x8/IY5SS53U9S7CEC0oOrRdSXTrkBZ2gaVmjM3/eiQg9SaealaftwXbGSejObZ+miK+6NClVzEBcx31udfc32ynh+BX7GkP07MNYBrEj9w6MZjdf2agFycnk7BRnLPy0hj8ZpngnctA9eAg4sRcdUUAgXYI9yIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945100; c=relaxed/simple;
	bh=88rQ7C7L+XiNgXQNo/dzktWudzuXdpg6XYc89O3CM08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6nottsU+0rsRdKq2a0r3IUj/mz5CBtrffCdH5kDQ1QD7rTnJFo2UmCet36oKcY3Wthgbq7w7J26iE8704tqMqpUq2GakjuM/1e03L2hXz74YuKrhSXEfhz1AxB/wdM94ELMfGjqk7CEcpDzgyVTBYuVMFSqIP87ZwI5BaddXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E6l1W84V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WQzjdFQA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=thndoz4v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rqzdl8aW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E6l1W84V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WQzjdFQA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="thndoz4v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rqzdl8aW"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50CE61FAB9;
	Wed,  9 Sep 2026 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788945092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hJCkWWR5fb9EozXcLM0YP5IOQmYfqf6veMj+ItgX2o=;
	b=E6l1W84VyBNnhC3NR+XAdxNOPwVCfJBRkzNCxYs+4yj24/Bfws4MikiTw2vvySZv1+VMrt
	+FFV/Gu6QYAo1WQn0j9aDQ0nTkXutDXXA5FPYEtZtAkN9kxPkp3cWZA4Eqohsr8weSd45d
	IEWss9ZS+7MQY23ANG37oBsw69dz+sA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788945092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hJCkWWR5fb9EozXcLM0YP5IOQmYfqf6veMj+ItgX2o=;
	b=WQzjdFQAuYCCgr4fuSFpj5PEsfmksWMU0oZ/c4wwb8lQeMAm+B0jIbGiEUFSfdMbYugl/h
	bMC9bk6298+jOlBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788945088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hJCkWWR5fb9EozXcLM0YP5IOQmYfqf6veMj+ItgX2o=;
	b=thndoz4vD6hss0/Q4b6WnmmdlUPQ9aSptiXdSUFXSVuLplwIPS+6VRs/0zmItQxrvxYeIo
	Bt3Mx+6tkPgIe4/CqRbp9zuckLBhpumFXV5SwR15s6E/cWwkyCvBS/0gRURY27rMwGvvjT
	uM6teyvSROC9nL9ND60Ysjnz+aVWJ80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788945088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hJCkWWR5fb9EozXcLM0YP5IOQmYfqf6veMj+ItgX2o=;
	b=rqzdl8aW9lQYLMtBcfVOd8QueGFEycdE2fMQVK0Gi5f0pkg7978ODXGKpLkbAbi1/nsjuV
	5oXALIeu5bAxMSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 225121352C;
	Wed,  9 Sep 2026 09:11:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qfvwB8AioWrgXQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 09 Sep 2026 09:11:28 +0000
Message-ID: <0f71a94d-a796-466c-a801-6549b6656cbf@suse.de>
Date: Wed, 9 Sep 2026 11:11:27 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/16] block: improve blkdev_get_zone_info()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260908085745.1082697-1-dlemoal@kernel.org>
 <20260908085745.1082697-8-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260908085745.1082697-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO

On 9/8/26 10:57 AM, Damien Le Moal wrote:
> Add a zone state array bound check to ensure that like
> disk_zone_get_state(), we never attempt to access the zone state array
> beyond its size.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
