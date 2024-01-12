Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107C6A332
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjcTxays"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705062116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6Tww1zFMixcbjFa6rUn6YQ5EOmwalSBsUCRomP3oMs=;
	b=fjcTxaysvswMKONM3lmi/UFqVQWQNroY9D1vg8l4gSfws27SHUo1jjv38noYM6ErThYN6N
	2nVaCqSSddDV3YGqphjiH9nhnNbkuTY+EFOxxWzAdFo9oekVTXTabO/xgFCxsUgdu3thk5
	x8RB9wZQb5GVMpYkvOL71EPu8RxGZr4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-JYdThnBoO2iPNxxIqHjVmQ-1; Fri,
 12 Jan 2024 07:21:50 -0500
X-MC-Unique: JYdThnBoO2iPNxxIqHjVmQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 703D71C07546;
	Fri, 12 Jan 2024 12:21:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D2235492BC6;
	Fri, 12 Jan 2024 12:21:46 +0000 (UTC)
Date: Fri, 12 Jan 2024 20:21:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH] blk-mq: fix IO hang from sbitmap wakeup race
Message-ID: <ZaEu1kFJX2qrygMm@fedora>
References: <20240111155448.4097173-1-ming.lei@redhat.com>
 <89d7ce62-9539-ba26-09fa-81875a69ce3f@huaweicloud.com>
 <20240112102004.uceqjn3a2hbmpck4@quack3>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112102004.uceqjn3a2hbmpck4@quack3>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Fri, Jan 12, 2024 at 11:20:04AM +0100, Jan Kara wrote:
> On Fri 12-01-24 17:27:48, Kemeng Shi wrote:
> > 
> > 
> > on 1/11/2024 11:54 PM, Ming Lei wrote:
> > > In blk_mq_mark_tag_wait(), __add_wait_queue() may be re-ordered
> > > with the following blk_mq_get_driver_tag() in case of getting driver
> > > tag failure.
> > > 
> > > Then in __sbitmap_queue_wake_up(), waitqueue_active() may not observe
> > > the added waiter in blk_mq_mark_tag_wait() and wake up nothing, meantime
> > > blk_mq_mark_tag_wait() can't get driver tag successfully.
> > > 
> > > This issue can be reproduced by running the following test in loop, and
> > > fio hang can be observed in < 30min when running it on my test VM
> > > in laptop.
> > > 
> > > 	modprobe -r scsi_debug
> > > 	modprobe scsi_debug delay=0 dev_size_mb=4096 max_queue=1 host_max_queue=1 submit_queues=4
> > > 	dev=`ls -d /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/* | head -1 | xargs basename`
> > > 	fio --filename=/dev/"$dev" --direct=1 --rw=randrw --bs=4k --iodepth=1 \
> > >        		--runtime=100 --numjobs=40 --time_based --name=test \
> > >         	--ioengine=libaio
> > > 
> > > Fix the issue by adding one explicit barrier in blk_mq_mark_tag_wait(), which
> > > is just fine in case of running out of tag.
> > > 
> > > Apply the same pattern in blk_mq_get_tag() which should have same risk.
> > > 
> > > Reported-by: Changhui Zhong <czhong@redhat.com>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > > BTW, Changhui is planning to upstream the test case to blktests.
> > > 
> > >  block/blk-mq-tag.c | 19 +++++++++++++++++++
> > >  block/blk-mq.c     | 16 ++++++++++++++++
> > >  2 files changed, 35 insertions(+)
> > > 
> > > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > > index cc57e2dd9a0b..29f77cae8eb2 100644
> > > --- a/block/blk-mq-tag.c
> > > +++ b/block/blk-mq-tag.c
> > > @@ -179,6 +179,25 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
> > >  
> > >  		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
> > >  
> > > +		/*
> > > +		 * Add one explicit barrier since __blk_mq_get_tag() may not
> > > +		 * imply barrier in case of failure.
> > > +		 *
> > > +		 * Order adding us to wait queue and the following allocating
> > > +		 * tag in  __blk_mq_get_tag().
> > > +		 *
> > > +		 * The pair is the one implied in sbitmap_queue_wake_up()
> > > +		 * which orders clearing sbitmap tag bits and
> > > +		 * waitqueue_active() in __sbitmap_queue_wake_up(), since
> > > +		 * waitqueue_active() is lockless
> > > +		 *
> > > +		 * Otherwise, re-order of adding wait queue and getting tag
> > > +		 * may cause __sbitmap_queue_wake_up() to wake up nothing
> > > +		 * because the waitqueue_active() may not observe us in wait
> > > +		 * queue.
> > > +		 */
> > > +		smp_mb();
> > > +
> > Hi Ming, thanks for the fix. I'm not sure if we should explicitly imply
> > a memory barrier here as prepare_to_wait variants normally imply a general
> > memory barrier (see section "SLEEP AND WAKE-UP FUNCTIONS " in [1]).
> > Wish this helps!
> 
> Indeed, good spotting with the ordering bug Ming! I agree with Kemeng
> though that set_current_state() called from sbitmap_prepare_to_wait() is
> guaranteed to contain a memory barrier and thus reads from
> __blk_mq_get_tag() are guaranteed to be ordered properly wrt addition into
> the waitqueue.
> 
> So only blk_mq_mark_tag_wait() is vulnerable to the problem you have
> spotted AFAICT.

Indeed, I will remove the one in blk_mq_get_tag() in V2.


thanks,
Ming

