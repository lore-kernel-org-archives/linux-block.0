Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862D6FC3
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 02:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752374310; cv=none; b=W2w3z7LNOpW4o8quV+GyY/Moc3ghSXG7mlu/GnNWFbazDJ3gweBZENDSaOzZh7AkXPre6nQ6RmOCM/Hzn09yZ+DZahFLWjbcoJ+jEKYCKMiCZjXCQDO1rm+s/1llCB8PpNnUjrApomvD8Qxc+l9oKhjpJtFzeKM1AQGKzzRnjRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752374310; c=relaxed/simple;
	bh=XCH4qywf3hI3hgMxrFX9yAoRCyPIY4uIVFHZfIwOqMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sitk/1MLjhRU6afeYp1SvjGDYCINENI8LoOQUWfOAVsjmcBOsRbevJrM7F21uOvyFvB3s+HrVBkUalC72bMP89ibNExsYMcTXIiiCt9Meo1d7qo9B242MJzMNcM8esZED/i5gfFugU5EifSJa68SnmonC2cGr0+Dw9BEMWbzZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCMkNd0P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCMkNd0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752374307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmiVUBVUYuW3NDZnxa+pcm/SSpIt/+vycvCWgqtMj+8=;
	b=eCMkNd0P91d6qd+zqYTQN4gbU9zwKlG6LDzQESS4Nkm3tYhSsaJsFtzspUmb7ZUBv370mG
	XejnkVmkpNQg0IUICFtQgzZF/9r2nlODpC/3ivnykhsMo+J8snuDFw3H1Y5i5ELLyTwufO
	rizdUuINZmTBuAQixTK0e0lR0yNMlf8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-64R7OAI9OkS7M-BU2tDNZA-1; Sat,
 12 Jul 2025 22:38:23 -0400
X-MC-Unique: 64R7OAI9OkS7M-BU2tDNZA-1
X-Mimecast-MFC-AGG-ID: 64R7OAI9OkS7M-BU2tDNZA_1752374302
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B80D6180047F;
	Sun, 13 Jul 2025 02:38:22 +0000 (UTC)
Received: from fedora (unknown [10.72.116.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D8AE3000225;
	Sun, 13 Jul 2025 02:38:18 +0000 (UTC)
Date: Sun, 13 Jul 2025 10:38:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V2 05/16] ublk: move auto buffer register handling into
 one dedicated helper
Message-ID: <aHMcFY96ZREasty8@fedora>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
 <20250708011746.2193389-6-ming.lei@redhat.com>
 <CADUfDZqZTJmz4bN99P6tRTL__8Uu6Lt=qLwwOFB2yTMb=XiBfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqZTJmz4bN99P6tRTL__8Uu6Lt=qLwwOFB2yTMb=XiBfg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jul 11, 2025 at 09:47:56AM -0400, Caleb Sander Mateos wrote:
> On Mon, Jul 7, 2025 at 9:18 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Move check & clearing UBLK_IO_FLAG_AUTO_BUF_REG to
> > ublk_handle_auto_buf_reg(), also return buffer index from this helper.
> >
> > Also move ublk_set_auto_buf_reg() to this single helper too.
> >
> > Add ublk_config_io_buf() for setting up ublk io buffer, covers both
> > ublk buffer copy or auto buffer register.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 131 ++++++++++++++++++++++-----------------
> >  1 file changed, 75 insertions(+), 56 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 41248b0d1182..dab02a8be41a 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -48,6 +48,8 @@
> >
> >  #define UBLK_MINORS            (1U << MINORBITS)
> >
> > +#define UBLK_INVALID_BUF_IDX   ((u16)-1)
> > +
> >  /* private ioctl command mirror */
> >  #define UBLK_CMD_DEL_DEV_ASYNC _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
> >  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> > @@ -2002,16 +2004,52 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
> >         return 0;
> >  }
> >
> > +static inline int ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
> > +{
> > +       struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > +
> > +       pdu->buf = ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
> > +
> > +       if (pdu->buf.reserved0 || pdu->buf.reserved1)
> > +               return -EINVAL;
> > +
> > +       if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
> > +               return -EINVAL;
> > +       return 0;
> > +}
> > +
> > +static int ublk_handle_auto_buf_reg(struct ublk_io *io,
> > +                                   struct io_uring_cmd *cmd,
> > +                                   u16 *buf_idx)
> > +{
> > +       if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
> > +               io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
> > +
> > +               /*
> > +                * `UBLK_F_AUTO_BUF_REG` only works iff `UBLK_IO_FETCH_REQ`
> > +                * and `UBLK_IO_COMMIT_AND_FETCH_REQ` are issued from same
> > +                * `io_ring_ctx`.
> > +                *
> > +                * If this uring_cmd's io_ring_ctx isn't same with the
> > +                * one for registering the buffer, it is ublk server's
> > +                * responsibility for unregistering the buffer, otherwise
> > +                * this ublk request gets stuck.
> > +                */
> > +               if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
> > +                       *buf_idx = io->buf_index;
> > +       }
> > +
> > +       return ublk_set_auto_buf_reg(cmd);
> > +}
> > +
> >  /* Once we return, `io->req` can't be used any more */
> >  static inline struct request *
> > -ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd,
> > -                unsigned long buf_addr, int result)
> > +ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd, int result)
> >  {
> >         struct request *req = io->req;
> >
> >         io->cmd = cmd;
> >         io->flags |= UBLK_IO_FLAG_ACTIVE;
> > -       io->addr = buf_addr;
> >         io->res = result;
> >
> >         /* now this cmd slot is owned by ublk driver */
> > @@ -2020,6 +2058,22 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd,
> >         return req;
> >  }
> >
> > +static inline int
> > +ublk_config_io_buf(const struct ublk_queue *ubq, struct ublk_io *io,
> > +                  struct io_uring_cmd *cmd, unsigned long buf_addr,
> > +                  u16 *buf_idx)
> > +{
> > +       if (ublk_support_auto_buf_reg(ubq)) {
> > +               int ret = ublk_handle_auto_buf_reg(io, cmd, buf_idx);
> > +
> > +               if (ret)
> > +                       return ret;
> 
> I mentioned this before, but just return ublk_handle_auto_buf_reg(io,
> cmd, buf_idx) to avoid the intermediate variable?

Will do it in next version.


Thanks,
Ming

