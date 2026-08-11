Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A842586B
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448502; cv=none; b=CuWJfiAhGHsVrI+4D/2c3ynIwMrY1vWgb7/tvj8Ab5xqkGPaV7pHx8K49Ubr8mk8G6+aO5z0J8JpOKcDkN/m/TQxfu4Fn0i2hDKGPrcdUTTaGqwVWPbdcG7wcel1BkrLMKjU+91maLhFeAOkXRnoB9TAujZ35hijgWJtVOku2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448502; c=relaxed/simple;
	bh=+f/43Wd3026DKGzesu4yfQNhm8KxOtaJLcgysuzJtbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXIl0PfJ0o6EBx+bWBG0C2XcEe7tpiRYyu3KUuxAQZxj2kFsvzeZQ0QEuj97wMNKwCtPbFNHZbVbV3m0H8kIK8FTFGw7XN8PdrP/WnIQ/5U19mXHI5D5YBKnbbb/UOgfS1NTpHVNxTnZLZAvDRRuQV0j/9w2X/+gncSY/3SgNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uTuYlF4V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YLSVf002; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ePG3inK+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z8sM7CSw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uTuYlF4V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YLSVf002";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ePG3inK+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z8sM7CSw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2362C3DF2;
	Tue, 11 Aug 2026 11:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6jb/8kCHjyT9gN/mxBYVTlsEwko5m5sso+jdsmiV+M=;
	b=uTuYlF4VPcre1V3ChKfiRFa5SmDfs4rcb3XUWXXVtzePaVjRJ7+IFjIl7k4AlJftOiuqey
	3qLNuYW0dzR6+1hYnIndV+k0xHhNQqPCPhS8VtOOnbAOGC3xqTnV5iSOIj5lPiyg0aIhER
	dF+dDS26qcqq/Z6TmEjaNNjyOT3an48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6jb/8kCHjyT9gN/mxBYVTlsEwko5m5sso+jdsmiV+M=;
	b=YLSVf0023/AqSVSMCjD4GAtrJKR5yv9mAaIBFPGHIBTnaA8Re3BNXpGSpSm7U11MNjSrnu
	C1YFHlt3UQD2XLCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6jb/8kCHjyT9gN/mxBYVTlsEwko5m5sso+jdsmiV+M=;
	b=ePG3inK+1n3HFdB8olVKeBClG99KJRn8I5w9udEL3rC0sc46Lq2KvRus0yr8UMKxUye40m
	I5izVrUIZYnfzrZ0UmbWXw62ZmhgIUBrBIQRyD0tPuxhubaATs6GJv5/v9VyDiv+gf8Tdn
	xJOYzYrxOUpQY3y9ts/wEWHujAQK488=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6jb/8kCHjyT9gN/mxBYVTlsEwko5m5sso+jdsmiV+M=;
	b=Z8sM7CSwYUvYy1X5ITWV/TIAS0DktDsx3yEEnxiOefK/hWoWBHL0Skvk03zgLvh+mYliNG
	GdcoZ56BSRncGdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 100DC779BC;
	Tue, 11 Aug 2026 11:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q3NuA2sKe2oKfQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 11:41:31 +0000
Message-ID: <e7b9dd5d-4385-4ae4-90c7-08d20a223ad6@suse.de>
Date: Tue, 11 Aug 2026 13:41:30 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] block: fail zone management operations to
 read-only and offline zones
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-11-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260811105852.1245357-11-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,acm.org:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 8/11/26 12:58 PM, Damien Le Moal wrote:
> Any zone management operation targeting a zone that is in the read-only
> or offline condition will fail. So there is no point in issuing such
> BIO. Modify the check in submit_bio_noacct() to use the new helper
> function bdev_check_zone_mgmt() to check that a zone is sequential (as was
> checked before) and also that the zone is not offline nor read-only.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-core.c  |  7 +++++--
>   block/blk-zoned.c | 24 ++++++++++++++++++++++++
>   block/blk.h       |  6 ++++++
>   3 files changed, 35 insertions(+), 2 deletions(-)
> 
Hmm. But that checks the in-kernel zone state only,
so I would expect that we still can see failures if
the zone state has not been updated (yet) while
the command has been issued.
What harm would it do to just run the command and
deal with the results?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
