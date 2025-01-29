Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97D86A33F
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738133252; cv=none; b=nTch4AtonJBUn6IT7fpD60lb0U0jmYgAFgTB+7SJVC3ukFal/YyvpcmmFBGC6l4Ayz7SOQ3+riI0At8CsZBIr6LRRwggBu+wkqB14CCHeR+aaFTF2qVTqYKyB+Fk8ebcPAZjF0a9ByTyeoesJ/Nm1lFw8SxxVORpuxEXLIfyTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738133252; c=relaxed/simple;
	bh=2qzY+ir8hdE6PW6xqY6S/48m1ECHrJkFHnastDM+J4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3xVPS2Eo3rM2dXEbSjnSneKXAhA5Y4LaCUUura2Id8dZsFlvhGZR6s9FRA0h14ewI2lOxos+IhY+DhuKU5WSz+bUOHrobfM16cu/ng/XF3SXY0obyoVUwzIXKZwcmMC3NCRXYqzMCJUueXCK1P6ok2/ATZj88je7EtFAN1qI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GqPg8Jez; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E15KA4xr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GqPg8Jez; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E15KA4xr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GqPg8Jez";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E15KA4xr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GqPg8Jez";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E15KA4xr"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A3F31F365;
	Wed, 29 Jan 2025 06:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738133247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gtIZOSk3enw/QUP8eLfDrfZ+vdpswptAFzuAX81EXY=;
	b=GqPg8Jez7rq7EWjOO00vuVM/vWDtr+Ma2GK+smNHd19Rp5G8HbalCC70NQQ6wBHl9SzOMI
	r8hrtzUehCa1U4/YudJur8zbq7cPbRgSghZdwa4LI+Cs1wmGUo1H8WZ4e86inxgjrs/5Xq
	GBeA1yxAOR20h013whH0g7m0B2fUALw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738133247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gtIZOSk3enw/QUP8eLfDrfZ+vdpswptAFzuAX81EXY=;
	b=E15KA4xrtmyZkPsK09CPBVh03BohHf/BBupMA6T8DaRzo5/0vFsAWoG8gNHVchUvQMhpZb
	nUdeshiZUWOk+pAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738133247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gtIZOSk3enw/QUP8eLfDrfZ+vdpswptAFzuAX81EXY=;
	b=GqPg8Jez7rq7EWjOO00vuVM/vWDtr+Ma2GK+smNHd19Rp5G8HbalCC70NQQ6wBHl9SzOMI
	r8hrtzUehCa1U4/YudJur8zbq7cPbRgSghZdwa4LI+Cs1wmGUo1H8WZ4e86inxgjrs/5Xq
	GBeA1yxAOR20h013whH0g7m0B2fUALw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738133247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gtIZOSk3enw/QUP8eLfDrfZ+vdpswptAFzuAX81EXY=;
	b=E15KA4xrtmyZkPsK09CPBVh03BohHf/BBupMA6T8DaRzo5/0vFsAWoG8gNHVchUvQMhpZb
	nUdeshiZUWOk+pAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2139B13AE1;
	Wed, 29 Jan 2025 06:47:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s9ixBf/OmWdHeAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 29 Jan 2025 06:47:27 +0000
Message-ID: <b520a3ae-5199-4246-aba3-76c060401de4@suse.de>
Date: Wed, 29 Jan 2025 07:47:26 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 1/2] block: get rid of request queue
 ->sysfs_dir_lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
 gjoyce@ibm.com
References: <20250128143436.874357-1-nilay@linux.ibm.com>
 <20250128143436.874357-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250128143436.874357-2-nilay@linux.ibm.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 1/28/25 15:34, Nilay Shroff wrote:
> The request queue uses ->sysfs_dir_lock for protecting the addition/
> deletion of kobject entries under sysfs while we register/unregister
> blk-mq. However kobject addition/deletion is already protected with
> kernfs/sysfs internal synchronization primitives. So use of q->sysfs_
> dir_lock seems redundant.
> 
> Moreover, q->sysfs_dir_lock is also used at few other callsites along
> with q->sysfs_lock for protecting the addition/deletion of kojects.
> One such example is when we register with sysfs a set of independent
> access ranges for a disk. Here as well we could get rid off q->sysfs_
> dir_lock and only use q->sysfs_lock.
> 
> The only variable which q->sysfs_dir_lock appears to protect is q->
> mq_sysfs_init_done which is set/unset while registering/unregistering
> blk-mq with sysfs. But use of q->mq_sysfs_init_done could be easily
> replaced using queue registered bit QUEUE_FLAG_REGISTERED.
> 
> So with this patch we remove q->sysfs_dir_lock from each callsite
> and replace q->mq_sysfs_init_done using QUEUE_FLAG_REGISTERED.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-core.c       |  1 -
>   block/blk-ia-ranges.c  |  4 ----
>   block/blk-mq-sysfs.c   | 23 +++++------------------
>   block/blk-sysfs.c      |  5 -----
>   include/linux/blkdev.h |  3 ---
>   5 files changed, 5 insertions(+), 31 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
