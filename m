Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577430C608
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099231; cv=none; b=EU2KUe7+b94giIAnSuxGw75FGDNtcBSIuW1Ok1b3OuotVEeh6GuoAsRkSmP5EZ7MZabOq0I2+v5WKUDATDop6Trr4fxBgCnq6eRkTr3uEdPKQ3feI5Z1kA6LQkH2bcLRGMZ0T68f1XKuZUHWV3JEZXVdZMt3CEOw6T9saULRcRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099231; c=relaxed/simple;
	bh=d1H7v9m4x1IMMm7brjp9rlLyw7L34VSz6CMgr/4jCf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAL9ZBd+AJufGzJz7ZMRRofsXAXXXN9ezIg8/cfw3XOPHLOiAd/esUMDBktp3Vp9Qz1s6SV4AxGkNE3/DxKhwNF3dAJV1T/s6pl1p3O+PE0dgZdTdmxPViyfXQjQJ8FsW0IbM/BfuU/S5ocNCVTUuFgJU0EW94+dsQxF9/IDmpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hR4Kgn2N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kIpLsxYk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hR4Kgn2N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kIpLsxYk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hR4Kgn2N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kIpLsxYk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hR4Kgn2N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kIpLsxYk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2E6D3E26;
	Wed, 15 Jul 2026 07:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784099227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uu+OVG50j8LnlkuFXILcEzxharACovqkA5wsx6t+OK4=;
	b=hR4Kgn2NSOpeV3/G8zy2H5hv7xbIABZ2VMm54nWwN3HZUNmLZVQV4+1CPJTI6MjP6VeAhi
	CQVM/0rYEQ07rrh0TN1MbxeL0WmPcLwuhOlQnxLiRO5Fbnuc2Qh92LsxPt+ehwMSXNIuu1
	t4RWw2mKrke6JY7AaJVZukkLcn31DwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784099227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uu+OVG50j8LnlkuFXILcEzxharACovqkA5wsx6t+OK4=;
	b=kIpLsxYk8IuCx1aXRZnPudOs2fp5N10OLLQqTVM1RoejPQdCu9mWQISlFGbrPZEHwbo4xv
	Eyga/6yodsuCHIAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784099227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uu+OVG50j8LnlkuFXILcEzxharACovqkA5wsx6t+OK4=;
	b=hR4Kgn2NSOpeV3/G8zy2H5hv7xbIABZ2VMm54nWwN3HZUNmLZVQV4+1CPJTI6MjP6VeAhi
	CQVM/0rYEQ07rrh0TN1MbxeL0WmPcLwuhOlQnxLiRO5Fbnuc2Qh92LsxPt+ehwMSXNIuu1
	t4RWw2mKrke6JY7AaJVZukkLcn31DwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784099227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uu+OVG50j8LnlkuFXILcEzxharACovqkA5wsx6t+OK4=;
	b=kIpLsxYk8IuCx1aXRZnPudOs2fp5N10OLLQqTVM1RoejPQdCu9mWQISlFGbrPZEHwbo4xv
	Eyga/6yodsuCHIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E713779AD;
	Wed, 15 Jul 2026 07:07:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bxJzGZsxV2ofDAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 15 Jul 2026 07:07:07 +0000
Message-ID: <0a26c1d8-27ed-434c-83a1-f6ed182dff7a@suse.de>
Date: Wed, 15 Jul 2026 09:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: fix aligning of bounced dio read bios
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Neptune <z1281552865@gmail.com>,
 linux-block@vger.kernel.org
References: <20260715064215.2934345-1-hch@lst.de>
 <20260715064215.2934345-3-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260715064215.2934345-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Level: 

On 7/15/26 8:42 AM, Christoph Hellwig wrote:
> bio_iov_iter_align_down expects the "normal" biovec layout from vector 0,
> while bio_iov_iter_bounce_read abuses vector 0 for a bounce buffer
> allocation.  Pass an explicit bvec to bio_iov_iter_align_down to deal
> with this case to avoid a double unpin.
> 
> Additionally we need to free the folio if no bio_vec could be added,
> and adjust the size of the first bio_vec that contains the bounce buffer
> when the I/O size is aligned down.
> 
> Fixes: e7b8b3c5b2a6 ("block: align down bounces bios")
> Reported-by: Neptune <z1281552865@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/bio.c | 41 ++++++++++++++++++++++++++---------------
>   1 file changed, 26 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
