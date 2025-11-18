Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E092FFDDB
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431907; cv=none; b=sFDol4T0am7x147ZT5rRT7PnSt6i2LazImPbmlAwlqUwwSRIIUWDpYw4a0Yii6a+5b9IRHK2glhKLs38ODxe1la3Nb4UjoB5eROcXuECz6l4lir6Stt34adUMzQ7agQYIt7kx+KByuY1lcTXOuTyjAIbHgJFpr2bXTpGSuRIpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431907; c=relaxed/simple;
	bh=9IIkXnJOIDh/raZ0B/Reudf6ec3+wFR1u2pBXOfU0OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7xmnkQ5JJ3879RiTt0A7Xb+GfozE1iGMAkDDLH89ouC7EH3QnI5KQSKeZrwF97Rgx2iHapRY+byDsl0ZZrDGijr8HDKi7TCfvi4BstaQDVzoEcgM1Eikm58Dygklgcv5tJ3AKg1kqUiKMy24Ue+65hkRyKJ2ehV3+M/9mDl9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLZ8etJm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLZ8etJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763431903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kH4/ZrSoq+DYFO2wL1YJXhN0SZjlp31GDT9ACoXaW8=;
	b=NLZ8etJmQHKarC7UVYZkT01rGPrM+/AdYiG+J2tH5+IlcEuzK1kKjzgST7dL0vvzOl32Fq
	movhBjRgMFBF5raH6+6dn8ci0xvlP+RH2ypIqvZqfZtuFo64dShy3UplFat6HpklmtwhBN
	ED6DQ3RUPC2zaXntenYidWcfz/TgFgQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-g3kzNAvqNdaeeIsMIjCy2g-1; Mon,
 17 Nov 2025 21:11:41 -0500
X-MC-Unique: g3kzNAvqNdaeeIsMIjCy2g-1
X-Mimecast-MFC-AGG-ID: g3kzNAvqNdaeeIsMIjCy2g_1763431900
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB7F5180035D;
	Tue, 18 Nov 2025 02:11:40 +0000 (UTC)
Received: from fedora (unknown [10.72.116.204])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACAF71800367;
	Tue, 18 Nov 2025 02:11:37 +0000 (UTC)
Date: Tue, 18 Nov 2025 10:11:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V3 09/27] ublk: add new batch command
 UBLK_U_IO_PREP_IO_CMDS & UBLK_U_IO_COMMIT_IO_CMDS
Message-ID: <aRvV1JWYYnq2nEuw@fedora>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
 <20251112093808.2134129-10-ming.lei@redhat.com>
 <CADUfDZp3RVr-n4UbiRa=+hDnZh2r-G-fFL0o8PtVD2ERMSfpPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp3RVr-n4UbiRa=+hDnZh2r-G-fFL0o8PtVD2ERMSfpPw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Nov 17, 2025 at 01:08:56PM -0800, Caleb Sander Mateos wrote:
