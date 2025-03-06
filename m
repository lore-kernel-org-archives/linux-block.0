Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFA119F438
	for <linux-block@vger.kernel.org>; Thu,  6 Mar 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252516; cv=none; b=oAPDiakdurD9OhA+fODElCkx82ZsSjsdJQtqgWfOsJfGjo82thUwOWOfZFncvDj3oBSW4e87XCV/ZuoplHm6qib/VYEhNUFWf9xYs5KiU2/rutTxh2GBlHo3wBUDura+TSK/qUFBGfzBWD3A5fhKUl34OLV11b4F8BoVta+my+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252516; c=relaxed/simple;
	bh=V+jWF95gHaHUxMo/YXkawzf7T55uTockMQppBhlaosc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPJLvXJHh/+r+HbNqKADa91CJHXz54gLgEwocy6lOmVKjL+OGmy0ZW35dIviOdB8VAuDQA59Sa/y41l5NIT9GcXEWY7vJEW1vIiOYcap21sAkvvGOVtI2Derqa22UwWQppgaU27nsHMzpJ0DQqlKlJMMw7PMnj8itDnusvQZ7gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vBwbmBBU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mD9aK61I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vBwbmBBU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mD9aK61I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBwbmBBU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mD9aK61I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBwbmBBU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mD9aK61I"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1908A211BA;
	Thu,  6 Mar 2025 09:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741252513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPhhRvINO8sdNrDDGrFMepQM60xk8knk9oHarU6dqAw=;
	b=vBwbmBBUiQw+JRmOBdvXucqI226N8EsqCTy5Oe+no3qWFLc5QmTXHJf0REGo3EvJdNV88R
	A4iF3rCIy4sf2BP2AFeurXxrRGQIgySCCEw3cF+kXWJUfjcLX6E+c1qzcPHdH30S77awLx
	ADL70xm8FrUyNLKW0RWpgkMYEKRK5S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741252513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPhhRvINO8sdNrDDGrFMepQM60xk8knk9oHarU6dqAw=;
	b=mD9aK61ISZTDqNAZvIMEfDYX4TLw8iNgnCLbNocLqk/PxZtLBjWr4amLJWTtdvAo0FiP6C
	qc6D6x8g0e8NpnCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741252513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPhhRvINO8sdNrDDGrFMepQM60xk8knk9oHarU6dqAw=;
	b=vBwbmBBUiQw+JRmOBdvXucqI226N8EsqCTy5Oe+no3qWFLc5QmTXHJf0REGo3EvJdNV88R
	A4iF3rCIy4sf2BP2AFeurXxrRGQIgySCCEw3cF+kXWJUfjcLX6E+c1qzcPHdH30S77awLx
	ADL70xm8FrUyNLKW0RWpgkMYEKRK5S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741252513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPhhRvINO8sdNrDDGrFMepQM60xk8knk9oHarU6dqAw=;
	b=mD9aK61ISZTDqNAZvIMEfDYX4TLw8iNgnCLbNocLqk/PxZtLBjWr4amLJWTtdvAo0FiP6C
	qc6D6x8g0e8NpnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF4D413A61;
	Thu,  6 Mar 2025 09:15:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NcMLOqBnyWf3EgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 06 Mar 2025 09:15:12 +0000
Message-ID: <c9110425-b584-4be6-af89-542d97859250@suse.cz>
Date: Thu, 6 Mar 2025 10:15:12 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 David Howells <dhowells@redhat.com>
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
 <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
 <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
 <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -6.80
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
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,grimberg.me,lists.infradead.org,vger.kernel.org,kvack.org,oracle.com,redhat.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/5/25 12:43, Hannes Reinecke wrote:
> On 3/5/25 09:58, Vlastimil Babka wrote:
>> On 3/5/25 09:20, Hannes Reinecke wrote:
>>> On 3/4/25 20:44, Vlastimil Babka wrote:
>>>> On 3/4/25 20:39, Hannes Reinecke wrote:
>>> [ .. ]
>>>>>
>>>>> Good news and bad news ...
>>>>> Good news: TLS works again!
>>>>> Bad news: no errors.
>>>>
>>>> Wait, did you add a WARN_ON_ONCE() to the put_page() as I suggested? If yes
>>>> and there was no error, it would have to be leaking the page. Or the path
>>>> uses folio_put() and we'd need to put the warning there.
>>>>
>>> That triggers:
>> ...
>>> Not surprisingly, though, as the original code did a get_page(), so
>>> there had to be a corresponding put_page() somewhere.
>> 
>> Is is this one? If there's no more warning afterwards, that should be it.
>> 
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index 61f3f3d4e528..b37d99cec069 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -182,9 +182,14 @@ static int sk_msg_free_elem(struct sock *sk, struct sk_msg *msg, u32 i,
>>   
>>          /* When the skb owns the memory we free it from consume_skb path. */
>>          if (!msg->skb) {
>> +               struct folio *folio;
>> +
>>                  if (charge)
>>                          sk_mem_uncharge(sk, len);
>> -               put_page(sg_page(sge));
>> +
>> +               folio = page_folio(sg_page(sge));
>> +               if (!folio_test_slab(folio))
>> +                       folio_put(folio);
>>          }
>>          memset(sge, 0, sizeof(*sge));
>>          return len;
>> 
>> 
> Oh, sure. But what annoys me: why do we have to care?
> 
> When doing I/O _all_ data is stuffed into bvecs via
> bio_add_page(), and after that information about the
> origin is lost; any iteration on the bio will be a bvec
> iteration.
> Previously we could just do a bvec iteration, get a reference
> for each page, and start processing.

AFAIU there's BIO_PAGE_PINNED that controls whether the pages are pinned, as
there are usecases where it makes sense to do that (userspace pages?). And
__bio_release_pages() can be removing the last pin and freeing the pages.

But this is a case where the buffer is a kmalloc() allocation, so somebody
has to do the corresponding kfree() when the messages are processed. A pin
on the slab folio where the kmalloc() resides helps nothing and as willy
says it's just unnecessary overhead of atomic allocations.

> Now suddenly the caller has to check if it's a slab page and don't
> get a reference for that. Not only that, he also has to remember
> to _not_ drop the reference when he's done.

The caller did kmalloc() and will have to do kfree(). I guess it's about
telling the intermediate layers via something similar like BIO_PAGE_PINNED
whether the pages should be pinned or not.

> And, of course, tracing get_page() and the corresponding put_page()
> calls through all the layers.
> Really?
> 
> Cheers,
> 
> Hannes

