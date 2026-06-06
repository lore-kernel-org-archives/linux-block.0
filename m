Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DA72622
	for <linux-block@vger.kernel.org>; Sat,  6 Jun 2026 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780730944; cv=none; b=BGgsZsvwpWn4QMr59AcFYG124zBIyp3hnqBWsqdWBIF61LwXHIVm+w38aCQg7M6paVFsWRiysEo3zGqte2vPQMAqugqO8ahAoprPygXPlVt340Zi2AAhBa2S8gvx1rY+hhwAysg+a3pnySJb6g5Zy/Dx/pS0VcTC+YdmnINcuAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780730944; c=relaxed/simple;
	bh=VeQgtyLZwex4j46Tp5dNTbznfW6J5BAR+X6/hFqYOj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ye/DI8qMrf/xTYwp2Ou7QUhkqVgnf3oO7RqKJ9XmlI0V7inowSHF8p0T17Dcrc5q2ic20gLxK14l/LO53JWctceQ+Q8EC7nLXjyvLufDU6wzwEtq/djPH837Y5IyHF/wyBLdCx3z/bi/57/UCUU2XiZn2yUN8Y5YOshTZ80REtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0lJ7y8fi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3+0Dm5Gp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h3PmZ5H+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DJ9Krip7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0lJ7y8fi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3+0Dm5Gp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h3PmZ5H+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DJ9Krip7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF2116B387;
	Sat,  6 Jun 2026 07:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780730942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqcAqiWpbibPNyAu/PW5PUvHHK4psakmpEjn7UuFGlk=;
	b=0lJ7y8fiEvrZuTZ0X6SqWI0aRu2wHKQD1eMnSYFFVGZnGhAT1h2l0awfjWbJZeczjRIP8n
	xInbXO16GTNv5N5Et61yP2d3T/oSi8Vv+GslY36ADjJ4vtZY+q9dYIAzrM/C9sMtNnhwSx
	Cx+S0nijmZLZSSrVP0ljBYt4VUztJp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780730942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqcAqiWpbibPNyAu/PW5PUvHHK4psakmpEjn7UuFGlk=;
	b=3+0Dm5GpJtjfjP/ELNfrDF9CXK09VIAQ38j5dl/LinavtW8KkZE1du1iWByBsPm0NPvdYR
	EeFqIHnlBlfwMMAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780730940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqcAqiWpbibPNyAu/PW5PUvHHK4psakmpEjn7UuFGlk=;
	b=h3PmZ5H+X9TrKhKkyRm0y5eRSexwyhyXgNcroCw/6bAE5fRvD34t/2aGvIuG80yudVV/TH
	0iTOQEp08Qym8Bcp30vT31t5jZleLOo8QS+Mt5bIFRPsgXmOIKcy8Gn9mYEDRnsXPGXMWu
	f7QG+0BfbFBHVHXrN+Y6S6zqBJgGWXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780730940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqcAqiWpbibPNyAu/PW5PUvHHK4psakmpEjn7UuFGlk=;
	b=DJ9Krip7s3AYNVLLLl/OSWyFaZmQ2SDOfboJbT/mIXVwRVnUcq14uthKlCh/rYXWJkuniI
	W0W0vHR6zGphWhCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 481CD779A7;
	Sat,  6 Jun 2026 07:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j0SrNDnMI2r6DAAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 06 Jun 2026 07:28:57 +0000
Message-ID: <4fc4ce6d-47a1-46c4-8c05-d35887e5fcd6@suse.de>
Date: Sat, 6 Jun 2026 09:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] block: add configurable error injection
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260605184441.590927-1-hch@lst.de>
 <20260605184441.590927-5-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260605184441.590927-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -4.30

On 6/5/26 20:44, Christoph Hellwig wrote:
> Add a new block error injection interface that allows to inject specific
> status code for specific ranges.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   Documentation/block/error-injection.rst |  59 +++++
>   Documentation/block/index.rst           |   1 +
>   block/Kconfig                           |   7 +
>   block/Makefile                          |   1 +
>   block/blk-core.c                        |   3 +
>   block/blk-sysfs.c                       |   4 +
>   block/blk.h                             |  12 +
>   block/error-injection.c                 | 308 ++++++++++++++++++++++++
>   block/genhd.c                           |   4 +
>   include/linux/blkdev.h                  |   6 +
>   10 files changed, 405 insertions(+)
>   create mode 100644 Documentation/block/error-injection.rst
>   create mode 100644 block/error-injection.c
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
