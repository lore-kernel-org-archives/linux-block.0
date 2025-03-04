Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06625290A
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117487; cv=none; b=cHOMnQoowIqQoKyM7Lm6zTuVMUfth694AXIlv06KTucgUZBW3pWwuASRIvl1pbH7RBarPXJqIspFmi1ArnfnC8F46uCPoED3qihhxsYNITv8OJBwHEKbKp3Q448pi7tn/K68FtvrirwSAmNdoYWqtgziBPQtVf7Ui8tjKZMHtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117487; c=relaxed/simple;
	bh=Iuvc8l/CYxsHRit8p150xRQB69U6VtjSgc1ToxMWcts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGQoOsAZb+lFwt5mN7QUlpT6Al8pi9K5d5RpXb05WE70njcLrSFM93KfaqR7haIBO0u/dmpyONkbPqVdQbVEV7IrL8L/HnD+kjoCDWnld+IRw8PtG9yMLr7nBmrMUUXp2Q2BYFRR2uBE+0dq1ICWCJKGGqtBESxafSv4m4A6ATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KwlfISgx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fFtZr7lC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KwlfISgx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fFtZr7lC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KwlfISgx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fFtZr7lC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KwlfISgx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fFtZr7lC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E5261F38A;
	Tue,  4 Mar 2025 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741117484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TqyJfscKY6wPCIzvMizjhxcGjT6FdOkeaod0/a9hsx0=;
	b=KwlfISgxzInnNK+mCrIDlx6S7ZweHFADm0sr8xfKu+tjGKkUDGk3jJ9tdfFu4tq+GqJRWF
	B8nTd5GgH/2hiHjaXmiRn+N7f+CTmzyJR3P/YWfiIHawZcBU01mjV7dMuKyTOi/3X0IZBA
	g9X4oPFp4HFbZvp6k+ZakDaFlniuJS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741117484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TqyJfscKY6wPCIzvMizjhxcGjT6FdOkeaod0/a9hsx0=;
	b=fFtZr7lCsWujicLkiVU2HL0qvFTZRJXIF9/aoyt/wHbWHioxx6jQ4rOipVxJjR+FI2/BOu
	iyRO9kzvMCzDDLCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741117484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TqyJfscKY6wPCIzvMizjhxcGjT6FdOkeaod0/a9hsx0=;
	b=KwlfISgxzInnNK+mCrIDlx6S7ZweHFADm0sr8xfKu+tjGKkUDGk3jJ9tdfFu4tq+GqJRWF
	B8nTd5GgH/2hiHjaXmiRn+N7f+CTmzyJR3P/YWfiIHawZcBU01mjV7dMuKyTOi/3X0IZBA
	g9X4oPFp4HFbZvp6k+ZakDaFlniuJS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741117484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TqyJfscKY6wPCIzvMizjhxcGjT6FdOkeaod0/a9hsx0=;
	b=fFtZr7lCsWujicLkiVU2HL0qvFTZRJXIF9/aoyt/wHbWHioxx6jQ4rOipVxJjR+FI2/BOu
	iyRO9kzvMCzDDLCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D36313967;
	Tue,  4 Mar 2025 19:44:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KZ18BixYx2dbEwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 04 Mar 2025 19:44:44 +0000
Message-ID: <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
Date: Tue, 4 Mar 2025 20:44:43 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Hannes Reinecke <hare@suse.com>
Cc: Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
 <Z8dA8l1NR-xmFWyq@casper.infradead.org>
 <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,grimberg.me,lists.infradead.org,vger.kernel.org,kvack.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/4/25 20:39, Hannes Reinecke wrote:
> On 3/4/25 19:05, Matthew Wilcox wrote:
>> On Tue, Mar 04, 2025 at 04:53:09PM +0000, Matthew Wilcox wrote:
>>> Right, that's what happened in the block layer.  We mark the bio with
>>> BIO_PAGE_PINNED if the pincount needs to be dropped.  As a transitional
>>> period, we had BIO_PAGE_REFFED which indicated that the page refcount
>>> needed to be dropped.  Perhaps there's something similar that network
>>> could be doing.
>> 
>> Until that time ... how does this look as a quick hack to avoid
>> reverting the slab change?
>> 
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index d6fed25243c3..ca08a923ac6d 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1520,7 +1520,10 @@ static inline void folio_get(struct folio *folio)
>>   
>>   static inline void get_page(struct page *page)
>>   {
>> -	folio_get(page_folio(page));
>> +	struct folio *folio = page_folio(page);
>> +	if (WARN_ON_ONCE(folio_test_slab(folio)))
>> +		return;
>> +	folio_get(folio);
>>   }
>>   
>>   static inline __must_check bool try_get_page(struct page *page)
>> @@ -1614,6 +1617,8 @@ static inline void put_page(struct page *page)
>>   {
>>   	struct folio *folio = page_folio(page);
>>   
>> +	if (folio_test_slab(folio))
>> +		return;
>>   	folio_put(folio);
>>   }
>>   
>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>> index 65f550cb5081..8c7fdb7d8c8f 100644
>> --- a/lib/iov_iter.c
>> +++ b/lib/iov_iter.c
>> @@ -1190,8 +1190,12 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>>   		if (!n)
>>   			return -ENOMEM;
>>   		p = *pages;
>> -		for (int k = 0; k < n; k++)
>> -			get_page(p[k] = page + k);
>> +		for (int k = 0; k < n; k++) {
>> +			struct folio *folio = page_folio(page);
>> +			p[k] = page + k;
>> +			if (!folio_test_slab(folio))
>> +				folio_get(folio);
>> +		}
>>   		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
>>   		i->count -= maxsize;
>>   		i->iov_offset += maxsize;
>> 
> 
> Good news and bad news ...
> Good news: TLS works again!
> Bad news: no errors.

Wait, did you add a WARN_ON_ONCE() to the put_page() as I suggested? If yes
and there was no error, it would have to be leaking the page. Or the path
uses folio_put() and we'd need to put the warning there.

> Question to the wise: this is not the only place in iov_iter.c where we 
> do a 'get_page()'. Do we leave them and wait for others to report 
> regressions, knowing fully well that the current code _has_ issues?
> Or shouldn't we rather clean them up?
> 
> I guess the real fix would be to fiddle with the 'bio_add_page()' logic;
> we are always adding a 'page' reference to the bio, completely ignoring
> whether this page is a slab page or a normal one.
> 
> Discussion at LSF, maybe?
> 
> Cheers,
> 
> Hannes