> On Wed, Nov 12, 2025 at 1:39 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add new command UBLK_U_IO_PREP_IO_CMDS, which is the batch version of
> > UBLK_IO_FETCH_REQ.
> >
> > Add new command UBLK_U_IO_COMMIT_IO_CMDS, which is for committing io command
> > result only, still the batch version.
> >
> > The new command header type is `struct ublk_batch_io`, and fixed buffer is
> > required for these two uring_cmd.
> >
> > This patch doesn't actually implement these commands yet, just validates the
> > SQE fields.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 107 +++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/ublk_cmd.h |  49 ++++++++++++++++
> >  2 files changed, 155 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index c62b2f2057fe..5f9d7ec9daa4 100644
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
> > @@ -108,6 +113,12 @@ struct ublk_uring_cmd_pdu {
> >         u16 tag;
> >  };
> >
> > +struct ublk_batch_io_data {
> > +       struct ublk_device *ub;
> 
> Is it possible for this to be a const pointer?

It isn't, for example, mutex_lock(&data->ub->mutex).

> 
> > +       struct io_uring_cmd *cmd;
> > +       struct ublk_batch_io header;
> > +};
> > +
> >  /*
> >   * io command is active: sqe cmd is received, and its cqe isn't done
> >   *
> > @@ -2520,10 +2531,104 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
> >         return ublk_ch_uring_cmd_local(cmd, issue_flags);
> >  }
> >
> > +static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
> > +{
> > +       const u16 mask = UBLK_BATCH_F_HAS_BUF_ADDR | UBLK_BATCH_F_HAS_ZONE_LBA;
> > +       const unsigned header_len = sizeof(struct ublk_elem_header);
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
> > +               if (uc->elem_bytes != header_len)
> > +                       return -EINVAL;
> > +               break;
> > +       case UBLK_BATCH_F_HAS_ZONE_LBA:
> > +       case UBLK_BATCH_F_HAS_BUF_ADDR:
> > +               if (uc->elem_bytes != header_len + sizeof(u64))
> > +                       return -EINVAL;
> > +               break;
> > +       case UBLK_BATCH_F_HAS_ZONE_LBA | UBLK_BATCH_F_HAS_BUF_ADDR:
> > +               if (uc->elem_bytes != header_len + sizeof(u64) + sizeof(u64))
> > +                       return -EINVAL;
> > +               break;
> > +       }
> 
> This could probably be implemented in a less branchy way using
> conditional moves:
> unsigned elem_bytes = sizeof(struct ublk_elem_header) +
>         (uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA ? sizeof(u64) : 0) +
>         (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR ? sizeof(u64) : 0);
> if (uc->elem_bytes != elem_bytes)
>         return -EINVAL;

I'd start with current more readable way, but the less branchy optimization
can be left in future.

> 
> > +
> > +       return 0;
> > +}
> > +
> > +static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data)
> > +{
> > +
> > +       const struct ublk_batch_io *uc = &data->header;
> > +
> > +       if (!(data->cmd->flags & IORING_URING_CMD_FIXED))
> > +               return -EINVAL;
> > +
> > +       if (uc->nr_elem * uc->elem_bytes > data->cmd->sqe->len)
> > +               return -E2BIG;
> > +
> > +       if (uc->nr_elem > data->ub->dev_info.queue_depth)
> > +               return -E2BIG;
> > +
> > +       if ((uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA) &&
> > +                       !ublk_dev_is_zoned(data->ub))
> > +               return -EINVAL;
> > +
> > +       if ((uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR) &&
> > +                       !ublk_dev_need_map_io(data->ub))
> > +               return -EINVAL;
> > +
> > +       if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
> > +                       !ublk_dev_support_auto_buf_reg(data->ub))
> > +               return -EINVAL;
> > +
> > +       if (uc->reserved || uc->reserved2)
> > +               return -EINVAL;
> 
> These fields aren't actually copied from the uring_cmd, so this check
> is a no-op.

Good catch, will kill it in next version.

> 
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
> > +               .ub  = ub,
> > +               .cmd = cmd,
> > +               .header = (struct ublk_batch_io) {
> > +                       .q_id = READ_ONCE(uc->q_id),
> > +                       .flags = READ_ONCE(uc->flags),
> > +                       .nr_elem = READ_ONCE(uc->nr_elem),
> > +                       .elem_bytes = READ_ONCE(uc->elem_bytes),
> > +               },
> > +       };
> > +       u32 cmd_op = cmd->cmd_op;
> > +       int ret = -EINVAL;
> > +
> > +       if (data.header.q_id >= ub->dev_info.nr_hw_queues)
> > +               goto out;
> > +
> > +       switch (cmd_op) {
> > +       case UBLK_U_IO_PREP_IO_CMDS:
> > +       case UBLK_U_IO_COMMIT_IO_CMDS:
> > +               ret = ublk_check_batch_cmd(&data);
> > +               if (ret)
> > +                       goto out;
> > +               ret = -EOPNOTSUPP;
> > +               break;
> > +       default:
> > +               ret = -EOPNOTSUPP;
> > +       }
> > +out:
> 
> Is the out label really necessary if there's no cleanup involved? Can
> we just return the result directly?

Yeah, it isn't necessary, but we have benefit of single exit with `goto`,
also will avoid extra `return` since command handler is added in following
patches.


Thanks,
Ming

