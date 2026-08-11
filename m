Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091A43B3D9
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448191; cv=none; b=SlcCUhkDPPmUjNtUz6WLHC/qHT9b7NZr3jHv9JWlARzOlNorwI7JGxEXrCwpURX3gQy1DsdRcnj8LmM6BP5GOqqABjjGKcE/P+AufGuQKsy8WPHtL+amvhGCR4L1ad0EW7EDM7/pKRR0F9Eky5wds3A38DVVJQgEaubFpOmvhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448191; c=relaxed/simple;
	bh=FGGczERqp7fnjhKxPHKCV67/UHqoGVboFcQ7E3DU9DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2nHkZcmWihPEUoSKULLOMH4mGqyE/k7DNgFvZ6apYAddUSrP6XM4E/FYxYHFKJPb3P1QZ3bkXD3zyaxsBqCtmT6O2eObQxbr0+wvPIRhElnrvdBuCVBU/yOlqBW2PKQMZCIFJmF/Gk7Ac1SQ5mzJjgeGkqM8wMrONCKug9euLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZnU+JCLI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ePbHlmZW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RQJ+zu5e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b/HTe+kC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZnU+JCLI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ePbHlmZW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RQJ+zu5e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b/HTe+kC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEACB819E4;
	Tue, 11 Aug 2026 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEDMWZDd1WhSyhq22+alxpejgZgcBUPSdTYMA5kFwl8=;
	b=ZnU+JCLIDkv8MMPPMPdAOtq95WnIr2REJbSvje5SOzvj56sQzfObZALQQJRv/sLkZxDcyp
	ib+A5MrhAyeb67yma1Amq+JbeI4oIjCOsLdYLzh4/Q/qxKjpZkQG5/WrhPMJ806h5PjYdn
	htD23SOr88dnkE0L3TDdkbH+WJgE/Zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEDMWZDd1WhSyhq22+alxpejgZgcBUPSdTYMA5kFwl8=;
	b=ePbHlmZWPzFZKt+Q314gWES3VfgtYoGC7XsIwEOkMYAtJLMaMnbjC2wTAvhnpsqs5kAxyU
	ZhjeCJ1mXFwcaCBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RQJ+zu5e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="b/HTe+kC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEDMWZDd1WhSyhq22+alxpejgZgcBUPSdTYMA5kFwl8=;
	b=RQJ+zu5eSKBJTBnkiBBoVPmgTUTN0Hy04MSeS1Sf/nPVksYMEdq7HxKKz4nWXgcZybzfD/
	7vPmwI6XN5uyvntXJNLjFxNlEYTVcJd0hJ4Djz0QR0zCSTenRYcmKIygjNOudR+7CQGBp1
	D18/isSFijyR3WgQsVUWkvOTY6p6okE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEDMWZDd1WhSyhq22+alxpejgZgcBUPSdTYMA5kFwl8=;
	b=b/HTe+kCPAlXcFCVEoK42lYX32QGEJe72QBMQpH7mqO1B8uSD30RNFqBXsS5Y4E7WhoejD
	gm08XhkxvZrtuPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A32A779BC;
	Tue, 11 Aug 2026 11:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k+M7JTMJe2rudwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 11:36:19 +0000
Message-ID: <f6f95d65-56ac-46c9-9b08-752fa0e045aa@suse.de>
Date: Tue, 11 Aug 2026 13:36:19 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] block: always treat offline and read-only zones
 as dead
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-10-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260811105852.1245357-10-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,acm.org:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: AEACB819E4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/11/26 12:58 PM, Damien Le Moal wrote:
> Since any write BIO targeting an offline or a read-only zone will fail,
> there is no point in keeping zone write plugs for these zones.
> So for any offline or read-only zone, the zone write plug should always
> be treated as dead.
> 
> Do this by modifying disk_check_zone_wplug_dead() to always mark read-only
> and offline zones as dead to force a removal of the zone write plug from
> the disk hash table on BIO submission. blk_zone_wplug_prepare_bio() is
> also modified to have the same checks to immediately fail a write BIO
> targeting a read-only or offline zone. With these two changes, any newly
> issued or unplugged write BIO targeting a read-only or offline zone is
> immediately failed.
> 
> Finally, disk_zone_wplug_sync_state() is modified to add a call to
> disk_mark_zone_wplug_dead() for the zone write plug of any read-only or
> offline zone found during zone revalidation or a report zones.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-zoned.c | 110 +++++++++++++++++++++++++---------------------
>   1 file changed, 59 insertions(+), 51 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
