Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CE7239E66
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880644; cv=none; b=dJgGquGJGx3lC3Evt/A6CYct2u+btqkjZQ0S2v9d4x7O12VIWIa2PTaMJkxMry1rPRn20LUj41UhV+Ay0qugUBWf1RtcU0daZFRYHAba6EnQ5Bdpcva8VjNovR0cZNVn6E16dECobQDEob5DZeGVbauwUWJvnlEw0tagmZWo77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880644; c=relaxed/simple;
	bh=Ri7BzHLJdIHUL6cELjzvaC2Kgq8dgyutpvolsdBJakw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4nxHPyGXZljb7qtj3tnyMPT6FKtMdVvbfnkrp+yTj/4HGp2Mq12AOkHtImDaV1RPd9iasq7AygD0YZ5BDp7aiDvw88N2CO96hsU5ZIt+TZf5sk2NBV9zLSlhdmtNoR1n9C4+fVKIntICNrgVA06SLw8lo65Bg6wepZeQnKYJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kotCYIyC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GpgDkiGW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kotCYIyC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GpgDkiGW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kotCYIyC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GpgDkiGW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kotCYIyC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GpgDkiGW"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B61981F853;
	Wed, 30 Jul 2025 13:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753880640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePH8CT9sd/T1aDrAXMuumSXHIO4ONMA5SNXXv8whZso=;
	b=kotCYIyCHI7+FDnmI5oznxSA3Wbxhy+QppbzwGvC/JiZ8MY9arPkFLgF1DfA3y3Q/FoB4h
	6QcH207a4yZwk00usxt6OlE8Rmi7dQuGSnbANY+9g781HyWCy+mndph4Y4hasyQ25Ex4Yc
	Qi99iryT3VFmsMSGuMxnn48jOXyj2Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753880640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePH8CT9sd/T1aDrAXMuumSXHIO4ONMA5SNXXv8whZso=;
	b=GpgDkiGWuObEa1VMoXFP5eGJya4u/8uoohGlKSMe0fNU1nJgz7f+rc+irvUKwLYVF1IoAz
	f7DufZ7F3AsVgJAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753880640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePH8CT9sd/T1aDrAXMuumSXHIO4ONMA5SNXXv8whZso=;
	b=kotCYIyCHI7+FDnmI5oznxSA3Wbxhy+QppbzwGvC/JiZ8MY9arPkFLgF1DfA3y3Q/FoB4h
	6QcH207a4yZwk00usxt6OlE8Rmi7dQuGSnbANY+9g781HyWCy+mndph4Y4hasyQ25Ex4Yc
	Qi99iryT3VFmsMSGuMxnn48jOXyj2Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753880640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePH8CT9sd/T1aDrAXMuumSXHIO4ONMA5SNXXv8whZso=;
	b=GpgDkiGWuObEa1VMoXFP5eGJya4u/8uoohGlKSMe0fNU1nJgz7f+rc+irvUKwLYVF1IoAz
	f7DufZ7F3AsVgJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F48D1388B;
	Wed, 30 Jul 2025 13:04:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id unCYJkAYimihMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Jul 2025 13:04:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4D3EBA094F; Wed, 30 Jul 2025 15:03:56 +0200 (CEST)
Date: Wed, 30 Jul 2025 15:03:56 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, axboe@kernel.dk, akpm@linux-foundation.org, 
	yang.yang@vivo.com, dlemoal@kernel.org, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, johnny.chenyi@huawei.com, Omar Sandoval <osandov@fb.com>, 
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
Message-ID: <jr54uomodnzqyw4bu4hcdpllgafkhueyygiiempuudwjy3vir5@d7lv3jsxxqx2>
References: <20250729031906.3615228-1-yukuai1@huaweicloud.com>
 <20250729031906.3615228-2-yukuai1@huaweicloud.com>
 <ozjsdoiqa2uem65qqj4fjbrwm6toxlj5bzv7f5dg5xfiljv3zi@wcaamboo2r6h>
 <8edcdef6-8749-aa45-e7d2-ada677645d76@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8edcdef6-8749-aa45-e7d2-ada677645d76@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[huawei.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 30-07-25 10:03:50, Yu Kuai wrote:
> 在 2025/07/29 18:16, Jan Kara 写道:
> > On Tue 29-07-25 11:19:05, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > Currently elevators will record internal 'async_depth' to throttle
> > > asynchronous requests, and they both calculate shallow_dpeth based on
> > > sb->shift, with the respect that sb->shift is the available tags in one
> > > word.
> > > 
> > > However, sb->shift is not the availbale tags in the last word, see
> > > __map_depth:
> > > 
> > > if (index == sb->map_nr - 1)
> > >    return sb->depth - (index << sb->shift);
> > > 
> > > For consequence, if the last word is used, more tags can be get than
> > > expected, for example, assume nr_requests=256 and there are four words,
> > > in the worst case if user set nr_requests=32, then the first word is
> > > the last word, and still use bits per word, which is 64, to calculate
> > > async_depth is wrong.
> > > 
> > > One the other hand, due to cgroup qos, bfq can allow only one request
> > > to be allocated, and set shallow_dpeth=1 will still allow the number
> > > of words request to be allocated.
> > > 
> > > Fix this problems by using shallow_depth to the whole sbitmap instead
> > > of per word, also change kyber, mq-deadline and bfq to follow this.
> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > 
> > I agree with these problems but AFAIU this implementation of shallow depth
> > has been done for a reason. Omar can chime in here as the original author
> > or perhaps Jens but the idea of current shallow depth implementation is
> > that each sbitmap user regardless of used shallow depth has a chance to
> > allocate from each sbitmap word which evenly distributes pressure among
> > available sbitmap words. With the implementation you've chosen there will
> > be higher pressure (and thus contention) on words with low indices.
> 
> Yes, this make sense. However, consider that shallow depth is only used
> by elevator, this higher pressure should be negligible for deadline and
> bfq. As for kyber, this might be a problem.

I agree that for bfq the overhead should be in the noise. For mq-deadline
it might be measurable but I'm not overly concerned.

> > So I think we would be good to fix issues with shallow depth for small
> > number of sbitmap words (because that's where these buggy cornercases may
> > matter in practice) but I believe the logic which constrains number of used
> > bits from each *word* when shallow_depth is specified should be kept.  It
> > might make sense to change the API so that shallow_depth is indeed
> > specified compared to the total size of the bitmap, not to the size of the
> > word (because that's confusing practically everybody I've met and is a
> > constant source of bugs) if it can be made to perform well.
> 
> Do you think will it be ok to add a new shallow depth API to use the
> total size, and convert bfq and deadline to use it?

I think having two APIs will be even more confusing than the current state.
But as I wrote I think you can have API to specify shallow depth in total
size and in sbitmap_queue_get_shallow() do:

shallow_per_word = (shallow_depth << sb->shift) / sb->depth;
rounding_index = shallow_depth - shallow_per_word * sb->depth;

and allow depth shallow_per_word + 1 if current index < rounding_index and
exactly shallow_per_word if current index >= rounding_index. This will
still evenly distribute shallow depth among words and I don't think the
additional overhead of the several arithmetic operations will be visible.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
