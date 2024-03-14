Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C36BB2F
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414683; cv=none; b=JDukJKXCDIUzy85FoFswgYmnI0B5Ichynn1k3dcsXmJWMhDKNlgiFEAiC+cLCL8lgAeJE9/P+Zk+X/wTa0TyiEYGOd1L14zL6kx/gzr8GqqbqmDeI/D5i0qnGZeZwxpJdV8MkAA+ITWLO+I2SNcm02BBI5AxtIs5dbKwdWh5d1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414683; c=relaxed/simple;
	bh=P+m+O7sV8DJGBecxlDsA/ZgtdEhvWYPqlNa0vOf+KOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEKAHb6tnSDprCOjIcvu8vTOaifzzOhxFxU05EuB7Eq88yIeRGR+b2H45snh/LhSRbUT+OwYhee9cFQIs3WBcRradcNOlowTnjRLd391AuSc/s2CnkMb0zWhZChRCf0Z3UDFyEISiMFsHAlSMLlx4Jc1mYpowzmKkuEbAp5x0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dA3hZZsb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZvCMRLuf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nMAuxX+V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lr6ZdZWu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dA3hZZsb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZvCMRLuf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nMAuxX+V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lr6ZdZWu"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C227921940;
	Thu, 14 Mar 2024 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710414680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+0GCPTxz5vbimKHK5Ubp44Hcp2QBp7tdBrr4d8qZUw=;
	b=dA3hZZsbLnTduYtbPU5Xy1LWBT5ZL0idRwcdyxniTK1dsexH9N1pyV1+OQ5Y2PKL8BNIkk
	Xv9yz8JLRgUuNdgRg1ko1Jl4wnTd0QqmY0Yq3a0t2TYzX9A6KvLXqsmDnbrXPCrp1GBl8l
	xes9u8s/oO8ZnJQmmuWv951tGrJbH1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710414680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+0GCPTxz5vbimKHK5Ubp44Hcp2QBp7tdBrr4d8qZUw=;
	b=ZvCMRLufTxpjpqhxF2LIVnHQTgl1A/b7ptkThp11sf98XCacoFvD1P+i9f9ZEo0o5XpVC8
	qp8vX4iYfYiDGSCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710414679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+0GCPTxz5vbimKHK5Ubp44Hcp2QBp7tdBrr4d8qZUw=;
	b=nMAuxX+VBbTHqa7aEbYVL1TD1QGlFHl14fbKlqdLbxwOmDkVbjyCzEIeVHLReNy3kf7weG
	GPuhEur0hcswZhHnRhL0NfCoD4StpdbTv0GP8HiuOmYgBJ3Zxgzai4HGfDbLuzPcZB6s+4
	CgpH/qwIpVi09wncPEm7KeSNDaQ+Dzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710414679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+0GCPTxz5vbimKHK5Ubp44Hcp2QBp7tdBrr4d8qZUw=;
	b=lr6ZdZWuwwA5D7DJL801T9EuiAIKmy3oe1a8KPPoryPpZJ1GXMBuK7OoLUKz/t6m2hui9O
	tTkYs1wbFLrUc4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 890371386E;
	Thu, 14 Mar 2024 11:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HvxkH1fb8mViXQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 14 Mar 2024 11:11:19 +0000
Message-ID: <886d8bde-e608-4e15-b13d-c891b4689b4f@suse.de>
Date: Thu, 14 Mar 2024 12:11:18 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brd in a memdesc world
To: Matthew Wilcox <willy@infradead.org>, Pankaj Raghav <p.raghav@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <CGME20240312174020eucas1p29cf41360c934c674fd1f36a808078e25@eucas1p2.samsung.com>
 <ZfCTfa9gfZwnCie0@casper.infradead.org>
 <d470e16b-b7bf-451e-a6e2-eb68adcc2635@samsung.com>
 <ZfHwXLr54bWl1fns@casper.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZfHwXLr54bWl1fns@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nMAuxX+V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lr6ZdZWu
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: C227921940
X-Spam-Flag: NO

On 3/13/24 19:28, Matthew Wilcox wrote:
> On Wed, Mar 13, 2024 at 06:15:26PM +0100, Pankaj Raghav wrote:
>> On 12/03/2024 18:40, Matthew Wilcox wrote:
>>> Hi Jens,
>>>
>>> I'm looking for an architecture-level decision on what the brd driver
>>> should look like once struct page has been shrunk to a minimal size
>>> (more detail at https://protect2.fireeye.com/v1/url?k=fdf5d9a0-9c7ecc9a-fdf452ef-74fe4860008a-d5306bf365c2b9b6&q=1&e=cbceae8b-61fb-4e3e-8f7c-6717d9b2431d&u=https%3A%2F%2Fkernelnewbies.org%2FMatthewWilcox%2FMemdescs )
>>>
>>> Currently brd uses page->index as a debugging check.  In the memdesc
>>> future, struct page has no members (you could store a small amount of
>>> information in it, but I'm not willing to commit to more than a few bits).
>>>
>>
>> Shouldn't we change brd to use folios? Once we do that, this will not
>> be a problem any more right?
> 
> We certainly could change brd to use folios.  But why would we want to?
> Hannes' work always allocates memory of a fixed size (a fixed multiple
> of PAGE_SIZE).  Folios are a medium-weight data structure (probably
> about 80 bytes once we get to memdescs).  They support a lot of things,
> eg belonging to an inode, having an index, being mappable to userspace,
> being lockable, accountable to memcgs, allowing extra private data,
> knowing their own size, ...
> 
> None of those things are needed for brd's uses.  All brd needs is to
> be able to allocate, kmap and free chunks of memory.  Unless there are
> plans to do more than this.
> 
The primary goal of my patchset is to make brd a test-bed for the LBS 
work; devices with a sector size larger than 4k are really hard to come
by. But really, it's just a testbed, and I'm not sure whether there's
a need for that in the general audience.
I can resubmit if you want ...

As for the memory overhead, I guess it only makes a noticable difference
when moving to hugepages, and have brd allocate hugepages only.
But that is future work for sure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich

