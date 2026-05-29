Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215636B07C
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035452; cv=none; b=noe7HAzxHyYOASAG1WxvjVuK5VpyAnvO86MukMoT1zr88H8I/4JWtH7xOpZdAdBiERIYuBUB3AM2DqXm8kLA8H47qltd/25cV2PfBtoXGQ7Uk35UQMYhV2PSX6AMdoCZW3ti2WD1PA+LDKxMFztVNo7A65ZcYhHKUrBx+V+9rnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035452; c=relaxed/simple;
	bh=d3FthbysvdYGqF8sr0529bBGtAtX9C2m+qzX+bsOnkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ1iMATCL/hMc6KXrrqgq5SJ3S9e/oCZfjghZH50IqSX6ydtJmEBCFNORItjLQJ0C2+9KUuQ+9wdIKh2PnBldSQM/D22RW64167Pub/RiKNwrlCLe9mO12u+Aq9G5E+GRA5GfvjsiP/+s+PXP1WyflMzhxF3vVFCSg4c+eBe2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bkzkhmIP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TZYlZ58k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bkzkhmIP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TZYlZ58k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bkzkhmIP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TZYlZ58k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bkzkhmIP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TZYlZ58k"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3F546ADFC;
	Fri, 29 May 2026 06:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vx4YswAc1yVXQsKvAiXfezzli9FVMB1COPrkwMvq7mk=;
	b=bkzkhmIPM1k+uqvO/DWR4X7xY2psViNf1K6x+RYuE0JEAMkYqTRFzbrdr/tb5EkDHjvqB+
	hNFu7KEcAE4gm1p9r0DzoLHly45JBcg+alpe0MLpMg8L6ftQv7QAMElPgG9sHnRlBpE3Zk
	5fAjjZRzKrXK8DmV5hKllJ8iiBO8zk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vx4YswAc1yVXQsKvAiXfezzli9FVMB1COPrkwMvq7mk=;
	b=TZYlZ58k999uRr99rmYwif3aPsN6aYeks/D3M/sevnjYUb/Z7jUJN+zYJU3AmoyDjz+fpH
	YZa8vidu0Oav2sAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vx4YswAc1yVXQsKvAiXfezzli9FVMB1COPrkwMvq7mk=;
	b=bkzkhmIPM1k+uqvO/DWR4X7xY2psViNf1K6x+RYuE0JEAMkYqTRFzbrdr/tb5EkDHjvqB+
	hNFu7KEcAE4gm1p9r0DzoLHly45JBcg+alpe0MLpMg8L6ftQv7QAMElPgG9sHnRlBpE3Zk
	5fAjjZRzKrXK8DmV5hKllJ8iiBO8zk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vx4YswAc1yVXQsKvAiXfezzli9FVMB1COPrkwMvq7mk=;
	b=TZYlZ58k999uRr99rmYwif3aPsN6aYeks/D3M/sevnjYUb/Z7jUJN+zYJU3AmoyDjz+fpH
	YZa8vidu0Oav2sAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D2B05B1C5;
	Fri, 29 May 2026 06:17:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5dFCIXMvGWorFAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:17:23 +0000
Message-ID: <4f02694e-1d99-473f-8ce4-2b263efe8138@suse.de>
Date: Fri, 29 May 2026 08:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] block: Include bvec.h kernel-doc in the htmldocs
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-mm@kvack.org,
 Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@infradead.org>
References: <20260528175905.1102280-1-willy@infradead.org>
 <20260528175905.1102280-3-willy@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260528175905.1102280-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 5/28/26 19:59, Matthew Wilcox (Oracle) wrote:
> People have gone to the trouble of writing this kernel-doc; the
> least we can do is publish it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   Documentation/core-api/kernel-api.rst | 1 +
>   include/linux/bvec.h                  | 2 ++
>   2 files changed, 3 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
