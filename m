Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870A3612F6
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848006; cv=none; b=QnvXUxomJdRh26v4eXzaHrOpMgfnNSpAY4vcqTf2XtzHR/Nj2MWyjYuFvepMVwWvN1q24SgTAl3dOFh+qMnB7fRUeJ+o5yVwBKYFj6xYy5GKbCtpjH0OS/RdXisYGQPyF1HnYQqmX9IONtF+Y0rrifqzKtlkJ4ip8XcmLQH21/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848006; c=relaxed/simple;
	bh=cDk5LPKjLhBWS+oXUN0X5IwdI2OAKxPiuA7H1V6dxC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dKNI37jicvrpWZVJ47KmpFwYHc1Sc0lkNFuTpA3RuFAgRPKo4VutgCCYrblyBr7D4lmKwUQdGh2S2oc5tDbu2Tav2iXuweIL+W3cZSsNkooY2MQMM0CysDjVa3fxMx7NxXExxRTz/Rb+rU9L6M3w/RqwRlmm1y1c38z9WxsL0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RfquLtI3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ISfRoy+S; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RfquLtI3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ISfRoy+S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RfquLtI3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ISfRoy+S";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RfquLtI3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ISfRoy+S"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E1FD3EC66;
	Mon, 23 Feb 2026 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771848001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fnopDZQEwneP2FoxuaAgqX3u6aowShoXHu6BKyqllI=;
	b=RfquLtI3gbfV00a/6e0m42vISJs98PmIqTsD8ckDurWNYRLccAL7pcZ92sKDDEIeogGmOY
	iZhkNivB/wDmGumqf9F56hRkqXJfv1tw0z12qhbVX5FOAwUMsK15LPJ7SS01O+eWVhW4E2
	drPdEg/qV1krhm8QXk1zUfWM3FmwLk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771848001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fnopDZQEwneP2FoxuaAgqX3u6aowShoXHu6BKyqllI=;
	b=ISfRoy+S7uJhA+bPitG9oviSuzKUIAlBcSvIYOMxXfLYZe1WfruAlbibeJ7juJl5BqkoCv
	r/+1cdX90cVBIiDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RfquLtI3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ISfRoy+S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771848001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fnopDZQEwneP2FoxuaAgqX3u6aowShoXHu6BKyqllI=;
	b=RfquLtI3gbfV00a/6e0m42vISJs98PmIqTsD8ckDurWNYRLccAL7pcZ92sKDDEIeogGmOY
	iZhkNivB/wDmGumqf9F56hRkqXJfv1tw0z12qhbVX5FOAwUMsK15LPJ7SS01O+eWVhW4E2
	drPdEg/qV1krhm8QXk1zUfWM3FmwLk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771848001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fnopDZQEwneP2FoxuaAgqX3u6aowShoXHu6BKyqllI=;
	b=ISfRoy+S7uJhA+bPitG9oviSuzKUIAlBcSvIYOMxXfLYZe1WfruAlbibeJ7juJl5BqkoCv
	r/+1cdX90cVBIiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35A583EA68;
	Mon, 23 Feb 2026 12:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1AqqDEFBnGn6SAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 12:00:01 +0000
Message-ID: <177a77b1-a2a4-4a43-a70f-1c1206c74b70@suse.de>
Date: Mon, 23 Feb 2026 13:00:00 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] block: rename struct gendisk zone_wplugs_lock field
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-6-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260221004411.548482-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 4E1FD3EC66
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/21/26 01:44, Damien Le Moal wrote:
> Rename struct gendisk zone_wplugs_lock field to zone_wplugs_hash_lock to
> clearly indicates that this is the spinlock used for manipulating the
> hash table of zone write plugs.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c      | 23 ++++++++++++-----------
>   include/linux/blkdev.h |  2 +-
>   2 files changed, 13 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
