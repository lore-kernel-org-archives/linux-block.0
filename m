Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394339E177
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448157; cv=none; b=luKdnP4QHSqdjRoHB+z4i/UtvAH4nssawa/2iCm6LGMzgkx8kG+kpOxGV1b3RnE/KE/UljaUsCdtVh91uHPMcfv7LA8RwJxCPmN6tnFVahTXnIcwYlXFLHiDGuvh1C2DLMsRqWFeAokgNsTgSvRkwythXJCSTMWj60Y7hggpEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448157; c=relaxed/simple;
	bh=jSSdlVZ3Gh/T8uMtL5pYBwbACGAKtR7GEr9CjlzDXT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOdihukip227qmzPgYobDc1hX02h1K4NFVO3BOB1LWzpx0Y3FoQE6rtkk7FqR2ekQwhSuQNXVQDVPDqOw2GtGlVXlKtTn75LfVJ2uv05/h038U6p1y8WHd/7FON+RLJo+HIbmUVovWkkdVddP7Z1tPiMI+HrOsfvcXxbrMRwKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F1t+BXRQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mDquoNBL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jGGtcVrn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CnoTQj7d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F1t+BXRQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mDquoNBL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jGGtcVrn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CnoTQj7d"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07D4181BB0;
	Tue, 11 Aug 2026 11:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeKakSDSeknr/ruoeidXD/FyV6b7JlXrCH36l8bfrsY=;
	b=F1t+BXRQ76ilZudAITGAc4+tZExjscC3fjMV9BW0icWGo8yNjho+1GLrQqxtJQK5V4OU+L
	EQggFfHGXLrs/MXgfWMi0leqi3XKqdK1ZYj91248MhR9Ee2zFQ8vkn7/NsOMPcxrukHT30
	9MDLBrpRrGjLpml+YNCuhh/fpuMskhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeKakSDSeknr/ruoeidXD/FyV6b7JlXrCH36l8bfrsY=;
	b=mDquoNBLWu9xtIYCfq3A1CVUH44Rs9fMNgS1X7qaUI4kGCwkYobN6Abcx2NduN/MgmdGCv
	bonMyKQPLEWLbxDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jGGtcVrn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CnoTQj7d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeKakSDSeknr/ruoeidXD/FyV6b7JlXrCH36l8bfrsY=;
	b=jGGtcVrnHoIHBDKdSP9Tabb9Qb1NaVOYZF2I9eJcdr1XdFpNVIqKUJrm+OCV3Kl9oRf+AE
	CQR0kweXyjyI6T0WPpZTrff13ynm1Bv5c5OVK02EvGv7avWXJVuPmrKzT5DjtQ4RfikHed
	B6z75qxkGrsAorrsJA7DwG2nlWZg6Ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeKakSDSeknr/ruoeidXD/FyV6b7JlXrCH36l8bfrsY=;
	b=CnoTQj7dhZZH4gA/KCas1FV71jgwhhA9/6rg+0UdGWqP9lcXCzY2EdHjWvkGJAxEx1H2/r
	pSkSfc1nDtbDsxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E053F779B2;
	Tue, 11 Aug 2026 11:35:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CgNeNhAJe2rIdwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 11:35:44 +0000
Message-ID: <a5e58173-11ca-422a-b68e-0e574efc9e1c@suse.de>
Date: Tue, 11 Aug 2026 13:35:44 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/13] block: propagate readonly and offline conditions
 to zone write plugs
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-9-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260811105852.1245357-9-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 07D4181BB0
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 8/11/26 12:58 PM, Damien Le Moal wrote:
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
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-zoned.c | 55 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 46 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
