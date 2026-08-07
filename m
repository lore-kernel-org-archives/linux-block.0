Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69DF207E00
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093436; cv=none; b=A017LLApbFNuNG0sTRpK6RC9RnLFfOgKticGar6bTmPogSfX+SdkNiyOaYrQPNXPE970bkNwF+ijlr/YtK2WreCj1iZww0hzzk6JjN9XvBfkqNwuItXT6k8aEvVQbUzE6XX0gRmRTR/aHB7Sh6vS0hFzwmLfVwBijcu4MTadm70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093436; c=relaxed/simple;
	bh=NImULWQBLQjbPXwbdhJrLHg6pDkiJkX8Pz/wMx10UO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+tBnN8q39izwTIICNKlF+0sOFd5je3t65JfhqqczoRTan26LqVbNPUs3dj8wXAh7B1foFo5EwO7ZSDoQH5fiIC02bf4UGFmnJeSOiFA1h3umYRk609trWgaR/EJZWpwUj4E6pJVvAwf8SGAXPfkH1FSNM9qgGMggqoyckW9x1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aDlDBpdG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pIst1ZLJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dn4J6xOS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SF7qTBPM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aDlDBpdG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pIst1ZLJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dn4J6xOS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SF7qTBPM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 968828050F;
	Fri,  7 Aug 2026 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786093428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiXgSUoH6+gEzkHOKU2pb8Pb9Y5LDqe3y7MzP39VzqA=;
	b=aDlDBpdG7kUdGp/R28IkWbmy+9PAabgZAJKR2eO3qLTUE2iL1uW41CfNBuOFwRRYWP36Pu
	0zwJeU62FhBCMV7XzXgZaXbhcDxjcAFpOefmPmCLJIbHeXlc8HNP3KiRcPP0zQYPQO1EPn
	qVo7kNQS4n1f2UotlZPt+VTD7iS8b/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786093428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiXgSUoH6+gEzkHOKU2pb8Pb9Y5LDqe3y7MzP39VzqA=;
	b=pIst1ZLJfaoD/5VLajkr7eCYGfzymbQeq27Esg/FTBYNVdx1RkK4O4c864H5VFVAeku3Sm
	7uIPRpD19xthCYBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786093424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiXgSUoH6+gEzkHOKU2pb8Pb9Y5LDqe3y7MzP39VzqA=;
	b=dn4J6xOSaSjiMznZp+qb/6Fd2hzVF18YlgFjLFenMkhnP3tTmGCJ6a/mZu62xG4PVFEPLI
	DW7zqVg5JTrF3M3vKNNgmpQvUzTC0aq8JI3R4AB2uo1sPOYJ8izv/KeELvKOWiwkmoAPhE
	RzxaUHloOvlhE7jplNf9xZmVhbLzCWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786093424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiXgSUoH6+gEzkHOKU2pb8Pb9Y5LDqe3y7MzP39VzqA=;
	b=SF7qTBPMXDisTGUnA9n1o3kdz/UXZMcdlrH/hnBbxpPJ0iGwxuejf325HAq86Xe8nKz/l2
	Dp84zXFFi+s2OhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 853B2779C3;
	Fri,  7 Aug 2026 09:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6rEfIHCfdWojcAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Aug 2026 09:03:44 +0000
Message-ID: <f0f36b47-59bb-4add-bee6-19fda2834602@suse.de>
Date: Fri, 7 Aug 2026 11:03:44 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] block: refactor disk_update_zone_resources()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260806160445.848337-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.973];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On 8/6/26 6:04 PM, Damien Le Moal wrote:
> Since the function disk_update_zone_resources() does a lot of checks
> beside updating a zoned disk limits and resources, rename this function
> to disk_revalidate_zone_resources(). To keep all checks together, move
> the capacity check in blk_revalidate_disk_zones() to this function and
> simplify it by moving the check on the number of zones before the call to
> queue_limits_start_update().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 46 +++++++++++++++++++---------------------------
>   1 file changed, 19 insertions(+), 27 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
