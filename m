Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7F42E2EE4
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778441; cv=none; b=EkIpf9G1OSNEObJh0LvjpL/uoauoRiDpYHidZAd4y8zX18A2wejmUD+Uj6lpHaJbeswUTO6I10tNtW9SvGRLy+NvIwy0CJReEZgV7elCE7UPKoKERcOUE37x54gUT0zy83upN+1mbKZCTS+G6NdJIp+0ApJp4SZzORYddbP3bSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778441; c=relaxed/simple;
	bh=6Il7XjuA0WfB7nAskwX7jAtJVUW4cOjAee2so+audSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb3Uw3rx9Qjsm9xumLxomY1abDkjDg+VWvo/AdPs7CRNuQg9xITIf8EpCY56DB7H6VnXyMy+LVXl5vSxKPldXkCDX6D1d6GWe1vqU7CqPAxDp7u+axxTSTbJ7rytRl60Og+ZUXq7q+c110A3x2qtWpE+3iioqPMSYNGZLm20Ftc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hy0yeafl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hy0yeafl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761778438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8iHCl4IHW6aAjpz/B3RZEb3I+FpCmt0riBVLveFMgpE=;
	b=Hy0yeaflccJcJmxVta8XJC0L3EO841LvZbWERe3qPFJ9bdPwcuDuqMWWaD0gRSxWOB5bRY
	N/xoSYAI34wBHCp8mtPaKF8mLVf7CAHNoswFlW79MZvUe8yZIHsjQWvHmBkQ4D6RMVpxJL
	1/9TN4WC3dIWbcC/tTK9T11o9WPcoCI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-fMFeM2LgOpm5hZPCbDtNJg-1; Wed,
 29 Oct 2025 18:53:56 -0400
X-MC-Unique: fMFeM2LgOpm5hZPCbDtNJg-1
X-Mimecast-MFC-AGG-ID: fMFeM2LgOpm5hZPCbDtNJg_1761778434
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90D171809A04;
	Wed, 29 Oct 2025 22:53:53 +0000 (UTC)
