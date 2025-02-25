Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A01E5B85
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469607; cv=none; b=Vo5vzRoSXkaxWUXQTN2bvMn/NywWsub41ezCeoOKHHbQ3aXDzm7lUR6SstiW2uPorBeLp9QVcAD5AvhBU2rJSTi9O/2ETxXuxS5/bfJglbPPNpK0KMsl05lGvSJAOhpEtqx1gLFJ6swvrtPzyCtM8I1Km1DruSIdIbXaNCt1SrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469607; c=relaxed/simple;
	bh=PA63aClZh6QxvWI4TSCAXERu0XijwBd/9eNqPmMZjRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnDtA51gDRVzPkXLUtVEG1ZUZDtuPTfbwqV/HyKNoZVv7Yuywppg29tvErNo5dfyYdiUAWG1LdEEBLwZsnKT40xChs0/5u2yHcqU96zYgTOQMjBOmUMXEsOiZBtd73Oobus9Ocz5cyrZwpNVK/QyAs6MtRKgGfygY+6gHNX1re0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HoDdQe4H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q6pzZy04; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HoDdQe4H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q6pzZy04; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HoDdQe4H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q6pzZy04";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HoDdQe4H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q6pzZy04"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29E0D1F44F;
	Tue, 25 Feb 2025 07:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2MSjssaio8PlBGjRvWHUfAfDPItOWWutKRmNBEDEkk=;
	b=HoDdQe4HxRqRk5FWt17LLc3avA8/w1FCBJontyD8YHrCcfy3JCceW26Hzc58Xnzfdxjisd
	EWx78DOCudN4cntAo6XWdpteV2ZREFfecR5r40K2hpb+5p2GDBCVNnHNt0fz7gUoNgvfgE
	8AnQzzEiq855Dj68cCZHnxH8kbpkKhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2MSjssaio8PlBGjRvWHUfAfDPItOWWutKRmNBEDEkk=;
	b=q6pzZy04lxX2zEFdpWJr3GtZehYxAVSI1kbxoyRqkuH7rwmYW01qtJeDvyRt57VIJ6UfFm
	YeZeSeB7OWCXmbBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2MSjssaio8PlBGjRvWHUfAfDPItOWWutKRmNBEDEkk=;
	b=HoDdQe4HxRqRk5FWt17LLc3avA8/w1FCBJontyD8YHrCcfy3JCceW26Hzc58Xnzfdxjisd
	EWx78DOCudN4cntAo6XWdpteV2ZREFfecR5r40K2hpb+5p2GDBCVNnHNt0fz7gUoNgvfgE
	8AnQzzEiq855Dj68cCZHnxH8kbpkKhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2MSjssaio8PlBGjRvWHUfAfDPItOWWutKRmNBEDEkk=;
	b=q6pzZy04lxX2zEFdpWJr3GtZehYxAVSI1kbxoyRqkuH7rwmYW01qtJeDvyRt57VIJ6UfFm
	YeZeSeB7OWCXmbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D44DE13332;
	Tue, 25 Feb 2025 07:46:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fYMDMmN1vWc5cQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Feb 2025 07:46:43 +0000
Message-ID: <7464a878-a751-46c7-ad95-5bbacb9cd071@suse.de>
Date: Tue, 25 Feb 2025 08:46:43 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 3/7] block: remove q->sysfs_lock for attributes which
 don't need it
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
 gjoyce@ibm.com
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
 <20250224133102.1240146-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250224133102.1240146-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 2/24/25 14:30, Nilay Shroff wrote:
> There're few sysfs attributes in block layer which don't really need
> acquiring q->sysfs_lock while accessing it. The reason being, reading/
> writing a value from/to such attributes are either atomic or could be
> easily protected using READ_ONCE()/WRITE_ONCE(). Moreover, sysfs
> attributes are inherently protected with sysfs/kernfs internal locking.
> 
> So this change help segregate all existing sysfs attributes for which
> we could avoid acquiring q->sysfs_lock. For all read-only attributes
> we removed the q->sysfs_lock from show method of such attributes. In
> case attribute is read/write then we removed the q->sysfs_lock from
> both show and store methods of these attributes.
> 
> We audited all block sysfs attributes and found following list of
> attributes which shouldn't require q->sysfs_lock protection:
> 
> 1. io_poll:
>     Write to this attribute is ignored. So, we don't need q->sysfs_lock.
> 
> 2. io_poll_delay:
>     Write to this attribute is NOP, so we don't need q->sysfs_lock.
> 
> 3. io_timeout:
>     Write to this attribute updates q->rq_timeout and read of this
>     attribute returns the value stored in q->rq_timeout Moreover, the
>     q->rq_timeout is set only once when we init the queue (under blk_mq_
>     init_allocated_queue()) even before disk is added. So that means
>     that we don't need to protect it with q->sysfs_lock. As this
>     attribute is not directly correlated with anything else simply using
>     READ_ONCE/WRITE_ONCE should be enough.
> 
> 4. nomerges:
>     Write to this attribute file updates two q->flags : QUEUE_FLAG_
>     NOMERGES and QUEUE_FLAG_NOXMERGES. These flags are accessed during
>     bio-merge which anyways doesn't run with q->sysfs_lock held.
>     Moreover, the q->flags are updated/accessed with bitops which are
>     atomic. So, protecting it with q->sysfs_lock is not necessary.
> 
That's not the point; point is that the queue is frozen when updating so
blk-merge will never see an incomplete update.
But that's a minor issue and doesn't affect the patch itself.

> 5. rq_affinity:
>     Write to this attribute file makes atomic updates to q->flags:
>     QUEUE_FLAG_SAME_COMP and QUEUE_FLAG_SAME_FORCE. These flags are
>     also accessed from blk_mq_complete_need_ipi() using test_bit macro.
>     As read/write to q->flags uses bitops which are atomic, protecting
>     it with q->stsys_lock is not necessary.
> 
> 6. nr_zones:
>     Write to this attribute happens in the driver probe method (except
>     nvme) before disk is added and outside of q->sysfs_lock or any other
>     lock. Moreover nr_zones is defined as "unsigned int" and so reading
>     this attribute, even when it's simultaneously being updated on other
>     cpu, should not return torn value on any architecture supported by
>     linux. So we can avoid using q->sysfs_lock or any other lock/
>     protection while reading this attribute.
> 
> 7. discard_zeroes_data:
>     Reading of this attribute always returns 0, so we don't require
>     holding q->sysfs_lock.
> 
> 8. write_same_max_bytes
>     Reading of this attribute always returns 0, so we don't require
>     holding q->sysfs_lock.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-settings.c |  2 +-
>   block/blk-sysfs.c    | 81 +++++++++++++++-----------------------------
>   2 files changed, 29 insertions(+), 54 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
