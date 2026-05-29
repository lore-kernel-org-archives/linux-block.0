Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832330DD11
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035881; cv=none; b=lhZ6fpiQM9g/rw88TCI1PMt7RoTmDWapenuZnW99w7bd7xYps76+53Mcnt/cLTDgcrFm+Har7d6a7qv+i02z7KSKRqjhktMQWzemC9osj0UZQfAl808uGQoV0XtchoPA+GBJjBAv8yONcAop2/oAprtgu4FNr0tPh2LHcR2Je2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035881; c=relaxed/simple;
	bh=v11FXS+soDOLhNwlmOFu9vFq9yMRY8MIyHxCtGI4epI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXwI6U0HOVjQfGnXT8iNnoGx9pdkUWYMMZnCRToUC2gIbJD8tS4MvDS7Rr7yXwjCqrcJrqnN0/eepCRZHUkVpuqABwGfvh+4mI/Apgqa6/N87YTgkemWZRJ0y/Afyx8eQn1NcbLOCPkBjC4FroRWLAjXYV2XqsQJt8kle5L0BeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lNfVNmwX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R15NsBdH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lNfVNmwX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R15NsBdH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lNfVNmwX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R15NsBdH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lNfVNmwX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R15NsBdH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 604546AB98;
	Fri, 29 May 2026 06:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3U+LKZlFxuKxLEdzYxFKF6PxCpZqgTx9uwiqoXVJeVs=;
	b=lNfVNmwX+v9ThAG4J2cXJx0dftSL7bY+Y1I+nGRVF8Rnuu5jiZWmqMryN+2TL38LrRj9BV
	8rMG+LhNpwcOTedkuK/QH9zTbKrTaZI/tu3YKuIhqw2u8wXTvIIAi8oGtMfLG4z+0pYEZ1
	3kXyIc8X+2AV18Bl1gHAUdqGdZ2/tnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3U+LKZlFxuKxLEdzYxFKF6PxCpZqgTx9uwiqoXVJeVs=;
	b=R15NsBdHqP1NbbguL+upLCJz0nKJHd2OtGqdctW4JHsjEacVvJRoYlq8KlN5Fh2YLebYZM
	8GQJ9gZdewFWbhCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lNfVNmwX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R15NsBdH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3U+LKZlFxuKxLEdzYxFKF6PxCpZqgTx9uwiqoXVJeVs=;
	b=lNfVNmwX+v9ThAG4J2cXJx0dftSL7bY+Y1I+nGRVF8Rnuu5jiZWmqMryN+2TL38LrRj9BV
	8rMG+LhNpwcOTedkuK/QH9zTbKrTaZI/tu3YKuIhqw2u8wXTvIIAi8oGtMfLG4z+0pYEZ1
	3kXyIc8X+2AV18Bl1gHAUdqGdZ2/tnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3U+LKZlFxuKxLEdzYxFKF6PxCpZqgTx9uwiqoXVJeVs=;
	b=R15NsBdHqP1NbbguL+upLCJz0nKJHd2OtGqdctW4JHsjEacVvJRoYlq8KlN5Fh2YLebYZM
	8GQJ9gZdewFWbhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 394E25B1CC;
	Fri, 29 May 2026 06:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4L8/DCYxGWoSGwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:24:38 +0000
Message-ID: <48b84168-db99-49f2-bc70-ed8e317d8024@suse.de>
Date: Fri, 29 May 2026 08:24:37 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] block/bdev: Annotate the blk_holder_ops callback
 functions
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>
References: <cover.1779997063.git.bvanassche@acm.org>
 <b0541615a41fc06f1c0636575db48dd3d7f30e64.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b0541615a41fc06f1c0636575db48dd3d7f30e64.1779997063.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 604546AB98
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,acm.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 5/28/26 21:45, Bart Van Assche wrote:
> The four callback functions in blk_holder_ops all release the
> bd_holder_lock. Annotate these functions accordingly.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   include/linux/blkdev.h | 12 ++++++++----
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
