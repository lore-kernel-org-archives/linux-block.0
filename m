Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33152749C
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576235; cv=none; b=hiq9IlKU31UAy6SJscKgUJp7CcuOUm7kNaNgUu8VLeyPMEfx+9NamhfSm06/xMmDWbQFzHimgLAaBHuaMiUQdPRGnnTvpAXyakw1dB8ZTv6mWPe/TbtOjomNc0Q/mGA/66G6eoAQ5zs1FPnns9F8t3RN2UCWbBUR8a2llxpy1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576235; c=relaxed/simple;
	bh=mWMfABGeW9OSw/4TtFiAqP00UGvqWSdO7a3VoQu3g3I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RywuZA/DHuc6K9QGmvFddmh7Mr7h3+zELkkvUoD2It1NyOUqwPMmP+DVi7DDUzJN7tUpWJ3TzdFDc4AU2RGFQRHQnzvHasya4p0uhY8E3YxAjG+h9RrFGwHvhkru7Dhp8AhRT8wxuII0URDScRDHZN50F5CxHNzKqYEpG5/LK9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hMvSYTPI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hMvSYTPI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hMvSYTPI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hMvSYTPI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C5481F45F;
	Mon, 27 Oct 2025 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761576231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWMfABGeW9OSw/4TtFiAqP00UGvqWSdO7a3VoQu3g3I=;
	b=hMvSYTPIV3B6Tl0ZuvukVB2z+/Tr/ka6zYw5DRu3yMd8R3U+ew5pPRN0DZWe9zNPe6iCMH
	OZRuDnf5NJEXecbvdIgUiQ63FPTsobVIdG+iDzeqi3QM+xKirndyi8uxdOB5mxQjH7PwcK
	0h069OQ2DVtQmSnswIlsQLgqE5m5pr8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761576231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWMfABGeW9OSw/4TtFiAqP00UGvqWSdO7a3VoQu3g3I=;
	b=hMvSYTPIV3B6Tl0ZuvukVB2z+/Tr/ka6zYw5DRu3yMd8R3U+ew5pPRN0DZWe9zNPe6iCMH
	OZRuDnf5NJEXecbvdIgUiQ63FPTsobVIdG+iDzeqi3QM+xKirndyi8uxdOB5mxQjH7PwcK
	0h069OQ2DVtQmSnswIlsQLgqE5m5pr8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 275C013693;
	Mon, 27 Oct 2025 14:43:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RvpZCCeF/2jFHwAAD6G6ig
	(envelope-from <mwilck@suse.com>); Mon, 27 Oct 2025 14:43:51 +0000
Message-ID: <563ef9b02d49fa05418c7a1b0b384d898819e0e9.camel@suse.com>
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue attributes
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Benjamin
 Marzinski <bmarzins@redhat.com>, Hannes Reinecke <hare@suse.com>
Date: Mon, 27 Oct 2025 15:43:50 +0100
In-Reply-To: <20250710080341.GA8622@lst.de>
References: <20250702182430.3764163-1-bvanassche@acm.org>
	 <20250703090906.GG4757@lst.de>
	 <918963a5-a349-433a-80a8-6d06c609f20e@acm.org>
	 <20250708095707.GA28737@lst.de>
	 <b23c05be-2bde-424a-a275-811ccc01567c@acm.org>
	 <20250710080341.GA8622@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Hello Christoph, Bart,

Sorry for jumping onto this old thread so late. I just recently became
aware of it because of the discussion about [1].

On Thu, 2025-07-10 at 10:03 +0200, Christoph Hellwig wrote:
> On Tue, Jul 08, 2025 at 09:11:41AM -0700, Bart Van Assche wrote:
> > I will look into modifying the SRP tests in the blktests repository
> > such
> > that these use bio-based mode instead of request-based mode.
>=20
> Note that this just fixes the test case.=C2=A0 The fact that request
> based dm-multipath keeps active requests and thus an elevated=20
> q_usage_counter around still exists then, with effects both to sysfs
> and other users of queue freezing.

As Bart's patch only addresses the regression introduced by
b07a889e8335 ("block: move q->sysfs_lock and queue-freeze under
show/store method"), can we perhaps leave non-sysfs users of queue
freezing aside in this context?

As far as sysfs users are concerned, what problem do you see with
Bart's approach to introduce a timeout for freezing the queues, and
returning an error to user space if this timeout is exceeded?

Would you be willing to accept the set if we'd use the timeout approach
for all affected sysfs attributes?

> > So the question remains what to do about these two regressions:
> > * The deadlock triggered by modifying a sysfs attribute of a
> > =C2=A0 dm-multipath device configured with "queue_if_no_path" and no
> > paths
> > =C2=A0 (temporarily).
>=20
> That's not a deadlock by the classic definition, but yes, it is hang
> that should be addressed.

You can see the "deadlock" in the stacks that Bart has posted in [2].

The dm layer wants to reload the dm table (which, more often than not,
means to re-add a previously lost path device, which would re-enable IO
processing and thus queue freezing), and fails because the process
accessing the sysfs attribute is holding the limits_lock. I can't think
of a better term for this situation than "deadlock".

Martin

[1] https://lore.kernel.org/dm-devel/20251009030431.2895495-1-bmarzins@redh=
at.com/
[2] https://lore.kernel.org/linux-block/20250625195450.1172740-1-bvanassche=
@acm.org/
