Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECD5262FC1
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887782; cv=none; b=Fl30/p35SB4uDy0Eer05Mo21x6Vb1Usadm/lHkyMS2qjDd1ohF3hm92tGStejjNjx+H1PJCo2Vg/v+XhyqHWDubNnOE6wi/GfnVNnqjDEFTuJzYcuUzSe1uCKg9BLKeb2pIe7aMV/ePdGZdyM4dPWqW9+4gnCx/TrstkCA0j5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887782; c=relaxed/simple;
	bh=LSfsGShTig/x/7sK5JTlkKbxqb9h598QtEadtZZbqZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rdbdi5Zy2ftKtxoTmfp9RpyDMsNqPcefclibf/FHFTK8EvrIVRUiUDUPaN0rMgKQfWAaYag91zvbAYucYg14KFcDoZ6F5zmtUUM79Snh6+4aWXiE175DY8pnSQVjUKmkYWNPl9el5c8qsWfZPwZHDsHQzGcVbQFkR7F/HOuZVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lzGuTPB9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v2twKcmK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lzGuTPB9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v2twKcmK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lzGuTPB9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v2twKcmK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lzGuTPB9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v2twKcmK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 20A57676A6;
	Wed, 27 May 2026 13:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779887779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlZN4MZBMRk7/mYsuEmdScE+habUyE7Kd5wM6ZSmZgo=;
	b=lzGuTPB9TxksItwNNrc4fVrQaUQB12CntSIS3UxwCx9fARLVE2nnW2n8of+sODqGKXmLXO
	nOSUl7rwGEX0Zd4AJ/peUQaUKyIvWF/j84REVLYx9Etg21Oy0JCkPOkLGOkui4McBgAc64
	v6p9l8QG6SIwDI7PgqZSwUOINHfTJJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779887779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlZN4MZBMRk7/mYsuEmdScE+habUyE7Kd5wM6ZSmZgo=;
	b=v2twKcmKpiySDGB6ar/59B5yPxRSfjBa/a7BG9Ubym94q6NC6NvrFj8nz8Pkyb3lKK+0dZ
	+uIydVF3HQvabxBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779887779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlZN4MZBMRk7/mYsuEmdScE+habUyE7Kd5wM6ZSmZgo=;
	b=lzGuTPB9TxksItwNNrc4fVrQaUQB12CntSIS3UxwCx9fARLVE2nnW2n8of+sODqGKXmLXO
	nOSUl7rwGEX0Zd4AJ/peUQaUKyIvWF/j84REVLYx9Etg21Oy0JCkPOkLGOkui4McBgAc64
	v6p9l8QG6SIwDI7PgqZSwUOINHfTJJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779887779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlZN4MZBMRk7/mYsuEmdScE+habUyE7Kd5wM6ZSmZgo=;
	b=v2twKcmKpiySDGB6ar/59B5yPxRSfjBa/a7BG9Ubym94q6NC6NvrFj8nz8Pkyb3lKK+0dZ
	+uIydVF3HQvabxBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 093ED5A849;
	Wed, 27 May 2026 13:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SJC9AaPuFmoFGwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 13:16:19 +0000
Message-ID: <26361fb4-54bb-4db6-9394-640ab7115b4f@suse.de>
Date: Wed, 27 May 2026 15:16:18 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
To: Christoph Hellwig <hch@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260520-block-v1-1-6463dc2cf042@kernel.org>
 <ahPnX-CwVgK-9chp@infradead.org> <ahPxmSqT4Y4jcAbQ@kernel.org>
 <ahP3R2nH8-bHMVf0@infradead.org> <ahQX_JCgS9JWIhY-@kernel.org>
 <1dea9df9-18c2-46f5-bf47-abb3f088574b@suse.com>
 <ahWwD0eqj3cUgaKn@casper.infradead.org>
 <8b780901-8184-4908-8bda-56fac42fe6b3@suse.com>
 <17258981-d5b3-4ed1-9b3d-56a0b6ecb3f9@suse.de>
 <ahbti6M8zRWR1oGa@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ahbti6M8zRWR1oGa@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.28
X-Spam-Level: 
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.897];
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

On 5/27/26 15:11, Christoph Hellwig wrote:
> On Wed, May 27, 2026 at 12:04:29PM +0200, Hannes Reinecke wrote:
>> Precisely my reasoning. In most cases, __get_free_page() is just a
>> lazy way of saying "I need some memory and the allocation should not fail".
> 
> Huh?  __get_free_page and kmalloc can and should fail.
> 
Even better, one argument less why it should not be converted :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