Received: from fedora (unknown [10.72.120.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E045530001BF;
	Wed, 29 Oct 2025 22:53:49 +0000 (UTC)
Date: Thu, 30 Oct 2025 06:53:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V3 2/5] ublk: implement NUMA-aware memory allocation
Message-ID: <aQKa-Jjg-Gr2DeXe@fedora>
References: <20251029031035.258766-1-ming.lei@redhat.com>
 <20251029031035.258766-3-ming.lei@redhat.com>
 <CADUfDZpBhBO8cppa2phmhkaCSJW1Yzk1aLzoF4zH3Cgu+D9Pcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpBhBO8cppa2phmhkaCSJW1Yzk1aLzoF4zH3Cgu+D9Pcg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 29, 2025 at 09:00:12AM -0700, Caleb Sander Mateos wrote:
> On Tue, Oct 28, 2025 at 8:11 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Implement NUMA-friendly memory allocation for ublk driver to improve
> > performance on multi-socket systems.
> >
> > This commit includes the following changes:
> >
> > 1. Convert struct ublk_device to use a flexible array member for the
> >    queues field instead of a separate pointer array allocation. This
> >    eliminates one level of indirection and simplifies memory management.
> >    The queues array is now allocated as part of struct ublk_device using
> >    struct_size().
> 
> Technically it ends up being the same number of indirections as
> before, since changing queues from a single allocation to an array of
> separate allocations adds another indirection.

I think it is fine, because the pre-condition is NUMA aware allocation for
ublk_queue.

> 
> >
> > 2. Rename __queues to queues, dropping the __ prefix since the field is
> >    now accessed directly throughout the codebase rather than only through
> >    the ublk_get_queue() helper.
> >
> > 3. Remove the queue_size field from struct ublk_device as it is no longer
> >    needed.
> >
> > 4. Move queue allocation and deallocation into ublk_init_queue() and
> >    ublk_deinit_queue() respectively, improving encapsulation. This
> >    simplifies ublk_init_queues() and ublk_deinit_queues() to just
> >    iterate and call the per-queue functions.
> >
> > 5. Add ublk_get_queue_numa_node() helper function to determine the
> >    appropriate NUMA node for a queue by finding the first CPU mapped
> >    to that queue via tag_set.map[HCTX_TYPE_DEFAULT].mq_map[] and
> >    converting it to a NUMA node using cpu_to_node(). This function is
> >    called internally by ublk_init_queue() to determine the allocation
> >    node.
> >
> > 6. Allocate each queue structure on its local NUMA node using
> >    kvzalloc_node() in ublk_init_queue().
> >
> > 7. Allocate the I/O command buffer on the same NUMA node using
> >    alloc_pages_node().
> >
> > This reduces memory access latency on multi-socket NUMA systems by
> > ensuring each queue's data structures are local to the CPUs that
> > access them.
> >
> > Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 84 +++++++++++++++++++++++++---------------
> >  1 file changed, 53 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 2569566bf5e6..ed77b4527b33 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -209,9 +209,6 @@ struct ublk_queue {
> >  struct ublk_device {
> >         struct gendisk          *ub_disk;
> >
> > -       char    *__queues;
> > -
> > -       unsigned int    queue_size;
> >         struct ublksrv_ctrl_dev_info    dev_info;
> >
> >         struct blk_mq_tag_set   tag_set;
> > @@ -239,6 +236,8 @@ struct ublk_device {
> >         bool canceling;
> >         pid_t   ublksrv_tgid;
> >         struct delayed_work     exit_work;
> > +
> > +       struct ublk_queue       *queues[] __counted_by(dev_info.nr_hw_queues);
> >  };
> >
> >  /* header of ublk_params */
> > @@ -781,7 +780,7 @@ static noinline void ublk_put_device(struct ublk_device *ub)
> >  static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
> >                 int qid)
> >  {
> > -       return (struct ublk_queue *)&(dev->__queues[qid * dev->queue_size]);
> > +       return dev->queues[qid];
> >  }
> >
> >  static inline bool ublk_rq_has_data(const struct request *rq)
> > @@ -2662,9 +2661,13 @@ static const struct file_operations ublk_ch_fops = {
> >
> >  static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
> >  {
> > -       int size = ublk_queue_cmd_buf_size(ub);
> > -       struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
> > -       int i;
> > +       struct ublk_queue *ubq = ub->queues[q_id];
> > +       int size, i;
> > +
> > +       if (!ubq)
> > +               return;
> > +
> > +       size = ublk_queue_cmd_buf_size(ub);
> >
> >         for (i = 0; i < ubq->q_depth; i++) {
> >                 struct ublk_io *io = &ubq->ios[i];
> > @@ -2676,57 +2679,76 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
> >
> >         if (ubq->io_cmd_buf)
> >                 free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
> > +
> > +       kvfree(ubq);
> > +       ub->queues[q_id] = NULL;
> > +}
> > +
> > +static int ublk_get_queue_numa_node(struct ublk_device *ub, int q_id)
> > +{
> > +       unsigned int cpu;
> > +
> > +       /* Find first CPU mapped to this queue */
> > +       for_each_possible_cpu(cpu) {
> > +               if (ub->tag_set.map[HCTX_TYPE_DEFAULT].mq_map[cpu] == q_id)
> > +                       return cpu_to_node(cpu);
> > +       }
> 
> I think you could avoid this quadratic lookup by using blk_mq_hw_ctx's
> numa_node field. The initialization code would probably have to move
> to ublk_init_hctx() in order to have access to the blk_mq_hw_ctx. But
> may not be worth the effort just to save some time at ublk creation
> time. What you have seems fine.

It isn't doable and not necessary.

disk/hw queues are created & initialized when handling UBLK_CMD_START_DEV, but the
backed ublk_queue need to be allocated when handling UBLK_CMD_ADD_DEV, which happens
before dealing with UBLK_CMD_START_DEV.


Thanks,
Ming

