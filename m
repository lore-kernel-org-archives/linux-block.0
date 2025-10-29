Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7A285CB6
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757766; cv=none; b=dax33gq2S8MjEvD6iPd2GLr+z4D0un4eWVC+YWuVKWQialbrQLsPjO0xo8/BJqViRxz7R69v7hHlDajIFneOBtPz0z4ZHY0+izTrrD+KrYNoLisgaNjlZIc1gS0iHMxZUE8zaVBKCbm3vSCocys/CKulQdf0MrzT7TULLIriWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757766; c=relaxed/simple;
	bh=pxVii3Uh33ZERhuiUOF1YtmI9dz2Yof4i5lDvqmJgyU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Myadvdxo5LzUNMOJP1Yw3sNBMPJJi6St6wUcqHzljC0MwDvwVJ8wtWFdmSO6SxK1peqO21LJ16/c4/Ob1mGuGeHZyMxW8TM5MzlipRZLNha9oYw7gn5m/mwlfR1haVPN/zm92mIHAR+EUtb4rWdKAd9LzsVWEuupeO0lnCwZGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kyca35cd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kyca35cd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kyca35cd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kyca35cd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5755334098;
	Wed, 29 Oct 2025 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761757762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxVii3Uh33ZERhuiUOF1YtmI9dz2Yof4i5lDvqmJgyU=;
	b=Kyca35cdVk52oA6yKGKwB/510FdJWdlaWwdn/6zsU8C2lJVcdtZRvpQ0udU8mniaRT4QQO
	qs7qdfuS2/hdixo2tqDESc4q2nLWSX12v+1W0J0JboyokKn+cB89cGAKasoPSQsrcPJ+mk
	1pVmlkP1efM34Zg/miO17LSHSoFOB40=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761757762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxVii3Uh33ZERhuiUOF1YtmI9dz2Yof4i5lDvqmJgyU=;
	b=Kyca35cdVk52oA6yKGKwB/510FdJWdlaWwdn/6zsU8C2lJVcdtZRvpQ0udU8mniaRT4QQO
	qs7qdfuS2/hdixo2tqDESc4q2nLWSX12v+1W0J0JboyokKn+cB89cGAKasoPSQsrcPJ+mk
	1pVmlkP1efM34Zg/miO17LSHSoFOB40=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E3F21396A;
	Wed, 29 Oct 2025 17:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DlU4CkJKAmmhUwAAD6G6ig
	(envelope-from <mwilck@suse.com>); Wed, 29 Oct 2025 17:09:22 +0000
Message-ID: <106959c64e91ff8cc4477d45e11d623067cac6e5.camel@suse.com>
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue attributes
From: Martin Wilck <mwilck@suse.com>
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Benjamin
 Marzinski <bmarzins@redhat.com>, Hannes Reinecke <hare@suse.com>
Date: Wed, 29 Oct 2025 18:09:21 +0100
In-Reply-To: <07b9a54e-a627-41ef-afa7-651bdeda0cbd@acm.org>
References: <20250702182430.3764163-1-bvanassche@acm.org>
	 <20250703090906.GG4757@lst.de>
	 <918963a5-a349-433a-80a8-6d06c609f20e@acm.org>
	 <20250708095707.GA28737@lst.de>
	 <b23c05be-2bde-424a-a275-811ccc01567c@acm.org>
	 <20250710080341.GA8622@lst.de>
	 <563ef9b02d49fa05418c7a1b0b384d898819e0e9.camel@suse.com>
	 <20251029085810.GA32474@lst.de>
	 <91b583c2fad9f1e72ed5dc794a709289de363a39.camel@suse.com>
	 <20251029093833.GA1066@lst.de>
	 <07b9a54e-a627-41ef-afa7-651bdeda0cbd@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, 2025-10-29 at 09:31 -0700, Bart Van Assche wrote:
>=20
> On 10/29/25 2:38 AM, Christoph Hellwig wrote:
> > On Wed, Oct 29, 2025 at 10:36:30AM +0100, Martin Wilck wrote:
> > > Consider it a "trylock" type of operation, which is a valid
> > > method to
> > > avoid deadlocks, AFAIK.
> >=20
> > Only if the operation is an optimistic optimization.=C2=A0 I don't see
> > how
> > setting an attribute would ever qualify =EF=AC=85or that.
>=20
> Let's take a step back.
>=20
> Before commit af2814149883 ("block: freeze the queue in
> queue_attr_store") there was a risk that modifying a request queue
> attribute while I/O is in flight would result in a malformed bio.
> Since
> that commit a deadlock occurs if an attribute is modified for a
> dm-multipath queue with I/O in flight and if queue_if_no_path has
> been
> set.
> How about introducing a new request queue flag that is set for=20
> dm-multipath devices if queue_if_no_path devices has been set and
> only
> calling blk_mq_freeze_queue_wait_timeout() instead of
> blk_freeze_queue_start() if that flag has been set? That would solve
> the
> deadlock for dm-multipath devices without affecting the request queue
> sysfs attribute behavior for other block devices.

Sounds good to me.

Martin
