Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145703BBFC4
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945629; cv=none; b=o+kSpvAswNp+w9+MFrQpMlC+mLrgxx6JDfvxlgZd9bgZmV2HpoUWY3gE0rnlxn0O6bMBDk/OtGIUR8uoIwHTanAkl0z0TFXZxdF0cf3BbD6i4hmMjt1trJuxb+ObUjnBv/UsJhpZPAYHQ8rdQ+xsbJBl0KFOlRKRxzjWnOMBKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945629; c=relaxed/simple;
	bh=11b92D4z6PYMzLtIlWDklz/6vKNCyDogBw0iLVu4ins=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCUuqOsax2ahpmE7ASxd4jw4G4QDGKjKq9nUsA2TJ/UE2an5smS3teQ4K2PtwCopkoJnzG8NJrNGNboBzw5r8RGUxP32wCWOKFTKrGKr87KbamQ+iPXUfOavId/HwBAMFbyhWKRvWZ5hkcMBx3vK/w7nqc17f053bqdlCS3iehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2M55rZE+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u13+uxPR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RjwL/LtH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lDKJcrnr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2M55rZE+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u13+uxPR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RjwL/LtH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lDKJcrnr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 333E9219D6;
	Wed,  9 Sep 2026 09:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788945619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlewHDOyDGneUjYT8h4cOrIRcdq18A3VS9JU7aiFEP4=;
	b=2M55rZE+9Lb7B4I3+6+KRjgt78O3uC9dq6ftEW8+IUutfINVkmoD8loOvyhhwj8OjAuaDv
	pwZsIXwU0sjQz+I2Jix6xZl+fuUMATsg02H+bejZwQZ8g2SkXXLE/ksPMla98cNH/kV8S5
	0gD5zhLhJ6a34aEBskgEr4j5N57cSPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788945619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlewHDOyDGneUjYT8h4cOrIRcdq18A3VS9JU7aiFEP4=;
	b=u13+uxPRnKf0mOzsNtoBRlTTkHUGnm1CGKgu+ffoIr7frHFL7RCG1fCwv0XF1rfCcCf0qu
	0Hv/XBOPPGkuHDAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="RjwL/LtH";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lDKJcrnr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788945615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlewHDOyDGneUjYT8h4cOrIRcdq18A3VS9JU7aiFEP4=;
	b=RjwL/LtHy3e4Gwsn8cxznV3mHZuQJ02UkusW+L4QbXwj2vTxNpjBzpXCCHkqMCWHJfuPoM
	IqZ6xbT31kj3uSb7ha3TzRa1uFCKoEiHcrcCPE+J//+ZFzMIxMErhH2UUOJc4Q3kwC86rF
	5F/yytsQMR7XVzCTtQWdKU0toIOVIag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788945615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlewHDOyDGneUjYT8h4cOrIRcdq18A3VS9JU7aiFEP4=;
	b=lDKJcrnrKIe25u2TSJs1MEAYoleOkYDBgYOItC81m/ZsqzNnCI9LMEk/udd2vjSj9yfqQ+
	/UEXtUM6pJ/+QHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04F091347F;
	Wed,  9 Sep 2026 09:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WVfNAM8koWqIZgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 09 Sep 2026 09:20:15 +0000
Message-ID: <a86e8211-7fdc-430b-9351-892bb3252f34@suse.de>
Date: Wed, 9 Sep 2026 11:20:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/16] block: serialize zone revalidation
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260908085745.1082697-1-dlemoal@kernel.org>
 <20260908085745.1082697-10-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260908085745.1082697-10-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 333E9219D6
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 9/8/26 10:57 AM, Damien Le Moal wrote:
> The zone related fields of struct gendisk can be modified by
> blk_revalidate_disk_zones() either on the first scan of the disk, or
> during user triggered scans or device revalidation, if some
> characteristics of the disk has changed (e.g. the disk capacity). Changes
> to these fields are always done with the disk request queue frozen so that
> BIO processing does not see any inconsistent state of the zones. This
> implies a contract that reading these zone related fields must always be
> done while holding a usage count on the request queue of the disk.
> 
> However, increasing the usage count of the disk request queue cannot be
> done from the context of blk_revalidate_disk_zones() itself, as that would
> prevent freezing the disk queue and result in a deadlock. This prevents
> blk_revalidate_disk_zones() from consulting the zone related fields of
> struct gendisk to detect, for instance, a change in the number of zones of
> the disk. For such case, we want to detect the change, take appropriate
> measures and revalidate exclusively revalidate the zones to avoid
> concurrent revalidation calls to see the same change while corrections are
> already on-going.
> 
> A simple solution to avoid this issue is to introduce a mutex to serialize
> calls to blk_revalidate_disk_zones() and ensure only a single context at a
> time can modify the zone related fields of a gendisk. In preparation for
> handling disk capacity revalidation in blk_revalidate_disk_zones(), do so
> with the mutex zone_revalidate_mutex. This mutex is initialized in
> disk_init_zone_resources(), destroyed in disk_release_zone_resources() and
> taken and released only in blk_revalidate_disk_zones() to serialize the
> execution of this function.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c      | 17 +++++++++++++++--
>   include/linux/blkdev.h |  9 ++++++---
>   2 files changed, 21 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
