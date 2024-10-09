Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3128EF;
	Wed,  9 Oct 2024 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454589; cv=none; b=nZJRPjsavbmd3Rq9IoNZ3mIglIqWx39QzRApyuymz8ZuSH8C1CGpVEZsJe/A9gMTT/MJwAP8bDxxlth/+qM9KhxQJ2P91WQl6v9OmbavuYUhgnjmab7aMgGF135zmkcKcCuppQdTo8B8RbkyTn7p1EzwfknUBzQNB/lV64+bezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454589; c=relaxed/simple;
	bh=yjwBsFGC9My5rObOK3EFJoIwwNtyYgoFoZ1TfQoSxiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEsHB0DTzfuNc4gDbLVJtjcXqD/X6ROR4QUnOAIMP/SHdjASJQ/+4kUkG/FiiNUvuNB5nmt1P3oRwJqFZw0wCUYgR9jZo5C1r6FOXD988wkYSCHvI7m0xnR/ftHKPBJBmBoiV0Ve4kO24jm9oIEqJ1zibAlUdXESGul2BHNyLns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1/lJZdfG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NwAhINPK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1/lJZdfG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NwAhINPK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1/lJZdfG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NwAhINPK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1/lJZdfG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NwAhINPK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D0EB1FE73;
	Wed,  9 Oct 2024 06:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728454586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R8UMdCYJ6u1qdjzgLSTWsSDbL2ji3UrqXX3eFvXSy4=;
	b=1/lJZdfGjiZ+7uPaiXe8MiZumN6mcL97DUThe+ZUc3fo3oefjYcgqMORKY2wov1ngdN/w7
	zjf08R7sCJ64lIP/aFB/HKqMHV/LAyGeZRj3+2Q6ctyMZEiTUY1TV19pFhY16yS8iT5fVh
	KiM3rez/9ywM9KPtLwXPRoKTF1mzHu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728454586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R8UMdCYJ6u1qdjzgLSTWsSDbL2ji3UrqXX3eFvXSy4=;
	b=NwAhINPKyVLEFLzpuokmrQahsKghdOu//b4R73gG/9AV5X+7wvHnDIAtvBOnX6/yt4QscJ
	zNk9/jUfsooLCmCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1/lJZdfG";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NwAhINPK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728454586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R8UMdCYJ6u1qdjzgLSTWsSDbL2ji3UrqXX3eFvXSy4=;
	b=1/lJZdfGjiZ+7uPaiXe8MiZumN6mcL97DUThe+ZUc3fo3oefjYcgqMORKY2wov1ngdN/w7
	zjf08R7sCJ64lIP/aFB/HKqMHV/LAyGeZRj3+2Q6ctyMZEiTUY1TV19pFhY16yS8iT5fVh
	KiM3rez/9ywM9KPtLwXPRoKTF1mzHu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728454586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R8UMdCYJ6u1qdjzgLSTWsSDbL2ji3UrqXX3eFvXSy4=;
	b=NwAhINPKyVLEFLzpuokmrQahsKghdOu//b4R73gG/9AV5X+7wvHnDIAtvBOnX6/yt4QscJ
	zNk9/jUfsooLCmCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0DEB136BA;
	Wed,  9 Oct 2024 06:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nRQEObkfBmfzJAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 09 Oct 2024 06:16:25 +0000
Message-ID: <a33f4ebe-de7d-479b-97d6-3d98e34ab94f@suse.de>
Date: Wed, 9 Oct 2024 08:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, kbusch@kernel.org,
 hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-2-m@bjorling.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241008145503.987195-2-m@bjorling.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5D0EB1FE73
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/8/24 16:55, Matias Bjørling wrote:
> From: Matias Bjørling <matias.bjorling@wdc.com>
> 
> The NVMe 2.0 specification adds an independent identify namespace
> data structure that contains generic attributes that apply to all
> namespace types. Some attributes carry over from the NVM command set
> identify namespace data structure, and others are new.
> 
> Currently, the data structure only considered when CRIMS is enabled or
> when the namespace type is key-value.
> 
> However, the independent namespace data structure
> is mandatory for devices that implement features from the 2.0+
> specification. Therefore, we can check this data structure first. If
> unavailable, retrieve the generic attributes from the NVM command set
> identify namespace data structure.
> 
> Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
> ---
>   drivers/nvme/host/core.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0dc8bcc664f2..9cbef6342c39 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3999,7 +3999,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   {
>   	struct nvme_ns_info info = { .nsid = nsid };
>   	struct nvme_ns *ns;
> -	int ret;
> +	int ret = 1;
>   
>   	if (nvme_identify_ns_descs(ctrl, &info))
>   		return;
> @@ -4015,10 +4015,9 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	 * data structure to find all the generic information that is needed to
>   	 * set up a namespace.  If not fall back to the legacy version.
>   	 */
> -	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
> -	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))
> +	if (!nvme_ctrl_limited_cns(ctrl))
>   		ret = nvme_ns_info_from_id_cs_indep(ctrl, &info);
> -	else
> +	if (ret > 0)
>   		ret = nvme_ns_info_from_identify(ctrl, &info);
>   
>   	if (info.is_removed)

That is a very odd coding. 'info' will only be filled out for a non-zero
return value of nvme_ns_info_from_cs_indep().
So why not check for that?
But if we get an NVME status back there is a fair chance that something 
else than 'invalid field' (or whatever indicated that the command is not 
supported). That then would cause the device to be misdetected without 
the admin knowning.
Shouldn't we add a message if we fall back to nvme_ns_info_from_identify()?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

