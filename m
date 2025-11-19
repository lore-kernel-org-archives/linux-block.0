Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CC3451D7
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546213; cv=none; b=sJCXHqRUXZL0VW8HsVwfMmMxrlFpEEOFJmI1tsZhmkxDKVWJlyucpoCO/3UdqcdUBpaLovtvbl3lkU7QpAQmInphPzUIEKbqyoboZ0k8jS3dw4MriW6hSU3IqJzqjEa1X4Ya887ziZlpVv9wEIdoAzbBymtcD4xmBE6z5EDjYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546213; c=relaxed/simple;
	bh=Jj6tEG9SIcIGLjtTYMzVitCLY7yNOLenqZrsBpOikWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU1dPrjIY/A02/xR3RtuZaHDYbd5R3lfWtMw3TDisbUzGEW0r3eEOXMkeZs+5Ytmqtdc+8nuixffE18zUJNVllJaUpJOw3Oo6tKBqqYzSC11qMWL2TugXTm4qtNU1dl/TSHWr0Oqo2KZE+V7u904SEVjeca+V8gKkg0kJJNJbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NupjaSfM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NupjaSfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763546207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/eBYlNHSBvxkKD7+aFQpr8u/Gl4MjCUDZle0nkmExI=;
	b=NupjaSfMY49CQhUp4AUTjuvGdlA5w3E0i9H/jJDxb2B7+YmXhzWvHgAv/ywh4Sc+Wzdfaw
	NGZbUQErd8MtEfWk2kNN3dGC59CLSgkVSb6qE22226wRaEvF/dKYxyjRojuwVPqTSLyhbl
	4iymSXEuB6cAJfkq30JzG94R03dq92Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-UZdYUVx3PDCDS15CfuGDnA-1; Wed,
 19 Nov 2025 04:56:31 -0500
X-MC-Unique: UZdYUVx3PDCDS15CfuGDnA-1
X-Mimecast-MFC-AGG-ID: UZdYUVx3PDCDS15CfuGDnA_1763546190
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9B301800EF6;
	Wed, 19 Nov 2025 09:56:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3CC4180047F;
	Wed, 19 Nov 2025 09:56:21 +0000 (UTC)
Date: Wed, 19 Nov 2025 17:56:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V3 10/27] ublk: handle UBLK_U_IO_PREP_IO_CMDS
Message-ID: <aR2UPxAROdH09mv-@fedora>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
 <20251112093808.2134129-11-ming.lei@redhat.com>
 <CADUfDZr88twJJLTJ0bx-OP4Rz54hF9enuw=8vYkPuhzOab1rEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZr88twJJLTJ0bx-OP4Rz54hF9enuw=8vYkPuhzOab1rEQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Nov 18, 2025 at 06:49:57PM -0800, Caleb Sander Mateos wrote:
