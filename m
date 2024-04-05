Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B264249F5
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298079; cv=none; b=mAucg3jp5csaXa9CvyPSTsfU3cfn27hTi0e5WctDgt1dH4swaqQg3mOr4MnaDAHKE4aY9rdLY0hpH1ODFRk4xb78P1xDttsSyyui/uHZrMEakg/2Kx9wLE3K/tymbUHFZkjhI4hG3h9rdUEtIx5VxQA17Q++xOSgv9So675Eh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298079; c=relaxed/simple;
	bh=Tu4YhthFeJyH0ZSfiRTQZK9Do5VSEphsSyS9xRej/ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=si0hhB56NNPn273zskmKdQ95zVdxaH2fc836OV0mO6QF3sdhD3ieQ2alNJwvb85g+uxWHNUFGkBmE/ohQvF/+n1aIx+4dVN5LU9uBDAdM2wND9Gmc+cmSNgUD+nWYRVObHxiEkNgxbgmCZQTASKjv8jIq0KrpiHwnc0QiMSy7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Um3syScX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z8UU39gg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Um3syScX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z8UU39gg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Um3syScX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z8UU39gg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Um3syScX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z8UU39gg"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F98821A19;
	Fri,  5 Apr 2024 06:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712298075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hQsz3NqchbdZqSfV77YRkvQmXrwp64p0MbAvfWY+jU=;
	b=Um3syScXlKMw2NkjDej/hWudhNtKE4lxorTKH25WmbDXGQJn8shG3ZrcH8zMDj+4JPGtRA
	iD35KR7oZyhEZY2mFEut+uuDRvB+O0rLkBrixHAuLBVwuurgs+egH3LG74zVmJjwl3lV0U
	UrlZqaTfMnb7SElIOsvsYZzBLFiz5qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712298075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hQsz3NqchbdZqSfV77YRkvQmXrwp64p0MbAvfWY+jU=;
	b=z8UU39gg8t45t7A5h+kWrLmAHPhKcNm6/Lr7/4y+R8LA/U7wwerrifMxb6vcpCScPxEQck
	lch6A4tg1hv3C6BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Um3syScX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=z8UU39gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712298075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hQsz3NqchbdZqSfV77YRkvQmXrwp64p0MbAvfWY+jU=;
	b=Um3syScXlKMw2NkjDej/hWudhNtKE4lxorTKH25WmbDXGQJn8shG3ZrcH8zMDj+4JPGtRA
	iD35KR7oZyhEZY2mFEut+uuDRvB+O0rLkBrixHAuLBVwuurgs+egH3LG74zVmJjwl3lV0U
	UrlZqaTfMnb7SElIOsvsYZzBLFiz5qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712298075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hQsz3NqchbdZqSfV77YRkvQmXrwp64p0MbAvfWY+jU=;
	b=z8UU39gg8t45t7A5h+kWrLmAHPhKcNm6/Lr7/4y+R8LA/U7wwerrifMxb6vcpCScPxEQck
	lch6A4tg1hv3C6BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B141E139E8;
	Fri,  5 Apr 2024 06:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CifVJ1qYD2a7GQAAn2gu4w
	(envelope-from <hare@suse.de>); Fri, 05 Apr 2024 06:21:14 +0000
Message-ID: <b255fca4-a9da-4364-a3af-eb699eeb4160@suse.de>
Date: Fri, 5 Apr 2024 08:21:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/2] block,nvme: latency-based I/O scheduler
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20240403141756.88233-1-hare@kernel.org>
 <Zg8YNrSnZPjR4kan@kbusch-mbp.dhcp.thefacebook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zg8YNrSnZPjR4kan@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4F98821A19
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 4/4/24 23:14, Keith Busch wrote:
> On Wed, Apr 03, 2024 at 04:17:54PM +0200, Hannes Reinecke wrote:
>> Hi all,
>>
>> there had been several attempts to implement a latency-based I/O
>> scheduler for native nvme multipath, all of which had its issues.
>>
>> So time to start afresh, this time using the QoS framework
>> already present in the block layer.
>> It consists of two parts:
>> - a new 'blk-nlatency' QoS module, which is just a simple per-node
>>    latency tracker
>> - a 'latency' nvme I/O policy
>   
> Whatever happened with the io-depth based path selector? That should
> naturally align with the lower latency path, and that metric is cheaper
> to track.

Turns out that tracking queue depth (on the NVMe level) always requires
an atomic, and with that a performance impact.
The qos/blk-stat framework is already present, and as the numbers show
actually leads to a performance improvement.

So I'm not quite sure what the argument 'cheaper to track' buys us here...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

