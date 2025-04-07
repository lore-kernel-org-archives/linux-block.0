Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F5225403
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009825; cv=none; b=eWnXZ3cxwfsHYYrmSg6XEKz0yOTSZjb9iDbopauTsUCxovEsqc/Q54wJkyoAEQVmewjq1P1pnGa1XJ+qCN5NVVw99wBeXdt7aiZ8jM6t+Uznts/LS5jTqhEdVqBidRsdJL2L1H4qWAHuvCIurI4ytxfNbuNrH2PkReSPa+Te8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009825; c=relaxed/simple;
	bh=6JGfdGFnCY4WXyqcO2YI5MQfXyaE9C2jLK/+n+Rbttc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBcd+uEF4DK5JVefAtaGrDKmYRGFpASytq8BPSAjdaB7PE1D+zUD1bzmD7FWG6QJ6wTI6R2z1HWA9k+owmkJUkNnavXRFqxPh1MqqcWGUyaHibkcvHziTmHNeIZT6eNXOt/+FhxgrCvR6AED4HXhH1NnzMIDGBBMLCUFBzRCisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JoZ5pIwx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=utwHAtPL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JoZ5pIwx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=utwHAtPL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JoZ5pIwx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="utwHAtPL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JoZ5pIwx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="utwHAtPL"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51E1D21165;
	Mon,  7 Apr 2025 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744009821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spWS8YK7RWKQFjV07RpNV3MQ5ZczpB5p5XPsvSawtAQ=;
	b=JoZ5pIwx0TywZ6j8Cqz9bWLy+nH4WYQTt20aFxVgWbh5tiZDdIOz45P+KPLBzmqkS6uSMu
	VBud1nPujwCT7GEJ3h0knWaYFtgERn7EL7P96X9mfhR4u1WS9KtEzgOZKNKl1R8MvxMgEG
	5lxsX0I4ji+rweBsIY7yoEqJDuGxXUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744009821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spWS8YK7RWKQFjV07RpNV3MQ5ZczpB5p5XPsvSawtAQ=;
	b=utwHAtPL/nsStzPnmXlCRF1e6lSJJxkqi/G44bQ+W1r2Fp2A4VhohK3KKClgiwHzopsHWw
	G0bU+t5RyIAAAbBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744009821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spWS8YK7RWKQFjV07RpNV3MQ5ZczpB5p5XPsvSawtAQ=;
	b=JoZ5pIwx0TywZ6j8Cqz9bWLy+nH4WYQTt20aFxVgWbh5tiZDdIOz45P+KPLBzmqkS6uSMu
	VBud1nPujwCT7GEJ3h0knWaYFtgERn7EL7P96X9mfhR4u1WS9KtEzgOZKNKl1R8MvxMgEG
	5lxsX0I4ji+rweBsIY7yoEqJDuGxXUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744009821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spWS8YK7RWKQFjV07RpNV3MQ5ZczpB5p5XPsvSawtAQ=;
	b=utwHAtPL/nsStzPnmXlCRF1e6lSJJxkqi/G44bQ+W1r2Fp2A4VhohK3KKClgiwHzopsHWw
	G0bU+t5RyIAAAbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A61413A4B;
	Mon,  7 Apr 2025 07:10:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cSv0Olx682fQEgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 07 Apr 2025 07:10:20 +0000
Message-ID: <8a232716-74f8-4bba-a514-d0f766492344@suse.de>
Date: Mon, 7 Apr 2025 09:10:20 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bio segment constraints
To: Sean Anderson <seanga2@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>
References: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/6/25 21:40, Sean Anderson wrote:
> Hi all,
> 
> I'm not really sure what guarantees the block layer makes regarding the
> segments in a bio as part of a request submitted to a block driver. As
> far as I can tell this is not documented anywhere. In particular,
> 
> - Is bv_len aligned to SECTOR_SIZE?

The block layer always uses a 512 byte sector size, so yes.

> - To logical_sector_size?

Not necessarily. Bvecs are a consecutive list of byte ranges which
make up the data portion of a bio.
The logical sector size is a property of the request queue, which is
applied when a request is formed from one or several bios.
For the request the overall length need to be a multiple of the logical
sector size, but not necessarily the individual bios.

> - What if logical_sector_size > PAGE_SIZE?

See above.

> - What about bv_offset?

Same story. The eventual request needs to observe that the offset
and the length is aligned to the logical block size, but the individual
bios might not.

> - Is it possible to have a bio where the total length is a multiple of
>    logical_sector_size, but the data is split across several segments
>    where each segment is a multiple of SECTOR_SIZE?

Sure.

> - Is is possible to have segments not even aligned to SECTOR_SIZE?

Nope.

> - Can I somehow request to only get segments with bv_len aligned to
>    logical_sector_size? Or do I need to do my own coalescing and bounce
>    buffering for that?
> 

The driver surely can. You should be able to set 'max_segment_size' to
the logical block size, and that should give you what you want.

> I've been reading some drivers (as well as stuff in block/) to try and
> figure things out, but it's hard to figure out all the places where
> constraints are enforced. In particular, I've read several drivers that
> make some big assumptions (which might be bugs?) For example, in
> drivers/mtd/mtd_blkdevs.c, do_blktrans_request looks like:
> 
In general, the block layer has two major data items, bios and requests.
'struct bio' is the central structure for any 'upper' layers to submit
data (via the 'submit_bio()' function), and 'struct request' is the
central structure for drivers to fetch data for submission to the
hardware (via the 'queue_rq()' request_queue callback).
And the task of the block layer is to convert 'struct bio' into
'struct request'.

[ .. ]

> For context, tr->blkshift is either 512 or 4096, depending on the
> backend. From what I can tell, this code assumes the following:
> 
mtd is probably not a good examples, as MTD has it's own set of 
limitations which might result in certain shortcuts to be taken.

> - There is only one bio in a request. This one is a bit of a soft
>    assumption since we should only flush the pages in the bio and not the
>    whole request otherwise.
> - There is only one segment in a bio. This one could be reasonable if
>    max_segments was set to 1, but it's not as far as I can tell. So I
>    guess we just go off the end of the bio if there's a second segment?
> - The data is in lowmem OR bv_offset + bv_len <= PAGE_SIZE. kmap() only
>    maps a single page, so if we go past one page we end up in adjacent
>    kmapped pages.
> 
Well, that code _does_ look suspicious. It really should be converted
to using the iov iterators.
But then again, it _might_ be okay if there are underlying MTD
restrictions which would devolve into MTD only having a single bvec.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
