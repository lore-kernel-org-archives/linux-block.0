Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD6A59
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098787; cv=none; b=Lk+hSEhvzl9BjlLB7yHunUm6ayYU9Sf/AxBcStbaoakdnNSXgTmgLHzJQ5mmz2nFjTNmtc1qcIu9PJoQweTD5oWs7fWXnC5rWFgAzumAKZunARYz8qSjmqa/opxe7RBBQ7TXn72lIVVsy0LMn6PI+W2Nu7J0ZdjnazJPN9TIZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098787; c=relaxed/simple;
	bh=Kse6xEAX/RV/s7MSSfl4XdtSf8g6Wi9KGzYC3pfEOl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkgPfOwsl3XccOgZx/PnvxJeHxHitDTlYrS7isCU7SyspB26SlpWLG99EGLRfsXJ2dvhReZwoT66hmsgDpmZssexloiLCaWJqJmOCCegbXB/PeqE7llgSF2kVSY63WPK3nVr3s+IDGXPDUGStv9rfww/uJ6F4bLgY2xdQp+VeYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sw7GH+BK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YPFnXSJt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lXqoaVcS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0p7RyVFJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sw7GH+BK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YPFnXSJt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lXqoaVcS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0p7RyVFJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DE688056C;
	Fri,  7 Aug 2026 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786098780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/MEymfirQVhQvpkIBjE4LOkL3iNdFfPzGm+UN7uWtQ=;
	b=sw7GH+BK0AXTfotPZetRE9SwMEV4/H71k11GG2ESZTldJ7SHeKkTifqImJ9xnVEYTD5Rxl
	MvzbLChs2vRX15/FQO3M1CEFCdFEblCoEs/wJoKveUaYc55NapjbEsxiVGT2kJnHU04B/L
	X4WXhXg4cVmvXuwHhm4AMIOgobT4cSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786098780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/MEymfirQVhQvpkIBjE4LOkL3iNdFfPzGm+UN7uWtQ=;
	b=YPFnXSJtJbyz7JKk+2fQswTRsopghLJySulkI/g7IpUorHjRd+yd6g69tf/ua2Y5oPIePh
	p+0kFLr46JE9a1Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lXqoaVcS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0p7RyVFJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786098776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/MEymfirQVhQvpkIBjE4LOkL3iNdFfPzGm+UN7uWtQ=;
	b=lXqoaVcSD3no/4ZjgBy0IGHqOnvQuMfXiZZqtQLt5CVAg2zEUJQBfJi0vfuo9fLNYZ0LFw
	33ngRdn6B1T1bMl9GFWBlJO+CMmrUgAUwtV8e8sxm+DWsQVgWcSOxTjIYfFFmmJNzmsK4u
	TBp6DyWi6LIMgD7eFB9HiBx1MMeBl0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786098776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/MEymfirQVhQvpkIBjE4LOkL3iNdFfPzGm+UN7uWtQ=;
	b=0p7RyVFJD2ckPoO0FKLDA6raLsECIJiq0GpPgHgeni/o2Bs0VHa1VxNHdhTKX47/L09+h/
	2ehmFaxBSferURBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AE5D779B6;
	Fri,  7 Aug 2026 10:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yBthEVi0dWrkSAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Aug 2026 10:32:56 +0000
Message-ID: <439ef998-f11c-49f8-bba0-7e1114e23420@suse.de>
Date: Fri, 7 Aug 2026 12:32:56 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] block: propagate readonly and offline conditions
 to zone write plugs
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-9-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260806160445.848337-9-dlemoal@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 5DE688056C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/6/26 6:04 PM, Damien Le Moal wrote:
> When revalidating the zones of a zoned block device, or when handling a
> zone which has a zone write plug flagged with
> BLK_ZONE_WPLUG_NEED_WP_UPDATE, the function
> disk_zone_wplug_sync_wp_offset() is used to update the write pointer
> offset of a zone write plug. However, this does not take into account the
> condition of the zone, which may have changed to readonly or offline,
> which in itself will always cause errors.
> 
> In order to catch such errors, rename disk_zone_wplug_sync_wp_offset() to
> disk_zone_wplug_sync_state() and in addition to the zone write pointer,
> also update the zone write plug condition if the zone is readonly or
> offline.
> 
> This change also requires changes to how a reset all zones operation
> (REQ_OP_ZONE_RESET_ALL) is handled so that the offline or read-only
> condition of zone write plugs is not overwritten with an erroneous empty
> condition. To do so, introduce the helper function
> disk_zone_is_offline_or_readonly() to skip updating the condition of zones
> that are read-only or offline and that do not have a zone write plug.
> For zones that have a zone write plug, the helper function
> disk_zone_wplug_is_offline_or_readonly() is used in
> disk_zone_wplug_set_wp_offset() to not update a zone write plug write
> pointer and condition for read-only and offline zones.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 52 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 43 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
