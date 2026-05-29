Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15A372EF3
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035994; cv=none; b=aFtL05VcbUxSHw5wRDfBuyvPXtWNZt/wb9Rhjm1+dsvTxnXNIx9ca/ZRTupEf3XJ5vCGXyegD/LnLFjQqlAqUIuC4VfpUZ7wm33j2cB7VhsGF3vBWxbTJv8DtBzcexy5tRR7lDlGjY7kdITIjp47Z4eM9TuNGhnk5BialoJ/gRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035994; c=relaxed/simple;
	bh=HV/awLalDo8kJ7LhDVHsm86LsOj+DXQojhBoigb6CzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2Ik1wdrAJyy0gy4rqAHPcrRtUaI1DIwHs0zNGGZSEtKwG/TYzWz4g52sQXE4UxUPsYu9pWXOckqrA1aDY9yGQ0clmyCEhSvT0nFOVgE7BQOOeziE+uie1lN1INCgKqFbIEw2057EymOQiZbUlDI8O7iu+w3JVM7L4Fl5oWF4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYFYcA2e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ehu3NCk5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYFYcA2e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ehu3NCk5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYFYcA2e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ehu3NCk5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYFYcA2e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ehu3NCk5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 772A366E2C;
	Fri, 29 May 2026 06:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McUHHd89X+SEBv2I7YAtQswXXpZsH0ruOdYZ8gXDThA=;
	b=oYFYcA2eODOcOWZGn6lR+gDFYB0h6Wm1tVKsNqLH4H9Lki7QUTM4dBT/k2EoqWFU3DyK79
	+tERMPMhUxGAPQwD1y6zkA3mzQy1vP5Qkx+JjOM5isiSArtggAEecgndvW5TG8I2OJFdqO
	6cQ3fuxaV3lOj4N3FZdyEglbwxB459U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McUHHd89X+SEBv2I7YAtQswXXpZsH0ruOdYZ8gXDThA=;
	b=ehu3NCk5lTAKl3EP1lKrCzCbKJhxNZb5emGajepIzXX0Hp3PvrxXh3NUujVPezt1TbY7Ec
	hQ2Z5xvVZFHHrlBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McUHHd89X+SEBv2I7YAtQswXXpZsH0ruOdYZ8gXDThA=;
	b=oYFYcA2eODOcOWZGn6lR+gDFYB0h6Wm1tVKsNqLH4H9Lki7QUTM4dBT/k2EoqWFU3DyK79
	+tERMPMhUxGAPQwD1y6zkA3mzQy1vP5Qkx+JjOM5isiSArtggAEecgndvW5TG8I2OJFdqO
	6cQ3fuxaV3lOj4N3FZdyEglbwxB459U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McUHHd89X+SEBv2I7YAtQswXXpZsH0ruOdYZ8gXDThA=;
	b=ehu3NCk5lTAKl3EP1lKrCzCbKJhxNZb5emGajepIzXX0Hp3PvrxXh3NUujVPezt1TbY7Ec
	hQ2Z5xvVZFHHrlBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C21B5B1CE;
	Fri, 29 May 2026 06:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4ajiDJcxGWr2HAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:26:31 +0000
Message-ID: <bbd4cc70-1a06-4183-9e04-2b03ca2c45a5@suse.de>
Date: Fri, 29 May 2026 08:26:30 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] block/cgroup: Split blkg_conf_prep()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai@fnnas.com>
References: <cover.1779997063.git.bvanassche@acm.org>
 <4e4b11711301f1522fec5fb59de12cbd48f5038f.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <4e4b11711301f1522fec5fb59de12cbd48f5038f.1779997063.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,acm.org:email,imap1.dmz-prg2.suse.org:helo,lst.de:email]

On 5/28/26 21:45, Bart Van Assche wrote:
> Move the blkg_conf_open_bdev() call out of blkg_conf_prep() to make it
> possible to add lock context annotations to blkg_conf_prep(). Change an
> if-statement in blkg_conf_open_bdev() into a WARN_ON_ONCE() call. Export
> blkg_conf_open_bdev() because it is called by the BFQ I/O scheduler and
> the BFQ I/O scheduler may be built as a kernel module.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/bfq-cgroup.c |  4 ++++
>   block/blk-cgroup.c | 18 ++++++++----------
>   block/blk-iocost.c |  4 ++++
>   3 files changed, 16 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
