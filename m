Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E413BC668
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876274; cv=none; b=idIQgjBO6m8Ggt0bdSkVDzRAgqXHdo/C6qM/+IIGj+qjDFilzCuLYa6WN1SljiPGBs9qo01hDgoyyf6k+OGO5PwIfj2UvHOzMCVFiO/NWrdW2FemMahH1vQCd2bj+vD8Fn0SkogiLrDkfmOt8P7qSIpdUXgyh3TBzNVa9KAKDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876274; c=relaxed/simple;
	bh=7JUC/p3dkbkWqi8r3QUXBftMmRestEmma/ahY1GA/T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmaBn2a5PCXTdgA1Nm9AzrkPVOy8bDkp2vgtVGyuH2hdUKRhILAOMdkgLu0azXB/3AsWGPq1A3vBGt/awd8nilYVkHF59/AHOKBCPzK1IjCoasVKFPZfa73oxuY2Rb+7NM17zduIIlcfLoYlmjRyStN2QeFI3YuyD0PRCecTru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mLBz8tZM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rh9FmP1M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rFvxMq2x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cA5FspLc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mLBz8tZM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rh9FmP1M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rFvxMq2x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cA5FspLc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 524606AB63;
	Wed, 27 May 2026 10:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779876271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmYoieD2LwluZC8EpmehcWynC6L7vkpdtLzTGX53oII=;
	b=mLBz8tZMTOXfnxoTF1GS8k2q8HVX40oAgymX2pbssvoFox9T7nOdI2t9oJsYmPC1Jz8ie8
	ilMmTmYTqDdGHmmS7kbWWg7Sqpvy7is0rrCqLmYGWDHBBoEvxegFvANsY1FGnha2wCv7hB
	Mn8LB5xMZfQRwFddTDp9aigpNJ2DJr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779876271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmYoieD2LwluZC8EpmehcWynC6L7vkpdtLzTGX53oII=;
	b=rh9FmP1MEzf7jn0kgTmrtjMv3xE0bVxctB0yjBdUSCz2CgoJPdxwF6NWiM9pwkXEIQgPka
	rr4hXQ3EbLlPi0AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779876270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmYoieD2LwluZC8EpmehcWynC6L7vkpdtLzTGX53oII=;
	b=rFvxMq2xu8FYED4hBciFi066c7ZdUARBy9WeJGfwFVNtqbFJOIXyC2mLrNoliz5+w5hWib
	pMjL/GejnUgYC/gkVMlcrPV/p3XKJsZb5eWUNXYz5pZ+xuKUJgS790ArpvlgikKCk0O11u
	7A1Wcv8pVWuwg32Bb+GdDYiVIsBQtls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779876270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmYoieD2LwluZC8EpmehcWynC6L7vkpdtLzTGX53oII=;
	b=cA5FspLcapv1NXUyaHC1Sp4ym3UO0qdoYxldrnCIMETKncqxJtmINH2+qgYyKhUwjayCup
	F8xXoiagENd1F6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 251015A78D;
	Wed, 27 May 2026 10:04:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i/qQCK7BFmpAVAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 10:04:30 +0000
Message-ID: <17258981-d5b3-4ed1-9b3d-56a0b6ecb3f9@suse.de>
Date: Wed, 27 May 2026 12:04:29 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
To: Vlastimil Babka <vbabka@suse.com>, Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260520-block-v1-1-6463dc2cf042@kernel.org>
 <ahPnX-CwVgK-9chp@infradead.org> <ahPxmSqT4Y4jcAbQ@kernel.org>
 <ahP3R2nH8-bHMVf0@infradead.org> <ahQX_JCgS9JWIhY-@kernel.org>
 <1dea9df9-18c2-46f5-bf47-abb3f088574b@suse.com>
 <ahWwD0eqj3cUgaKn@casper.infradead.org>
 <8b780901-8184-4908-8bda-56fac42fe6b3@suse.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8b780901-8184-4908-8bda-56fac42fe6b3@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 5/26/26 22:57, Vlastimil Babka wrote:
> On 5/26/26 16:37, Matthew Wilcox wrote:
>> On Tue, May 26, 2026 at 02:07:36PM +0200, Vlastimil Babka wrote:
>>> The main reasons for switching AFAIU would be related with the
>>> folio/memdesc conversions? If one needs just a kernel memory buffer,
>>> kmalloc() it is, even if it happens to be page size. Page allocator
>>> should be only used if you need e.g. the refcounting or anything else
>>> that struct page provides. But then in some cases the memdesc conversion
>>> would need adjustments at some point. With kmalloc() we can forget about
>>> this user.
>>
>> No, I think this is unrelated to memdescs.
>>
>> I've seen a few people say slightly wrong things about
>> folios/pages/memdescs recently, so let me try to clarify the end state.
>>
>> I do not intend to get rid of the ability to allocate a bare page of
>> memory with something like alloc_pages() or get_free_page().  It's
>> just that the struct page associated with it will contain far less
>> information (because it's smaller).
> 
> Alright, but isn't it still the case that if you don't need any of what
> struct page provides today or will do in the future, it's better if you just
> use kmalloc()? I thought you said so yourself?
> 
> https://lore.kernel.org/all/aPQxN7-FeFB6vTuv@casper.infradead.org/
> 
Precisely my reasoning. In most cases, __get_free_page() is just a
lazy way of saying "I need some memory and the allocation should not 
fail". And typically these callers don't really care about the page
mapping, too.
Additionally, these applications get in the way when using large block
sizes on the system, as they needlessly increase the pressure on
compaction.
So switching them over to kmalloc() is a good thing IMO.
If nothing else it allows us to differentiate which places _actually_
need struct page, and which callers just want to do a memory allocation.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
