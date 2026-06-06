Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B220E702
	for <linux-block@vger.kernel.org>; Sat,  6 Jun 2026 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780730830; cv=none; b=iBvYLbKqE/UrWuUOjp1fEXHOYZ8gA9DGTiJgdTd/FydVQHRmMosR+DA5zmqxqYJUhcdLScAMSOHGjvrJnuPD9O+pYr9/Jn3PIjXlF7eNdf28wMDc6aqL4eEhzKyWFpijL1Yk+zdRwMq8ZVMPZ13A77CBD7PHE2ZzSFdb93x/was=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780730830; c=relaxed/simple;
	bh=H9BvqPMhGTwjUGqQ/nhPPQ1S9rSVcigvJrteydMUf18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzIWL0l6Mjo2fgaXqnI2CyHRQcgTC3StiXTYfnSXCbQEj/CoRin2TUeSMJ50kg2BtiG4Xqr27xZJHI+gusZE4iiQCjj0VBI23BliLt9iiDrhsadNixJfFRVJi91TJsZMfl8dgTIMoUcCgtFGh0eSPq16W7lEsJMs9oatjxJrQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMb3Dz9w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P1vlZfrp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMb3Dz9w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P1vlZfrp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMb3Dz9w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P1vlZfrp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMb3Dz9w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P1vlZfrp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CDC2758CA;
	Sat,  6 Jun 2026 07:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780730827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKQv9nUSGn/OFq7QahY19As0nQO6eXc8oWwO0yTC6ic=;
	b=TMb3Dz9wVjORx9tEkkT3xopFPDlMp4Cdp+4PDkVHbF05XYP/hHoOd6jr3PuABizxX4SRng
	Ezh70cEY8ba/EZM83MwVM/sMxxoh9FwBIC4kxkZBSLg2D2bKRh8JBDZ6qxb2L+RLwtTNGv
	5p9PXFWv5SqN09nFSdOnm5QNh0/9gGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780730827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKQv9nUSGn/OFq7QahY19As0nQO6eXc8oWwO0yTC6ic=;
	b=P1vlZfrpI+GfkpYPmtxJffanfV2fMAXaSUoBTzmheY6pTHqLQ+1hex5NEM8MTM+brf3RWX
	Zn/0CR6BVX+QRiCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TMb3Dz9w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P1vlZfrp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780730827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKQv9nUSGn/OFq7QahY19As0nQO6eXc8oWwO0yTC6ic=;
	b=TMb3Dz9wVjORx9tEkkT3xopFPDlMp4Cdp+4PDkVHbF05XYP/hHoOd6jr3PuABizxX4SRng
	Ezh70cEY8ba/EZM83MwVM/sMxxoh9FwBIC4kxkZBSLg2D2bKRh8JBDZ6qxb2L+RLwtTNGv
	5p9PXFWv5SqN09nFSdOnm5QNh0/9gGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780730827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKQv9nUSGn/OFq7QahY19As0nQO6eXc8oWwO0yTC6ic=;
	b=P1vlZfrpI+GfkpYPmtxJffanfV2fMAXaSUoBTzmheY6pTHqLQ+1hex5NEM8MTM+brf3RWX
	Zn/0CR6BVX+QRiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 682B1779A7;
	Sat,  6 Jun 2026 07:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t3t7OcfLI2oRCwAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 06 Jun 2026 07:27:03 +0000
Message-ID: <e41e442c-3191-424b-aa83-fc63b10b47ba@suse.de>
Date: Sat, 6 Jun 2026 09:27:00 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] block: add a str_to_blk_op helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20260605184441.590927-1-hch@lst.de>
 <20260605184441.590927-4-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260605184441.590927-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4CDC2758CA
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/5/26 20:44, Christoph Hellwig wrote:
> Add a helper to find the REQ_OP_XYZ constant from the "XYZ" string.
> This will be used for the error injection debugfs interface.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/blk-core.c | 10 ++++++++++
>   block/blk.h      |  1 +
>   2 files changed, 11 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
