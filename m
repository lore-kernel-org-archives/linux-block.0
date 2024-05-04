Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF48F6D
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714826119; cv=none; b=MwNpa1RQSbxa4tFTVFjZXBKOHmGdiMb3+RdmEpMh3mWL//b73LrAoGmdcGPJflfswqZ1MC2ps8tYmHt7lIpBU5s1Licz86QLrl153NzWhrqi61lifSHo82NeXKzexFQn/O/IMEzZNOKz6nL9xIt/AfTa7Q/TMIcAB7uxK9wJwq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714826119; c=relaxed/simple;
	bh=j0InEp2r8dWo7g/iIq7o05YPX7Qp1oCfkyyPHF+tP4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlIGv8yhilc+uTiKMxoEuWGlS4fpzX+iA/A77Z+4720lRc6rCR9Lot8zRqdqgFY9VGCDsto7oexgf9QYeVzvkdS1xqy8f1aGPIeJAQ3pvQJ9JkR7fdJOeAj99u8biA6UnNOErPvLDKcER1kNNtahxwYwy0VeLQOhRYkQ1EIdJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mpihq9RY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NQ8YZvI/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mpihq9RY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NQ8YZvI/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mpihq9RY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NQ8YZvI/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mpihq9RY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NQ8YZvI/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5608934539;
	Sat,  4 May 2024 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714826116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLEn0vYnhUOuk7js5RlFqlDimxB3lRT887R/KLwr4Rk=;
	b=mpihq9RYpM0QlKAUEHN64ecbnrOwBrqzA8oeSTJfJGmoGFS+iyk6irz6FmU3Xb5UoN8LKN
	0dzSLQO+QziwCKS+UiZ0tknfa3ZhGlvsq4EhWKJj+Qly0Bhv6BjwyRx9ik1DpmQpazPYRJ
	wSkGNWxGHtPmc0W1wqfd9qYX95F+tJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714826116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLEn0vYnhUOuk7js5RlFqlDimxB3lRT887R/KLwr4Rk=;
	b=NQ8YZvI/tvVt/cD17uzJrIyX8SZ44ZgGf5vXYhe2oGw8xRx/ZJO3V8y9rm6Pds15HSUHGM
	SnD/YqFp4IlS3EBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mpihq9RY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="NQ8YZvI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714826116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLEn0vYnhUOuk7js5RlFqlDimxB3lRT887R/KLwr4Rk=;
	b=mpihq9RYpM0QlKAUEHN64ecbnrOwBrqzA8oeSTJfJGmoGFS+iyk6irz6FmU3Xb5UoN8LKN
	0dzSLQO+QziwCKS+UiZ0tknfa3ZhGlvsq4EhWKJj+Qly0Bhv6BjwyRx9ik1DpmQpazPYRJ
	wSkGNWxGHtPmc0W1wqfd9qYX95F+tJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714826116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLEn0vYnhUOuk7js5RlFqlDimxB3lRT887R/KLwr4Rk=;
	b=NQ8YZvI/tvVt/cD17uzJrIyX8SZ44ZgGf5vXYhe2oGw8xRx/ZJO3V8y9rm6Pds15HSUHGM
	SnD/YqFp4IlS3EBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C18751386E;
	Sat,  4 May 2024 12:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wNUXLYMrNma+aQAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 04 May 2024 12:35:15 +0000
Message-ID: <89417350-2589-4b7d-831e-eccfe1ce1ae2@suse.de>
Date: Sat, 4 May 2024 14:35:15 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block : add larger order folio size instead of pages
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
 anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
 gost.dev@samsung.com
References: <CGME20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff@epcas5p1.samsung.com>
 <20240430175014.8276-1-kundan.kumar@samsung.com>
 <317ce09b-5fec-4ed2-b32c-d098767956d0@suse.de>
 <20240502125340.GB20610@lst.de> <ZjUCP08UyIGTzpW_@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZjUCP08UyIGTzpW_@casper.infradead.org>
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
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5608934539
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 5/3/24 17:26, Matthew Wilcox wrote:
> On Thu, May 02, 2024 at 02:53:40PM +0200, Christoph Hellwig wrote:
>> On Thu, May 02, 2024 at 08:45:33AM +0200, Hannes Reinecke wrote:
>>>> -		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
>>>> -			   fi.offset / PAGE_SIZE + 1;
>>>> -		do {
>>>> -			bio_release_page(bio, page++);
>>>> -		} while (--nr_pages != 0);
>>>> +		bio_release_page(bio, page);
>>>
>>> Errm. I guess you need to call 'folio_put()' here, otherwise the page
>>> reference counting will be messed up.
>>
>> It shouldn't.  See the rfc patch and explanation that Keith sent in reply
>> to the previous version.  But as I wrote earlier it should be a separate
>> prep patch including a commit log clearly explaining the reason for it
>> and how it works.
> 
> I think this is wandering into a minefield.  I'm pretty sure
> it's considered valid to split the bio, and complete the two halves
> independently.  Each one will put the refcounts for the pages it touches,
> and if we do this early putting of references, that's going to fail.

Precisesly my worries. Something I want to talk to you about at LSF; 
refcounting of folios vs refcounting of pages.
When one takes a refcount on a folio we are actually taking a refcount
on the first page, which is okay if we stick with using the folio 
throughout the call chain. But if we start mixing between pages and 
folios (as we do here) we will be getting the refcount wrong.

Do you have plans how we could improve the situation?
Like a warning 'Hey, you've used the folio for taking the reference, but 
now you are releasing the references for the page'?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

