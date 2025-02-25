Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568572571AE
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469791; cv=none; b=rC8MZQGfOcgFRVL0Vk/csOTqxcam+iHUhJPhcR0VHql/M3wD/po8oc2voy6TiHcQqPvML45ZJb/8uSGXJ0DR2420a/FZo5CxyVTlk5nuOG/a/M/PAFBd+KNkb5IWPMv+jgxeLoLvJqYBjBqvi53dt+eSLfh7RgN28Kd1jjbLFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469791; c=relaxed/simple;
	bh=LI74NX3K2PiDCmUSvfh0t6Ct6rr26lPHRlsuyHPD5PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utMFynQE5KzOweu82w1p5Cfta/cWpawFMfatmGfJdO1zPpUL20lUVNTdy1oC+NCrHmG4RJ/nqTqF7GH4QjHa6XQZPFqQ4JZMRKB+n10kRjcL0qAktkSGN09mLw1nf1WHBJ8aM186lwvryl8hOUIanFDN+i4Ai3zmoT2SkDm5Z28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fiCrfkGJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3IjFdxzP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fiCrfkGJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3IjFdxzP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fiCrfkGJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3IjFdxzP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fiCrfkGJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3IjFdxzP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F76A1F44F;
	Tue, 25 Feb 2025 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtAC3K6CHJCgGDq3T8PQrNOiF6HVcdt8QuBcBT7FQQs=;
	b=fiCrfkGJmQC2ZT5z7YvjTIcF6W4mtlOdN5eUcJIR0jEfllvXrrN2hml/4GRIbL0ZeXs8cV
	0OIOHceqfjhy4PcJIcy6GunCxSSHCDhM+ZrQLizcnif2fL7daj8+tSKezdbVce79kM8rUj
	9+7ERG/Y2EJqn3SwxOTgVljfohUwIws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtAC3K6CHJCgGDq3T8PQrNOiF6HVcdt8QuBcBT7FQQs=;
	b=3IjFdxzPKv203q05p7RrlT6Kay3i887sWgQfwblShC4oq+tmWxsxSjf/Fo4ONqufGnaGlY
	vILOhnnLMkCEO5Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtAC3K6CHJCgGDq3T8PQrNOiF6HVcdt8QuBcBT7FQQs=;
	b=fiCrfkGJmQC2ZT5z7YvjTIcF6W4mtlOdN5eUcJIR0jEfllvXrrN2hml/4GRIbL0ZeXs8cV
	0OIOHceqfjhy4PcJIcy6GunCxSSHCDhM+ZrQLizcnif2fL7daj8+tSKezdbVce79kM8rUj
	9+7ERG/Y2EJqn3SwxOTgVljfohUwIws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtAC3K6CHJCgGDq3T8PQrNOiF6HVcdt8QuBcBT7FQQs=;
	b=3IjFdxzPKv203q05p7RrlT6Kay3i887sWgQfwblShC4oq+tmWxsxSjf/Fo4ONqufGnaGlY
	vILOhnnLMkCEO5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3793A13332;
	Tue, 25 Feb 2025 07:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oK/SCxx2vWcAcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Feb 2025 07:49:48 +0000
Message-ID: <0a42ee15-43ad-453a-84b4-015b391a2eef@suse.de>
Date: Tue, 25 Feb 2025 08:49:47 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 4/7] block: Introduce a dedicated lock for protecting
 queue elevator updates
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
 gjoyce@ibm.com
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
 <20250224133102.1240146-5-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250224133102.1240146-5-nilay@linux.ibm.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/24/25 14:30, Nilay Shroff wrote:
> A queue's elevator can be updated either when modifying nr_hw_queues
> or through the sysfs scheduler attribute. Currently, elevator switching/
> updating is protected using q->sysfs_lock, but this has led to lockdep
> splats[1] due to inconsistent lock ordering between q->sysfs_lock and
> the freeze-lock in multiple block layer call sites.
> 
> As the scope of q->sysfs_lock is not well-defined, its (mis)use has
> resulted in numerous lockdep warnings. To address this, introduce a new
> q->elevator_lock, dedicated specifically for protecting elevator
> switches/updates. And we'd now use this new q->elevator_lock instead of
> q->sysfs_lock for protecting elevator switches/updates.
> 
> While at it, make elv_iosched_load_module() a static function, as it is
> only called from elv_iosched_store(). Also, remove redundant parameters
> from elv_iosched_load_module() function signature.
> 
> [1] https://lore.kernel.org/all/67637e70.050a0220.3157ee.000c.GAE@google.com/
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-core.c       |  1 +
>   block/blk-mq.c         | 15 +++++++--------
>   block/blk-sysfs.c      | 32 ++++++++++++++++++++++----------
>   block/elevator.c       | 35 ++++++++++++++++-------------------
>   block/elevator.h       |  2 --
>   block/genhd.c          |  9 ++++++---
>   include/linux/blkdev.h |  5 +++++
>   7 files changed, 57 insertions(+), 42 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
