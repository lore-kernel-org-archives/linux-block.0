Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBE25BEF1
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757476604; cv=none; b=GPS18BO7Rc5c3juCPHccD7ZWgv5mbkZUF6ozPnJ949SgDAg6Nj5h7tlzX3B//iJSlswov2gKgidjs+PRAM6Y5s4wZcOdcqc+7Pfj/HVBhbVLs20FMwkVEJC6lyHm1Z9bleuNHFA1QfCcIKC7UJT64yZ6GVZRzb3sn++ZCIdFVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757476604; c=relaxed/simple;
	bh=90ljOXxJevsFxqUAYx66ah8D4W7doALX+89IkpoZpjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaOD+zfeOKpczmUQCzfQ+RS/Ia2tZ4DZFYJDY6bBMFtMF2jUO6ZrJ3OzXLQ2RwMuqi9t85rAOiEry4LfkFY2zIEEUwbctO72idr02EQHCczKcMRG4p/lDeE4JKMbx45lOh5fooTP6LH7t/CwU6wC3otCofgHwaWOQA28+TDN9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VB7gAiTi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB7gAiTi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757476600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ecIGj/W4dFvy3mdhHTe3an1m5ejKA2bK5QuqFH+G0wU=;
	b=VB7gAiTi91HJvt6CyztTryfgigYmdTByqS/VmShLZ9xapuT8qYDwNm3Fp4dLiqK0YxWfog
	RtByZhlBsnPCO/e2nOmVpzBVww6DpZPmaENN9SI5UkCdQ8tvqe4rXaPtJGg6QdvPOuWZ0A
	x3dMoXJSoJHv0u7eJ6Gg3nWao1rb9Yk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-SmgGZ1EZPPuujunGBBApnA-1; Tue,
 09 Sep 2025 23:56:38 -0400
X-MC-Unique: SmgGZ1EZPPuujunGBBApnA-1
X-Mimecast-MFC-AGG-ID: SmgGZ1EZPPuujunGBBApnA_1757476597
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90B3C195608D;
	Wed, 10 Sep 2025 03:56:37 +0000 (UTC)
