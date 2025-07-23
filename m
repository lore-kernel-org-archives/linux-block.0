Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFC2F5C3D
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284562; cv=none; b=tlc4uNsA/g8f7/MBfGRbGudRoqoo+cokX/5e1FCTAXwBnckJtosvCLpa8z+ulqqM4vAfD3HxRPykoLqk6wcyvBkykuik5O+991xIQ8iVp78s9AkeeRjmnYAX5ovzMRKaVSkb3N25mziogH60RUQD11SpENWueZPSpqZhiS1AI00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284562; c=relaxed/simple;
	bh=3PQjgfro9/jXlZIqFrscT4n1ucciOEw1LfO76PJ0Zqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fk3aXJ9I8s7MLigtfq3EFCCSZ+wzS1iMy7lqmeiV07VZwLvmp1z0E4cskd1HqVyb3Xrucfn25/Hn3vVjVufJ6OxK5pDWqvyIm3fKWznUHof2VSrjYWwlzRAIc3jAWq8dYIijeKWrtN0bwIWUH15tq9qCL08yYsHegwy8ghzglRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CyCwFSaE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=75CwH9zX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yac+c1x4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UBcvdgGe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CyCwFSaE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="75CwH9zX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yac+c1x4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UBcvdgGe"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 54A4F1F790;
	Wed, 23 Jul 2025 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753284558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SmvVbmjVOnywz8s4KlKQ0HT75IQJMQP4zilWietuRM=;
	b=CyCwFSaEPQxviAiyBY+ggLlx1a2tYkATzUWMGXHGMrfYe9fkdJrUfMZ+oDCZ48wtAdSsOd
	GbkoQbRxf1/JTZjOZpkVfWNZTZhIWZX2kbmte1dkCr75sGsqNArIjOO2SmTt3lP9rsRYBy
	tFDcgJ2Im7myixZqRnp0YjqPM7TLhjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753284558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SmvVbmjVOnywz8s4KlKQ0HT75IQJMQP4zilWietuRM=;
	b=75CwH9zXRYWEdP4cPbBYB03t1w16r7y3pPCZUUUWwgDS44kg/bG3PQ5TdTk6YuIfKk7fWB
	Y3E74HRJFyX33BAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753284557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SmvVbmjVOnywz8s4KlKQ0HT75IQJMQP4zilWietuRM=;
	b=yac+c1x4NUBNb2m+xyuXwfSg/8tzOTc8C7LX06BfdcrjpFfxCGlRX8/2TtvZxnXN7eBOqG
	5KwR5UdOFbo5HKtRAozO+HTkP9srgCUWbErJ5HCIvK7BjQtRsKe/aO17mk2aXWDr7/kPym
	ZZUqrj1tz2tLcQB1snTUsX7UAfdi5g8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753284557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SmvVbmjVOnywz8s4KlKQ0HT75IQJMQP4zilWietuRM=;
	b=UBcvdgGe+wUPyxkJTv+qb0irU+xRhR8IB0cgmbnlGomgnsScuyBip01mL7+8ZqMkOqPK5l
	G/iXX7F0tcsubEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1811013302;
	Wed, 23 Jul 2025 15:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bZ2kBM3/gGjIRQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 23 Jul 2025 15:29:17 +0000
Message-ID: <03327105-b5e7-42c6-942f-218ba6fd110d@suse.de>
Date: Wed, 23 Jul 2025 17:29:16 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/2] null_blk: prevent submit and poll queues update for
 shared tagset
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, dlemoal@kernel.org, yukuai1@huaweicloud.com,
 ming.lei@redhat.com, axboe@kernel.dk, johannes.thumshirn@wdc.com,
 gjoyce@ibm.com
References: <20250723134442.1283664-1-nilay@linux.ibm.com>
 <20250723134442.1283664-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250723134442.1283664-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/23/25 15:43, Nilay Shroff wrote:
> When a user updates the number of submit or poll queues on a null_blk
> device, the block layer creates new hardware queues (hctxs). However, if
> the device is using a shared tagset, null_blk does not map any software
> queues (ctx) to the newly created hctx (via null_map_queues()), resulting
> in those hardware queues being left unused for I/O. This behavior is
> misleading, as the user may expect the new queues to be functional, even
> though they are effectively ignored. To avoid this confusion and potential
> misconfiguration:
> - Reject runtime updates to submit_queues or poll_queues via sysfs when
>    the device uses a shared tagset by returning -EINVAL.
> - During configuration validation (prior to powering on the device), reset
>    submit_queues and poll_queues to the module parameters (g_submit_queues
>    and g_poll_queues) if the shared tagset is enabled.
> 
> This ensures consistent behavior and avoids creating unused hardware queues
> (hctxs) due to ineffective runtime queue updates.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/block/null_blk/main.c | 32 ++++++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 10 deletions(-)
> 
Reviwed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
