Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2210E2367B8
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128140; cv=none; b=EOu8H9WtdH484hADtWqxZ2ZKkLBa4plDBk2oEbcX9fxf/CU/7NVbnYDA1TMxfCCeRSxLoaWDtc0kG0q4zI+XnYhU1Uc+c4jkODyYUNWOsf/HosVlk15b19wVH6hRhCRGniZ733X1Xkg8EPReHSTWoi7Aq2s6qblco0EGjHjRlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128140; c=relaxed/simple;
	bh=BKY2HztaHoZgXSgLSe5nbZxVuvCJIyCNNGgnNWZsHyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0An6Q9E43PgFWyq4sWEfiGRu8svLMNkipF7+sO1iZDWgspVbjdTYFSza0IWvonVeZnIZsP9J/Yg22xKA+LkQRke/tTsT/V4uzVGNB79i0x5wGm6UUZD/1SmN8JfUFZh9hwupAeCglWs32p0LaBmGzDcEJKgMg9K2jM7v1qVyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjoI/4sV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjoI/4sV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761128137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42xj7SxCOi2bUIpSukTLyYbT4eu7t1ZV7feZ7Rc8KgU=;
	b=NjoI/4sVSJIfx5JonhBsR17SkK/MwHTekc4ntgQcrCe9Cy4IDvfsQswX2EUjxhi+8W04fE
	0uGQklHdKRBAZyUMRKRhrnGc8PcyNpky+FtkSUrCjo/sN5XUo3pUNfq2UaT97N3XN8ImbI
	pHQkuLTX+2qXPY8lSxLaBYxEVIA+SI4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-OyQTpqXLN0-0dwaz_ePWjw-1; Wed,
 22 Oct 2025 06:15:35 -0400
X-MC-Unique: OyQTpqXLN0-0dwaz_ePWjw-1
X-Mimecast-MFC-AGG-ID: OyQTpqXLN0-0dwaz_ePWjw_1761128134
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7407E19560B1;
	Wed, 22 Oct 2025 10:15:34 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9665D30001BF;
	Wed, 22 Oct 2025 10:15:30 +0000 (UTC)
Date: Wed, 22 Oct 2025 18:15:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 08/23] ublk: handle UBLK_U_IO_PREP_IO_CMDS
Message-ID: <aPiuvRXKHYC9KL8C@fedora>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
 <20250901100242.3231000-9-ming.lei@redhat.com>
 <CADUfDZr6QLHHaM=LJfRKXKGyE+2Emzhvkab53Yen1Cyinp21hg@mail.gmail.com>
 <aMD27G9-rwJpU49_@fedora>
 <CADUfDZoQwNhQncLYi-AZZGpPSackgKejXYoBZh43sciCAUDGCg@mail.gmail.com>
 <aPDELNXqlckznZJI@fedora>
 <CADUfDZqCo2O0toQ0M=RBDLnYkANJJ3iQkFmpD_QDbbimx6egRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqCo2O0toQ0M=RBDLnYkANJJ3iQkFmpD_QDbbimx6egRg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 22, 2025 at 01:00:53AM -0700, Caleb Sander Mateos wrote:
