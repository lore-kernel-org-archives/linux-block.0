Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A14315F
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473561; cv=none; b=RUn8WF0DfX8FNm7jDa/RdE/9h3WICC6K1aJeAlG95QtQR6P+hZL4mNVbBMTJcXxd3x3MO7JsOn/o1AyYXjWhfV+c7NpzU0Uw+j2thVEYSJBBBqnBzOBiV0r6d2FAsJtO2CjkDoDZf06frS/8PNXqvmZ0jtFasTcAKWaSjRyap10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473561; c=relaxed/simple;
	bh=jBjlHFP90gvxXGlhdyiKkQFZSES5lU+ZVCofA4PuuFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu/ih5ldlKuRx0AtwA+HXClCK6v4q3X0qhfZ6RdXSEkibydseuQOerOrOh/ZYTpFnDzMTy8Qfj5gSp6ooGTX2E3o1uO21QDbIkE5BG3Jomxx6nSK2Dxj2XspDOSNl4uoSGyzDl27uvYypqCnHQDFkLxo+QNyTYAA464ByLQ6ifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPa5yFz7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPa5yFz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757473558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYJelEYHjA9dmenDGgRMZwyzaCBU8s3ekTzpyKJM2fY=;
	b=XPa5yFz79APjpNMGLoolsgjegiefTFcTeh2xK3SK6mrycH+SSFHepdOoBKL6gIFpW6cZ4j
	gBp5wNPvRXM+vcvgAizZ/8Awq/YusgIF0/wbKZeNSt9ILFzmJnKRN69H4FzxUbMwSxqvbB
	3HDfndchxqrfncI/nw8niuT2nrwpewg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-14JmrzWHOqC-qkWCdR2iLw-1; Tue,
 09 Sep 2025 23:05:55 -0400
X-MC-Unique: 14JmrzWHOqC-qkWCdR2iLw-1
X-Mimecast-MFC-AGG-ID: 14JmrzWHOqC-qkWCdR2iLw_1757473554
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27ACF180034F;
	Wed, 10 Sep 2025 03:05:54 +0000 (UTC)
