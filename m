Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B114F9E2
	for <linux-block@vger.kernel.org>; Sat,  7 Sep 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725702799; cv=none; b=Qb92dv5HpJCSo/L6obenf6af3p9Bps+j0UrMq3oAuX0Fv5bYfUVsL/Eiktoa760P+P2XTu5zu1pH/OKnCVfL3lE1PY9JHD7GJC4n+77vRkwzhvoGrWEm+8UR/I/4QEzZgfMqgEMYSOSyybVtdGMSdLY50PaWqNYo03Hn7MdEDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725702799; c=relaxed/simple;
	bh=DSnQGnhbIEJAUBPg6CpXh8wFr5AKQ47ZCxdQo6AJQYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/7vF9/Her+SRdrW2iyOfk45M30Zj2wAs/9rK3H7lIgZ6xTgE9imlwXvbZ5lKwHHHw9G8D4SdgLmNDWWvxRnur0qUDGwvoEFVgkKFoqXhnAjWlJs1zPmgSdMW4tt+U4tbSx3TWHMXQheIWCFqNRxh/EyLdEK/dHZX5wPCzhZfps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqXUgC5Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqXUgC5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725702796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+fUO38sCTgjcyc5l5kotiCotpCigUxUA2rQR6zbLyac=;
	b=KqXUgC5Yqk5TE5hgeXjb8VqeEGywNYjy+HFAxQyZPXwpmmx7TLQPH2HpTjEmrj7OroioWu
	KT7cmOpzTNRTduZ2KMHFrY0j0lluRyOEtAv9S7mgNQ6LbL8cKGh1iUmRTtYChLCE3agfj0
	Zsc6owE/XXf5DxKI0muzLBMxBJlcDv4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-I1vrjZHMPciNigsGipAQig-1; Sat,
 07 Sep 2024 05:53:13 -0400
X-MC-Unique: I1vrjZHMPciNigsGipAQig-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ECCE19560AE;
	Sat,  7 Sep 2024 09:53:12 +0000 (UTC)
