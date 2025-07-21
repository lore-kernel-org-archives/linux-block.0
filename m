Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7D76034
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082130; cv=none; b=OrJ36raR5aFXtIO5rvTK/RtpDGgwd5jBbha4eOPNwwHO43QnKqxQSxrpc/qn9LQ+IEHd1ZNKL+liPJ+iuZHiJ2c1gCtVuN5tgn6BA0e9A6kKldvm0nN7QIr8lzbcfUxdBtXSDbHZHVKtROACJEHkc/JsnUn233AvwhXx1ge4Vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082130; c=relaxed/simple;
	bh=bhrNtWV3ihx1Xozl54UoAkMnpcs+Hr8c7+QNpySyFsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMbrM+jXIgsYYNNJuA4pWLnF6iOwwGquEbV9Ci7wqZMkuC6eoVW/ciygIRLkLNNl/KXaN0zRHira8WRfD9tU/2kM74RxtLzXmtd0BqyHrjo/p/j8x9+BG32L03s2z6CfquXTI9TG/QEWFOUkgjn69ay2wtaUsLoO+Xq4Us2gi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DjT1JaWh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b8TXaFBh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c2ws57Gm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=43q4NLe6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DjT1JaWh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b8TXaFBh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c2ws57Gm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="43q4NLe6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F091321AEF;
	Mon, 21 Jul 2025 07:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753082127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfcWLqiKuLNC5Z3myc8ZRY0650S9UbNdqAtdJkgdscg=;
	b=DjT1JaWhrdzH740Ep997FAPTWxFAYPudpT2/LRI7rNsT/2B4rNbdEtsxhlsVbnprjFEzqS
	G39KQI8xmjqfPuM3VgbYyPm48JqDyPBB8CapRpHgCBjSYnorram2qunsyxidZZ9i7OzR++
	neXQfiyDSuhGIQKc5rWID8E/4a/a1yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753082127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfcWLqiKuLNC5Z3myc8ZRY0650S9UbNdqAtdJkgdscg=;
	b=b8TXaFBhUadQZzwoTXeAm8jXJdocnbCT9IESefnnGRlSYvxpXjcpVgIgV9xOt5MlqsqGAY
	iIzyjwTluUEh/WBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753082126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfcWLqiKuLNC5Z3myc8ZRY0650S9UbNdqAtdJkgdscg=;
	b=c2ws57GmunvU0sK8FjL60lqdiIj/16rT6053v0x976NFj6UJq5j278cyIaK0spwxU9LQlC
	g1iRHnZ+GR1+0HdBp/sI/l6DS/gx5HaaBnaKdzpZOTtSqD/mH/e6zCFLjhoDk+TcfcTDuK
	9gg7++3p/aVAK/mPVwqKxP7QQ5xSlC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753082126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfcWLqiKuLNC5Z3myc8ZRY0650S9UbNdqAtdJkgdscg=;
	b=43q4NLe6cPw4kxzyOGdl6M5gkN4OsuqPnUVgyTQ5ARAUnBZf2fy6ldyYguQwCH62wMmfF0
	WJKgsoz0Cg1pl7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99AA9136A8;
	Mon, 21 Jul 2025 07:15:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hLSbIw7pfWjLWgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Jul 2025 07:15:26 +0000
Message-ID: <5738fec8-43e4-43ff-8735-0cd659ff93d7@suse.de>
Date: Mon, 21 Jul 2025 09:15:26 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/sbitmap: fix kernel crash observed when sbitmap
 depth is zero
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, dlemoal@kernel.org,
 johannes.thumshirn@wdc.com, gjoyce@ibm.com
References: <20250720113553.913034-1-nilay@linux.ibm.com>
 <20250720113553.913034-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250720113553.913034-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/20/25 13:35, Nilay Shroff wrote:
> We observed a kernel crash when the I/O scheduler allocates an sbitmap
> for a hardware queue (hctx) that has no associated software queues (ctx),
> and later attempts to free it. When no software queues are mapped to a
> hardware queue, the sbitmap is initialized with a depth of zero. In such
> cases, the sbitmap_init_node() function should set sb->alloc_hint to NULL.
> However, if this is not done, sb->alloc_hint may contain garbage, and
> calling sbitmap_free() will pass this invalid pointer to free_percpu(),
> resulting in a kernel crash.
> 
> Example crash trace:
> ==================================================================
> Kernel attempted to read user page (28) - exploit attempt? (uid: 0)
> BUG: Kernel NULL pointer dereference on read at 0x00000028
> Faulting instruction address: 0xc000000000708f88
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA pSeries
> [...]
> CPU: 5 UID: 0 PID: 5491 Comm: mk_nullb_shared Kdump: loaded Tainted: G    B               6.16.0-rc5+ #294 VOLUNTARY
> Tainted: [B]=BAD_PAGE
> Hardware name: IBM,9043-MRX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_028) hv:phyp pSeries
> [...]
> NIP [c000000000708f88] free_percpu+0x144/0xba8
> LR [c000000000708f84] free_percpu+0x140/0xba8
> Call Trace:
>      free_percpu+0x140/0xba8 (unreliable)
>      kyber_exit_hctx+0x94/0x124
>      blk_mq_exit_sched+0xe4/0x214
>      elevator_exit+0xa8/0xf4
>      elevator_switch+0x3b8/0x5d8
>      elv_update_nr_hw_queues+0x14c/0x300
>      blk_mq_update_nr_hw_queues+0x5cc/0x670
>      nullb_update_nr_hw_queues+0x118/0x1f8 [null_blk]
>      nullb_device_submit_queues_store+0xac/0x170 [null_blk]
>      configfs_write_iter+0x1dc/0x2d0
>      vfs_write+0x5b0/0x77c
>      ksys_write+0xa0/0x180
>      system_call_exception+0x1b0/0x4f0
>      system_call_vectored_common+0x15c/0x2ec
> 
> If the sbitmap depth is zero, sb->alloc_hint memory is NOT allocated, but
> the pointer is not explicitly set to NULL. Later, during sbitmap_free(),
> the kernel attempts to free sb->alloc_hint, which is a per cpu pointer
> variable, regardless of whether it was valid, leading to a crash.
> 
> This patch ensures that sb->alloc_hint is explicitly set to NULL in
> sbitmap_init_node() when the requested depth is zero. This prevents
> free_percpu() from freeing sb->alloc_hint and thus avoids the observed
> crash.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   lib/sbitmap.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index d3412984170c..aa8b6ca76169 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -119,6 +119,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>   
>   	if (depth == 0) {
>   		sb->map = NULL;
> +		sb->alloc_hint = NULL;
>   		return 0;
>   	}
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
