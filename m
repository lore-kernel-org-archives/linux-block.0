Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C257DA6D
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301985; cv=none; b=nRgRkI9MEKG8RnykqXOpqz6xMJDjP8Ngwy1/rEEXlkPng5RWzZYHfWqS9Z0f+EEhfgvEagvsTIPowBz2moVILvxtkoaiiZXZxh+diJUjZQKSrIJ3+RRKkfyM7+BWRNzduQxC3pgDxRaBBO8KCjOyEfFr3t0PWhGGaa1POOl+0YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301985; c=relaxed/simple;
	bh=bwbENWi/NVp/uBVIg3FoIVWrg2cU8sEjszgEWWsG3oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBzn2SjHwPJ9q075R6Ahfd3Geq+QJfELKfaH5MfFZLz/sRX/rtVnxXd3fQulBZpdMH1fGVL693pR8+0gKME1jXzIahW53O2hsslCqxDUuC7mR7q9dwJ8STRqWQ/ReLpxazBmh0TA5WkeuQNAGAvIedqOnnDj1U9MEJ/r2ougzWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NmL+LwTZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vzb0X3Pf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NmL+LwTZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vzb0X3Pf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NmL+LwTZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vzb0X3Pf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NmL+LwTZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vzb0X3Pf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 418C521257;
	Tue, 22 Apr 2025 06:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745301981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znez1bn9CNCEHXU8pY9el32iycJ4p21yrYX4sJROvag=;
	b=NmL+LwTZ5DitFzE7pgizDHf8dG8mgjopUkEuRESgukwOXlEJl5ybvJbIO+o8y/FiHozlWl
	bFGT4eQAiYgG0tagYBLfD2ofGQcUpmknwGZm4VHeoKoHcP7vkXQO6Di0qCGHr112+tyG1m
	ttlFVZg2TMYTqNvF+Biju+mUMgtaXbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745301981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znez1bn9CNCEHXU8pY9el32iycJ4p21yrYX4sJROvag=;
	b=Vzb0X3PflPQC+McPxB7unDJvWdar61W6rsYRTWIDld1U72ifLQt/SMMFlxgZJ8+iG/HguK
	eXsCBoIMOBjNdICA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745301981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znez1bn9CNCEHXU8pY9el32iycJ4p21yrYX4sJROvag=;
	b=NmL+LwTZ5DitFzE7pgizDHf8dG8mgjopUkEuRESgukwOXlEJl5ybvJbIO+o8y/FiHozlWl
	bFGT4eQAiYgG0tagYBLfD2ofGQcUpmknwGZm4VHeoKoHcP7vkXQO6Di0qCGHr112+tyG1m
	ttlFVZg2TMYTqNvF+Biju+mUMgtaXbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745301981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znez1bn9CNCEHXU8pY9el32iycJ4p21yrYX4sJROvag=;
	b=Vzb0X3PflPQC+McPxB7unDJvWdar61W6rsYRTWIDld1U72ifLQt/SMMFlxgZJ8+iG/HguK
	eXsCBoIMOBjNdICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA74139D5;
	Tue, 22 Apr 2025 06:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OOP5N9wxB2gLIwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 06:06:20 +0000
Message-ID: <461f33c5-8fb7-410f-a018-44a5f6ef6edb@suse.de>
Date: Tue, 22 Apr 2025 08:06:20 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/20] block: move sched debugfs register into
 elvevator_register_queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-6-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250418163708.442085-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/18/25 18:36, Ming Lei wrote:
> sched debugfs shares same lifetime with scheduler's kobject, and same
> lock(elevator lock), so move sched debugfs register/unregister into
> elevator_register_queue() and elevator_unregister_queue().
> 
> Then we needn't blk_mq_debugfs_register() for us to register sched
> debugfs any more.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c | 11 -----------
>   block/blk-mq-sched.c   | 11 ++---------
>   block/elevator.c       |  8 ++++++++
>   block/elevator.h       |  3 +++
>   4 files changed, 13 insertions(+), 20 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
