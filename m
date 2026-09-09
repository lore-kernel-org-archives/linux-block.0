Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607D48E0D7
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944993; cv=none; b=Q2j/BHV8PwOCgwX+sdiGM0BtXzVmidik2+U9zm+gKbC6UymXCf3UVpg1j8e4cUoBjm17ASu1Xr9dMHkNoUwDc8fn9S3Gmb5/5BquiTP/0+D8xBSGA6k6i7CcnsPViEhieIwHsHNWtCjPn9HYpQiA1jcWJiIAPqyBmPrYLbMYUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944993; c=relaxed/simple;
	bh=xPSGfrnoQhUqWMsY1C5FpInR5Ny/IomIRDroP65CPvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxEFpeqclcZnQP7zwMYlOiHmcCItY+jrlVE1BkLU08WjUJbE6OG6TyO1lH0RFRHHp0uHf1GVAhr4Bu8qz5QQd1Kowff598JUkLf5oZxOYEjToxWj9EjGMITZToAApJD8//GZ0PbON2l5VdU7PwxtrS0PqmnpHnp3XHUaA2ph5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k45cVJ9G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZMJqNhTp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X06QlGiD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MANmLaQf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k45cVJ9G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZMJqNhTp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X06QlGiD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MANmLaQf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46E7021A31;
	Wed,  9 Sep 2026 09:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26miKsNSktnio/oessRxqG3b/AxETMl+hhrg5Cdhm5g=;
	b=k45cVJ9GTFOarUYWquE182I+yKVB0tbmHALbZ2ZxFWeo+2oDJ3DehC/DjaKh60Z4ZyFiWb
	KBv9cGzLzmhAMRb9dESf6DsaH8SO0+ilykjAEfKgxK4d0IfmTFkCW+BfcvqWxZ2O7jkvdN
	GlcYZfSp2ZclOV+0aLcjS/JvJ52xIWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26miKsNSktnio/oessRxqG3b/AxETMl+hhrg5Cdhm5g=;
	b=ZMJqNhTpfpd2YBoeuddESoAGBC3bmZmtMbJW+u6klUnQgDIvpXHrMM4vUM5RKpL5KJTnrL
	jDgD0EzG1dvF0/DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X06QlGiD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MANmLaQf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26miKsNSktnio/oessRxqG3b/AxETMl+hhrg5Cdhm5g=;
	b=X06QlGiDxKQ9SlqmM5R3V6B4xpZxZ3sOSJAa0SYPki/uAUUv/W6a2yPmePM3Xgac2akqnS
	oq3TjeSN7ptqBJmba4u/UAiZe56fU5Pzx+EB8FE4ucCpGcH4CkPJ3+3uJH7u/N68Kun4+u
	HaIK+V1Hi3NDNXJxFj19W7H8u6rPk44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26miKsNSktnio/oessRxqG3b/AxETMl+hhrg5Cdhm5g=;
	b=MANmLaQfxwjX3e1rYklpL2oc6xoIwcPQYqFOJSRfoZcEqvtBdKwiBzltSF8vOxJ2JP05yz
	Fl/hwlFFOz81h9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F1771352C;
	Wed,  9 Sep 2026 09:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 10kkB1UioWooXAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 09 Sep 2026 09:09:41 +0000
Message-ID: <56f483a0-21b2-474c-80b0-0bcec204f13f@suse.de>
Date: Wed, 9 Sep 2026 11:09:40 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/16] block: refactor disk_update_zone_resources()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260908085745.1082697-1-dlemoal@kernel.org>
 <20260908085745.1082697-5-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260908085745.1082697-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 46E7021A31
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On 9/8/26 10:57 AM, Damien Le Moal wrote:
> Since the function disk_update_zone_resources() does a lot of checks
> beside updating a zoned disk limits and resources, rename this function
> to disk_revalidate_zone_resources().
> 
> To keep all the checks together, move the capacity checks (including the
> check on the end sector of the last zone of the disk) in
> blk_revalidate_disk_zones() to this function.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 64 ++++++++++++++++++++++++++---------------------
>   1 file changed, 35 insertions(+), 29 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
