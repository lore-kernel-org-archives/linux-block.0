Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69E1A23AC
	for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753739146; cv=none; b=psE9u2CSxL4Otei+rsuViLYuJC+8Pb9D55YUV9S0LEiPiNCzoggrTcRHjoetrKytjM9yBRnzXGX58vZrkukaulitNbJxqz23Z7zORjCnSeSZ2/J6tkywFLuOxyyqIr9oX3PWWwUdztH86rcYZYk4kOkJ8nxz7uI2hD3lAUILlM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753739146; c=relaxed/simple;
	bh=iV6+bPTGbUHi2MhzhyQci+TW/n5MwTAaYqeJo4d8HcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6dnbvQtK/r6OxDnQEY9B2RTG8flSIBUAdlazmw/zAf786pryDc5+uqcfmyT+MuIl1Bsu3kErIAFVasBcWUNwcX0LVntnvIl5PCM5kTqX06CyfzvNr0Za31RG0BqQBKcucboTsNB7IU9+1vUmyU4oXbM0yl62siGYN/L1Gg2D2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=strhdwqC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhj3IyxI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=strhdwqC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhj3IyxI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="strhdwqC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhj3IyxI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="strhdwqC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhj3IyxI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8ABA82126C;
	Mon, 28 Jul 2025 21:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753739141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv5jRqD9WZlAyj2+uK5Sxb4o6SmtPb77HgSRhD/FrJQ=;
	b=strhdwqC75liZrJ+knU4/Q28CGPXy3uzwt36vx4Wcab8QuS9r4566PKKNBgZd7+KjIoIo+
	X68NaVTq0n7LSZ0GPFp0JorGVTTxkwqvpB1Qk0E4KDd8oJ5GEHhyYdST9fjjRjIwFpWVtO
	Lg7JPEFlU5C3nzd1NyUXmKM7h1xquME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753739141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv5jRqD9WZlAyj2+uK5Sxb4o6SmtPb77HgSRhD/FrJQ=;
	b=nhj3IyxI+sKRRTvYYVORUevMQUyIMeoRsK0mS1Yp5OKOcSokqQ7s1jPo43p4i6SV70NDPK
	henPZ8PGw7KNNQDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=strhdwqC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nhj3IyxI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753739141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv5jRqD9WZlAyj2+uK5Sxb4o6SmtPb77HgSRhD/FrJQ=;
	b=strhdwqC75liZrJ+knU4/Q28CGPXy3uzwt36vx4Wcab8QuS9r4566PKKNBgZd7+KjIoIo+
	X68NaVTq0n7LSZ0GPFp0JorGVTTxkwqvpB1Qk0E4KDd8oJ5GEHhyYdST9fjjRjIwFpWVtO
	Lg7JPEFlU5C3nzd1NyUXmKM7h1xquME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753739141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv5jRqD9WZlAyj2+uK5Sxb4o6SmtPb77HgSRhD/FrJQ=;
	b=nhj3IyxI+sKRRTvYYVORUevMQUyIMeoRsK0mS1Yp5OKOcSokqQ7s1jPo43p4i6SV70NDPK
	henPZ8PGw7KNNQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 766F81368A;
	Mon, 28 Jul 2025 21:45:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8j2XHIXvh2jMDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 28 Jul 2025 21:45:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 25821A09E7; Mon, 28 Jul 2025 23:45:37 +0200 (CEST)
Date: Mon, 28 Jul 2025 23:45:37 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai@kernel.org>
Cc: Jan Kara <jack@suse.cz>, dlemoal@kernel.org, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH v2] blk-ioc: don't hold queue_lock for ioc_lookup_icq()
Message-ID: <nqlzjsh267pnjh3gviw4bwtvviwiq5oso4pksngjcd46c5pmf3@l5cjx5h7akab>
References: <20250725180334.40187-1-yukuai@kernel.org>
 <64sbgvovtubkm2zelenee6pjkdciqlgqmri3bmycce6y265sy4@uptdqvz7g2lk>
 <9dc51c34-1e5d-4da2-bc00-a89e7c173073@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dc51c34-1e5d-4da2-bc00-a89e7c173073@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8ABA82126C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Tue 29-07-25 01:08:40, Yu Kuai wrote:
> Hi,
> 
> 在 2025/7/28 17:28, Jan Kara 写道:
> > On Sat 26-07-25 02:03:34, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > Currently issue io can grab queue_lock three times from bfq_bio_merge(),
> > > bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
> > > necessary if icq is already created because both queue and ioc can't be
> > > freed before io issuing is done, hence remove the unnecessary queue_lock
> > > and use rcu to protect radix tree lookup.
> > > 
> > > Noted this is also a prep patch to support request batch dispatching[1].
> > > 
> > > [1] https://lore.kernel.org/all/20250722072431.610354-1-yukuai1@huaweicloud.com/
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > Looks good! Just one small comment below. With that fixed feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > > diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> > > index ce82770c72ab..ea9c975aaef7 100644
> > > --- a/block/blk-ioc.c
> > > +++ b/block/blk-ioc.c
> > > @@ -308,19 +308,18 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
> > >   #ifdef CONFIG_BLK_ICQ
> > >   /**
> > > - * ioc_lookup_icq - lookup io_cq from ioc
> > > + * ioc_lookup_icq - lookup io_cq from ioc in io issue path
> > >    * @q: the associated request_queue
> > >    *
> > >    * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
> > > - * with @q->queue_lock held.
> > > + * from io issue path, either return NULL if current issue io to @q for the
> > > + * first time, or return a valid icq.
> > >    */
> > >   struct io_cq *ioc_lookup_icq(struct request_queue *q)
> > >   {
> > >   	struct io_context *ioc = current->io_context;
> > >   	struct io_cq *icq;
> > > -	lockdep_assert_held(&q->queue_lock);
> > > -
> > >   	/*
> > >   	 * icq's are indexed from @ioc using radix tree and hint pointer,
> > >   	 * both of which are protected with RCU.  All removals are done
> > In this comment there's still reference to holding 'q lock'. I think you
> > should replace that with justification why when called from IO issue path
> > we are guaranteed found pointer is safe to use.
> Thanks for the review! How about:

Just one spelling correction. Otherwise looks great to me.

> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index ea9c975aaef7..fd77e655544f 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -322,9 +322,9 @@ struct io_cq *ioc_lookup_icq(struct request_queue *q)
> 
>         /*
>          * icq's are indexed from @ioc using radix tree and hint pointer,
> -        * both of which are protected with RCU.  All removals are done
> -        * holding both q and ioc locks, and we're holding q lock - if we
> -        * find a icq which points to us, it's guaranteed to be valid.
> +        * both of which are protected with RCU, io issue path ensures that
> +        * both request_queue and current task are valid, the founded icq
							    ^^^^ thus the
found icq

> +        * is guaranteed to be valid until the io is done.
>          */
>         rcu_read_lock();
>         icq = rcu_dereference(ioc->icq_hint);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
