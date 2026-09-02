Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D5F3BB115
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348931; cv=none; b=Bt+qx4tBhgUrzKvEIJfuywFsUx6sTl2onMFYBT4enjOqy8YPn2nsxXPEYjdmT4UCB5ctEHIeQ53L3TmRE0txeZaHZysqFYyf6Ik+93NWF5qwK8Tankol9hW8QSOgpzazERtAnin6oVdMxsdwTmrMNbPsAnDWLneBcjeU5pEpUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348931; c=relaxed/simple;
	bh=gvfLWAi/E5B9PTHk65JL8jITynk7Hx82tS1lgGfrLDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqbCcgD4GttIiCvb9HA4gIKAKv73um8MvivXmaeqDVitl5SQcrNvoAMDuEgDl1Rmyo+ykP94w4yK2IO0oMoFy+D10hC6m0N8P3ig8ft54Q2dTi/dld4KWjEk/kBSGtXXHWpyLkv3xKfG9ISKYUqU3NhvH1wMw0K3GDP0yJTjOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FCfJ1E9e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qf3pF7ck; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AnwMusCH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sKVEOPge; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FCfJ1E9e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qf3pF7ck";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AnwMusCH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sKVEOPge"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B7C851F7C4;
	Wed,  2 Sep 2026 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788348916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LIxcUlVmkaqf9PlRx+Jcxqa7LBviWNAQp0ES3BDubc=;
	b=FCfJ1E9eW1IqkSZlh/vYXC3/phn3n11+5OaLbHO83dklzIapaSWbceDb4/I4j7DAHo/n36
	mcU/jxnr3FJYAstoZavwWMTbBn6moZfAnTYfOeMkp43flCNIMMG7uhXV+005FvTdhMsEg5
	21UWx6LXFMZfJO7PRdd0S6vwiOfnaHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788348916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LIxcUlVmkaqf9PlRx+Jcxqa7LBviWNAQp0ES3BDubc=;
	b=Qf3pF7ckKEHaT8cxrCAaAY1MgO36/T1fJND29DsCo0Tqkj2mi6q2Zr3BBC+QGbOxKzgUGA
	Khn+YIjF73WfxBCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AnwMusCH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sKVEOPge
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788348912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LIxcUlVmkaqf9PlRx+Jcxqa7LBviWNAQp0ES3BDubc=;
	b=AnwMusCHudV9ojWH08ovIWwbBFZ8VSH2F45Ys+Rn9uE/S/NAtz1RtvDyj06zvfh5bmG6mx
	xC3ocnhW3LtSzF6qFbWNLgSfsKz5wKNqEcXwgXzXPcmhanZqHCe0UFrEwzp2IsTYsx2xrm
	kgek5cUdMBWt0P0m04YaD5BIUnO0U7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788348912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LIxcUlVmkaqf9PlRx+Jcxqa7LBviWNAQp0ES3BDubc=;
	b=sKVEOPgemX4h7xEjVi/IT3+5B/YtukZy+n3+bJYOZkE+drZoVABvhY5qf8df05FBROTkJ9
	iJ0Ns2Yc0kGBoUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8957F13736;
	Wed,  2 Sep 2026 11:35:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ADngIPAJmGrFYgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 02 Sep 2026 11:35:12 +0000
Message-ID: <68259afb-32dc-46bc-8dd0-4cb1b8b288df@suse.de>
Date: Wed, 2 Sep 2026 13:35:12 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/12] block: simplify disk_zone_set_cond()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260831034109.744039-1-dlemoal@kernel.org>
 <20260831034109.744039-13-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260831034109.744039-13-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: B7C851F7C4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,lst.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On 8/31/26 5:41 AM, Damien Le Moal wrote:
> disk_zone_set_cond() is used to set a zone condition afer a reset, a
> finish or a reset all operation. For a single zone reset or finish, we are
> guaranteed that the target zone is a sequential one that is not offline
> nor read-only (otherwise, the operation would have failed). For a reset
> all operation, there is no point in calling this function for offline and
> read-only zones since the condition checks in disk_zone_set_cond() will
> result in nothing being done.
> 
> Simplify all this using disk_zone_is_offline_or_readonly() in
> blk_zone_reset_all_bio_endio() to skip zones that are offline or
> read-only. This change allows simplifying disk_zone_set_cond() by removing
> the zone condition checks. This change is also consistent with the fact
> that conventional zones can now have the offline or read-only condition.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c | 26 ++++++--------------------
>   1 file changed, 6 insertions(+), 20 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
