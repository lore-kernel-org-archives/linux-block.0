Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7825A11F
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413665; cv=none; b=MgcUpjAz3Dr/cvt1PuDPaYZcpDhCvxSDCWaMdjj2wqwrjFjhAG2etkSclqSto7Uqq1J8xeD/toAKanIQuIa8V9bDZcG2A8iYTWJ0Xi2ucS3LadPegp9ijlBja9rjlpS1AuV8wDL3bRDVv9w58PRV/xOSLF4fjNA3cJDBKrA0F6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413665; c=relaxed/simple;
	bh=dGz3XYq6IzCyn6BIFOgk9YF2nJCx2n0zU1jflcK9avs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BicMeUHanKMad/WPsf9aM0I+jhoxM1V7cyW2FLDZcNI0EUkYQ1bNnaIQovSqX3fgoMfB7CpueopE9808GcLQYHnr5jJYL6lyHieupPTOlHpyODMJumFwFXJYSpzCAj5ei3hFnmUiKS4QJN/n4jBKVa94ccbuDs8K1CUYtzQ8gTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FdwhxNBF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d5F8hyUa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FdwhxNBF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d5F8hyUa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FdwhxNBF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d5F8hyUa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FdwhxNBF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d5F8hyUa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3135921DED;
	Tue, 20 Feb 2024 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddQH3Epi/4yePqZ+5MDffCCXSV0pf0IwXVDBvSnaox4=;
	b=FdwhxNBFLwaEvslHe/SiqAbNyJKsIvNDA/hXuTs+UClKB8Wqst2DxHPNxSfkUMkFd3mKbp
	TjLPD04U2mLLLwRk7E8Sor20wCXvpYOT3OhxcW3OJMO+KYzPZ74srztVdJ7Kl3y3FREsBs
	smBWp0/rkNWazTjDNYam1TfSYVAVkpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddQH3Epi/4yePqZ+5MDffCCXSV0pf0IwXVDBvSnaox4=;
	b=d5F8hyUasMbVH5fK0JrohVZPpFrey5eZz8sL1W2LsbpmaOhJj8/o2s8wx86Qy2Q2XwtzsA
	q2kknykQI99xV0AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddQH3Epi/4yePqZ+5MDffCCXSV0pf0IwXVDBvSnaox4=;
	b=FdwhxNBFLwaEvslHe/SiqAbNyJKsIvNDA/hXuTs+UClKB8Wqst2DxHPNxSfkUMkFd3mKbp
	TjLPD04U2mLLLwRk7E8Sor20wCXvpYOT3OhxcW3OJMO+KYzPZ74srztVdJ7Kl3y3FREsBs
	smBWp0/rkNWazTjDNYam1TfSYVAVkpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddQH3Epi/4yePqZ+5MDffCCXSV0pf0IwXVDBvSnaox4=;
	b=d5F8hyUasMbVH5fK0JrohVZPpFrey5eZz8sL1W2LsbpmaOhJj8/o2s8wx86Qy2Q2XwtzsA
	q2kknykQI99xV0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6545134E4;
	Tue, 20 Feb 2024 07:21:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wvOOKt1S1GUpRQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 20 Feb 2024 07:21:01 +0000
Message-ID: <4756c152-dbdf-462e-bd74-79b0a0070c12@suse.de>
Date: Tue, 20 Feb 2024 08:21:00 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] null_blk: remove the bio based I/O path
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240220053303.3211004-1-hch@lst.de>
 <20240220053303.3211004-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240220053303.3211004-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FdwhxNBF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d5F8hyUa
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 3135921DED
X-Spam-Flag: NO

On 2/20/24 06:32, Christoph Hellwig wrote:
> The bio based I/O path complicates null_blk and also make various
> data structures, including the per-command one way bigger than
> required for the main request based interface.   As the bio-based
> path is mostly used by stacking drivers and simple memory based
> drivers, and brd is a good example driver for the latter there is
> no need to have a bio based path in null_blk.  Remove the path
> to simplify the driver and make future block layer API changes
> simpler by not having to deal with the complex two API setup in
> null_blk.
> 
> Note that the queue_mode field in struct nullb_device is kept as
> that is simpler than having two different places to check the
> value and fully open coding the debugfs helpers as the existing
> ones won't work without a named struct member.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/block/null_blk/main.c     | 365 ++++++------------------------
>   drivers/block/null_blk/null_blk.h |  17 --
>   drivers/block/null_blk/trace.h    |   5 +-
>   drivers/block/null_blk/zoned.c    |  10 +-
>   4 files changed, 69 insertions(+), 328 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

