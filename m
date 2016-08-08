Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13486 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752072AbcHHQcl (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 8 Aug 2016 12:32:41 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u78GKFCq092220
	for <linux-block@vger.kernel.org>; Mon, 8 Aug 2016 12:32:40 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 24nc1pyb34-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 08 Aug 2016 12:32:40 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-block@vger.kernel.org> from <bblock@linux.vnet.ibm.com>;
	Mon, 8 Aug 2016 17:32:39 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 367D51B08023
	for <linux-block@vger.kernel.org>; Mon,  8 Aug 2016 17:34:09 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u78GWaEo8782222
	for <linux-block@vger.kernel.org>; Mon, 8 Aug 2016 16:32:36 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u78GWapO029072
	for <linux-block@vger.kernel.org>; Mon, 8 Aug 2016 10:32:36 -0600
Received: from bblock-ThinkPad-W530 (dyn-9-152-212-142.boeblingen.de.ibm.com [9.152.212.142])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u78GWaJO029067
	for <linux-block@vger.kernel.org>; Mon, 8 Aug 2016 10:32:36 -0600
Date: Mon, 8 Aug 2016 18:32:36 +0200
From: Benjamin Block <bblock@linux.vnet.ibm.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	dm-devel@redhat.com, linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [dm-devel] bug: using smp_processor_id() in preemptible code in
 rr_select_path()
References: <20160803153545.GE20370@bblock-ThinkPad-W530>
 <20160805152705.GA17480@redhat.com>
 <497f02e5-4f3d-8590-3096-fb5e2422bff4@kernel.dk>
 <20160805154223.GA2340@redhat.com>
 <107dc81f-675d-8ae4-0ac2-99c248a23c60@kernel.dk>
 <20160805160638.GA17651@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160805160638.GA17651@redhat.com>
Message-Id: <20160808163236.GB31352@bblock-ThinkPad-W530>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12:06 Fri 05 Aug     , Mike Snitzer wrote:
> On Fri, Aug 05 2016 at 11:54am -0400,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > On 08/05/2016 09:42 AM, Mike Snitzer wrote:
> > >On Fri, Aug 05 2016 at 11:33P -0400,
> > >Jens Axboe <axboe@kernel.dk> wrote:
> > >
> > >>On 08/05/2016 09:27 AM, Mike Snitzer wrote:
> > >>>On Wed, Aug 03 2016 at 11:35am -0400,
> > >>>Benjamin Block <bblock@linux.vnet.ibm.com> wrote:
> > >>>
> > >>>>Hej Mike,
> > >>>>
> > >>>>when running a debug-kernel today with several multipath-devices using
> > >>>>the round-robin path selector I noticed that the kernel throws these
> > >>>>warnings here:
> > >>>>
> > >>>>BUG: using smp_processor_id() in preemptible [00000000] code: kdmwork-252:0/881
> > >>>>caller is rr_select_path+0x36/0x108 [dm_round_robin]
> > >>>>CPU: 1 PID: 881 Comm: kdmwork-252:0 Not tainted 4.7.0-debug #4
> > >>>>      00000000617679b8 0000000061767a48 0000000000000002 0000000000000000
> > >>>>      0000000061767ae8 0000000061767a60 0000000061767a60 00000000001145d0
> > >>>>      0000000000000000 0000000000b962ae 0000000000bb291e 000000000000000b
> > >>>>      0000000061767aa8 0000000061767a48 0000000000000000 0000000000000000
> > >>>>      0700000000b962ae 00000000001145d0 0000000061767a48 0000000061767aa8
> > >>>>Call Trace:
> > >>>>([<00000000001144a2>] show_trace+0x8a/0xe0)
> > >>>>([<0000000000114586>] show_stack+0x8e/0xf0)
> > >>>>([<00000000006c7fdc>] dump_stack+0x9c/0xe0)
> > >>>>([<00000000006fbbc0>] check_preemption_disabled+0x108/0x130)
> > >>>>([<000003ff80268646>] rr_select_path+0x36/0x108 [dm_round_robin])
> > >>>>([<000003ff80259a42>] choose_path_in_pg+0x42/0xc8 [dm_multipath])
> > >>>>([<000003ff80259b62>] choose_pgpath+0x9a/0x1a0 [dm_multipath])
> > >>>>([<000003ff8025b51a>] __multipath_map.isra.5+0x72/0x228 [dm_multipath])
> > >>>>([<000003ff8025b75e>] multipath_map+0x3e/0x50 [dm_multipath])
> > >>>>([<000003ff80225eb6>] map_request+0x66/0x458 [dm_mod])
> > >>>>([<000003ff802262ec>] map_tio_request+0x44/0x70 [dm_mod])
> > >>>>([<000000000016835a>] kthread_worker_fn+0xf2/0x1d8)
> > >>>>([<00000000001681da>] kthread+0x112/0x120)
> > >>>>([<000000000098378a>] kernel_thread_starter+0x6/0xc)
> > >>>>([<0000000000983784>] kernel_thread_starter+0x0/0xc)
> > >>>>no locks held by kdmwork-252:0/881.
> > >>>>
[:snip:]
> > 
> > I always forget the details (if this confuses lockdep or not), but you
> > could potentially turn it into:
> > 
> > local_irq_save(flags);
> > x = this_cpu_ptr();
> > [...]
> > 
> > spin_lock(&s->lock);
> > [...]
> > 
> > instead.
> 
> Cool, I've coded up the patch (compile tested only).
> 
> Benjamin, any chance you could test this against your v4.7 kernel and
> report back?
> 
> Thanks,
> Mike
> 
> diff --git a/drivers/md/dm-round-robin.c b/drivers/md/dm-round-robin.c
> index 4ace1da..ed446f8 100644
> --- a/drivers/md/dm-round-robin.c
> +++ b/drivers/md/dm-round-robin.c
> @@ -210,14 +210,17 @@ static struct dm_path *rr_select_path(struct path_selector *ps, size_t nr_bytes)
>  	struct path_info *pi = NULL;
>  	struct dm_path *current_path = NULL;
> 
> +	local_irq_save(flags);
>  	current_path = *this_cpu_ptr(s->current_path);
>  	if (current_path) {
>  		percpu_counter_dec(&s->repeat_count);
> -		if (percpu_counter_read_positive(&s->repeat_count) > 0)
> +		if (percpu_counter_read_positive(&s->repeat_count) > 0) {
> +			local_irq_restore(flags);
>  			return current_path;
> +		}
>  	}
> 
> -	spin_lock_irqsave(&s->lock, flags);
> +	spin_lock(&s->lock);
>  	if (!list_empty(&s->valid_paths)) {
>  		pi = list_entry(s->valid_paths.next, struct path_info, list);
>  		list_move_tail(&pi->list, &s->valid_paths);
> @@ -225,7 +228,8 @@ static struct dm_path *rr_select_path(struct path_selector *ps, size_t nr_bytes)
>  		set_percpu_current_path(s, pi->path);
>  		current_path = pi->path;
>  	}
> -	spin_unlock_irqrestore(&s->lock, flags);
> +	spin_unlock(&s->lock);
> +	local_irq_restore(flags);
> 
>  	return current_path;
>  }
> 

Ok, this works as far as the warnings don't appear anymore. But while
applying the patch and thinking about it, why local_irq_save() and not
preempt_disable()? "Sounds" like this is the function you want, and I
also stumbled across this in Documentation/preempt-locking.txt:

  But keep in mind that 'irqs disabled' is a fundamentally unsafe way of
  disabling preemption - any spin_unlock() decreasing the preemption
  count to 0 might trigger a reschedule. 

The spinlock would do an other nested preempt_disable(), but those even
out.


                                                    Beste Gr��e / Best regards,
                                                      - Benjamin Block
-- 
Linux on z Systems Development         /         IBM Systems & Technology Group
		  IBM Deutschland Research & Development GmbH 
Vorsitz. AufsR.: Martina Koederitz     /        Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: AmtsG Stuttgart, HRB 243294

