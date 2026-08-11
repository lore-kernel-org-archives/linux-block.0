Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CC43B6D2
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450627; cv=none; b=d7gd8+OIm1brTbO0r7uCVz0kWhibNzY6Fl2Mfu0hw7ENypA03lDuUOeQQ7W5wBwnRiBiIRHyFl3rbPqIXALTFNGhGbVGnXNcGUl/Ua6TCi52sJCxZ9lwD/k1Limy5Yz686hF1yCSZzURi81pX+hknncJWnwJCJno/YNScEQAfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450627; c=relaxed/simple;
	bh=A/AwD+Msfz1JmLsW5PzsZyqSvfr4DtKm9DguA4rAeBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNxpmmoljSae35QSwbMc1XqijuWWd1Yh0jHeZ+AimXaQI1cDLQiAlajmuuE85+BO2jkqhmNVc72Yd78ZhdqCuhfCWFnz/WKdvABVHAd0yFUYA009kLYqvna++QxDG8Cstx16aMX2+QdYGxopY8FJXRMOvPuKo4u455rSvHippfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pxth5Nd6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vC+u61KA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OKcXnOhi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z5iOkn7l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pxth5Nd6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vC+u61KA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OKcXnOhi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z5iOkn7l"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A38103E21;
	Tue, 11 Aug 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786450619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53eImeORfGMNylLa/5R91lKYnKC2HxVQUOXoPjXW4hw=;
	b=pxth5Nd6As4/3m8LO7UKaG0d7z723QyDMWiCCcXuew5ceBthyca551RHBXayBSjFU3bfBw
	EUZDY8iqdo+JBkxV5JB9Mo0i0ZREONUGu68h94up4r9kjJjenOa0Id6Zgim7YcyPCucDzp
	eMgsAKR8WO5RXzAm5bJo+QbzstM2u3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786450619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53eImeORfGMNylLa/5R91lKYnKC2HxVQUOXoPjXW4hw=;
	b=vC+u61KA1YvYryBjo+yT5ruWQXiWTTXDwaLeaOdvDnkrOn1AddqmaY8w/Lfm+u721WR1Nu
	llqtVFgWNjSW0GAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786450615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53eImeORfGMNylLa/5R91lKYnKC2HxVQUOXoPjXW4hw=;
	b=OKcXnOhixX/xrdimIw8ZLKjqU/h5VFxx9ILZaexDG3bZbELeZrzdAF2/hmkOvPbKWBQwkD
	FbPmB3G+SIej3ej8uOqYFP+T/r/kExlR9fmGpSlP9aXwU9+q47B6HAmNwNN2xXbHkmHy96
	f7OIfjIahxxraUNEty+qVjXvIBiXHo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786450615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53eImeORfGMNylLa/5R91lKYnKC2HxVQUOXoPjXW4hw=;
	b=z5iOkn7l0Ax1QX+aTXvcoI03RM2F4uhLpVfY+eXIsLLttvH1mWO5bVYB47VvNAJjfYM2zP
	s+nImIAbr+gphAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93E6B779B2;
	Tue, 11 Aug 2026 12:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4kqzI7cSe2qNIQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 12:16:55 +0000
Message-ID: <84d641dd-2234-4327-9b86-93f8109e8c25@suse.de>
Date: Tue, 11 Aug 2026 14:16:55 +0200
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
 <e7b9dd5d-4385-4ae4-90c7-08d20a223ad6@suse.de>
 <427819c1-a827-478d-a260-a1ecbde09015@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <427819c1-a827-478d-a260-a1ecbde09015@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,acm.org:email,suse.de:email,suse.de:mid]

On 8/11/26 2:13 PM, Damien Le Moal wrote:
> On 2026/08/11 4:41, Hannes Reinecke wrote:
>> On 8/11/26 12:58 PM, Damien Le Moal wrote:
>>> Any zone management operation targeting a zone that is in the read-only
>>> or offline condition will fail. So there is no point in issuing such
>>> BIO. Modify the check in submit_bio_noacct() to use the new helper
>>> function bdev_check_zone_mgmt() to check that a zone is sequential (as was
>>> checked before) and also that the zone is not offline nor read-only.
>>>
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>>    block/blk-core.c  |  7 +++++--
>>>    block/blk-zoned.c | 24 ++++++++++++++++++++++++
>>>    block/blk.h       |  6 ++++++
>>>    3 files changed, 35 insertions(+), 2 deletions(-)
>>>
>> Hmm. But that checks the in-kernel zone state only,
>> so I would expect that we still can see failures if
>> the zone state has not been updated (yet) while
>> the command has been issued.
>> What harm would it do to just run the command and
>> deal with the results?
> 
> NCQ errors are painful with SATA due to the queue drain they cause. So I am all
> for avoiding them as much as possible. This is not the hot path and this check
> is not a heavy one, so I added it.
> 
Ah yes, these are NCQ commands. That's of course painful.

So:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
