Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5932B267B68
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555191; cv=none; b=kSrVhvptAlkSMRbNnIvvx0LdOpxVnWLJDwZ6tk606iz7XbDSguayUSpd9anhp5+72gEg+c+PI0PnmW/LLUc4/8d/WWj3AUpQDJ1kxbBnBD7zfwKUZWRYXq22IMU1vDhcdU4PWlr4Uka2FBJQucmCWDQspSTgIK04pcExvasH2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555191; c=relaxed/simple;
	bh=zAv9u1Phzn7Tvx7HaGlQ2l54AdPOpy8DjEGnkJR4BnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwHSQv3ZsXqEDd7o5fSC7EECz/dCtT+cat6gXhg6qRKZkIURgMWtcl5Y7IOO/qDUy6tZE+kuGfH9LOkM5XjNe0m99AEq3y+HCkdmfEWSx9w/3mnsFqM/j1jOxSseRDXq+QqgkQ6ykepTMMQtv06CRZAZpxK6NU5lBpehv1vWvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=04dav0se; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UHDz8p24; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VZl0feZ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gtBs4u78; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="04dav0se";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UHDz8p24";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VZl0feZ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gtBs4u78"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C2F21F387;
	Wed, 26 Feb 2025 07:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740555188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnHcMG9VTb5hu3nbXK7lGRCLoaUHL2KDAugvchKRNU0=;
	b=04dav0sebPvfZxRk9Kzctx5fNqz8pz2ZSrs/E6MYhrE3Bi56+W0g99GDb9y96IxnnxqftG
	EUEpz/mNUXS/JuWKqOwwZ7L/Ni0zxdkIjSNR0nGSg3zPwN7Z7QQISkNIE5ZYs6uzJYr+PM
	7e7jsWX4mFn8ZopoIXqmcVPyE1jBmeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740555188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnHcMG9VTb5hu3nbXK7lGRCLoaUHL2KDAugvchKRNU0=;
	b=UHDz8p24l5ZVdWKKFsEW/jvlxge1VMZoOtUMFhtbKPy2LNTNBhzya9rhpXDCjISukTceK1
	Fk1mIdgj90mJoxAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740555187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnHcMG9VTb5hu3nbXK7lGRCLoaUHL2KDAugvchKRNU0=;
	b=VZl0feZ3wCAtVWVtYyLG861oTB4Y8+cNxpejoBxrcoOxXjV4+/05zHeQD+f2cY4QcaDlAh
	ggdvu0tFEuX0syH3VbrcPcVZFCumRrXT7ME5O9sFulA8By6haZ9IaS4qi52hZevuKZaYOI
	q16UPH+Aw8kleUx0HC0JGOtr3a+e5mY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740555187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnHcMG9VTb5hu3nbXK7lGRCLoaUHL2KDAugvchKRNU0=;
	b=gtBs4u78rMHwOCTijf9Wl1j2Zpii3xLfZcimyAJsqJOja5+adnilUT8+eqRPPFIv+YaPTf
	nUVGO8vIRoxF13Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B13513A53;
	Wed, 26 Feb 2025 07:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id naENAbPDvmdyNAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 26 Feb 2025 07:33:07 +0000
Message-ID: <f977113c-8fe9-4d01-870f-529df9f26ea8@suse.de>
Date: Wed, 26 Feb 2025 08:33:06 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 6/7] block: protect wbt_lat_usec using q->elevator_lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
 gjoyce@ibm.com
References: <20250225133110.1441035-1-nilay@linux.ibm.com>
 <20250225133110.1441035-7-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250225133110.1441035-7-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 2/25/25 14:30, Nilay Shroff wrote:
> The wbt latency and state could be updated while initializing the
> elevator or exiting the elevator. It could be also updates while
> configuring IO latency QoS parameters using cgroup. The elevator
> code path is now protected with q->elevator_lock. So we should
> protect the access to sysfs attribute wbt_lat_usec using q->elevator
> _lock instead of q->sysfs_lock. White we're at it, also protect
> ioc_qos_write(), which configures wbt parameters via cgroup, using
> q->elevator_lock.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-iocost.c |  2 ++
>   block/blk-sysfs.c  | 20 ++++++++------------
>   2 files changed, 10 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
