Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450B306B3F
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545790; cv=none; b=kola0UlTF2+Ay/Ejsxu/DdiXfYouJi001/7zR3giXyaEc0hX5HIK19Cq8nmmiQ+6R1v1Y87WaI3+NHJX6Yn/ogfsCDImLpd8RngJfCKIhC/zLJr7fFyBHSZSGoTaYtRyTFZUm1qLAb3Vn67t2XMV3bU31sdSTZ1WttYN5RGwOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545790; c=relaxed/simple;
	bh=FF0ofG+qLkShiY6yRQotnIgLVRk0Cx1RTJixGke1GiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsb7ZaUOEg558r23ok2tdusPaAYdc81Yto8NgKDgSP/PV5EiUm/yqPxDKPm+m4FI81WjmbHqRw19ibTQD7s751NhreKv5LJTkh3pY/ZBn9JxTWN/7PWJ5Nv9scwqTOkhAUY4uo3LHYXAuTOYHzkyH2NYAI/UL8IG3006xL/mM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZ2Hjcbu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZ2Hjcbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763545786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZqp95DOE96ctky2OPYYTlysxb3CveRDhIODhIU5D+o=;
	b=XZ2HjcbuoCS42oiBBbrHVG/ioQ9TTw2r3BXDGqwQk9UHLGeaOo2df8Cw2S39nKTjeISAg2
	c+1OUtNoQGG9k7XaFz+9cTW5cgoYnzupVUd38rBRcWrpBRENmKI2iOiMTjaPSCapGXE/JB
	M87XRQbHgIT1hNi+GCHnJ52niKKTBCk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-fMf_V56QPiu75ZmsOStfeg-1; Wed,
 19 Nov 2025 04:49:43 -0500
X-MC-Unique: fMf_V56QPiu75ZmsOStfeg-1
X-Mimecast-MFC-AGG-ID: fMf_V56QPiu75ZmsOStfeg_1763545782
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1757018AB41B;
	Wed, 19 Nov 2025 09:49:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FBA1195608E;
	Wed, 19 Nov 2025 09:49:36 +0000 (UTC)
Date: Wed, 19 Nov 2025 17:49:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V3 09/27] ublk: add new batch command
 UBLK_U_IO_PREP_IO_CMDS & UBLK_U_IO_COMMIT_IO_CMDS
Message-ID: <aR2SpkBWHm800dmm@fedora>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
 <20251112093808.2134129-10-ming.lei@redhat.com>
 <CADUfDZpoeUF+dAm4AtjzC-+BOwwZr2CnTgcZoPAE_4KNNsmoXw@mail.gmail.com>
 <CADUfDZo0NB39mgp-4zpL63bGi6WtsEsfxZ95Jrj6RBqQ60NZug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZo0NB39mgp-4zpL63bGi6WtsEsfxZ95Jrj6RBqQ60NZug@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Nov 18, 2025 at 06:39:09PM -0800, Caleb Sander Mateos wrote:
> On Tue, Nov 18, 2025 at 6:37 PM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Wed, Nov 12, 2025 at 1:39 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > Add new command UBLK_U_IO_PREP_IO_CMDS, which is the batch version of
> > > UBLK_IO_FETCH_REQ.
> > >
> > > Add new command UBLK_U_IO_COMMIT_IO_CMDS, which is for committing io command
> > > result only, still the batch version.
> > >
> > > The new command header type is `struct ublk_batch_io`, and fixed buffer is
> > > required for these two uring_cmd.
> > >
> > > This patch doesn't actually implement these commands yet, just validates the
> > > SQE fields.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 107 +++++++++++++++++++++++++++++++++-
> > >  include/uapi/linux/ublk_cmd.h |  49 ++++++++++++++++
> > >  2 files changed, 155 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index c62b2f2057fe..5f9d7ec9daa4 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -85,6 +85,11 @@
> > >          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > >          UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > >
> > > +#define UBLK_BATCH_F_ALL  \
> > > +       (UBLK_BATCH_F_HAS_ZONE_LBA | \
> > > +        UBLK_BATCH_F_HAS_BUF_ADDR | \
> > > +        UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
> > > +
> > >  struct ublk_uring_cmd_pdu {
> > >         /*
> > >          * Store requests in same batch temporarily for queuing them to
> > > @@ -108,6 +113,12 @@ struct ublk_uring_cmd_pdu {
> > >         u16 tag;
> > >  };
> > >
> > > +struct ublk_batch_io_data {
> > > +       struct ublk_device *ub;
> > > +       struct io_uring_cmd *cmd;
> > > +       struct ublk_batch_io header;
> > > +};
> > > +
> > >  /*
> > >   * io command is active: sqe cmd is received, and its cqe isn't done
> > >   *
> > > @@ -2520,10 +2531,104 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
> > >         return ublk_ch_uring_cmd_local(cmd, issue_flags);
> > >  }
> > >
> > > +static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
> > > +{
> > > +       const u16 mask = UBLK_BATCH_F_HAS_BUF_ADDR | UBLK_BATCH_F_HAS_ZONE_LBA;
> > > +       const unsigned header_len = sizeof(struct ublk_elem_header);
> > > +
> > > +       if (uc->flags & ~UBLK_BATCH_F_ALL)
> > > +               return -EINVAL;
> > > +
> > > +       /* UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK requires buffer index */
> > > +       if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
> > > +                       (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR))
> > > +               return -EINVAL;
> > > +
> > > +       switch (uc->flags & mask) {
> > > +       case 0:
> > > +               if (uc->elem_bytes != header_len)
> > > +                       return -EINVAL;
> > > +               break;
> > > +       case UBLK_BATCH_F_HAS_ZONE_LBA:
> > > +       case UBLK_BATCH_F_HAS_BUF_ADDR:
> > > +               if (uc->elem_bytes != header_len + sizeof(u64))
> > > +                       return -EINVAL;
> > > +               break;
> > > +       case UBLK_BATCH_F_HAS_ZONE_LBA | UBLK_BATCH_F_HAS_BUF_ADDR:
> > > +               if (uc->elem_bytes != header_len + sizeof(u64) + sizeof(u64))
> > > +                       return -EINVAL;
> > > +               break;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data)
> > > +{
> > > +
> > > +       const struct ublk_batch_io *uc = &data->header;
> > > +
> > > +       if (!(data->cmd->flags & IORING_URING_CMD_FIXED))
> > > +               return -EINVAL;
> > > +
> > > +       if (uc->nr_elem * uc->elem_bytes > data->cmd->sqe->len)
> >
> > sqe->len should be accessed with READ_ONCE() since it may point to
> > user-mapped memory.
> 
> Actually, is there any point in this check since sqe->len is no longer
> used anywhere?

Right, will remove it in next version.


Thanks, 
Ming

