Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E96259C9C
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504504; cv=none; b=tXjSj3LXD4HVVw3HaMC8GmPt9bMME8tISLVmEFciOGnm5XDfrHNB1ioHUd6aNZ73wX++iROFBJYVFAbHkUL+h4jIqG7oa8oI068fQT3dCBZmC4cgiBx362DLqdUQWAubOgAySDyCBJb9xZuSm1UaYXMU6OqMh6K9BZOX0hsilPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504504; c=relaxed/simple;
	bh=94wH6VhOT+acCnVnfhMLiM/EB2G4NJPhcKqiinjbsXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvWdeeDdXfiwmk1Z7hbMjvL5zJRSb27lHrdZCR4LPbQ/pqze0cJFZZQZdbGH6yWP0hFIm2JaOynqbMus2RFFUrtgt8CRhryAkfI7EIpfRQL4rgdyq7djoUMvsR4dVh8x70MlAKwF5ZnSuWJDH3wFcvx5sh4RKP7lAXyePIYl1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uu8Lc5un; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZKDV89SL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uu8Lc5un; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZKDV89SL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uu8Lc5un";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZKDV89SL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uu8Lc5un";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZKDV89SL"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1AF02115B;
	Fri,  7 Nov 2025 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762504500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkOipS9HSNRQLh+gCWAaAkKMrglfx9LENWFTAIEcqVM=;
	b=Uu8Lc5unxs+QBKoJ/rFzxg47u4ySP15azrFnEDtroielHORAm0Z4kkvB5gjYQitkjKA+kL
	OJw9ulwcB1bBdUtaK6CxLYyfiF02i8pw2S4Mf25rrVvdXPOl+MqM7M9q4I4VSkp6F8+8Ej
	mrV86W2E+fNXqVI1Cp/RB+Q7XUVy20k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762504500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkOipS9HSNRQLh+gCWAaAkKMrglfx9LENWFTAIEcqVM=;
	b=ZKDV89SL8XAYZ1i/iFQhyYomqGDifylkEHlvKKypoaLsRICi9uTtq32ucYkTRJyeYBMonm
	l5HQ1DTZmF8i5LCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762504500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkOipS9HSNRQLh+gCWAaAkKMrglfx9LENWFTAIEcqVM=;
	b=Uu8Lc5unxs+QBKoJ/rFzxg47u4ySP15azrFnEDtroielHORAm0Z4kkvB5gjYQitkjKA+kL
	OJw9ulwcB1bBdUtaK6CxLYyfiF02i8pw2S4Mf25rrVvdXPOl+MqM7M9q4I4VSkp6F8+8Ej
	mrV86W2E+fNXqVI1Cp/RB+Q7XUVy20k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762504500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkOipS9HSNRQLh+gCWAaAkKMrglfx9LENWFTAIEcqVM=;
	b=ZKDV89SL8XAYZ1i/iFQhyYomqGDifylkEHlvKKypoaLsRICi9uTtq32ucYkTRJyeYBMonm
	l5HQ1DTZmF8i5LCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 985BF132DD;
	Fri,  7 Nov 2025 08:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yxlrIzSvDWkPTwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Nov 2025 08:35:00 +0000
Message-ID: <91a1a547-0148-4822-8396-d8c52aeaaaeb@suse.de>
Date: Fri, 7 Nov 2025 09:35:00 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] block: refactor disk_zone_wplug_sync_wp_offset()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20251107063844.151103-1-dlemoal@kernel.org>
 <20251107063844.151103-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251107063844.151103-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/7/25 07:38, Damien Le Moal wrote:
> The helper function blk_zone_wp_offset() is called from
> disk_zone_wplug_sync_wp_offset(), and again called from
> blk_revalidate_seq_zone() right after the call to
> disk_zone_wplug_sync_wp_offset().
> 
> Change disk_zone_wplug_sync_wp_offset() to return the value of obtained
> with blk_zone_wp_offset() to avoid this double call, which simplifies a
> little blk_revalidate_seq_zone().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
