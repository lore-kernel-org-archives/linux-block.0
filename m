Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA654570C2;
	Thu, 10 Sep 2026 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036841; cv=none; b=kJs+RBVXUOZTXNNUlGfLbMrkIqtazW4ZQLr8+xoNJW/uH6yl+ecK71wjvIjLzja20UsHtbqJnMf3+QH0jGECJGLXv+ktJ9t5mARuCKMp68y06AUCy45FlYGRTH3agSGjrUzBctJhKVNGe8EaJ0/ojln8ILd8jld03I60SNQrHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036841; c=relaxed/simple;
	bh=MIcY1C8MN6ruQso0PInqXSYbJW/J3xRQLXFt6LaXZhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zz5rFL+/d1yKOhVDQAQiI3pElDX+PEnfoXLQndm8kEilOk0T49fA403LdnuR7gXIOYzOPhf3I9IN868Pkd1sLbsxdBAiCfcDspjq8oA5zOpko0g8DZIjLQkpo48H4XC/UfdaMnpVtma8eUgB0OcbE+YbBrNOW17nX2zLH+n9W64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oKnzk6qp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CGE5WYVp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vGMkJVot; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4nuin77n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oKnzk6qp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CGE5WYVp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vGMkJVot";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4nuin77n"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D500F1FD91;
	Thu, 10 Sep 2026 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789036834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69B/w051ajDwGu+8Za/JAqWssX4AmJ+eR0Ae71+TIaM=;
	b=oKnzk6qp221MxeaLysF5WGuuQWZ9htHvF2sU8L01JLhKsTqv6XdPsPFLfnf949mKjd+2KW
	4ZJMFbu3/nZcxPcfjC9Qa/rwd05UwPr1wfujjmI4JL0nXq5wN7jDD1EtrgAthbLb/qHsLD
	mT5w/ZYwimzK1tTd0UaHS0fMm0qPqU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789036834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69B/w051ajDwGu+8Za/JAqWssX4AmJ+eR0Ae71+TIaM=;
	b=CGE5WYVpzolyPAM98sjSKHy0XSRmdEHHW0KfPwYGkrFbnP75cvJXauBY1kMfA9l9/Lbz0V
	16k30U22AG9zpHBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vGMkJVot;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4nuin77n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789036829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69B/w051ajDwGu+8Za/JAqWssX4AmJ+eR0Ae71+TIaM=;
	b=vGMkJVotbONpPT4Ck84jmBWLJaIQmxCU9JSwGhovkDmbd4n3UPM17xoSzJMYo7cxU3j2yh
	+LQDg84w9llomTKsX5EMhxdl1TgK0HSEKNOQzFNuV3JUsXu9KszhLIpEm0esl8ipERDebc
	6fP7x9/RlLLSDZFr7VQ8KbMV5UVgKMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789036829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69B/w051ajDwGu+8Za/JAqWssX4AmJ+eR0Ae71+TIaM=;
	b=4nuin77n+MGJib/6bFwOFK/RpEmkfQ0Xq5ybvk0qUQyS44zBbYRqRdUYqiSHtT54NHkyao
	METyYWSESbfxGABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49A9713180;
	Thu, 10 Sep 2026 10:40:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L3gJDx2JomqWWwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 10 Sep 2026 10:40:29 +0000
Message-ID: <b6eb9cd8-9597-4023-a2d1-7bc0f07f68b2@suse.de>
Date: Thu, 10 Sep 2026 12:40:28 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] block: remove dead metadata handling from the
 async direct I/O path
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 John Garry <john.g.garry@oracle.com>, Christian Brauner
 <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
 <20260909-blkdev-fixes-v3-7-1a5222c6e8ad@columbia.edu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260909-blkdev-fixes-v3-7-1a5222c6e8ad@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: D500F1FD91
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,lst.de:email,suse.de:dkim,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On 9/10/26 12:05 AM, Tal Zussman wrote:
> Since commit 2729a60bbfb9 ("block: don't silently ignore metadata for
> sync read/write"), blkdev_direct_IO() sends every IOCB_HAS_METADATA
> request to __blkdev_direct_IO(). Remove the now unreachable metadata
> mapping in __blkdev_direct_IO_async() and the unmap in its completion
> handler.
> 
> No functional change.
> 
> Assisted-by: Claude:claude-fable-5
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   block/fops.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
Maybe a 'Fixes' tag, since you already referenced the commit?

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
