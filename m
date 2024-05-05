Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188D11C92
	for <linux-block@vger.kernel.org>; Sun,  5 May 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714911022; cv=none; b=hB6pixhWMoPxDqpr2Kgz/fofcRYLw8fNhWIk7N50/k01XFMJZSfV0MafzsUawJ+tI77UWTU9dEWd2zgDbFl5VTXlHKmvlfy6RNkIYbSLxXCqvBSmQKXtPy48owyRedHOUofZ+AHS7MDPZulR+IVoj+qXB4tEXRXK+6cwWx8NQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714911022; c=relaxed/simple;
	bh=LM3jpZFmz3aPKVIKeOLoTm8ueGnr7JK1FvElrlxAOvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRHzF2+hJ8N88UwC87p7Pf4Vi2kdhIEU3TZ4bkAFR1zxMIAxF0RUHnzLDOvUN5UNkWD3YQtiA2mCQbu1SjCnZeBsTCl5Ez3j/RTYslSF8n3LCQ5Ld6o/tVF7lStiVINAG3vTfkWLgQ9+866s4MGtst/vI5Dc4LDY26QdhsZ/9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eD1+EsG8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OYPaPoXA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eD1+EsG8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OYPaPoXA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eD1+EsG8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OYPaPoXA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eD1+EsG8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OYPaPoXA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1CFF75CDE2;
	Sun,  5 May 2024 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714911019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVNs+9RKN+Xe5D6g3y0g+eiSogIJnZCWpuAHtlhR0go=;
	b=eD1+EsG8Eigt3vzWOeLp8k41ANPo990tx9Qr62rLsU9qnT4DfyuoOt8Q4HEHZaGR/6Czs6
	9i8ruN/17fWN5ycmyPWoMB7ZlEM5Y0PFDng5HGlvYb3TQR2F69J15tgQTFb8ojH0+xElzc
	Xz5U1FgOUcNFy/7lH6x3cg2zFQZH23k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714911019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVNs+9RKN+Xe5D6g3y0g+eiSogIJnZCWpuAHtlhR0go=;
	b=OYPaPoXAh8uwffv6K1AS3UEaY6p7Aukhv/j9wiL6vdKVsCXzR3hwUBJeABplYpvlSxLgkh
	mJYHYL70bDUXzWCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eD1+EsG8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OYPaPoXA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714911019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVNs+9RKN+Xe5D6g3y0g+eiSogIJnZCWpuAHtlhR0go=;
	b=eD1+EsG8Eigt3vzWOeLp8k41ANPo990tx9Qr62rLsU9qnT4DfyuoOt8Q4HEHZaGR/6Czs6
	9i8ruN/17fWN5ycmyPWoMB7ZlEM5Y0PFDng5HGlvYb3TQR2F69J15tgQTFb8ojH0+xElzc
	Xz5U1FgOUcNFy/7lH6x3cg2zFQZH23k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714911019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVNs+9RKN+Xe5D6g3y0g+eiSogIJnZCWpuAHtlhR0go=;
	b=OYPaPoXAh8uwffv6K1AS3UEaY6p7Aukhv/j9wiL6vdKVsCXzR3hwUBJeABplYpvlSxLgkh
	mJYHYL70bDUXzWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF0A813A27;
	Sun,  5 May 2024 12:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6lQSKSp3N2ZdMQAAD6G6ig
	(envelope-from <hare@suse.de>); Sun, 05 May 2024 12:10:18 +0000
Message-ID: <33717b97-8986-4d6e-aa10-47393b810ea2@suse.de>
Date: Sun, 5 May 2024 14:10:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block : add larger order folio size instead of pages
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Kundan Kumar <kundan.kumar@samsung.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org, joshi.k@samsung.com,
 mcgrof@kernel.org, anuj20.g@samsung.com, nj.shetty@samsung.com,
 c.gameti@samsung.com, gost.dev@samsung.com
References: <CGME20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff@epcas5p1.samsung.com>
 <20240430175014.8276-1-kundan.kumar@samsung.com>
 <317ce09b-5fec-4ed2-b32c-d098767956d0@suse.de>
 <20240502125340.GB20610@lst.de> <ZjUCP08UyIGTzpW_@casper.infradead.org>
 <89417350-2589-4b7d-831e-eccfe1ce1ae2@suse.de>
 <ZjZjBHAdUdt6FJe6@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZjZjBHAdUdt6FJe6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1CFF75CDE2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 5/4/24 18:32, Matthew Wilcox wrote:
> On Sat, May 04, 2024 at 02:35:15PM +0200, Hannes Reinecke wrote:
>>> I think this is wandering into a minefield.  I'm pretty sure
>>> it's considered valid to split the bio, and complete the two halves
>>> independently.  Each one will put the refcounts for the pages it touches,
>>> and if we do this early putting of references, that's going to fail.
>>
>> Precisesly my worries. Something I want to talk to you about at LSF;
>> refcounting of folios vs refcounting of pages.
>> When one takes a refcount on a folio we are actually taking a refcount
>> on the first page, which is okay if we stick with using the folio throughout
>> the call chain. But if we start mixing between pages and folios (as we do
>> here) we will be getting the refcount wrong.
>>
>> Do you have plans how we could improve the situation?
>> Like a warning 'Hey, you've used the folio for taking the reference, but now
>> you are releasing the references for the page'?
> 
> This is a fairly common misunderstanding, but TLDR: problem solved long
> before I started this project.
> 
> Individual pages don't actually have a refcount.  I know it looks
> like they do, and they kind of do, but for tail pages, the refcount is
> always 0.  Functions like get_page() and put_page() always operate on
> the head page (ie folio) refcount.
> 
Precisely.

> Specifically, I think you're concerned about pages coming from GUP.
> Take a look at try_get_folio().  We pass in a struct page, explicitly
> get the refcount on a folio, check the page is still part of the
> folio, then return the folio.  And we return the page to the caller
> because the caller needs to know the precise page at that address,
> not the folio that contains it.
> 
> There are functions which don't surreptitiously call compound_head()
> behind your back.  set_page_count(), for example.  And page_ref_count()
> (rather than the more normal page_count()).
> 
> And none of this is true if you don't use __GFP_COMP.  But let's call
> that an aberration that must die.

Ah, right. So the refcount for a page is always unwound to use the 
refcount of the enclosing folio.

I was actually concerned with the iov_iter functions, where we take a 
reference for each page. Currently iov_iter is iterating in units of
PAGE_SIZE, so there is no easy way of converting that to folios.

But one step at a time, I guess. First get the blocksize > pagesize 
patches in.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

