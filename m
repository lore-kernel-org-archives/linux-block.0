Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B7271479
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367612; cv=none; b=QiLOwRGhoBTUpRLPpv5ayOUlPZn2ulEKPvKXmxSwNHXOEFKbwL8sS//fN8KE29TH+8wzqTulhWH7seuhAmH7K3EyBCadOoGCGkMwa7JUPVbwgIloXlw9VlICpyYV0PXZYjwSdzNIJL5M7p/Vz53kdVeEvgU/Bxz4k9bwDyDAzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367612; c=relaxed/simple;
	bh=Dshf5p3XcW//mcUzDmTffF/gY5pMmPmlA7gsjjaMyug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDPZ3EpKwNpqv6/vhWb5MQAtud0+VufiGPEhVPEzkxGQ10ytGGdfjJjDd5Bei0X9SHmzilQvetr+BptNBCgQmwB8TI9BWvCtBTCkk19jLGPJsMKKADwCUvEwEVNCo9Sg8mexyuk6WmetWgVbsfjwsQx+pQDISb8K0X9nbUhNbSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tvaE9a+B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=etiAnCtp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uexkloDZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MwGOdLBY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tvaE9a+B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="etiAnCtp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uexkloDZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MwGOdLBY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E487E21199;
	Tue,  1 Jul 2025 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751367608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lnziZN4HaVPwYCs99ZQBQ0q1fMeCxubi23tdvggBPE=;
	b=tvaE9a+BuaP2nlRHCbqlaNw2/loKBF8M9VvFHCZrLPf0pMNFUrqFRuTH4jPUjb5NUcUfBC
	d2+wu0kVm0bfuAuLBu5UdVPU+1HjjuM3eZMl5IwstekpSrgnjSp1UVuJ4NAjXbe4ZAgHtF
	vhWA/VCAG7wsfKqjzpqranJ/Trx5QDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751367608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lnziZN4HaVPwYCs99ZQBQ0q1fMeCxubi23tdvggBPE=;
	b=etiAnCtpTNceoHFU2wxyTgogh35L9w60iZ41uVCfUyj3yGRMgQI5Ag47NFsHCLcf+bbPXq
	32tdEftS5GO2hHAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uexkloDZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MwGOdLBY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751367607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lnziZN4HaVPwYCs99ZQBQ0q1fMeCxubi23tdvggBPE=;
	b=uexkloDZ2KcqNcMo2fTSwTc2f5rPwvcve90EpSyJx/r3FYYDJIFYPREeBBIW37SK2Zv7d4
	fxBJCFm9r9DoiJ4gd6jtPI96G3jTLfbkCqmciqJ9nrfu1A9m4ikJPSJHXOnE9CedJTg2+1
	IY1QCVhgi9ADMR+6jwxxjIW2V4n95LE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751367607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lnziZN4HaVPwYCs99ZQBQ0q1fMeCxubi23tdvggBPE=;
	b=MwGOdLBY2JPVshZ1z7ohRJS1hOS4JWXCY0XY061/JOsBiQ6RDTBMptT4k7khNVE0wiFOzd
	AlysRUgLA2Wcb9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A505813890;
	Tue,  1 Jul 2025 11:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jiGxJre/Y2gWSwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 11:00:07 +0000
Message-ID: <b05b2c0e-a5f1-403c-978a-2fb39837d052@suse.de>
Date: Tue, 1 Jul 2025 13:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 3/3] block: fix potential deadlock while running
 nr_hw_queue update
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
 gjoyce@ibm.com
References: <20250701081954.57381-1-nilay@linux.ibm.com>
 <20250701081954.57381-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250701081954.57381-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E487E21199
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 7/1/25 10:19, Nilay Shroff wrote:
> Move scheduler tags (sched_tags) allocation and deallocation outside
> both the ->elevator_lock and ->freeze_lock when updating nr_hw_queues.
> This change breaks the dependency chain from the percpu allocator lock
> to the elevator lock, helping to prevent potential deadlocks, as
> observed in the reported lockdep splat[1].
> 
> This commit introduces batch allocation and deallocation helpers for
> sched_tags, which are now used from within __blk_mq_update_nr_hw_queues
> routine while iterating through the tagset.
> 
> With this change, all sched_tags memory management is handled entirely
> outside the ->elevator_lock and the ->freeze_lock context, thereby
> eliminating the lock dependency that could otherwise manifest during
> nr_hw_queues updates.
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> 
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-mq-sched.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
>   block/blk-mq-sched.h |  4 +++
>   block/blk-mq.c       | 16 +++++++++--
>   block/blk.h          |  3 +-
>   block/elevator.c     |  6 ++--
>   5 files changed, 88 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
