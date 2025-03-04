Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A42080C7
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117195; cv=none; b=cVUjnLNkS8/xEWD4MyO8oJMuJV9CcgAJd39yOnhgQ6yCht71QAbw7bpdDg/3NOkbEWubVm8I4r7nWMQ1e4BQnXPXijKaZHrzwh73Ak+pkgQ7MXlanuCggh/2pcAC8ciqen9SddhBWo3AnyfTgjhIs0pVo+ZDLAt14TB+PCmykY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117195; c=relaxed/simple;
	bh=D6K0kCjdccWNxvUY3exNRraZxpidvHALFNoVgD6GD94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odlXDyX31t0zuilCGJyHgfpjY67mrQCNQPFLzztrlB7UcgbDm0Jx5sWQKiPrZ+eaO4bm5TCeQ6x6wqvFdcayPz6W68uPZ28QrXPmQRtf2/QcknhNdrpafm+xQgmqpaajH3oqmNzydblXB+8E7xYPObNkSUkJ8hmc+PJKwgDVjnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=anqvoSfE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1n2KVnn/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=anqvoSfE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1n2KVnn/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="anqvoSfE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1n2KVnn/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="anqvoSfE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1n2KVnn/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62357211A0;
	Tue,  4 Mar 2025 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741117191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iIFedqhWb3N9WUw+rahWwqAHHg+Q/R9dVRr6Mkc640=;
	b=anqvoSfEOnhz0IPcWTGSRgdqJIPeXdhfg9TnG3YDma3lIYyfUwj+9kbSwphyLo0wokxO2W
	44BapP+OKcrPnYG5WMwrnbfXCRrCsAGwH6dTzAAEo/LhVYUv9vfk12KvLS72Ke9+xQzrI/
	38r33aZD1jqZ4zWMcEUlbkBECsdsLJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741117191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iIFedqhWb3N9WUw+rahWwqAHHg+Q/R9dVRr6Mkc640=;
	b=1n2KVnn/CFICXg6pLnHAAW61irz5COL/8/knYOnEvhO2iEPqeDULGN3X3MyCIHu3ACYBy6
	s+mldAt+ufwI+NAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=anqvoSfE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="1n2KVnn/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741117191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iIFedqhWb3N9WUw+rahWwqAHHg+Q/R9dVRr6Mkc640=;
	b=anqvoSfEOnhz0IPcWTGSRgdqJIPeXdhfg9TnG3YDma3lIYyfUwj+9kbSwphyLo0wokxO2W
	44BapP+OKcrPnYG5WMwrnbfXCRrCsAGwH6dTzAAEo/LhVYUv9vfk12KvLS72Ke9+xQzrI/
	38r33aZD1jqZ4zWMcEUlbkBECsdsLJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741117191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iIFedqhWb3N9WUw+rahWwqAHHg+Q/R9dVRr6Mkc640=;
	b=1n2KVnn/CFICXg6pLnHAAW61irz5COL/8/knYOnEvhO2iEPqeDULGN3X3MyCIHu3ACYBy6
	s+mldAt+ufwI+NAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F08E313967;
	Tue,  4 Mar 2025 19:39:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VWpROAZXx2cgEgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Mar 2025 19:39:50 +0000
Message-ID: <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
Date: Tue, 4 Mar 2025 20:39:50 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Matthew Wilcox <willy@infradead.org>, Hannes Reinecke <hare@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Boris Pismenny <borisp@nvidia.com>,
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
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z8dA8l1NR-xmFWyq@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62357211A0
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,nvidia.com,gmail.com,kernel.org,grimberg.me,lists.infradead.org,vger.kernel.org,kvack.org,oracle.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 3/4/25 19:05, Matthew Wilcox wrote:
> On Tue, Mar 04, 2025 at 04:53:09PM +0000, Matthew Wilcox wrote:
>> Right, that's what happened in the block layer.  We mark the bio with
>> BIO_PAGE_PINNED if the pincount needs to be dropped.  As a transitional
>> period, we had BIO_PAGE_REFFED which indicated that the page refcount
>> needed to be dropped.  Perhaps there's something similar that network
>> could be doing.
> 
> Until that time ... how does this look as a quick hack to avoid
> reverting the slab change?
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d6fed25243c3..ca08a923ac6d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1520,7 +1520,10 @@ static inline void folio_get(struct folio *folio)
>   
>   static inline void get_page(struct page *page)
>   {
> -	folio_get(page_folio(page));
> +	struct folio *folio = page_folio(page);
> +	if (WARN_ON_ONCE(folio_test_slab(folio)))
> +		return;
> +	folio_get(folio);
>   }
>   
>   static inline __must_check bool try_get_page(struct page *page)
> @@ -1614,6 +1617,8 @@ static inline void put_page(struct page *page)
>   {
>   	struct folio *folio = page_folio(page);
>   
> +	if (folio_test_slab(folio))
> +		return;
>   	folio_put(folio);
>   }
>   
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 65f550cb5081..8c7fdb7d8c8f 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1190,8 +1190,12 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>   		if (!n)
>   			return -ENOMEM;
>   		p = *pages;
> -		for (int k = 0; k < n; k++)
> -			get_page(p[k] = page + k);
> +		for (int k = 0; k < n; k++) {
> +			struct folio *folio = page_folio(page);
> +			p[k] = page + k;
> +			if (!folio_test_slab(folio))
> +				folio_get(folio);
> +		}
>   		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
>   		i->count -= maxsize;
>   		i->iov_offset += maxsize;
> 

Good news and bad news ...
Good news: TLS works again!
Bad news: no errors.

Question to the wise: this is not the only place in iov_iter.c where we 
do a 'get_page()'. Do we leave them and wait for others to report 
regressions, knowing fully well that the current code _has_ issues?
Or shouldn't we rather clean them up?

I guess the real fix would be to fiddle with the 'bio_add_page()' logic;
we are always adding a 'page' reference to the bio, completely ignoring
whether this page is a slab page or a normal one.

Discussion at LSF, maybe?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
