Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F52144366
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868070; cv=none; b=VmDiZt05aevOehjiIi3bm/pIy4OrFyWHDHKoZ9K4uuHOl3pviqgJ+b4nV94HJlugBHJ/bCvKUYNBpTl9P2nl0hp9pgj39u8jnV8PQQ9WxMc9ZGmlzWLiZQaNFP14bHuitRCNdWmX6KPhwwfhA3KgdebrMjydFiTM+SM4JRHlWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868070; c=relaxed/simple;
	bh=tv1dTYSpQiRkW6+GwObbNMT/4jd8QFiLTPoHxbqsbNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7F/Yw1lrp0UrHluXPzmyZ5q4TREvX6pya+Tq4GgOl8dAerrmudqcQh/AlDoNSp14KNLrgZMsqvXCaTvQ/NhZ0X8pVsuNyXrcmfXnzUw4ZPwFfB0DVNFnn+oUQMZ9BPK6IXW2LrDZC/hsSqQRRUgV8TPRobhfhcuMGhTf+JIsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qO+aBD/h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ge19r9B/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qO+aBD/h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ge19r9B/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qO+aBD/h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ge19r9B/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qO+aBD/h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ge19r9B/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D21421AAD;
	Thu, 20 Jun 2024 07:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718868064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOMAtS2uNoRfMujYbeqtLI8M1VlWYs3Lm7Jxupc43KQ=;
	b=qO+aBD/hzMaRboMEwvkP4OAfNodQc4mEdgF3fVelWqL0XaIUfkHg6n5iepdUss8dYSEzam
	9iHHu3hNGgAJMnyU34x0p3Fhscxx/iyxP4DAoqibAxNvl6h9zJaB/CBtbed3AP8LpL8HAM
	/7eGg4oYmaeGOOKJ/2TLlnfv0nus7BQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718868064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOMAtS2uNoRfMujYbeqtLI8M1VlWYs3Lm7Jxupc43KQ=;
	b=Ge19r9B/eF3W9mYe3/Uciul5d64XL4zRtCtU3Y6m0AUIGQ45DHrcObUUKOQeZgL2U/YpIa
	YEkIYPV4j6vk3XCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qO+aBD/h";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Ge19r9B/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718868064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOMAtS2uNoRfMujYbeqtLI8M1VlWYs3Lm7Jxupc43KQ=;
	b=qO+aBD/hzMaRboMEwvkP4OAfNodQc4mEdgF3fVelWqL0XaIUfkHg6n5iepdUss8dYSEzam
	9iHHu3hNGgAJMnyU34x0p3Fhscxx/iyxP4DAoqibAxNvl6h9zJaB/CBtbed3AP8LpL8HAM
	/7eGg4oYmaeGOOKJ/2TLlnfv0nus7BQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718868064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOMAtS2uNoRfMujYbeqtLI8M1VlWYs3Lm7Jxupc43KQ=;
	b=Ge19r9B/eF3W9mYe3/Uciul5d64XL4zRtCtU3Y6m0AUIGQ45DHrcObUUKOQeZgL2U/YpIa
	YEkIYPV4j6vk3XCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D084F13AC1;
	Thu, 20 Jun 2024 07:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xcGRMF/Yc2b8SwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 20 Jun 2024 07:21:03 +0000
Message-ID: <32938990-bb50-4fae-9b48-564f8b707390@suse.de>
Date: Thu, 20 Jun 2024 09:21:02 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] block: add folio awareness instead of looping
 through pages
Content-Language: en-US
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org,
 linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
 anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
 gost.dev@samsung.com
References: <20240619023420.34527-1-kundan.kumar@samsung.com>
 <CGME20240619024150epcas5p267bd3cbd24061e723a7b632746de92d6@epcas5p2.samsung.com>
 <20240619023420.34527-3-kundan.kumar@samsung.com>
 <c29524a5-f3c7-4236-968c-58b5f3004b66@suse.de>
 <20240620044842.oxbryv2i7q4muiwf@green245>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240620044842.oxbryv2i7q4muiwf@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7D21421AAD
X-Spam-Flag: NO
X-Spam-Score: -6.50
X-Spam-Level: 

On 6/20/24 06:48, Kundan Kumar wrote:
> On 19/06/24 09:47AM, Hannes Reinecke wrote:
[ .. ]
>>
>> Well. The issue here is that bvecs really only use the 'struct page' 
>> entry as an address to the data; the page size itself is completely
>> immaterial. So from that perspective it doesn't really matter whether
>> we use 'struct page' or 'struct folio' to get to that address.
>> However, what matters is whether we _iterate_ over pages or folios.
>> The current workflow is to first allocate an array of pages,
>> call one of the _get_pages() variants, and the iterate over all
>> pages.
>> What we should be doing is to add _get_folios() variants, working
>> on folio batches and not pre-allocated arrays.
> 
> The XXX_get_pages() functions do page table walk and fill the pages
> corresponding to a user space addr in pages array. The _get_folios()
> variants shall return a folio_vec, rather than folio array, as every folio
> entry will need a folio_offset and len per folio. If we convert to
> _get_folios() variants, number of folios may be lesser than number of
> pages. But we will need allocation of folio_vec array as a replacement
> of pages array.
> 
Well, actually I was thinking of using 'struct folio_batch' instead of
an array. There is an entire set of helpers here (pagevec.h) for 
precisely this purpose.

But yes, we will end up with less folios than pages (which was kinda the 
idea).

> Am I missing something?
> 
> Down in the page table walk (gup_fast_pte_range), we fill the pages array
> addr -> pte -> page. This shall be modified to fill a folio_vec array. The
> page table walk also deals with huge pages, and looks like huge page
> functions shall also be modified to fill folio_vec array. Also handling
> the gup slow path will need a modification to fill the folio_vec array.

Yes. I did say it's a tall order. But it would have the advantage of 
assembling large folios right at the start, so lower level (ie those
consuming the folio batch) would not need to worry of painstakingly
re-assemble folios from a list of pages.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

