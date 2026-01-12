Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8032E154
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203137; cv=none; b=XGuBpWL4klVvinmWF/+yNXWZALW/z/pao9B4TrXSRIfZ97I/ro6Dr+SCMta6GA8vLQ9wpFJRfnwVdFLJSj+bFs7k2xr+2UZ+SfWaWMvtK4HWDzbwerMqyx2nB2ws3bL0PuzQRQ07OGNGHYWIOilODm4hcrvp+xrHD7SnSOoG+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203137; c=relaxed/simple;
	bh=UI0PqBIQP5hsmWJgMOgtZLdENRGsnMZwf85Oo+xWLjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SggnE0RE2Nr1/O9S3qQ4nkUbAv1xAG3afSpiLUPLJrnORWP9YT/w/qejxuZJ9NKoJQf/9+txXxFL2DOjzIONO+0Kea62mTBMS2ElELiAG7KiiItpVQbo5MAQyFGkMFhmBuC8vFAXFIEaoaZCFaIpK4j0WSUwqu3raNHNtGpB5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wrIo4n7k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LpNN0rAw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wrIo4n7k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LpNN0rAw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wrIo4n7k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LpNN0rAw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wrIo4n7k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LpNN0rAw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF7895BD31;
	Mon, 12 Jan 2026 07:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbXJGsTtcJWXyUVSuPnOdvV+LhUE4cMC2wmDVmBQPv4=;
	b=wrIo4n7kVNg3EOk9hXiJ6eZVbqE6jUl/tEYgYxk7qU+r3hGUfTOSVpsajwTXFxlSBaT5vG
	z2fOr6fjeb8rPrt7kHsPBSqJD2tvSB/+GMUb9ytzTSxhBLNU8ph+js1CNHGzAUSDptJX6X
	S+qqV5o8TkoPuuqiFE6rBaCLqhoW+7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbXJGsTtcJWXyUVSuPnOdvV+LhUE4cMC2wmDVmBQPv4=;
	b=LpNN0rAwLhtpEo5Ensh56yssaoP3lKovBGhjMtiZsqQFiz1FUl56AKsEU66qwDVB3nNe24
	VVyTiYo6DDSEURAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbXJGsTtcJWXyUVSuPnOdvV+LhUE4cMC2wmDVmBQPv4=;
	b=wrIo4n7kVNg3EOk9hXiJ6eZVbqE6jUl/tEYgYxk7qU+r3hGUfTOSVpsajwTXFxlSBaT5vG
	z2fOr6fjeb8rPrt7kHsPBSqJD2tvSB/+GMUb9ytzTSxhBLNU8ph+js1CNHGzAUSDptJX6X
	S+qqV5o8TkoPuuqiFE6rBaCLqhoW+7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbXJGsTtcJWXyUVSuPnOdvV+LhUE4cMC2wmDVmBQPv4=;
	b=LpNN0rAwLhtpEo5Ensh56yssaoP3lKovBGhjMtiZsqQFiz1FUl56AKsEU66qwDVB3nNe24
	VVyTiYo6DDSEURAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 651AA3EA63;
	Mon, 12 Jan 2026 07:32:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2SbhFXujZGniSAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Jan 2026 07:32:11 +0000
Message-ID: <6070ede6-9d8d-40ae-b42b-9c82ae002a4f@suse.de>
Date: Mon, 12 Jan 2026 08:32:10 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/8] blk-wbt: factor out a helper wbt_set_lat()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
References: <20260109065230.653281-1-yukuai@fnnas.com>
 <20260109065230.653281-2-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260109065230.653281-2-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/9/26 07:52, Yu Kuai wrote:
> To move implementation details inside blk-wbt.c, prepare to fix possible
> deadlock to call wbt_init() while queue is frozen in the next patch.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>   block/blk-sysfs.c | 39 ++----------------------------------
>   block/blk-wbt.c   | 50 ++++++++++++++++++++++++++++++++++++++++++++---
>   block/blk-wbt.h   |  7 ++-----
>   3 files changed, 51 insertions(+), 45 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
