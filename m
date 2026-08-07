Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1E2463B75
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093880; cv=none; b=d1kLhrAnUAhST+M+5qP0s5avE3LpjlxNHJDzzeed/l4sjFsOgxGG8Ap1guZkHWpvTVSYN9uVcr62sEZ5rOkBCp0Qf02iDILPyemJnS5HtlBnPTY022sHT5rlLqWVrlHeeWH1Kr8Mk+z8hK+jgK1fcaaaW/Wh88sjJQ+2MxCdGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093880; c=relaxed/simple;
	bh=EhL9HLRTxU8yc6hwq2OQqOMBvi6lCQBtUsjiHZ617vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jdxt9PWYqlEhA6HVYtR5wi/PZxfITDSmQewcJlZcc5CRjZb/1onk28jP7cTn7lAakRqWYqjkC+u5/ME16WcbvokW2fDStQJD9ZCB4t7s6hOsyYXUkh60MZjGDRh0QJZUVR3K6+h8t8dhoKg5ob/X7EaBSTQ2PdA+iuzR/7eSvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DrwSQ6Mm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d9k4ml/6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FZMdEzuB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BayitqfE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DrwSQ6Mm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d9k4ml/6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FZMdEzuB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BayitqfE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F28F580521;
	Fri,  7 Aug 2026 09:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786093867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PllrfMeMRi01DBXMQ66DlAHSwIu9lzLYUVM4BIARnOs=;
	b=DrwSQ6Mmf/tObvR0qvqpbZZxsihIIOa90YVSgkSghWhZY1QhND1VuK8otjhAY+0/4LHuW7
	6vGB2St3KHyWe1NG/bQovY3Ty1AQUvm9cwIZHAHTxV9loPJpxlNOCLYP1AZDxLBtJzPGWz
	KC93OedEhhKt1pLBQcS6kD26nHthqtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786093867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PllrfMeMRi01DBXMQ66DlAHSwIu9lzLYUVM4BIARnOs=;
	b=d9k4ml/6p8B/MHVYm/ogUXglVJimu2+7LWDRv9uW8bzu1dAUyh0LqCS0t8vKZtIMqsKfev
	w4rCBDeELT4zj2BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FZMdEzuB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BayitqfE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786093862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PllrfMeMRi01DBXMQ66DlAHSwIu9lzLYUVM4BIARnOs=;
	b=FZMdEzuBs0iFS7XL4CFPmJIRKGWDOtid4H1ty6BlaolGS34a4EMPBZfoIBQRJCVw4c11e1
	NJxiB5mbd8jFiSyBywJeqZRoVu1zvt63fYr3L8Mme+jaJ9cd6fGquTk5wiPsZNzZc0NmZE
	9OGTmksl2a+u/MbljOhJhrFCIDiKfuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786093862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PllrfMeMRi01DBXMQ66DlAHSwIu9lzLYUVM4BIARnOs=;
	b=BayitqfEThDkdJCgqFoDWOsjvvC+8RFLZIYyZ+X+RBZq04my5/WdWpL2NhWo8vylBfXb7T
	XW96QRfjloQAnjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4A7E779B6;
	Fri,  7 Aug 2026 09:11:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QbJlNyahdWo+dwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Aug 2026 09:11:02 +0000
Message-ID: <ea0ba582-58ec-4f54-a7e3-cc8790682212@suse.de>
Date: Fri, 7 Aug 2026 11:11:02 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] block: remember a zone type regardless of its
 condition
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-5-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260806160445.848337-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F28F580521
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 8/6/26 6:04 PM, Damien Le Moal wrote:
> Currently, bdev_zone_is_seq() identifies a sequential zone by looking at
> the zone condition, assuming that any zone that does not have the
> condition BLK_ZONE_COND_NOT_WP is a sequential write required zone. That
> is correct only as long as the target zoned device does not support
> storage element depopulation (aka HDD head depopulation), which is a
> feature that can transition conventional zones to the read-only or offline
> condition. For such device, we cannot distinguish anymore between
> conventional and sequential zones using the zone condition as both zone
> types can have the same conditions.
> 
> Prepare for fully supporting storage element depopulation and restoration
> by caching the type of a zone in addition to its condition. This is
> implemented by reformating the zones_cond array using a more compact zone
> condition representation with the new enum blk_zstate. This zone condition
> representation only uses the lower 4 bits of a byte for the condition
> values, thus leaving the high order 4 bits of each byte entry of the
> array for flags. The flag BLK_ZFLAG_CONV is defined to indicate
> conventional zones.
> 
> The helper functions blk_zstate_to_zone_cond() and
> blk_zone_cond_to_zstate() are implemented using lookup tables to convert
> between enum blk_zone_condition values and enum blk_zstate zone condition
> values. The helper blk_zstate_set() can be used to prepare a zones_state
> entry for a disk with a zone condition and zone type flags. This helper is
> used in disk_zone_set_cond() to update a zone condition.
> bdev_zone_is_seq() is modified to use the flags of the zones_state array
> entries to identify sequential zones. The zones_state array initialization
> and revalidation is unchanged from the former zones_cond array.
> 
> Overall, any zone condition that is being considered outside of the
> zones_state array always uses the enum blk_zone_condition values as
> before, thus minimizing the number of changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c      | 202 +++++++++++++++++++++++++++++------------
>   include/linux/blkdev.h |   2 +-
>   2 files changed, 143 insertions(+), 61 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
