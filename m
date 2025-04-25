Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761318D
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563662; cv=none; b=gfcDAUo3BAiQze+JzVXHP2cEo46pLzhJNIpmXNOnzHEGuDmmyeGW7cfVA0x+xR0+Yo4IymQADU4mzXQW4wp6iFgTohYPqf21vfpJKfNBPJ1jJWxBrGG2UMai2x6F5pjoqUN7K0qK6/5yfz1ZVntVGJ1WPGNZSeLfCw0UmDm5SGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563662; c=relaxed/simple;
	bh=cNCFlSHTIVdZR9qf8B/8CcO2e9W8IV+1hkZvCVyMwVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRcdJOj4BGsCTO/UTC42r8iXhrUyOt7tZacZNXrFpKdNg/jM2fivmeK2Pr55XZPP9Va782LUPJnSwYly545HdC9bRXNp4UcM1tZGtFsmXCPn/55o7EM4clhFyNMxksfbUdpZO2nP5pZnI5dnex4AIJX7HJq+N9oGsFwPrbgUL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KnGULEVX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FDg3Kw1e; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KnGULEVX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FDg3Kw1e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KnGULEVX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FDg3Kw1e";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KnGULEVX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FDg3Kw1e"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FB0E1F38D;
	Fri, 25 Apr 2025 06:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Rme/XBDQVdWOWS9gvb/2M9fgkVhlorMN3RbVDi3vAw=;
	b=KnGULEVXd82PzrdHgzIe8alE5kTLldBQnlnPqkOb/ZiXorDQefNVVBqTftKpzD6L23/Ywq
	CbcCZZVroW5HAdYuO4b6GIVcZzC1USxOt7huqkTB/YyR0FFgnR3xqegv6V/5uTU3M5Dkgn
	WR/8dddzniaGAPnp0eyjHAQEAwd+rK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Rme/XBDQVdWOWS9gvb/2M9fgkVhlorMN3RbVDi3vAw=;
	b=FDg3Kw1e7RbysibindmYuEY2sVb5PajOJNpwQ1GEEYR6Sydi8AYx81JkeZYP0BVY4DlnCm
	3RjFfsjGylMv1BCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KnGULEVX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FDg3Kw1e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Rme/XBDQVdWOWS9gvb/2M9fgkVhlorMN3RbVDi3vAw=;
	b=KnGULEVXd82PzrdHgzIe8alE5kTLldBQnlnPqkOb/ZiXorDQefNVVBqTftKpzD6L23/Ywq
	CbcCZZVroW5HAdYuO4b6GIVcZzC1USxOt7huqkTB/YyR0FFgnR3xqegv6V/5uTU3M5Dkgn
	WR/8dddzniaGAPnp0eyjHAQEAwd+rK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Rme/XBDQVdWOWS9gvb/2M9fgkVhlorMN3RbVDi3vAw=;
	b=FDg3Kw1e7RbysibindmYuEY2sVb5PajOJNpwQ1GEEYR6Sydi8AYx81JkeZYP0BVY4DlnCm
	3RjFfsjGylMv1BCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AC3C13A79;
	Fri, 25 Apr 2025 06:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id glsGAQowC2jmYwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:47:38 +0000
Message-ID: <1c76ff8c-0a51-4a1f-b388-dc93d533d47b@suse.de>
Date: Fri, 25 Apr 2025 08:47:37 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 17/20] block: move debugfs/sysfs register out of
 freezing queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-18-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-18-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5FB0E1F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/24/25 17:21, Ming Lei wrote:
> Move debugfs/sysfs register out of freezing queue in
> __blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
> can be killed:
> 
> 	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
> 	#1 (fs_reclaim){+.+.}-{0:0}:
> 	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs
> 
> And registering/un-registering debugfs/sysfs does not require queue to be
> frozen.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
