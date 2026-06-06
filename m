Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D682E2E7F3A
	for <linux-block@vger.kernel.org>; Sat,  6 Jun 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780730733; cv=none; b=POy0qgHBit9WWydrly/Qxz9X4cKoHyrRrxLsm8rEVfSojLhivfC3DC5v6AFOqMTeuNH/RtUQyIvuE2gFXUnfJScW1UD813gXCzzOdpEbPt78/n7a6XfKtRQVTs5R9lnJAnRQWzDCI+fgZixK/0uOeuWaXvK7kUm+WtrOPthzKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780730733; c=relaxed/simple;
	bh=ckFsxjkjGyDJD3VcdP40STwpXVLbkbEi70iuoPOwKVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOZ9VB8661cwzHgkGgtUeeWgx1Sc2+dIHBarI4hcCyoGwBby9aXn9cuCC8l3gESzaFF7vjLb54aznHXVo59QeqyPhfTOhqPzE6WVRJHpontMSsja0W8bd1Sw6T0eMqpHem/PDCHiRILErT307WbwMHtTo1RrH1mQcBjhK7DUPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wzF3ZLI6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NUFUiKq6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wzF3ZLI6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NUFUiKq6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wzF3ZLI6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NUFUiKq6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wzF3ZLI6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NUFUiKq6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38FB56B34B;
	Sat,  6 Jun 2026 07:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780730729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSypJu6BrWGqbSdcfdtIqEuyCM61VM3zsWQ/fpzesAM=;
	b=wzF3ZLI6XtFboy7SUhF1DBtFukrz4tXK4KgEx57CTP7nMTiZFSmJRgYixDkfz7DfWxqts4
	r307MDaOgzq03x3C70fhPb1Qovhg5KPMtoZEGRr7Sc3ORnZ4c6OI+9FaRKLtxq/3YvifjX
	NyYlBnYsmuBxMsPzr2uNGg1zhkc8d/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780730729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSypJu6BrWGqbSdcfdtIqEuyCM61VM3zsWQ/fpzesAM=;
	b=NUFUiKq6fADHsiWRkDE9u7Kkg4xg1VdRMX81ilb5eSz5whszr41RLOnVSn8N+zLxnTXyuP
	yXNKI/I7gfLZ+2CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wzF3ZLI6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NUFUiKq6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780730729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSypJu6BrWGqbSdcfdtIqEuyCM61VM3zsWQ/fpzesAM=;
	b=wzF3ZLI6XtFboy7SUhF1DBtFukrz4tXK4KgEx57CTP7nMTiZFSmJRgYixDkfz7DfWxqts4
	r307MDaOgzq03x3C70fhPb1Qovhg5KPMtoZEGRr7Sc3ORnZ4c6OI+9FaRKLtxq/3YvifjX
	NyYlBnYsmuBxMsPzr2uNGg1zhkc8d/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780730729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSypJu6BrWGqbSdcfdtIqEuyCM61VM3zsWQ/fpzesAM=;
	b=NUFUiKq6fADHsiWRkDE9u7Kkg4xg1VdRMX81ilb5eSz5whszr41RLOnVSn8N+zLxnTXyuP
	yXNKI/I7gfLZ+2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D0A8779A7;
	Sat,  6 Jun 2026 07:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IawJN2TLI2qgCQAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 06 Jun 2026 07:25:24 +0000
Message-ID: <1e6af3f7-dec3-47c4-a1a9-8ac4692d729b@suse.de>
Date: Sat, 6 Jun 2026 09:25:21 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] block: add a "tag" for block status codes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20260605184441.590927-1-hch@lst.de>
 <20260605184441.590927-3-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260605184441.590927-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 38FB56B34B
X-Spam-Score: -4.51

On 6/5/26 20:44, Christoph Hellwig wrote:
> The full name of the status codes is not good for user interfaces as it
> can contain white spaces.  Add the name of the status code without the
> BLK_STS_ prefix as a tag so that it can be used for user interfaces.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/blk-core.c | 28 ++++++++++++++++++++++++++++
>   block/blk.h      |  2 ++
>   2 files changed, 30 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