> On Wed, Nov 12, 2025 at 1:39 AM Ming Lei <ming.lei@redhat.com> wrote:
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
> >  drivers/block/ublk_drv.c      | 205 +++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/ublk_cmd.h |   5 +
> >  2 files changed, 209 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 5f9d7ec9daa4..84d838df18cb 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -117,6 +117,7 @@ struct ublk_batch_io_data {
> >         struct ublk_device *ub;
> >         struct io_uring_cmd *cmd;
> >         struct ublk_batch_io header;
> > +       unsigned int issue_flags;
> >  };
> >
> >  /*
> > @@ -201,6 +202,7 @@ struct ublk_io {
> >         unsigned task_registered_buffers;
> >
> >         void *buf_ctx_handle;
> > +       spinlock_t lock;
> >  } ____cacheline_aligned_in_smp;
> >
> >  struct ublk_queue {
> > @@ -270,6 +272,16 @@ static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
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
> > @@ -2531,6 +2543,183 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
> >         return ublk_ch_uring_cmd_local(cmd, issue_flags);
> >  }
> >
> > +static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
> > +                                       const struct ublk_elem_header *elem)
> > +{
> > +       const void *buf = elem;
> > +
> > +       if (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR)
> > +               return *(__u64 *)(buf + sizeof(*elem));
> > +       return 0;
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
> > +/*
> > + * 48 can hold any type of buffer element(8, 16 and 24 bytes) because
> > + * it is the least common multiple(LCM) of 8, 16 and 24
> > + */
> > +#define UBLK_CMD_BATCH_TMP_BUF_SZ  (48 * 10)
> > +struct ublk_batch_io_iter {
> > +       /* copy to this buffer from iterator first */
> > +       unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
> > +       struct iov_iter iter;
> > +       unsigned done, total;
> > +       unsigned char elem_bytes;
> > +};
> > +
> > +static inline int
> > +__ublk_walk_cmd_buf(struct ublk_queue *ubq,
> > +                   struct ublk_batch_io_iter *iter,
> > +                   const struct ublk_batch_io_data *data,
> > +                   unsigned bytes,
> > +                   int (*cb)(struct ublk_queue *q,
> > +                           const struct ublk_batch_io_data *data,
> > +                           const struct ublk_elem_header *elem))
> > +{
> > +       int i, ret = 0;
> 
> unsigned i to avoid comparisons between signed and unsigned values?

OK.

> 
> > +
> > +       for (i = 0; i < bytes; i += iter->elem_bytes) {
> > +               const struct ublk_elem_header *elem =
> > +                       (const struct ublk_elem_header *)&iter->buf[i];
> > +
> > +               if (unlikely(elem->tag >= data->ub->dev_info.queue_depth)) {
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> > +
> > +               ret = cb(ubq, data, elem);
> > +               if (unlikely(ret))
> > +                       break;
> > +       }
> > +
> > +       /* revert unhandled bytes in case of failure */
> > +       if (ret)
> > +               iov_iter_revert(&iter->iter, bytes - i);
> > +
> > +       iter->done += i;
> > +       return ret;
> > +}
> > +
> > +static int ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> > +                            const struct ublk_batch_io_data *data,
> > +                            int (*cb)(struct ublk_queue *q,
> > +                                    const struct ublk_batch_io_data *data,
> > +                                    const struct ublk_elem_header *elem))
> > +{
> > +       struct ublk_queue *ubq = ublk_get_queue(data->ub, data->header.q_id);
> > +       int ret = 0;
> > +
> > +       while (iter->done < iter->total) {
> > +               unsigned int len = min(sizeof(iter->buf), iter->total - iter->done);
> > +
> > +               ret = copy_from_iter(iter->buf, len, &iter->iter);
> 
> Would make more sense to store this as an unsigned value.

OK.

BTW, it has been changed to plain copy_from_user() in my local version by
dropping fixed buffer for commit/prep ios command.

There is also one big bug fix in patch 'ublk: add batch I/O dispatch infrastructure',

Do you prefer to continuing to review on V3 or the coming V4?

If you prefer to V4, I can prepare and send it soon.

> 
> > +               if (ret != len) {
> > +                       pr_warn("ublk%d: read batch cmd buffer failed %u/%u\n",
> > +                                       data->ub->dev_info.dev_id, ret, len);
> > +                       ret = -EINVAL;
> > +                       break;
> 
> Just return -EINVAL?
> 
> > +               }
> > +
> > +               ret = __ublk_walk_cmd_buf(ubq, iter, data, len, cb);
> > +               if (ret)
> > +                       break;
> 
> Just return ret?
> 
> > +       }
> > +       return ret;
> > +}
> > +
> > +static int ublk_batch_unprep_io(struct ublk_queue *ubq,
> > +                               const struct ublk_batch_io_data *data,
> > +                               const struct ublk_elem_header *elem)
> > +{
> > +       struct ublk_io *io = &ubq->ios[elem->tag];
> > +
> > +       data->ub->nr_io_ready--;
> > +       ublk_io_lock(io);
> > +       io->flags = 0;
> > +       ublk_io_unlock(io);
> > +       return 0;
> > +}
> > +
> > +static void ublk_batch_revert_prep_cmd(struct ublk_batch_io_iter *iter,
> > +                                      const struct ublk_batch_io_data *data)
> > +{
> > +       int ret;
> > +
> > +       if (!iter->done)
> > +               return;
> > +
> > +       iov_iter_revert(&iter->iter, iter->done);
> > +       iter->total = iter->done;
> > +       iter->done = 0;
> > +
> > +       ret = ublk_walk_cmd_buf(iter, data, ublk_batch_unprep_io);
> > +       WARN_ON_ONCE(ret);
> > +}
> > +
> > +static int ublk_batch_prep_io(struct ublk_queue *ubq,
> > +                             const struct ublk_batch_io_data *data,
> > +                             const struct ublk_elem_header *elem)
> > +{
> > +       struct ublk_io *io = &ubq->ios[elem->tag];
> > +       const struct ublk_batch_io *uc = &data->header;
> > +       union ublk_io_buf buf = { 0 };
> > +       int ret;
> > +
> > +       if (ublk_dev_support_auto_buf_reg(data->ub))
> > +               buf.auto_reg = ublk_batch_auto_buf_reg(uc, elem);
> > +       else if (ublk_dev_need_map_io(data->ub)) {
> > +               buf.addr = ublk_batch_buf_addr(uc, elem);
> > +
> > +               ret = ublk_check_fetch_buf(data->ub, buf.addr);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       ublk_io_lock(io);
> > +       ret = __ublk_fetch(data->cmd, data->ub, io);
> > +       if (!ret)
> > +               io->buf = buf;
> > +       ublk_io_unlock(io);
> > +
> > +       return ret;
> > +}
> > +
> > +static int ublk_handle_batch_prep_cmd(const struct ublk_batch_io_data *data)
> > +{
> > +       const struct ublk_batch_io *uc = &data->header;
> > +       struct io_uring_cmd *cmd = data->cmd;
> > +       struct ublk_batch_io_iter iter = {
> > +               .total = uc->nr_elem * uc->elem_bytes,
> > +               .elem_bytes = uc->elem_bytes,
> > +       };
> > +       int ret;
> > +
> > +       ret = io_uring_cmd_import_fixed(cmd->sqe->addr, iter.total,
> 
> sqe-> addr should be accessed with READ_ONCE() since it may point to
> user-mapped memory.

OK.

> 
> > +                       WRITE, &iter.iter, cmd, data->issue_flags);
> > +       if (ret)
> > +               return ret;
> > +
> > +       mutex_lock(&data->ub->mutex);
> > +       ret = ublk_walk_cmd_buf(&iter, data, ublk_batch_prep_io);
> > +
> > +       if (ret && iter.done)
> > +               ublk_batch_revert_prep_cmd(&iter, data);
> 
> Mentioned this on V1 as well, but the iter.done check is duplicated in
> ublk_batch_revert_prep_cmd().

OK, will drop the check in ublk_batch_revert_prep_cmd().

Thanks,
Ming