> On Thu, Oct 16, 2025 at 3:08 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Thu, Sep 18, 2025 at 11:12:00AM -0700, Caleb Sander Mateos wrote:
> > > On Tue, Sep 9, 2025 at 8:56 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Sat, Sep 06, 2025 at 12:48:41PM -0700, Caleb Sander Mateos wrote:
> > > > > On Mon, Sep 1, 2025 at 3:03 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > >
> > > > > > This commit implements the handling of the UBLK_U_IO_PREP_IO_CMDS command,
> > > > > > which allows userspace to prepare a batch of I/O requests.
> > > > > >
> > > > > > The core of this change is the `ublk_walk_cmd_buf` function, which iterates
> > > > > > over the elements in the uring_cmd fixed buffer. For each element, it parses
> > > > > > the I/O details, finds the corresponding `ublk_io` structure, and prepares it
> > > > > > for future dispatch.
> > > > > >
> > > > > > Add per-io lock for protecting concurrent delivery and committing.
> > > > > >
> > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > ---
> > > > > >  drivers/block/ublk_drv.c      | 191 +++++++++++++++++++++++++++++++++-
> > > > > >  include/uapi/linux/ublk_cmd.h |   5 +
> > > > > >  2 files changed, 195 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > > index 4da0dbbd7e16..a4bae3d1562a 100644
> > > > > > --- a/drivers/block/ublk_drv.c
> > > > > > +++ b/drivers/block/ublk_drv.c
> > > > > > @@ -116,6 +116,10 @@ struct ublk_uring_cmd_pdu {
> > > > > >  struct ublk_batch_io_data {
> > > > > >         struct ublk_queue *ubq;
> > > > > >         struct io_uring_cmd *cmd;
> > > > > > +       unsigned int issue_flags;
> > > > > > +
> > > > > > +       /* set when walking the element buffer */
> > > > > > +       const struct ublk_elem_header *elem;
> > > > > >  };
> > > > > >
> > > > > >  /*
> > > > > > @@ -200,6 +204,7 @@ struct ublk_io {
> > > > > >         unsigned task_registered_buffers;
> > > > > >
> > > > > >         void *buf_ctx_handle;
> > > > > > +       spinlock_t lock;
> > > > >
> > > > > From our experience writing a high-throughput ublk server, the
> > > > > spinlocks and mutexes in the kernel are some of the largest CPU
> > > > > hotspots. We have spent a lot of effort working to avoid locking where
> > > > > possible or shard data structures to reduce contention on the locks.
> > > > > Even uncontended locks are still very expensive to acquire and release
> > > > > on machines with many CPUs due to the cache coherency overhead. ublk's
> > > > > per-io daemon architecture is great for performance by removing the
> > > >
> > > > io-uring highly depends on batch submission and completion, but per-io daemon
> > > > may break the batch easily, because it doesn't guarantee that one batch IOs
> > > > can be forwarded in single io task/io_uring when static tag mapping policy is
> > > > taken, for example:
> > >
> > > That's a good point. We've mainly focused on optimizing the ublk
> > > server side, but it's true that distributing incoming ublk I/Os to
> > > more ublk server threads adds overhead on the submitting side. One
> > > idea we had but haven't experimented with much is for the ublk server
> > > to perform the round-robin assignment of tags within each queue to
> >
> > round-robin often hurts perf, and it isn't enabled yet.
> 
> I don't mean BLK_MQ_F_TAG_RR. I thought even the default tag
> allocation scheme resulted in approximately round-robin tag
> allocation, right? __sbitmap_queue_get_batch() will attempt to
> allocate contiguous bits from the map, so a batch of queued requests
> will likely be assigned sequential tags (or a couple sequential runs
> of tags) in the queue. I guess that's only true if the queue is mostly
> empty; if many tags are in use, it will be harder to allocate
> contiguous sets of tags.

Yes, __sbitmap_queue_get_batch() may fail and fallback to single bit
allocation, so you need to setup big queue depth for avoiding batch
allocation failure. But it is still hard to avoid in case of very
high IO depth.

> 
> >
> > > threads in larger chunks. For example, with a chunk size of 4, tags 0
> > > to 3 would be assigned to thread 0, tags 4 to 7 would be assigned to
> > > thread 1, etc. That would improve the batching of ublk I/Os when
> > > dispatching them from the submitting CPU to the ublk server thread.
> > > There's an inherent tradeoff where distributing tags to ublk server
> > > threads in larger chunks makes the distribution less balanced for
> > > small numbers of I/Os, but it will be balanced when averaged over
> > > large numbers of I/Os.
> >
> > How can fixed chunk size work generically? It depends on workload batch
> > size on /dev/ublkbN, and different workload takes different batch size.
> 
> Yes, that's a good point. It requires pretty specific knowledge of the
> workload to optimize the tag assignment to ublk server threads like
> this.
> 
> >
> > >
> > > >
> > > > ```
> > > > [root@ktest-40 ublk]# ./kublk add -t null  --nthreads 8 -q 4 --per_io_tasks
> > > > dev id 0: nr_hw_queues 4 queue_depth 128 block size 512 dev_capacity 524288000
> > > >         max rq size 1048576 daemon pid 89975 flags 0x6042 state LIVE
> > > >         queue 0: affinity(0 )
> > > >         queue 1: affinity(4 )
> > > >         queue 2: affinity(8 )
> > > >         queue 3: affinity(12 )
> > > > [root@ktest-40 ublk]#
> > > > [root@ktest-40 ublk]# ./kublk add -t null  -q 4
> > > > dev id 1: nr_hw_queues 4 queue_depth 128 block size 512 dev_capacity 524288000
> > > >         max rq size 1048576 daemon pid 90002 flags 0x6042 state LIVE
> > > >         queue 0: affinity(0 )
> > > >         queue 1: affinity(4 )
> > > >         queue 2: affinity(8 )
> > > >         queue 3: affinity(12 )
> > > > [root@ktest-40 ublk]#
> > > > [root@ktest-40 ublk]# ~/git/fio/t/io_uring -p0 /dev/ublkb0
> > > > submitter=0, tid=90024, file=/dev/ublkb0, nfiles=1, node=-1
> > > > polled=0, fixedbufs=1, register_files=1, buffered=0, QD=128
> > > > Engine=io_uring, sq_ring=128, cq_ring=128
> > > > IOPS=188.54K, BW=736MiB/s, IOS/call=32/31
> > > > IOPS=187.90K, BW=734MiB/s, IOS/call=32/32
> > > > IOPS=195.39K, BW=763MiB/s, IOS/call=32/32
> > > > ^CExiting on signal
> > > > Maximum IOPS=195.39K
> > > >
> > > > [root@ktest-40 ublk]# ~/git/fio/t/io_uring -p0 /dev/ublkb1
> > > > submitter=0, tid=90026, file=/dev/ublkb1, nfiles=1, node=-1
> > > > polled=0, fixedbufs=1, register_files=1, buffered=0, QD=128
> > > > Engine=io_uring, sq_ring=128, cq_ring=128
> > > > IOPS=608.26K, BW=2.38GiB/s, IOS/call=32/31
> > > > IOPS=586.59K, BW=2.29GiB/s, IOS/call=32/31
> > > > IOPS=599.62K, BW=2.34GiB/s, IOS/call=32/32
> > > > ^CExiting on signal
> > > > Maximum IOPS=608.26K
> > > >
> > > > ```
> > > >
> > > >
> > > > > need for locks in the I/O path. I can't really see us adopting this
> > > > > ublk batching feature; adding a spin_lock() + spin_unlock() to every
> > > > > ublk commit operation is not worth the reduction in io_uring SQEs and
> > > > > uring_cmds.
> > > >
> > > > As I mentioned in cover letter, the per-io lock can be avoided for UBLK_F_PER_IO_DAEMON
> > > > as one follow-up, since io->task is still there for helping to track task context.
> > > >
> > > > Just want to avoid too much features in enablement stage, that is also
> > > > why the spin lock is wrapped in helper.
> > >
> > > Okay, good to know there's at least an idea for how to avoid the
> > > spinlock. Makes sense to defer it to follow-on work.
> > >
> > > >
> > > > >
> > > > > >  } ____cacheline_aligned_in_smp;
> > > > > >
> > > > > >  struct ublk_queue {
> > > > > > @@ -276,6 +281,16 @@ static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
> > > > > >         return false;
> > > > > >  }
> > > > > >
> > > > > > +static inline void ublk_io_lock(struct ublk_io *io)
> > > > > > +{
> > > > > > +       spin_lock(&io->lock);
> > > > > > +}
> > > > > > +
> > > > > > +static inline void ublk_io_unlock(struct ublk_io *io)
> > > > > > +{
> > > > > > +       spin_unlock(&io->lock);
> > > > > > +}
> > > > > > +
> > > > > >  static inline struct ublksrv_io_desc *
> > > > > >  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
> > > > > >  {
> > > > > > @@ -2538,6 +2553,171 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
> > > > > >         return ublk_ch_uring_cmd_local(cmd, issue_flags);
> > > > > >  }
> > > > > >
> > > > > > +static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
> > > > > > +                                       const struct ublk_elem_header *elem)
> > > > > > +{
> > > > > > +       const void *buf = (const void *)elem;
> > > > >
> > > > > Don't need an explicit cast in order to cast to void *.
> > > >
> > > > OK.
> > > >
> > > > >
> > > > >
> > > > > > +
> > > > > > +       if (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR)
> > > > > > +               return *(__u64 *)(buf + sizeof(*elem));
> > > > > > +       return -1;
> > > > >
> > > > > Why -1 and not 0? ublk_check_fetch_buf() is expecting a 0 buf_addr to
> > > > > indicate the lack
> > > >
> > > > Good catch, it needs to return 0.
> > > >
> > > > >
> > > > > > +}
> > > > > > +
> > > > > > +static struct ublk_auto_buf_reg
> > > > > > +ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
> > > > > > +                       const struct ublk_elem_header *elem)
> > > > > > +{
> > > > > > +       struct ublk_auto_buf_reg reg = {
> > > > > > +               .index = elem->buf_index,
> > > > > > +               .flags = (uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) ?
> > > > > > +                       UBLK_AUTO_BUF_REG_FALLBACK : 0,
> > > > > > +       };
> > > > > > +
> > > > > > +       return reg;
> > > > > > +}
> > > > > > +
> > > > > > +/* 48 can cover any type of buffer element(8, 16 and 24 bytes) */
> > > > >
> > > > > "can cover" is a bit vague. Can you be explicit that the buffer size
> > > > > needs to be a multiple of any possible buffer element size?
> > > >
> > > > I should have documented that 48 is least common multiple(LCM) of (8, 16 and
> > > > 24)
> > > >
> > > > >
> > > > > > +#define UBLK_CMD_BATCH_TMP_BUF_SZ  (48 * 10)
> > > > > > +struct ublk_batch_io_iter {
> > > > > > +       /* copy to this buffer from iterator first */
> > > > > > +       unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
> > > > > > +       struct iov_iter iter;
> > > > > > +       unsigned done, total;
> > > > > > +       unsigned char elem_bytes;
> > > > > > +};
> > > > > > +
> > > > > > +static int __ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> > > > > > +                               struct ublk_batch_io_data *data,
> > > > > > +                               unsigned bytes,
> > > > > > +                               int (*cb)(struct ublk_io *io,
> > > > > > +                                       const struct ublk_batch_io_data *data))
> > > > > > +{
> > > > > > +       int i, ret = 0;
> > > > > > +
> > > > > > +       for (i = 0; i < bytes; i += iter->elem_bytes) {
> > > > > > +               const struct ublk_elem_header *elem =
> > > > > > +                       (const struct ublk_elem_header *)&iter->buf[i];
> > > > > > +               struct ublk_io *io;
> > > > > > +
> > > > > > +               if (unlikely(elem->tag >= data->ubq->q_depth)) {
> > > > > > +                       ret = -EINVAL;
> > > > > > +                       break;
> > > > > > +               }
> > > > > > +
> > > > > > +               io = &data->ubq->ios[elem->tag];
> > > > > > +               data->elem = elem;
> > > > > > +               ret = cb(io, data);
> > > > >
> > > > > Why not just pas elem as a separate argument to the callback?
> > > >
> > > > One reason is that we don't have complete type for 'elem' since its size
> > > > is a variable.
> > >
> > > I didn't mean to pass ublk_elem_header by value, still by pointer.
> > > Just that you could pass const struct ublk_elem_header *elem as an
> > > additional parameter to the callback. I think that would make the code
> > > a bit easier to follow than passing it via data->elem.
> >
> > OK.
> >
> > >
> > > >
> > > > >
> > > > > > +               if (unlikely(ret))
> > > > > > +                       break;
> > > > > > +       }
> > > > > > +       iter->done += i;
> > > > > > +       return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static int ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> > > > > > +                            struct ublk_batch_io_data *data,
> > > > > > +                            int (*cb)(struct ublk_io *io,
> > > > > > +                                    const struct ublk_batch_io_data *data))
> > > > > > +{
> > > > > > +       int ret = 0;
> > > > > > +
> > > > > > +       while (iter->done < iter->total) {
> > > > > > +               unsigned int len = min(sizeof(iter->buf), iter->total - iter->done);
> > > > > > +
> > > > > > +               ret = copy_from_iter(iter->buf, len, &iter->iter);
> > > > > > +               if (ret != len) {
> > > > >
> > > > > How would this be possible? The iterator comes from an io_uring
> > > > > registered buffer with at least the requested length, so the user
> > > > > addresses should have been validated when the buffer was registered.
> > > > > Should this just be a WARN_ON()?
> > > >
> > > > yes, that is why pr_warn() is used, I remember that WARN_ON() isn't
> > > > encouraged in user code path.
> > > >
> > > > >
> > > > > > +                       pr_warn("ublk%d: read batch cmd buffer failed %u/%u\n",
> > > > > > +                                       data->ubq->dev->dev_info.dev_id, ret, len);
> > > > > > +                       ret = -EINVAL;
> > > > > > +                       break;
> > > > > > +               }
> > > > > > +
> > > > > > +               ret = __ublk_walk_cmd_buf(iter, data, len, cb);
> > > > > > +               if (ret)
> > > > > > +                       break;
> > > > > > +       }
> > > > > > +       return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static int ublk_batch_unprep_io(struct ublk_io *io,
> > > > > > +                               const struct ublk_batch_io_data *data)
> > > > > > +{
> > > > > > +       if (ublk_queue_ready(data->ubq))
> > > > > > +               data->ubq->dev->nr_queues_ready--;
> > > > > > +
> > > > > > +       ublk_io_lock(io);
> > > > > > +       io->flags = 0;
> > > > > > +       ublk_io_unlock(io);
> > > > > > +       data->ubq->nr_io_ready--;
> > > > > > +       return 0;
> > > > >
> > > > > This "unprep" looks very subtle and fairly complicated. Is it really
> > > > > necessary? What's wrong with leaving the I/Os that were successfully
> > > > > prepped? It also looks racy to clear io->flags after the queue is
> > > > > ready, as the io may already be in use by some I/O request.
> > > >
> > > > ublk_batch_unprep_io() is called in partial completion of UBLK_U_IO_PREP_IO_CMDS,
> > > > when START_DEV can't succeed, so there can't be any IO.
> > >
> > > Isn't it possible that the UBLK_U_IO_PREP_IO_CMDS batch contains all
> > > the I/Os not yet prepped followed by some duplicates? Then the device
> > > could be started following the successful completion of all the newly
> > > prepped I/Os, but the batch would fail on the following duplicate
> > > I/Os, causing the successfully prepped I/Os to be unprepped?
> >
> > It can be avoided easily because ub->mutex is required for UBLK_U_IO_PREP_IO_CMDS,
> > such as, ub->dev_info.state can be set to UBLK_S_DEV_DEAD in case of any failure.
> 
> Are you saying that the situation I described isn't possible, or that
> it can be prevented with an additional state check?

I meant it can be avoided easily, such as by adding check ublk_dev_ready() in
ublk_ctrl_start_dev() after ub->mutex is acquired.

> I don't think the mutex alone prevents this situation. The mutex
> guards against concurrent UBLK_U_IO_PREP_IO_CMDS, but it doesn't
> prevent requests from being queued concurrently to the ublk device
> once it's ready. And __ublk_fetch() will mark the ublk device as ready
> as soon as all the tags have been fetched/prepped, when there could
> still be more commands in the UBLK_U_IO_PREP_IO_CMDS batch.
> I think to fix the issue, you'd need to wait to mark the ublk device
> ready until the end of the UBLK_U_IO_PREP_IO_CMDS batch.


Thanks,
Ming

