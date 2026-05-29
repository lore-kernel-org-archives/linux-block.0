Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005491C84BC
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036311; cv=none; b=rSruhkKnG0twGa5luckfO6v+5k/3HTpYlBSAS73DmqSYHPx+4uHRDNQJ7PX3XCnD6nroodYLC3/Bipe5nyyLeEI9hVdPelLQSsyojd4QU2wlRDZjoJZC2mbr9NJf2dlEv+dDybb1Yst/q3m7LzUzTLaZrhFFhFb7LBM2jAWvIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036311; c=relaxed/simple;
	bh=U+AUJKs2ENEfjydgXj4XaQtwhGcVewxDWNbue9LIPTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTpvVrorTmpBR+CFai93GOKTIBk+gpR5lRjRm0MjCduu81ict559IDOcmXJ/YED0GWEMBznckAkCHHIKokOdeS5Z1ofLdF/4nIhEWCTZAryyLnx8FSD8JFDdjwjB0+THZf4FT4yfvcEtEzNOj2rp1KK+s939ma2qNkdAOqjYOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QAuWD23B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IgXy7Q0f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QAuWD23B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IgXy7Q0f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QAuWD23B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IgXy7Q0f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QAuWD23B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IgXy7Q0f"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CE4566E2C;
	Fri, 29 May 2026 06:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XnJQb7U5X2b4L22rfD/V2zbWT/bPFbcdm0m2p+KNnK4=;
	b=QAuWD23B+VFhjXpDWFKl3ugsrCtkK7yATH/r3lugWAw3ffrW1BQNVkjAXns49u88XqZnVw
	qs1yvpmF+HYGcQiZT6cZE5QI4VS2RXUf9AuakICbW58lcSCNFoEsGeJ7PgcIG2SFzqsPaG
	EMMjlrlQT7bP+4AanGs2YvysYf2TUv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XnJQb7U5X2b4L22rfD/V2zbWT/bPFbcdm0m2p+KNnK4=;
	b=IgXy7Q0fQKGqt591OgaX+s23HrfhBg1w5yI+r6ugDga0iVPpZEv3YHkdkx2Qqo9xaIP3T8
	2mklVhbSInqdlPDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XnJQb7U5X2b4L22rfD/V2zbWT/bPFbcdm0m2p+KNnK4=;
	b=QAuWD23B+VFhjXpDWFKl3ugsrCtkK7yATH/r3lugWAw3ffrW1BQNVkjAXns49u88XqZnVw
	qs1yvpmF+HYGcQiZT6cZE5QI4VS2RXUf9AuakICbW58lcSCNFoEsGeJ7PgcIG2SFzqsPaG
	EMMjlrlQT7bP+4AanGs2YvysYf2TUv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XnJQb7U5X2b4L22rfD/V2zbWT/bPFbcdm0m2p+KNnK4=;
	b=IgXy7Q0fQKGqt591OgaX+s23HrfhBg1w5yI+r6ugDga0iVPpZEv3YHkdkx2Qqo9xaIP3T8
	2mklVhbSInqdlPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 032345B1D4;
	Fri, 29 May 2026 06:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3o82O9MyGWqsIgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:31:47 +0000
Message-ID: <8c8eaf8b-1441-4701-8806-00b5748802f2@suse.de>
Date: Fri, 29 May 2026 08:31:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] block/blk-iocost: Add lock context annotations
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
References: <cover.1779997063.git.bvanassche@acm.org>
 <669c0e4dd3a8e8e038dff8c19aa61f0359df2bd8.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <669c0e4dd3a8e8e038dff8c19aa61f0359df2bd8.1779997063.git.bvanassche@acm.org>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On 5/28/26 21:45, Bart Van Assche wrote:
> Since iocg_lock() and iocg_unlock() both use conditional locking,
> annotate both with __no_context_analysis and use token_context_lock() to
> introduce a new lock context.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-iocost.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
