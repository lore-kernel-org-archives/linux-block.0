Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFFF344D85
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951375; cv=none; b=C06kca/nbKhUGCzkT09Jt5YrzsJCEfcLlTbKXSSI48ypu4K9Y3x4QPIGe8fje5ylTRnMtgQhO4wU+pcVj2P+FfoNQCfNKrVBBDStqBEByZTEu6N52VPXqzIR20jy2k7ECnyRta/AWv4xx1I0vrx2En5FVQpukh1LKk6sgrbKCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951375; c=relaxed/simple;
	bh=SwD0IPuRzuJZ2AoP+mqgQR8DV+wOcMnT1+S+C9ozfOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TF3W1ttjPTBQoCKVrXosYkA/gxX23ukKLRTz4N0oUJblLiho8JAFkj2BXloF25IoqppnbVkCGnCeKSPxdP5vMOBQSBjpZxYSIOQfgXZUNkPowOE2WbuFZFR2Ml9Ynl93sWfFVgHP+5UwbtKkI0b3q1ANIvjzlfuU52/4MRYUbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ntJDVeYm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F7wqDskN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ntJDVeYm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F7wqDskN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ntJDVeYm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F7wqDskN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ntJDVeYm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F7wqDskN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BECA0672D1;
	Thu, 28 May 2026 06:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779951372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDu68Ug9uNo4rHkze5DwSrFLoMbcgbikAzJaX4KlFOo=;
	b=ntJDVeYmlkz1LoZOKFbz9P7oGjIVnfdOzeXho7nwolI58m0VhLsg146JGRp10qVsM2LxUm
	QZDWGtJnYhuYd+aQj07v1U5jytys1cwc7iLxmUCvnM5DaOk0asXgim9YoUWALXIOYZKTb0
	SGC4mk5X1QsIkFH1AuXKF/u3+8a5Pl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779951372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDu68Ug9uNo4rHkze5DwSrFLoMbcgbikAzJaX4KlFOo=;
	b=F7wqDskNKCVdwvelo3CaISuZgQSPkz/4aNNMG7vMEbX70m1UrBhIi3eLP3jd+SRCbUXexN
	iTIc9g/DfjKJfDDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ntJDVeYm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F7wqDskN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779951372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDu68Ug9uNo4rHkze5DwSrFLoMbcgbikAzJaX4KlFOo=;
	b=ntJDVeYmlkz1LoZOKFbz9P7oGjIVnfdOzeXho7nwolI58m0VhLsg146JGRp10qVsM2LxUm
	QZDWGtJnYhuYd+aQj07v1U5jytys1cwc7iLxmUCvnM5DaOk0asXgim9YoUWALXIOYZKTb0
	SGC4mk5X1QsIkFH1AuXKF/u3+8a5Pl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779951372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDu68Ug9uNo4rHkze5DwSrFLoMbcgbikAzJaX4KlFOo=;
	b=F7wqDskNKCVdwvelo3CaISuZgQSPkz/4aNNMG7vMEbX70m1UrBhIi3eLP3jd+SRCbUXexN
	iTIc9g/DfjKJfDDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B5D45AC5F;
	Thu, 28 May 2026 06:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /kzCIwznF2qSLAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 28 May 2026 06:56:12 +0000
Message-ID: <d0e85760-6c34-4182-84b6-50558af99546@suse.de>
Date: Thu, 28 May 2026 08:56:12 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add a bio_endio_status helper
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260527151247.2352145-1-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260527151247.2352145-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BECA0672D1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 5/27/26 17:12, Christoph Hellwig wrote:
> Add a helper that sets bi_status and call bio_endio() as that is a very
> common pattern and convert the core block code over to it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c            | 11 ++++-------
>   block/blk-crypto-fallback.c |  9 +++------
>   block/blk-crypto.c          |  3 +--
>   block/blk-merge.c           |  6 ++----
>   block/blk-mq.c              |  6 ++----
>   block/fops.c                |  3 +--
>   include/linux/bio.h         | 19 +++++++++++++++----
>   7 files changed, 28 insertions(+), 29 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