Received: from fedora (unknown [10.72.120.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2780C19560AB;
	Wed, 10 Sep 2025 03:05:50 +0000 (UTC)
Date: Wed, 10 Sep 2025 11:05:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 07/23] ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS
 & UBLK_U_IO_COMMIT_IO_CMDS
Message-ID: <aMDrCcIYpa8EzBMb@fedora>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
 <20250901100242.3231000-8-ming.lei@redhat.com>
 <CADUfDZq8hWU1z7_-s3We7pMSxW6uAmX=yp7RXOYwkrWxcvPXDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZq8hWU1z7_-s3We7pMSxW6uAmX=yp7RXOYwkrWxcvPXDA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Sep 06, 2025 at 11:50:55AM -0700, Caleb Sander Mateos wrote:
> On Mon, Sep 1, 2025 at 3:03 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add new command UBLK_U_IO_PREP_IO_CMDS, which is the batch version of
> > UBLK_IO_FETCH_REQ.
> >
> > Add new command UBLK_U_IO_COMMIT_IO_CMDS, which is for committing io command
> > result only, still the batch version.
> >
> > The new command header type is `struct ublk_batch_io`, and fixed buffer is
> > required for these two uring_cmd.
> 
> The commit message could be clearer that it doesn't actually implement
> these commands yet, just validates the SQE fields.

OK.

> 
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 102 +++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/ublk_cmd.h |  49 ++++++++++++++++
> >  2 files changed, 149 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 46be5b656f22..4da0dbbd7e16 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -85,6 +85,11 @@
> >          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> >          UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> >
> > +#define UBLK_BATCH_F_ALL  \
> > +       (UBLK_BATCH_F_HAS_ZONE_LBA | \
> > +        UBLK_BATCH_F_HAS_BUF_ADDR | \
> > +        UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
> > +
> >  struct ublk_uring_cmd_pdu {
> >         /*
> >          * Store requests in same batch temporarily for queuing them to
> > @@ -108,6 +113,11 @@ struct ublk_uring_cmd_pdu {
> >         u16 tag;
> >  };
> >
> > +struct ublk_batch_io_data {
> > +       struct ublk_queue *ubq;
> > +       struct io_uring_cmd *cmd;
> > +};
> > +
> >  /*
> >   * io command is active: sqe cmd is received, and its cqe isn't done
> >   *
> > @@ -277,7 +287,7 @@ static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
> >         return ub->dev_info.flags & UBLK_F_ZONED;
> >  }
> >
> > -static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
> > +static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
> 
> This change could go in a separate commit.

Fair enough.

> 
> >  {
> >         return ubq->flags & UBLK_F_ZONED;
> >  }
> > @@ -2528,10 +2538,98 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
> >         return ublk_ch_uring_cmd_local(cmd, issue_flags);
> >  }
> >
> > +static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
> > +{
> > +       const unsigned short mask = UBLK_BATCH_F_HAS_BUF_ADDR |
> > +               UBLK_BATCH_F_HAS_ZONE_LBA;
> 
> Can we use a fixed-size integer type, i.e. u16?

Good point, since here the flag is defined in uapi.

> 
> > +
> > +       if (uc->flags & ~UBLK_BATCH_F_ALL)
> > +               return -EINVAL;
> > +
> > +       /* UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK requires buffer index */
> > +       if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
> > +                       (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR))
> > +               return -EINVAL;
> > +
> > +       switch (uc->flags & mask) {
> > +       case 0:
> > +               if (uc->elem_bytes != 8)
> 
> sizeof(struct ublk_elem_header)?

Yes.

> 
> > +                       return -EINVAL;
> > +               break;
> > +       case UBLK_BATCH_F_HAS_ZONE_LBA:
> > +       case UBLK_BATCH_F_HAS_BUF_ADDR:
> > +               if (uc->elem_bytes != 8 + 8)
> 
> sizeof(u64)?

OK

> 
> > +                       return -EINVAL;
> > +               break;
> > +       case UBLK_BATCH_F_HAS_ZONE_LBA | UBLK_BATCH_F_HAS_BUF_ADDR:
> > +               if (uc->elem_bytes != 8 + 8 + 8)
> > +                       return -EINVAL;
> 
> So elem_bytes is redundant with flags? Do we really need a separate a
> separate field then?

It is used for cross verification purpose, especially the command
header has enough space.

> 
> > +               break;
> > +       default:
> > +               return -EINVAL;
> 
> default case is unreachable?

Right.

> 
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data,
> > +                               const struct ublk_batch_io *uc)
> > +{
> > +       if (!(data->cmd->flags & IORING_URING_CMD_FIXED))
> > +               return -EINVAL;
> > +
> > +       if (uc->nr_elem * uc->elem_bytes > data->cmd->sqe->len)
> 
> Cast nr_elem and/or elem_bytes to u32 to avoid overflow concerns?

`u16` * `u8` can't overflow.

> 
> Should also use READ_ONCE() to read the userspace-mapped sqe->len.

Yes.

When I write the patch, sqe is always copied, but it isn't true now.

> 
> > +               return -E2BIG;
> > +
> > +       if (uc->nr_elem > data->ubq->q_depth)
> > +               return -E2BIG;
> > +
> > +       if ((uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA) &&
> > +                       !ublk_queue_is_zoned(data->ubq))
> > +               return -EINVAL;
> > +
> > +       if ((uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR) &&
> > +                       !ublk_need_map_io(data->ubq))
> > +               return -EINVAL;
> > +
> > +       if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
> > +                       !ublk_support_auto_buf_reg(data->ubq))
> > +               return -EINVAL;
> > +
> > +       if (uc->reserved || uc->reserved2)
> > +               return -EINVAL;
> > +
> > +       return ublk_check_batch_cmd_flags(uc);
> > +}
> > +
> >  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> >                                        unsigned int issue_flags)
> >  {
> > -       return -EOPNOTSUPP;
> > +       const struct ublk_batch_io *uc = io_uring_sqe_cmd(cmd->sqe);
> > +       struct ublk_device *ub = cmd->file->private_data;
> > +       struct ublk_batch_io_data data = {
> > +               .cmd = cmd,
> > +       };
> > +       u32 cmd_op = cmd->cmd_op;
> > +       int ret = -EINVAL;
> > +
> > +       if (uc->q_id >= ub->dev_info.nr_hw_queues)
> > +               goto out;
> > +       data.ubq = ublk_get_queue(ub, uc->q_id);
> 
> Should be using READ_ONCE() to read from userspace-mapped memory.

Indeed, it can be copied to `ublk_batch_io_data`, just 64bits.

> 
> 
> 
> > +
> > +       switch (cmd_op) {
> > +       case UBLK_U_IO_PREP_IO_CMDS:
> > +       case UBLK_U_IO_COMMIT_IO_CMDS:
> > +               ret = ublk_check_batch_cmd(&data, uc);
> > +               if (ret)
> > +                       goto out;
> > +               ret = -EOPNOTSUPP;
> > +               break;
> > +       default:
> > +               ret = -EOPNOTSUPP;
> > +       }
> > +out:
> > +       return ret;
> >  }
> >
> >  static inline bool ublk_check_ubuf_dir(const struct request *req,
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> > index ec77dabba45b..01d3af52cfb4 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -102,6 +102,10 @@
> >         _IOWR('u', 0x23, struct ublksrv_io_cmd)
> >  #define        UBLK_U_IO_UNREGISTER_IO_BUF     \
> >         _IOWR('u', 0x24, struct ublksrv_io_cmd)
> > +#define        UBLK_U_IO_PREP_IO_CMDS  \
> > +       _IOWR('u', 0x25, struct ublk_batch_io)
> > +#define        UBLK_U_IO_COMMIT_IO_CMDS        \
> > +       _IOWR('u', 0x26, struct ublk_batch_io)
> >
> >  /* only ABORT means that no re-fetch */
> >  #define UBLK_IO_RES_OK                 0
> > @@ -525,6 +529,51 @@ struct ublksrv_io_cmd {
> >         };
> >  };
> >
> > +struct ublk_elem_header {
> > +       __u16 tag;      /* IO tag */
> > +
> > +       /*
> > +        * Buffer index for incoming io command, only valid iff
> > +        * UBLK_F_AUTO_BUF_REG is set
> > +        */
> > +       __u16 buf_index;
> > +       __u32 result;   /* I/O completion result (commit only) */
> 
> The result is unsigned? So there's no way to specify a request failure?

oops, definitely it should be __s32.

> 
> > +};
> > +
> > +/*
> > + * uring_cmd buffer structure
> 
> Add "for batch commands"?

Sure.

> 
> > + *
> > + * buffer includes multiple elements, which number is specified by
> > + * `nr_elem`. Each element buffer is organized in the following order:
> > + *
> > + * struct ublk_elem_buffer {
> > + *     // Mandatory fields (8 bytes)
> > + *     struct ublk_elem_header header;
> > + *
> > + *     // Optional fields (8 bytes each, included based on flags)
> > + *
> > + *     // Buffer address (if UBLK_BATCH_F_HAS_BUF_ADDR) for copying data
> > + *     // between ublk request and ublk server buffer
> > + *     __u64 buf_addr;
> > + *
> > + *     // returned Zone append LBA (if UBLK_BATCH_F_HAS_ZONE_LBA)
> > + *     __u64 zone_lba;
> > + * }
> > + *
> > + * Used for `UBLK_U_IO_PREP_IO_CMDS` and `UBLK_U_IO_COMMIT_IO_CMDS`
> > + */
> > +struct ublk_batch_io {
> > +       __u16  q_id;
> 
> So this doesn't allow batching completions across ublk queues? That

Yes.

I tried device-wide batch, it may introduce a little complexity to
ublk_handle_batch_commit_cmd(), especially it becomes hard to apply
some future optimizations, such as batched request completion.

It isn't hard to add one variant for covering cross-queue commit,
just `qid` need to be added to 'ublk_elem_buffer', which becomes not
aligned any more.

> seems like it significantly limits the usefulness of this feature. A
> ublk server thread may be handling ublk requests from a number of
> client threads which are submitting to different ublk queues.

But ublk server still can support cross-queue completion.

The selftest code does support arbitrary ublk queues/thread combination,
just a one-shot per-queue commit buffer is needed.

It is sort of trade-off between driver and ublk server implementation.

Thanks,
Ming

