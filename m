Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581085;
	b=xkRUFWniEg38qwpI0e1DEsIXtOlSsc9m8bUISzJCbxhfjj020cOHlDmGPtp/+vqbzKT3
	 d12qGfIAkEJHdhcwL5uYavlMBn6yjxRpKLk0KonUQHca3mNoVRTg54ZHnO79fBbN+nPza
	 dSC8dxQrVKKKx/H/zZ6i7FwVBbwBpP58DkQDu63Vj8ex5fZs5B1M1bI0x7bC+p21rNNJG
	 JaAZh+Z9NyVacVxPTvT2aDiIpugXCR9nIX7X2JO1o5jMqKr9jEN7rNuk6+napsoNf11P1
	 hHv6TcqmYdYUcKw498dCM8IYqYr2NxViCCJxzks8fJTbXnhCa54Ht/pJaJoQuP6vPzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581085;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=n0j1drhlnlCtpxxLEzYakiDDyaGlUXaZ4daHm/zAbPc=;
	b=1FPKXOD5f9bpgRZPFVhTDahcNVOLlSCiXQK/JxOWwdKorx9jIdirpr7RS8o9mLKycoSV
	 Naom8KzJY9NK7Myyijty29zSOUWG1ht73OXl+CgOJ4yYPiAlla/JPP0lV3t/J+dxTt23C
	 sNAAIAvAnRdJzWRy0wmukmYJMFowuMACnSP3tGU2ELWe14pTCD/Ub3WjpJLEwcl2Ec+NU
	 6I4AcGhygmGMx5ojs3BLCyuSp2H3dJe8vT+luhAJ21YAqontk5qRpLLZGohPZLKO8QCD8
	 P8wbOqSd4lbpuBfTCbXwT5K9ve7x6dHb1B9zc+aPkAWgpvXejFJp3WFyaEHHUPKiHOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2DKp838h;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+YSkjRbj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2DKp838h;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+YSkjRbj;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3D606A319;
	Wed, 21 Oct 2026 11:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33E3D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2DKp838h;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+YSkjRbj;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2DKp838h;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+YSkjRbj
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75BF81F799;
	Wed, 21 Oct 2026 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0j1drhlnlCtpxxLEzYakiDDyaGlUXaZ4daHm/zAbPc=;
	b=2DKp838h55iWZtAoeCI3WZP/tbtdH69Fwhhl5snOhoo/SOvL3TPxNEB7kElvokkgG+kFMH
	dRdZN201sNExTcipJQflaHmiV6GJKQ55UmD7+lzYVcd0icuunWJunUswUzPBuKizecMJZx
	oImFJ5JvtScmceKTbnbyHQw3a7PtGS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0j1drhlnlCtpxxLEzYakiDDyaGlUXaZ4daHm/zAbPc=;
	b=+YSkjRbjIc3ICzHlctLiruKD0Aw4WtCCt1FOeWs6Wcaam8cuUt2KI0ECIFZ8cLajG6TuAU
	7XEJbLme4433DjAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0j1drhlnlCtpxxLEzYakiDDyaGlUXaZ4daHm/zAbPc=;
	b=2DKp838h55iWZtAoeCI3WZP/tbtdH69Fwhhl5snOhoo/SOvL3TPxNEB7kElvokkgG+kFMH
	dRdZN201sNExTcipJQflaHmiV6GJKQ55UmD7+lzYVcd0icuunWJunUswUzPBuKizecMJZx
	oImFJ5JvtScmceKTbnbyHQw3a7PtGS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0j1drhlnlCtpxxLEzYakiDDyaGlUXaZ4daHm/zAbPc=;
	b=+YSkjRbjIc3ICzHlctLiruKD0Aw4WtCCt1FOeWs6Wcaam8cuUt2KI0ECIFZ8cLajG6TuAU
	7XEJbLme4433DjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D84613518;
	Wed, 21 Oct 2026 11:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TnWRBNud2GqWAQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Oct 2026 11:11:23 +0000
Message-ID: <e818bd40-2333-412c-800f-9bad6d6d7f6b@suse.de>
Date: Wed, 21 Oct 2026 13:11:22 +0200
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvme-fabrics: reset io_queues before computing the
 queue mapping
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>,
 Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Aaron Tomlin
 <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
 <20261014-nvme-fabrics-isolcpu-v1-3-355156be27b2@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-3-355156be27b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 10/14/26 9:46 AM, Daniel Wagner wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> nvmf_set_io_queues only sets the io_queues entries of the queue types it
> hands out, but the array is reused on every reconnect.  When the
> controller grants fewer queues on a reconnect, stale entries survive and
> nvmf_map_queues maps CPUs to hardware contexts that don't exist anymore,
> which crashes blk_mq_map_swqueue with a NULL pointer dereference.  E.g.
> with nr_io_queues=8, nr_write_queues=8 and nr_poll_queues=8, 24 queues
> are mapped 8/8/8 (default/read/poll).  If the controller grants only 16
> queues on the reconnect, the poll map still starts at hardware context
> 16.
> 
> Clear the array before computing the new mapping.
> 
> Fixes: 6486199378a5 ("nvme-tcp: fix queue mapping when queue count is limited")
> Fixes: 5651cd3c4336 ("nvme-rdma: fix queue mapping when queue count is limited")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fabrics.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 59f823dfbbcc..571de549fbaf 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1125,6 +1125,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
>   			u32 io_queues[HCTX_MAX_TYPES])
>   {
> +	memset(io_queues, 0, sizeof(*io_queues) * HCTX_MAX_TYPES);
> +
>   	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
>   		/*
>   		 * separate read/write queues
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
