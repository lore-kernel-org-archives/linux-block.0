Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707D309EF9
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036055; cv=none; b=uiEqsRWYm3ephPm4wK0BiLawkLXBqZv1NtsZBML70rLO8rtrQFLxb0sTEEMaoJfo0fnQknplXXRGHSvm4yLtxwLJZA1mdMsUOczTSBaXyrrs4cd7yVfkmSItRBvF94oIC99qR76tGGlFHt2h7U/JVo8hwzNttKeWm/k4khMeGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036055; c=relaxed/simple;
	bh=6ouPsmbShohLZL7OV5aGc4ka2mpZne252KxQ0v2jH4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ok3bYRfMfEDSo6lQKlA0PD2fLX4KGwWWN750TLd+o+KZBiko7MNv1fwAjeqohriNBW4HX1/q5WllrlA+wR/Ctf4VaEN+eS21D9rez1LlbVfBjVZFs+sdHo4PpDFoeryq6pLkttCoiqmPDwdmIOYb9gaJRj+MVTKZNPo8db9HAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TDkpGM11; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xamaajws; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TDkpGM11; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xamaajws; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TDkpGM11";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xamaajws";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TDkpGM11";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xamaajws"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F8996A92E;
	Fri, 29 May 2026 06:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZHcqtngYI/Vw3Sc8z123TLOHHGrgN6DzdgD/9jvNNk=;
	b=TDkpGM11XuXTIRTGtIzXLWMc/Pgz8Kgz5o2zhdaSAG3iL85OlQSmNMWbbaQuu1Eg3KQZZe
	fW/Ip6Rw81emNwTT37ksGV69l/4TRTqaUvRXhnoA0j8aKVB673/qWjyl/6cSyClU2QND1r
	5YPz+9SQWwAseBeLjJSvV9b5JZ/ethE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZHcqtngYI/Vw3Sc8z123TLOHHGrgN6DzdgD/9jvNNk=;
	b=XamaajwsIoDkgXVuWpxytsqsFjIJlgMX4x/ZbFa+GvGjZ0paQRPz5t2BszqwCpaemhwScP
	/nYUmCP+lbYKY3Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TDkpGM11;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xamaajws
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZHcqtngYI/Vw3Sc8z123TLOHHGrgN6DzdgD/9jvNNk=;
	b=TDkpGM11XuXTIRTGtIzXLWMc/Pgz8Kgz5o2zhdaSAG3iL85OlQSmNMWbbaQuu1Eg3KQZZe
	fW/Ip6Rw81emNwTT37ksGV69l/4TRTqaUvRXhnoA0j8aKVB673/qWjyl/6cSyClU2QND1r
	5YPz+9SQWwAseBeLjJSvV9b5JZ/ethE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZHcqtngYI/Vw3Sc8z123TLOHHGrgN6DzdgD/9jvNNk=;
	b=XamaajwsIoDkgXVuWpxytsqsFjIJlgMX4x/ZbFa+GvGjZ0paQRPz5t2BszqwCpaemhwScP
	/nYUmCP+lbYKY3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 211165B1CF;
	Fri, 29 May 2026 06:27:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SmMiBtQxGWrdHQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:27:32 +0000
Message-ID: <e08b2bf2-5402-4880-87c3-7f81442b5894@suse.de>
Date: Fri, 29 May 2026 08:27:31 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] block/cgroup: Split blkg_conf_exit()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai@fnnas.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <cover.1779997063.git.bvanassche@acm.org>
 <1b128afeb0797264cdad34d0102ae65f9a1e478d.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1b128afeb0797264cdad34d0102ae65f9a1e478d.1779997063.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5F8996A92E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 5/28/26 21:45, Bart Van Assche wrote:
> Split blkg_conf_exit() into blkg_conf_unprep() and blkg_conf_close_bdev()
> because blkg_conf_exit() is not compatible with the Clang thread-safety
> annotations. Remove blkg_conf_exit(). Rename blkg_conf_exit_frozen() into
> blkg_conf_close_bdev_frozen(). Add thread-safety annotations to the new
> functions.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/bfq-cgroup.c    |  9 ++++--
>   block/blk-cgroup.c    | 57 ++++++++++++++++++------------------
>   block/blk-cgroup.h    |  6 ++--
>   block/blk-iocost.c    | 67 +++++++++++++++++++++----------------------
>   block/blk-iolatency.c | 19 ++++++------
>   block/blk-throttle.c  | 34 +++++++++++++---------
>   6 files changed, 101 insertions(+), 91 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
