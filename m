Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C455224B03
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746170745; cv=none; b=CsRUoV5Euv42NHBKagYt19NnUYV+a9yNY+RExKIaWzKssd/EACApj4ZeGqTqqeMzasy118NncdQkkOQ5PCzIzPPdmhDxmEN8luhuO4LrfnDK6xvI+F3g3Q+jD3Hxkj8pE5djxckcn5ktGrmFOidrVaEe/BN0kkTCr2eK6H79CHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746170745; c=relaxed/simple;
	bh=8NHzMtXPii+u6K2yYR7EXXJvm3niEMwHp6Onj7Ovu7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svM8wJE/T7gLjetiNZEdmdMm80pIlNGCW4RSjRYgEwK+NX5r5uN/MDig1Ff6SeYfp3cd1EdgPfZWPIvEVE0B8efwBREjqm0+rDjNFHXkYfWh0+PuRybe9pnu+gPSCcnuF+FJ1fcdhGwDiDONs3saKcqSqYWBLI5DSSBVtrX9sIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bgz5d/OR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lOlCN19K; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bgz5d/OR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lOlCN19K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bgz5d/OR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lOlCN19K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bgz5d/OR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lOlCN19K"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BBA021A0B;
	Fri,  2 May 2025 07:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746170742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdycDKjOKhQw8kvWRatNLAyh1DS6YoulBU0STzXFB9o=;
	b=bgz5d/ORjq2WyEnWITalKiKSfNLvqh5iKg44/MYhjztW40nqGH2CM7ltAQhMe0CcRH9ikl
	4+UflUuEz3eN4Np298eNiz7jbL34Fnat717MXUCtC+rv4Hnf8xvStqQSqge2pE+gAykfcj
	wRY7wDfGPewPMp67BRawqF3PCgO01/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746170742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdycDKjOKhQw8kvWRatNLAyh1DS6YoulBU0STzXFB9o=;
	b=lOlCN19KLNsW7S1bNLkPjR9MJOiiMekh1yIJLBY8Kn3WVxLoamUMlxawbCmcC7MLnxCa02
	pAWFERu5oY0JhdCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746170742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdycDKjOKhQw8kvWRatNLAyh1DS6YoulBU0STzXFB9o=;
	b=bgz5d/ORjq2WyEnWITalKiKSfNLvqh5iKg44/MYhjztW40nqGH2CM7ltAQhMe0CcRH9ikl
	4+UflUuEz3eN4Np298eNiz7jbL34Fnat717MXUCtC+rv4Hnf8xvStqQSqge2pE+gAykfcj
	wRY7wDfGPewPMp67BRawqF3PCgO01/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746170742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdycDKjOKhQw8kvWRatNLAyh1DS6YoulBU0STzXFB9o=;
	b=lOlCN19KLNsW7S1bNLkPjR9MJOiiMekh1yIJLBY8Kn3WVxLoamUMlxawbCmcC7MLnxCa02
	pAWFERu5oY0JhdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC8F713687;
	Fri,  2 May 2025 07:25:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OhVJOHVzFGhlOAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 02 May 2025 07:25:41 +0000
Message-ID: <77d504d3-3998-4222-9e71-2e45f397a25d@suse.de>
Date: Fri, 2 May 2025 09:25:41 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] usb-storage: reject probe of device one non-DMA HCDs
 when using highmem
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Juergen E. Fischer" <fischer@norbit.de>,
 Alan Stern <stern@rowland.harvard.edu>,
 Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net, linux-mm@kvack.org
References: <20250502064930.2981820-1-hch@lst.de>
 <20250502064930.2981820-5-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250502064930.2981820-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,lst.de:email,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 5/2/25 08:49, Christoph Hellwig wrote:
> usb-storage is the last user of the block layer bounce buffering now,
> and only uses it for HCDs that do not support DMA on highmem configs.
> 
> Remove this support and fail the probe so that the block layer bounce
> buffering can go away.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/usb/storage/usb.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
