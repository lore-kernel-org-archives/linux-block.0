Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B95FF00
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HnFA3Dym";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ql7WC3B3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HnFA3Dym";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ql7WC3B3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F4991FC31;
	Fri, 12 Jan 2024 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705054805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9PBBBSrh1R8EnWSD99EfZZw8ml3AtYDZAyovkcANU8=;
	b=HnFA3Dymnn6rOOcXdq4HEczXnUiUBCcyDHxt729vGKVrvjup+xQ8CGvtc0fDY0klOLNYm/
	mTnmEGJaAh5nz3/GWvWLeJ8DU3rp3wq/X+pMdR0XOeC9a2Hv/sfrWYo7v8vqZycof8++Vh
	gaYBBkinX6UZ4NIsopX9mg4oOGM3S0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705054805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9PBBBSrh1R8EnWSD99EfZZw8ml3AtYDZAyovkcANU8=;
	b=ql7WC3B3xCAI0mxDq138MHfPFubg0P/qOfO+fjMPfpFCrkKpjoQYF5E9+PAsXWIc9VYTC3
	kFjUZPJDvHe3NkAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705054805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9PBBBSrh1R8EnWSD99EfZZw8ml3AtYDZAyovkcANU8=;
	b=HnFA3Dymnn6rOOcXdq4HEczXnUiUBCcyDHxt729vGKVrvjup+xQ8CGvtc0fDY0klOLNYm/
	mTnmEGJaAh5nz3/GWvWLeJ8DU3rp3wq/X+pMdR0XOeC9a2Hv/sfrWYo7v8vqZycof8++Vh
	gaYBBkinX6UZ4NIsopX9mg4oOGM3S0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705054805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9PBBBSrh1R8EnWSD99EfZZw8ml3AtYDZAyovkcANU8=;
	b=ql7WC3B3xCAI0mxDq138MHfPFubg0P/qOfO+fjMPfpFCrkKpjoQYF5E9+PAsXWIc9VYTC3
	kFjUZPJDvHe3NkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16A6313782;
	Fri, 12 Jan 2024 10:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3GmDBVUSoWVfQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Jan 2024 10:20:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B8761A0802; Fri, 12 Jan 2024 11:20:04 +0100 (CET)
Date: Fri, 12 Jan 2024 11:20:04 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>, Jan Kara <jack@suse.cz>,
	Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH] blk-mq: fix IO hang from sbitmap wakeup race
Message-ID: <20240112102004.uceqjn3a2hbmpck4@quack3>
References: <20240111155448.4097173-1-ming.lei@redhat.com>
 <89d7ce62-9539-ba26-09fa-81875a69ce3f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d7ce62-9539-ba26-09fa-81875a69ce3f@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Fri 12-01-24 17:27:48, Kemeng Shi wrote:
> 
> 
> on 1/11/2024 11:54 PM, Ming Lei wrote:
> > In blk_mq_mark_tag_wait(), __add_wait_queue() may be re-ordered
> > with the following blk_mq_get_driver_tag() in case of getting driver
> > tag failure.
> > 
> > Then in __sbitmap_queue_wake_up(), waitqueue_active() may not observe
> > the added waiter in blk_mq_mark_tag_wait() and wake up nothing, meantime
> > blk_mq_mark_tag_wait() can't get driver tag successfully.
> > 
> > This issue can be reproduced by running the following test in loop, and
> > fio hang can be observed in < 30min when running it on my test VM
> > in laptop.
> > 
> > 	modprobe -r scsi_debug
> > 	modprobe scsi_debug delay=0 dev_size_mb=4096 max_queue=1 host_max_queue=1 submit_queues=4
> > 	dev=`ls -d /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/* | head -1 | xargs basename`
> > 	fio --filename=/dev/"$dev" --direct=1 --rw=randrw --bs=4k --iodepth=1 \
> >        		--runtime=100 --numjobs=40 --time_based --name=test \
> >         	--ioengine=libaio
> > 
> > Fix the issue by adding one explicit barrier in blk_mq_mark_tag_wait(), which
> > is just fine in case of running out of tag.
> > 
> > Apply the same pattern in blk_mq_get_tag() which should have same risk.
> > 
> > Reported-by: Changhui Zhong <czhong@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > BTW, Changhui is planning to upstream the test case to blktests.
> > 
> >  block/blk-mq-tag.c | 19 +++++++++++++++++++
> >  block/blk-mq.c     | 16 ++++++++++++++++
> >  2 files changed, 35 insertions(+)
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index cc57e2dd9a0b..29f77cae8eb2 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -179,6 +179,25 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
> >  
> >  		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
> >  
> > +		/*
> > +		 * Add one explicit barrier since __blk_mq_get_tag() may not
> > +		 * imply barrier in case of failure.
> > +		 *
> > +		 * Order adding us to wait queue and the following allocating
> > +		 * tag in  __blk_mq_get_tag().
> > +		 *
> > +		 * The pair is the one implied in sbitmap_queue_wake_up()
> > +		 * which orders clearing sbitmap tag bits and
> > +		 * waitqueue_active() in __sbitmap_queue_wake_up(), since
> > +		 * waitqueue_active() is lockless
> > +		 *
> > +		 * Otherwise, re-order of adding wait queue and getting tag
> > +		 * may cause __sbitmap_queue_wake_up() to wake up nothing
> > +		 * because the waitqueue_active() may not observe us in wait
> > +		 * queue.
> > +		 */
> > +		smp_mb();
> > +
> Hi Ming, thanks for the fix. I'm not sure if we should explicitly imply
> a memory barrier here as prepare_to_wait variants normally imply a general
> memory barrier (see section "SLEEP AND WAKE-UP FUNCTIONS " in [1]).
> Wish this helps!

Indeed, good spotting with the ordering bug Ming! I agree with Kemeng
though that set_current_state() called from sbitmap_prepare_to_wait() is
guaranteed to contain a memory barrier and thus reads from
__blk_mq_get_tag() are guaranteed to be ordered properly wrt addition into
the waitqueue.

So only blk_mq_mark_tag_wait() is vulnerable to the problem you have
spotted AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
