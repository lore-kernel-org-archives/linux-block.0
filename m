Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2536B
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397104; cv=none; b=DRFdw2twsmY6YNoAMWSx9jfGTdOyvM2sJ5I+J/gRZCtI3OJ3th89XUueukCgf6qfv0tC3spJh7F6WWly5iq2igtU+d3CK1MaWE27qeTr/FlKUgSRbRDMtlwoM99dDQkBQGgOO++HEVehD/Up0bg8zyB7wu6x1RlmjUi4pDejKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397104; c=relaxed/simple;
	bh=2zdp7qMgH7u3+X36FMpb+HCGCdyEcz7Cu7LRTdOeFB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cD0hSWVoVCjhXXN6SsQsCVWVoZpXsPuJ1rFLqFiSm8jHG0IqMsp0kU6z7oWvPaltGCY1AgqdW/yOfGNcs7CxpL6BZKQ6cM3jYbf37jemzrqGUaarcQqGSZgXs6j2znOi7nTHDVT2xL6jM9G0FDuoigFvImlWtTagG4voMckGTaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vEW2cCu6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rC1yq8Xl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vEW2cCu6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rC1yq8Xl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vEW2cCu6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rC1yq8Xl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vEW2cCu6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rC1yq8Xl"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2FA3721FD0;
	Wed, 19 Mar 2025 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742397100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcHjYImoZ4zMa+3sgvJp80GEtUicvPgGPbO5RgLH6Lw=;
	b=vEW2cCu6nmkMkQalYI82l9s2ig557qlzONbrgTUzLWKmlIsnjt47imaXWm8DIBtCSS7jd3
	mQs1UiC/cS6/HmmhoroxLcO9cPjsNpLBAY2pRy8iQddDSxxRFnEXygE//EuC6q2pxNf51P
	2kdw2NDMXz59RZsgctiAXCTPH6PQei0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742397100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcHjYImoZ4zMa+3sgvJp80GEtUicvPgGPbO5RgLH6Lw=;
	b=rC1yq8XlOg9YwLjr7aO3eYN+Wfb9CLfhAX+z5otOF7wG6WBI0q09dOmQ2VUmqVNdH4JVcX
	7VbXU2MIwVnOGVDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742397100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcHjYImoZ4zMa+3sgvJp80GEtUicvPgGPbO5RgLH6Lw=;
	b=vEW2cCu6nmkMkQalYI82l9s2ig557qlzONbrgTUzLWKmlIsnjt47imaXWm8DIBtCSS7jd3
	mQs1UiC/cS6/HmmhoroxLcO9cPjsNpLBAY2pRy8iQddDSxxRFnEXygE//EuC6q2pxNf51P
	2kdw2NDMXz59RZsgctiAXCTPH6PQei0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742397100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcHjYImoZ4zMa+3sgvJp80GEtUicvPgGPbO5RgLH6Lw=;
	b=rC1yq8XlOg9YwLjr7aO3eYN+Wfb9CLfhAX+z5otOF7wG6WBI0q09dOmQ2VUmqVNdH4JVcX
	7VbXU2MIwVnOGVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C36113A2C;
	Wed, 19 Mar 2025 15:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cyRQBqze2md4QwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 19 Mar 2025 15:11:40 +0000
Message-ID: <6c5bfc10-f5ad-4a80-b0ca-772ac06a37f1@suse.cz>
Date: Wed, 19 Mar 2025 16:11:39 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM BPF Topic] Warming up to frozen pages
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Matthew Wilcox <willy@infradead.org>,
 lsf-pc@lists.linuxfoundation.org, linux-mm@kvack.org,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <2a2e5822-d8a6-4460-b92a-01d113e18ead@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <2a2e5822-d8a6-4460-b92a-01d113e18ead@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/18/25 15:47, Hannes Reinecke wrote:
> Hey all,
> 
> (Thanks, Jon, for the title :-)
> the recent discussion around frozen pages and when to do a 
> get_page()/put_page() and when not resulted in quite some unresolved issues.
> So I would like to propose a session at LSF/MM:
> 
> 'Warming up to frozen pages'
> With the frozen pages patchset from Willy slab pages don't need
> (and, in fact, can have) a page reference anymore. While this easy

BTW, my hope is that large kmalloc folios would also drop the refcount. That
means anything obtained by kmalloc(N) where N is over 8k (order-1 folio on
4k PAGE_SIZE). That 8k is an implementation detail of SLUB (SLAB used to
have more) and thus all kmalloc() buffers should better behave the same to
avoid surprises when some particular allocation size changes, or the thing
becomes used on an architecture with larger than 4k page size and thus
becomes a "small" kmalloc() there.

Willy already added a page type for large kmalloc. Given we can expect
possible troubles after the small kmalloc() ones already hit us, I'd first
just add get_page()/put_page() warnings for that large kmalloc page type in
addition to the slab page type ones and expose that to -next (after the 6.15
merge window) to see if something needs fixing.

> to state, and to implement when using iov iterators, problems
> arise when these iov iterators get mangled eg when being passed
> via the various layers in the kernel.
> Case in point: 'recvmsg()', when called from userspace, is being
> passed an iov, and the iterator type defines if a page reference
> need to be taken. However, when called from other kernel subsystems
> (eg from nvme-tcp or iscsi), the iov is filled from a bvec which
> in itself is filled from an iov iter from userspace, so the iov
> iterator will assume it's a 'normal' bvec, and get a reference for
> all entries as it wouldn't know which entry is a 'normal' and which
> is a 'slab' page.
> As Christoph indicated this is _not_ how things should be, so
> a discussion on how to disentangle this would be good.
> Maybe we even manage to lay down some rules when a page reference
> should be taken and when not.
> 
> Cheers,
> 
> Hannes

