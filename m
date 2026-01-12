Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5813191B4
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203625; cv=none; b=mXqmCGAdDLYaM3mbFmCmnRoAa/NwZGrHSo3Qs6LCYkOG2uWqDAIZl22dTFpTmyuq2v738cwMWlQ8eHUFRH5sSNWcvRWp3AbEOK9Elhlbdn6Um4asp+V0rjfhMz4lWFx4XYCI8CHqFuzAG+tk67PTiNd4MTxQ+F8lw3UNtvjsGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203625; c=relaxed/simple;
	bh=pshz27wH5Tq7tvU684+of3qw8bnh1mbLWY0ecq5M4bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I6exeWxqON0QioisvMHpC2J2uP97ZBJcTbiIVcq8tKXSKs3pb6dEx0ZY0MMAwd++SH45Dr03n0Ol684TCB1Jo7B2SvdntIsZFd/+3IkOwFQjia6qU2sYa5W3ZN1xN3gP9Vdnp3a5Agiavz/IoL7qjGfCs8UJdWNkPS9C+ll2LF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Btm2gSJ4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nHZLYf7X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vqJC1JHq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pNTZOOu+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Btm2gSJ4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nHZLYf7X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vqJC1JHq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pNTZOOu+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0D80336FD;
	Mon, 12 Jan 2026 07:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85kHGSaL1i7qMjq2I/Lf3NdHy1/+lnWUt/+PzNS/d5s=;
	b=Btm2gSJ4iQKqOWK+/pvdP+VyqNJ7jgzgNeKwvnuBQFFokflvg9PeGCKQhJsqIG4jAII+JQ
	HaM5mKBklIHhgVW+dkEHkf/ADyGTFhh5fNfQRlIZvei1iRTQ/e0BmGSwQoUWZMKB0nTR0a
	1imNPvjTwXawiuE3F9CuGfw1nUzVeFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85kHGSaL1i7qMjq2I/Lf3NdHy1/+lnWUt/+PzNS/d5s=;
	b=nHZLYf7XE/3QWTGkCMPv5b2ZRmcHjyU5JO8n4QGJaq8vLv6VdQF76WT3X1u7mwPQTZhMVD
	x5ScSEamlnGWQjDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85kHGSaL1i7qMjq2I/Lf3NdHy1/+lnWUt/+PzNS/d5s=;
	b=vqJC1JHqeyx+IicVH0ZNaENKt9uGQIAfDdbFitn6/1O/hChq7IQ+a5GNPhn0pkr6iMWI9d
	Sasshryw+o2nH/1KAeEEzLt/u4B2Tdf847Z8oekNidGxkvtVK6Nj7IUOhkt8d0s5Nk07W+
	YnoOYYodwSh2D3zhzXNtROkkKMvtXTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85kHGSaL1i7qMjq2I/Lf3NdHy1/+lnWUt/+PzNS/d5s=;
	b=pNTZOOu+g7CfeUSmgE5sSJzB2m6XavkKuv4KIe5LBFQw92lDW5ObL5EtvXceITbfe4u+c9
	VMWEIKo0dCuCIkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A27F53EA63;
	Mon, 12 Jan 2026 07:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WnmjJWWlZGnXUAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Jan 2026 07:40:21 +0000
Message-ID: <231026e6-531d-4ad2-b085-9b7fce870188@suse.de>
Date: Mon, 12 Jan 2026 08:40:21 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/8] blk-rq-qos: fix possible debugfs_mutex deadlock
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
References: <20260109065230.653281-1-yukuai@fnnas.com>
 <20260109065230.653281-5-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260109065230.653281-5-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,fnnas.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 1/9/26 07:52, Yu Kuai wrote:
> Currently rq-qos debugfs entries are created from rq_qos_add(), while
> rq_qos_add() can be called while queue is still frozen. This can
> deadlock because creating new entries can trigger fs reclaim.
> 
> Fix this problem by delaying creating rq-qos debugfs entries after queue
> is unfrozen.
> 
> - For wbt, 1) it can be initialized by default, fix it by calling new
>    helper after wbt_init() from wbt_init_enable_default(); 2) it can be
>    initialized by sysfs, fix it by calling new helper after queue is
>    unfrozen from wbt_set_lat().
> - For iocost and iolatency, they can only be initialized by blkcg
>    configuration, however, they don't have debugfs entries for now, hence
>    they are not handled yet.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-rq-qos.c |  7 -------
>   block/blk-wbt.c    | 13 ++++++++++++-
>   2 files changed, 12 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