Received: from fedora (unknown [10.72.120.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDFE718003FC;
	Wed, 10 Sep 2025 03:56:33 +0000 (UTC)
Date: Wed, 10 Sep 2025 11:56:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 08/23] ublk: handle UBLK_U_IO_PREP_IO_CMDS
Message-ID: <aMD27G9-rwJpU49_@fedora>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
 <20250901100242.3231000-9-ming.lei@redhat.com>
 <CADUfDZr6QLHHaM=LJfRKXKGyE+2Emzhvkab53Yen1Cyinp21hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZr6QLHHaM=LJfRKXKGyE+2Emzhvkab53Yen1Cyinp21hg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Sep 06, 2025 at 12:48:41PM -0700, Caleb Sander Mateos wrote:
> On Mon, Sep 1, 2025 at 3:03 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > This commit implements the handling of the UBLK_U_IO_PREP_IO_CMDS command,
> > which allows userspace to prepare a batch of I/O requests.
> >
> > The core of this change is the `ublk_walk_cmd_buf` function, which iterates
> > over the elements in the uring_cmd fixed buffer. For each element, it parses
> > the I/O details, finds the corresponding `ublk_io` structure, and prepares it
> > for future dispatch.
> >
> > Add per-io lock for protecting concurrent delivery and committing.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 191 +++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/ublk_cmd.h |   5 +
> >  2 files changed, 195 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 4da0dbbd7e16..a4bae3d1562a 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -116,6 +116,10 @@ struct ublk_uring_cmd_pdu {
> >  struct ublk_batch_io_data {
> >         struct ublk_queue *ubq;
> >         struct io_uring_cmd *cmd;
> > +       unsigned int issue_flags;
> > +
> > +       /* set when walking the element buffer */
> > +       const struct ublk_elem_header *elem;
> >  };
> >
> >  /*
> > @@ -200,6 +204,7 @@ struct ublk_io {
> >         unsigned task_registered_buffers;
> >
> >         void *buf_ctx_handle;
> > +       spinlock_t lock;
> 
> From our experience writing a high-throughput ublk server, the
> spinlocks and mutexes in the kernel are some of the largest CPU
> hotspots. We have spent a lot of effort working to avoid locking where
> possible or shard data structures to reduce contention on the locks.
> Even uncontended locks are still very expensive to acquire and release
> on machines with many CPUs due to the cache coherency overhead. ublk's
> per-io daemon architecture is great for performance by removing the

io-uring highly depends on batch submission and completion, but per-io daemon
may break the batch easily, because it doesn't guarantee that one batch IOs
can be forwarded in single io task/io_uring when static tag mapping policy is
taken, for example:

```
[root@ktest-40 ublk]# ./kublk add -t null  --nthreads 8 -q 4 --per_io_tasks
dev id 0: nr_hw_queues 4 queue_depth 128 block size 512 dev_capacity 524288000
	max rq size 1048576 daemon pid 89975 flags 0x6042 state LIVE
	queue 0: affinity(0 )
	queue 1: affinity(4 )
	queue 2: affinity(8 )
	queue 3: affinity(12 )
[root@ktest-40 ublk]#
[root@ktest-40 ublk]# ./kublk add -t null  -q 4
dev id 1: nr_hw_queues 4 queue_depth 128 block size 512 dev_capacity 524288000
	max rq size 1048576 daemon pid 90002 flags 0x6042 state LIVE
	queue 0: affinity(0 )
	queue 1: affinity(4 )
	queue 2: affinity(8 )
	queue 3: affinity(12 )
[root@ktest-40 ublk]#
[root@ktest-40 ublk]# ~/git/fio/t/io_uring -p0 /dev/ublkb0
submitter=0, tid=90024, file=/dev/ublkb0, nfiles=1, node=-1
polled=0, fixedbufs=1, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=188.54K, BW=736MiB/s, IOS/call=32/31
IOPS=187.90K, BW=734MiB/s, IOS/call=32/32
IOPS=195.39K, BW=763MiB/s, IOS/call=32/32
^CExiting on signal
Maximum IOPS=195.39K

[root@ktest-40 ublk]# ~/git/fio/t/io_uring -p0 /dev/ublkb1
submitter=0, tid=90026, file=/dev/ublkb1, nfiles=1, node=-1
polled=0, fixedbufs=1, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=608.26K, BW=2.38GiB/s, IOS/call=32/31
IOPS=586.59K, BW=2.29GiB/s, IOS/call=32/31
IOPS=599.62K, BW=2.34GiB/s, IOS/call=32/32
^CExiting on signal
Maximum IOPS=608.26K

```


> need for locks in the I/O path. I can't really see us adopting this
> ublk batching feature; adding a spin_lock() + spin_unlock() to every
> ublk commit operation is not worth the reduction in io_uring SQEs and
> uring_cmds.

As I mentioned in cover letter, the per-io lock can be avoided for UBLK_F_PER_IO_DAEMON
as one follow-up, since io->task is still there for helping to track task context.

Just want to avoid too much features in enablement stage, that is also
why the spin lock is wrapped in helper.

> 
> >  } ____cacheline_aligned_in_smp;
> >
> >  struct ublk_queue {
> > @@ -276,6 +281,16 @@ static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
> >         return false;
> >  }
> >
> > +static inline void ublk_io_lock(struct ublk_io *io)
> > +{
> > +       spin_lock(&io->lock);
> > +}
> > +
> > +static inline void ublk_io_unlock(struct ublk_io *io)
> > +{
> > +       spin_unlock(&io->lock);
> > +}
> > +
> >  static inline struct ublksrv_io_desc *
> >  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
> >  {
> > @@ -2538,6 +2553,171 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
> >         return ublk_ch_uring_cmd_local(cmd, issue_flags);
> >  }
> >
> > +static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
> > +                                       const struct ublk_elem_header *elem)
> > +{
> > +       const void *buf = (const void *)elem;
> 
> Don't need an explicit cast in order to cast to void *.

OK.

> 
> 
> > +
> > +       if (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR)
> > +               return *(__u64 *)(buf + sizeof(*elem));
> > +       return -1;
> 
> Why -1 and not 0? ublk_check_fetch_buf() is expecting a 0 buf_addr to
> indicate the lack

Good catch, it needs to return 0.

> 
> > +}
> > +
> > +static struct ublk_auto_buf_reg
> > +ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
> > +                       const struct ublk_elem_header *elem)
> > +{
> > +       struct ublk_auto_buf_reg reg = {
> > +               .index = elem->buf_index,
> > +               .flags = (uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) ?
> > +                       UBLK_AUTO_BUF_REG_FALLBACK : 0,
> > +       };
> > +
> > +       return reg;
> > +}
> > +
> > +/* 48 can cover any type of buffer element(8, 16 and 24 bytes) */
> 
> "can cover" is a bit vague. Can you be explicit that the buffer size
> needs to be a multiple of any possible buffer element size?

I should have documented that 48 is least common multiple(LCM) of (8, 16 and
24)

> 
> > +#define UBLK_CMD_BATCH_TMP_BUF_SZ  (48 * 10)
> > +struct ublk_batch_io_iter {
> > +       /* copy to this buffer from iterator first */
> > +       unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
> > +       struct iov_iter iter;
> > +       unsigned done, total;
> > +       unsigned char elem_bytes;
> > +};
> > +
> > +static int __ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> > +                               struct ublk_batch_io_data *data,
> > +                               unsigned bytes,
> > +                               int (*cb)(struct ublk_io *io,
> > +                                       const struct ublk_batch_io_data *data))
> > +{
> > +       int i, ret = 0;
> > +
> > +       for (i = 0; i < bytes; i += iter->elem_bytes) {
> > +               const struct ublk_elem_header *elem =
> > +                       (const struct ublk_elem_header *)&iter->buf[i];
> > +               struct ublk_io *io;
> > +
> > +               if (unlikely(elem->tag >= data->ubq->q_depth)) {
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> > +
> > +               io = &data->ubq->ios[elem->tag];
> > +               data->elem = elem;
> > +               ret = cb(io, data);
> 
> Why not just pas elem as a separate argument to the callback?

One reason is that we don't have complete type for 'elem' since its size
is a variable.

> 
> > +               if (unlikely(ret))
> > +                       break;
> > +       }
> > +       iter->done += i;
> > +       return ret;
> > +}
> > +
> > +static int ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> > +                            struct ublk_batch_io_data *data,
> > +                            int (*cb)(struct ublk_io *io,
> > +                                    const struct ublk_batch_io_data *data))
> > +{
> > +       int ret = 0;
> > +
> > +       while (iter->done < iter->total) {
> > +               unsigned int len = min(sizeof(iter->buf), iter->total - iter->done);
> > +
> > +               ret = copy_from_iter(iter->buf, len, &iter->iter);
> > +               if (ret != len) {
> 
> How would this be possible? The iterator comes from an io_uring
> registered buffer with at least the requested length, so the user
> addresses should have been validated when the buffer was registered.
> Should this just be a WARN_ON()?

yes, that is why pr_warn() is used, I remember that WARN_ON() isn't
encouraged in user code path.

> 
> > +                       pr_warn("ublk%d: read batch cmd buffer failed %u/%u\n",
> > +                                       data->ubq->dev->dev_info.dev_id, ret, len);
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> > +
> > +               ret = __ublk_walk_cmd_buf(iter, data, len, cb);
> > +               if (ret)
> > +                       break;
> > +       }
> > +       return ret;
> > +}
> > +
> > +static int ublk_batch_unprep_io(struct ublk_io *io,
> > +                               const struct ublk_batch_io_data *data)
> > +{
> > +       if (ublk_queue_ready(data->ubq))
> > +               data->ubq->dev->nr_queues_ready--;
> > +
> > +       ublk_io_lock(io);
> > +       io->flags = 0;
> > +       ublk_io_unlock(io);
> > +       data->ubq->nr_io_ready--;
> > +       return 0;
> 
> This "unprep" looks very subtle and fairly complicated. Is it really
> necessary? What's wrong with leaving the I/Os that were successfully
> prepped? It also looks racy to clear io->flags after the queue is
> ready, as the io may already be in use by some I/O request.

ublk_batch_unprep_io() is called in partial completion of UBLK_U_IO_PREP_IO_CMDS,
when START_DEV can't succeed, so there can't be any IO.

> 
> > +}
> > +
> > +static void ublk_batch_revert_prep_cmd(struct ublk_batch_io_iter *iter,
> > +                                      struct ublk_batch_io_data *data)
> > +{
> > +       int ret;
> > +
> > +       if (!iter->done)
> > +               return;
> > +
> > +       iov_iter_revert(&iter->iter, iter->done);
> 
> Shouldn't the iterator be reverted by the total number of bytes
> copied, which may be more than iter->done?

->done is exactly the total bytes handled. 

> 
> > +       iter->total = iter->done;
> > +       iter->done = 0;
> > +
> > +       ret = ublk_walk_cmd_buf(iter, data, ublk_batch_unprep_io);
> > +       WARN_ON_ONCE(ret);
> > +}
> > +
> > +static int ublk_batch_prep_io(struct ublk_io *io,
> > +                             const struct ublk_batch_io_data *data)
> > +{
> > +       const struct ublk_batch_io *uc = io_uring_sqe_cmd(data->cmd->sqe);
> > +       union ublk_io_buf buf = { 0 };
> > +       int ret;
> > +
> > +       if (ublk_support_auto_buf_reg(data->ubq))
> > +               buf.auto_reg = ublk_batch_auto_buf_reg(uc, data->elem);
> > +       else if (ublk_need_map_io(data->ubq)) {
> > +               buf.addr = ublk_batch_buf_addr(uc, data->elem);
> > +
> > +               ret = ublk_check_fetch_buf(data->ubq, buf.addr);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       ublk_io_lock(io);
> > +       ret = __ublk_fetch(data->cmd, data->ubq, io);
> > +       if (!ret)
> > +               io->buf = buf;
> > +       ublk_io_unlock(io);
> > +
> > +       return ret;
> > +}
> > +
> > +static int ublk_handle_batch_prep_cmd(struct ublk_batch_io_data *data)
> > +{
> > +       struct io_uring_cmd *cmd = data->cmd;
> > +       const struct ublk_batch_io *uc = io_uring_sqe_cmd(cmd->sqe);
> > +       struct ublk_batch_io_iter iter = {
> > +               .total = uc->nr_elem * uc->elem_bytes,
> > +               .elem_bytes = uc->elem_bytes,
> > +       };
> > +       int ret;
> > +
> > +       ret = io_uring_cmd_import_fixed(cmd->sqe->addr, cmd->sqe->len,
> 
> Could iter.total be used in place of cmd->sqe->len? That way userspace
> wouldn't have to specify a redundant value in the SQE len field.

This way follows how buffer is used in io_uring/rw.c, but looks it can be saved.
But benefit is cross-verify, cause io-uring sqe user interface is complicated.

> 
> > +                       WRITE, &iter.iter, cmd, data->issue_flags);
> > +       if (ret)
> > +               return ret;
> > +
> > +       mutex_lock(&data->ubq->dev->mutex);
> > +       ret = ublk_walk_cmd_buf(&iter, data, ublk_batch_prep_io);
> > +
> > +       if (ret && iter.done)
> > +               ublk_batch_revert_prep_cmd(&iter, data);
> 
> The iter.done check is duplicated in ublk_batch_revert_prep_cmd().

OK, we can remove the check in ublk_batch_revert_prep_cmd().

> 
> > +       mutex_unlock(&data->ubq->dev->mutex);
> > +       return ret;
> > +}
> > +
> >  static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
> >  {
> >         const unsigned short mask = UBLK_BATCH_F_HAS_BUF_ADDR |
> > @@ -2609,6 +2789,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> >         struct ublk_device *ub = cmd->file->private_data;
> >         struct ublk_batch_io_data data = {
> >                 .cmd = cmd,
> > +               .issue_flags = issue_flags,
> >         };
> >         u32 cmd_op = cmd->cmd_op;
> >         int ret = -EINVAL;
> > @@ -2619,6 +2800,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> >
> >         switch (cmd_op) {
> >         case UBLK_U_IO_PREP_IO_CMDS:
> > +               ret = ublk_check_batch_cmd(&data, uc);
> > +               if (ret)
> > +                       goto out;
> > +               ret = ublk_handle_batch_prep_cmd(&data);
> > +               break;
> >         case UBLK_U_IO_COMMIT_IO_CMDS:
> >                 ret = ublk_check_batch_cmd(&data, uc);
> >                 if (ret)
> > @@ -2780,7 +2966,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
> >         struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
> >         gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
> >         void *ptr;
> > -       int size;
> > +       int size, i;
> >
> >         spin_lock_init(&ubq->cancel_lock);
> >         ubq->flags = ub->dev_info.flags;
> > @@ -2792,6 +2978,9 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
> >         if (!ptr)
> >                 return -ENOMEM;
> >
> > +       for (i = 0; i < ubq->q_depth; i++)
> > +               spin_lock_init(&ubq->ios[i].lock);
> > +
> >         ubq->io_cmd_buf = ptr;
> >         ubq->dev = ub;
> >         return 0;
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> > index 01d3af52cfb4..38c8cc10d694 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -102,6 +102,11 @@
> >         _IOWR('u', 0x23, struct ublksrv_io_cmd)
> >  #define        UBLK_U_IO_UNREGISTER_IO_BUF     \
> >         _IOWR('u', 0x24, struct ublksrv_io_cmd)
> > +
> > +/*
> > + * return 0 if the command is run successfully, otherwise failure code
> > + * is returned
> > + */
> 
> Not sure this is really necessary to comment, that's pretty standard
> for syscalls and uring_cmds.

OK, I think it is for showing the difference with UBLK_U_IO_COMMIT_IO_CMDS,
which has to support partial commit, however UBLK_U_IO_PREP_IO_CMDS
need to be all or nothing.


Thanks,
Ming

