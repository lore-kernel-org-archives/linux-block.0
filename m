Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C35A18D
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563705; cv=none; b=jatNi27wtwx8h/r6+NvaiHArMAWexRSECqPuXHX0Ua0yqlo0LMyY5A49nmyT0evYlo0MMKw85z8B8Wr3gQPk9suEfWUyzswgwvxshj4m5LHIWmw2n2WLKppEODNYq5HrgDjAcN/AzJ+i0+yKCTNl8W/V42IC8MlPbWiOZOfwrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563705; c=relaxed/simple;
	bh=8q9m1RNusADDEDm07GatPdYFhJD5h3F4T58ApzeVVUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgMxwBJ7/iogWmRntKtXnqcy0uz7n4i+rh6xXfNz4usnD4sm7yDcaJZv6zkdPjAk8KO8IRqvF0upNY51I2obE2pxCh4lzDu8NdTwBTk0O1f9Iiv0njvnlpXZzGhp5Z7MNEUlEN2xlLA/OK5O42+Zc6s2d+xtVpcOkEue0z8rQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JBdkl4qP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xoi6GwQN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JBdkl4qP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xoi6GwQN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JBdkl4qP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xoi6GwQN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JBdkl4qP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xoi6GwQN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D59B1F38C;
	Fri, 25 Apr 2025 06:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/uF/SnS7za1f56vvxrJiJgR2xPfWk6H8J3uFsxSYfo=;
	b=JBdkl4qPtfS59kAKR2/N5hKERpLjpzjulbCJrvSqjbiGL3rjmsGtjwyLasrUrP6+ipjVAJ
	G1nDFYd3LpHxiVwmYz+UfPQLju7+5xmXJPqq5UcCMyroABSrxTmrjxcw5PNJp5bQTMGaTN
	QbEUbw0aj+XqAc9GwVMfNY5lSk7I/Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/uF/SnS7za1f56vvxrJiJgR2xPfWk6H8J3uFsxSYfo=;
	b=xoi6GwQNUrQoVBfOpRjUjgxwnP1Q9fYdovzvTj/Im85IYfnaRSgDgAunLEULsCvpb+0RZB
	gcAW4qVnWHPBm2Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/uF/SnS7za1f56vvxrJiJgR2xPfWk6H8J3uFsxSYfo=;
	b=JBdkl4qPtfS59kAKR2/N5hKERpLjpzjulbCJrvSqjbiGL3rjmsGtjwyLasrUrP6+ipjVAJ
	G1nDFYd3LpHxiVwmYz+UfPQLju7+5xmXJPqq5UcCMyroABSrxTmrjxcw5PNJp5bQTMGaTN
	QbEUbw0aj+XqAc9GwVMfNY5lSk7I/Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/uF/SnS7za1f56vvxrJiJgR2xPfWk6H8J3uFsxSYfo=;
	b=xoi6GwQNUrQoVBfOpRjUjgxwnP1Q9fYdovzvTj/Im85IYfnaRSgDgAunLEULsCvpb+0RZB
	gcAW4qVnWHPBm2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 157F613A79;
	Fri, 25 Apr 2025 06:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2NhWAzYwC2gLZAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:48:22 +0000
Message-ID: <21ea7d79-c05c-4983-8754-598f625a5a8f@suse.de>
Date: Fri, 25 Apr 2025 08:48:21 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 18/20] block: remove several ->elevator_lock
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-19-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-19-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/24/25 17:21, Ming Lei wrote:
> Both blk_mq_map_swqueue() and blk_mq_realloc_hw_ctxs() are called before
> the request queue is added to tagset list, so the two won't run concurrently
> with blk_mq_update_nr_hw_queues().
> 
> When the two functions are only called from queue initialization or
> blk_mq_update_nr_hw_queues(), elevator switch can't happen.
> 
> So remove these ->elevator_lock uses.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