Received: from localhost (unknown [10.42.28.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 01CDD1956054;
	Sat,  7 Sep 2024 09:53:10 +0000 (UTC)
Date: Sat, 7 Sep 2024 10:53:09 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this
 disk
Message-ID: <20240907095309.GX1450@redhat.com>
References: <20240907014331.176152-1-ming.lei@redhat.com>
 <20240907073522.GW1450@redhat.com>
 <ZtwHwTh6FYn+WnGD@fedora>
 <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Sat, Sep 07, 2024 at 06:04:59PM +0900, Damien Le Moal wrote:
> On 9/7/24 16:58, Ming Lei wrote:
> > On Sat, Sep 07, 2024 at 08:35:22AM +0100, Richard W.M. Jones wrote:
> >> On Sat, Sep 07, 2024 at 09:43:31AM +0800, Ming Lei wrote:
> >>> When switching io scheduler via sysfs, 'request_module' may be called
> >>> if the specified scheduler doesn't exist.
> >>>
> >>> This was has deadlock risk because the module may be stored on FS behind
> >>> our disk since request queue is frozen before switching its elevator.
> >>>
> >>> Fix it by returning -EDEADLK in case that the disk is claimed, which
> >>> can be thought as one signal that the disk is mounted.
> >>>
> >>> Some distributions(Fedora) simulates the original kernel command line of
> >>> 'elevator=foo' via 'echo foo > /sys/block/$DISK/queue/scheduler', and boot
> >>> hang is triggered.
> >>>
> >>> Cc: Richard Jones <rjones@redhat.com>
> >>> Cc: Jeff Moyer <jmoyer@redhat.com>
> >>> Cc: Jiri Jaburek <jjaburek@redhat.com>
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>
> >> I'd suggest also:
> >>
> >> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=219166
> >> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> >> Reported-by: Jiri Jaburek <jjaburek@redhat.com>
> >> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> >>
> >> So I have tested this patch and it does fix the issue, at the possible
> >> cost that now setting the scheduler can fail:
> >>
> >>   + for f in /sys/block/{h,s,ub,v}d*/queue/scheduler
> >>   + echo noop
> >>   /init: line 109: echo: write error: Resource deadlock avoided
> >>
> >> (I know I'm setting it to an impossible value here, but this could
> >> also happen when setting it to a valid one.)
> > 
> > Actually in most of dist, io-schedulers are built-in, so request_module
> > is just a nop, but meta IO must be started.
> > 
> >>
> >> Since almost no one checks the result of 'echo foo > /sys/...'  that
> >> would probably mean that sometimes a desired setting is silently not
> >> set.
> > 
> > As I mentioned, io-schedulers are built-in for most of dist, so
> > request_module isn't called in case of one valid io-sched.
> > 
> >>
> >> Also I bisected this bug yesterday and found it was caused by (or,
> >> more likely, exposed by):
> >>
> >>   commit af2814149883e2c1851866ea2afcd8eadc040f79
> >>   Author: Christoph Hellwig <hch@lst.de>
> >>   Date:   Mon Jun 17 08:04:38 2024 +0200
> >>
> >>     block: freeze the queue in queue_attr_store
> >>     
> >>     queue_attr_store updates attributes used to control generating I/O, and
> >>     can cause malformed bios if changed with I/O in flight.  Freeze the queue
> >>     in common code instead of adding it to almost every attribute.
> >>
> >> Reverting this commit on top of git head also fixes the problem.
> >>
> >> Why did this commit expose the problem?
> > 
> > That is really the 1st bad commit which moves queue freezing before
> > calling request_module(), originally we won't freeze queue until
> > we have to do it.
> > 
> > Another candidate fix is to revert it, or at least not do it
> > for storing elevator attribute.
> 
> I do not think that reverting is acceptable. Rather, a proper fix would simply
> be to do the request_module() before freezing the queue.
> Something like below should work (totally untested and that may be overkill).
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 60116d13cb80..aef87f6b4a8a 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -23,6 +23,7 @@
>  struct queue_sysfs_entry {
>         struct attribute attr;
>         ssize_t (*show)(struct gendisk *disk, char *page);
> +       int (*pre_store)(struct gendisk *disk, const char *page, size_t count);
>         ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
>  };
> 
> @@ -413,6 +414,14 @@ static struct queue_sysfs_entry _prefix##_entry = {        \
>         .store  = _prefix##_store,                      \
>  };
> 
> +#define QUEUE_RPW_ENTRY(_prefix, _name)                        \
> +static struct queue_sysfs_entry _prefix##_entry = {    \
> +       .attr   = { .name = _name, .mode = 0644 },      \
> +       .show   = _prefix##_show,                       \
> +       .pre_store = _prefix##_pre_store,               \
> +       .store  = _prefix##_store,                      \
> +};
> +
>  QUEUE_RW_ENTRY(queue_requests, "nr_requests");
>  QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
>  QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
> @@ -420,7 +429,7 @@ QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
>  QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
>  QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
>  QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
> -QUEUE_RW_ENTRY(elv_iosched, "scheduler");
> +QUEUE_RPW_ENTRY(elv_iosched, "scheduler");
> 
>  QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
>  QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
> @@ -670,6 +679,12 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>         if (!entry->store)
>                 return -EIO;
> 
> +       if (entry->pre_store) {
> +               res = entry->pre_store(disk, page, length);
> +               if (res)
> +                       return res;
> +       }
> +
>         blk_mq_freeze_queue(q);
>         mutex_lock(&q->sysfs_lock);
>         res = entry->store(disk, page, length);
> diff --git a/block/elevator.c b/block/elevator.c
> index f13d552a32c8..c338282d5148 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -698,17 +698,26 @@ static int elevator_change(struct request_queue *q, const
> char *elevator_name)
>                 return 0;
> 
>         e = elevator_find_get(q, elevator_name);
> -       if (!e) {
> -               request_module("%s-iosched", elevator_name);
> -               e = elevator_find_get(q, elevator_name);
> -               if (!e)
> -                       return -EINVAL;
> -       }
> +       if (!e)
> +               return -EINVAL;
>         ret = elevator_switch(q, e);
>         elevator_put(e);
>         return ret;
>  }
> 
> +int elv_iosched_pre_store(struct gendisk *disk, const char *buf,
> +                          size_t count)
> +{
> +       char elevator_name[ELV_NAME_MAX];
> +
> +       if (!elv_support_iosched(disk->queue))
> +               return -ENOTSUPP;
> +
> +       strscpy(elevator_name, buf, sizeof(elevator_name));
> +
> +       return request_module("%s-iosched", elevator_name);
> +}
> +
>  ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>                           size_t count)
>  {
> diff --git a/block/elevator.h b/block/elevator.h
> index 3fe18e1a8692..059172c0f93c 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -148,6 +148,7 @@ extern void elv_unregister(struct elevator_type *);
>   * io scheduler sysfs switching
>   */
>  ssize_t elv_iosched_show(struct gendisk *disk, char *page);
> +int elv_iosched_pre_store(struct gendisk *disk, const char *page, size_t count);
>  ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
> 
>  extern bool elv_bio_merge_ok(struct request *, struct bio *);

I tested this on top of current git head and it fixes the problem for me.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

