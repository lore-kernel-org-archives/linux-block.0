Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE31EA7FA
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158899; cv=none; b=gSUPIszJZzf0AnhdXuTg4BeNUlsKEe3Xs2BKUa6lyt2qMMvIiVPCvDJxCvDZ4ZJ00Z/ESdMK1ZYQ8VnnquZi/bZ+y0dnuJC3zsR9W6z+1GFIi+sUwY0Sf17hj+1Qars3jcG1xNxFSRBfca+OW531e2MCOcxQh4wS+8riFDyIawY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158899; c=relaxed/simple;
	bh=yvZIGlrzQUS7kneI2ZsUmnrVR8WoOn4WJuyWnxa1vDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OX8pvwx3BNuXDVCHOqzTq8P7/kpH1H1lWkPSwOyO27PKrM1SaP+X8GVxjMu8GGHstHiLH/lKu5OlXDk2l8xIpO77I6EnV5II+d4uF+PvXFtmcXg/ivSIj908pa3sgH7ZnvtsYIVQ+TidmH9UBdfZgB/N6pDc3jCV2t+YFFoSDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=afS8XBdS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mqQEKA+Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OQNjnXNk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ogxQo14n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="afS8XBdS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mqQEKA+Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OQNjnXNk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ogxQo14n"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ECFEE2118C;
	Wed,  5 Mar 2025 07:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741158895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvFN6KNwKJUNoJkvS2ieU0t84GJ/LyzPiMoahiO9g5c=;
	b=afS8XBdS7HvS36sBsHegYd1P3QAAV85NE78eW3csQ5S4xT2YgNGxNzsPi65aR0Cf8gpEcu
	BMWBvmp9Uz4VZbAfT0a1WCkdc9YtkiIrbFoIwxo3JnnxIh9LQWdEJYI397c7fOiT85U+ad
	jAVmrWfCpeiL2mw5qmxEJYbWmic6JTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741158895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvFN6KNwKJUNoJkvS2ieU0t84GJ/LyzPiMoahiO9g5c=;
	b=mqQEKA+YYOMEmtzpjiDaePAuAu5XQMwY0/UlLYwL8wBSq23NQRcUTuFTFCdGClL+xrFEqH
	0IUQP/kf1CyeVYDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741158894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvFN6KNwKJUNoJkvS2ieU0t84GJ/LyzPiMoahiO9g5c=;
	b=OQNjnXNk91XUHVdChxFWVZq9Dxs3SVDybtjahPwY8qCtBZEG4Pjs1czk34HkJnDsHupabE
	BKgcPIMUwAcRbPqQrpBeGSnhhvGt25EFoshbDFmxjaf0SUPMdXtwd2kHBnQ/psSIvJrKfV
	oo/pmPYX7UNYvaJ+aLj/4WCtiv5ML6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741158894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvFN6KNwKJUNoJkvS2ieU0t84GJ/LyzPiMoahiO9g5c=;
	b=ogxQo14n0Cfbz+paAo0eHijspk7kwSwRkYpYhn/fcm52Ql9fzsKlWlEpZWJa5N78aNW9Ji
	6NET4+HBmX1inUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8491813939;
	Wed,  5 Mar 2025 07:14:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id naj6He75x2fyQwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Mar 2025 07:14:54 +0000
Message-ID: <f7306936-1181-432c-9060-1de6bd36a31f@suse.de>
Date: Wed, 5 Mar 2025 08:14:50 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
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
 <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,grimberg.me,lists.infradead.org,vger.kernel.org,kvack.org,oracle.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -6.80
X-Spam-Flag: NO

On 3/4/25 20:44, Vlastimil Babka wrote:
> On 3/4/25 20:39, Hannes Reinecke wrote:
>> On 3/4/25 19:05, Matthew Wilcox wrote:
>>> On Tue, Mar 04, 2025 at 04:53:09PM +0000, Matthew Wilcox wrote:
>>>> Right, that's what happened in the block layer.  We mark the bio with
>>>> BIO_PAGE_PINNED if the pincount needs to be dropped.  As a transitional
>>>> period, we had BIO_PAGE_REFFED which indicated that the page refcount
>>>> needed to be dropped.  Perhaps there's something similar that network
>>>> could be doing.
>>>
>>> Until that time ... how does this look as a quick hack to avoid
>>> reverting the slab change?
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index d6fed25243c3..ca08a923ac6d 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -1520,7 +1520,10 @@ static inline void folio_get(struct folio *folio)
>>>    
>>>    static inline void get_page(struct page *page)
>>>    {
>>> -	folio_get(page_folio(page));
>>> +	struct folio *folio = page_folio(page);
>>> +	if (WARN_ON_ONCE(folio_test_slab(folio)))
>>> +		return;
>>> +	folio_get(folio);
>>>    }
>>>    
>>>    static inline __must_check bool try_get_page(struct page *page)
>>> @@ -1614,6 +1617,8 @@ static inline void put_page(struct page *page)
>>>    {
>>>    	struct folio *folio = page_folio(page);
>>>    
>>> +	if (folio_test_slab(folio))
>>> +		return;
>>>    	folio_put(folio);
>>>    }
>>>    
>>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>>> index 65f550cb5081..8c7fdb7d8c8f 100644
>>> --- a/lib/iov_iter.c
>>> +++ b/lib/iov_iter.c
>>> @@ -1190,8 +1190,12 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>>>    		if (!n)
>>>    			return -ENOMEM;
>>>    		p = *pages;
>>> -		for (int k = 0; k < n; k++)
>>> -			get_page(p[k] = page + k);
>>> +		for (int k = 0; k < n; k++) {
>>> +			struct folio *folio = page_folio(page);
>>> +			p[k] = page + k;
>>> +			if (!folio_test_slab(folio))
>>> +				folio_get(folio);
>>> +		}
>>>    		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
>>>    		i->count -= maxsize;
>>>    		i->iov_offset += maxsize;
>>>
>>
>> Good news and bad news ...
>> Good news: TLS works again!
>> Bad news: no errors.
> 
> Wait, did you add a WARN_ON_ONCE() to the put_page() as I suggested? If yes
> and there was no error, it would have to be leaking the page. Or the path
> uses folio_put() and we'd need to put the warning there.
> 
Oh, no, I didn't. Just added the WARN_ON to get_page().
Let me try ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
