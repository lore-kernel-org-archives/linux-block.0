Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F228A3F7
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881495; cv=none; b=jC/VEyKbejcYDynmOR5WjwSV3yJjdr9hW51HvhjgkNIRfj0RaZzNoitiqvbGiHvMhnJAc7HOfQ1DOHkD98LOpEpXJ89q59wG7vSUwSqDlw9ql8Wp1P/prco8LXDEWQ8KF9vNY1xd1iXL0brlOMjc7vSg5naeyqkhVjVmqJMYpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881495; c=relaxed/simple;
	bh=27kPDHNu5ioHNBIDG3RGc2ZItUClnEI4MI6px4NQQY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+waGIqufKXZGEBosirlmVe2YCSbAoNjkUqVvDVVMlP5rZnxfZ0FUNPHpZIlbeHZnzaMpRF/azv/XqTe1Y7TJnF3LOGUM4crL1lZrXmZm3HZ+puK4rjanoOMAlw++FhG6tf1eoiz/lWQNr3raF1JNmNTdv/jiknuXQTW8f6ANHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PO2jazvS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PO2jazvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751881492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/q/AxiC8BPDCr7vW3PgW92g3apgii+JmJcKYGFYmhY=;
	b=PO2jazvSSt1jjTbrh9/vX/oYYuZNDEOhVfLhC9u3aUngCqX2jAWGLvSPNkDEZnhBscQp0N
	2Zeo4MchnuKP7YregmyAVsCyDMDboxHFQmugC3taTtceZaZb0DPbX9XorcEZ/5D2pjbO1N
	O/o1kfsOkO8Q8ac9GbpPFl5TMCZ0yls=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-25j0m1p7O1CaKrg0i_Xy0w-1; Mon,
 07 Jul 2025 05:44:49 -0400
X-MC-Unique: 25j0m1p7O1CaKrg0i_Xy0w-1
X-Mimecast-MFC-AGG-ID: 25j0m1p7O1CaKrg0i_Xy0w_1751881488
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C820A19560BE;
	Mon,  7 Jul 2025 09:44:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.160])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A29318046C5;
	Mon,  7 Jul 2025 09:44:44 +0000 (UTC)
Date: Mon, 7 Jul 2025 17:44:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 05/16] ublk: move auto buffer register handling into one
 dedicated helper
Message-ID: <aGuXBzbLEreWzNJ_@fedora>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
 <20250702040344.1544077-6-ming.lei@redhat.com>
 <CADUfDZpaNOqvqwMNUi_YavV9nHc8tkmPhZHKkx7UVk3W=Pbn6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpaNOqvqwMNUi_YavV9nHc8tkmPhZHKkx7UVk3W=Pbn6w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Jul 03, 2025 at 04:19:50PM -0400, Caleb Sander Mateos wrote:
> On Wed, Jul 2, 2025 at 12:04 AM Ming Lei <ming.lei@redhat.com> wrote:
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
> >  drivers/block/ublk_drv.c | 132 ++++++++++++++++++++++-----------------
> >  1 file changed, 76 insertions(+), 56 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 1780f9ce3a24..ba1b2672e7a8 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -48,6 +48,8 @@
> >
> >  #define UBLK_MINORS            (1U << MINORBITS)
> >
> > +#define UBLK_INVALID_BUF_IDX   ((unsigned short)-1)
> 
> u16?

Yeah.

> 
> > +
> >  /* private ioctl command mirror */
> >  #define UBLK_CMD_DEL_DEV_ASYNC _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
> >  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> > @@ -1983,16 +1985,53 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
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
> > +               if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd) &&
> > +                               buf_idx)
> 
> Not sure the buf_idx check here is necessary. This io->flags &
> UBLK_IO_FLAG_AUTO_BUF_REG path should only be reachable from
> ublk_commit_and_fetch(), not ublk_fetch() or UBLK_IO_NEED_GET_DATA.

Good catch, UBLK_IO_FLAG_AUTO_BUF_REG can only be set from
ublk_commit_and_fetch(), will fix it in next version.


Thanks,
Ming

