Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ADE15E5D4
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471016; cv=none; b=bDF1XLDF1uIatgFX5voK4bUW4X8i8Q8bhE1vqzvLexbXn7GZuXWz63GKmXqF6teYH652olTnj7IC61UKnX+y8zPNJDKOuQW4hGBRkIB+idEBX6A5C2CLnLkYSGE0jfv6f/G0Q2QU/aj5XJ4JgJYe18/ReCkX1+OMvDAoizhJKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471016; c=relaxed/simple;
	bh=N7lJQ1NEFlUaZsR1JW3bVBmcp1SscR/9BMXuHhsIF7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJ6uRHaJKYuSEOg4Q0YDgOIK4KazQmOMXWwbiB3k0v1aC/K1B5oZFT/5IIGc/VNF/YyiH+DDKByHU4Dn+JjaVvfzoso8vur/Dz7ciJzsCI8lrSm5hl2sOW3WXnyoF4F7cJ1GXCgFECPoFJmG5PSvDOTg4Y0v+WxRc1KImGDkc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhX+7nMQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhX+7nMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757471013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5nZTC725hmekpjW2szbzTQxpvhfx6xMp4UpuLwt734=;
	b=NhX+7nMQdUsMuwbK414ltzu9eozS7/pKmg3PLJJ5L73bp8Bw3yHBdMMh7WCYh7a+AtnI4r
	bQBBKq+0Oj9xiCMbGpEYfyxIUDGccPPYtFpRD7MmogGpJ+ghDBtnoOilsFpkTLtOSqYIjM
	XwpIt86Fsit5yvt+c4yTFrOP6fuLw1g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-qVr18EMoPPOcmUHQXUzfMg-1; Tue,
 09 Sep 2025 22:23:31 -0400
X-MC-Unique: qVr18EMoPPOcmUHQXUzfMg-1
X-Mimecast-MFC-AGG-ID: qVr18EMoPPOcmUHQXUzfMg_1757471010
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47D4A180034A;
	Wed, 10 Sep 2025 02:23:30 +0000 (UTC)
Received: from fedora (unknown [10.72.120.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53D93300018D;
	Wed, 10 Sep 2025 02:23:25 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:23:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 03/23] ublk: refactor auto buffer register in
 ublk_dispatch_req()
Message-ID: <aMDhGBhYvmuRg20C@fedora>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
 <20250901100242.3231000-4-ming.lei@redhat.com>
 <CADUfDZqfFC__Y7uqE4LDUsKmWwM=Fyiyh4KMNL-OE+iw059g7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqfFC__Y7uqE4LDUsKmWwM=Fyiyh4KMNL-OE+iw059g7Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 02, 2025 at 09:41:55PM -0700, Caleb Sander Mateos wrote:
> On Mon, Sep 1, 2025 at 3:03 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Refactor auto buffer register code and prepare for supporting batch IO
> > feature, and the main motivation is to put 'ublk_io' operation code
> > together, so that per-io lock can be applied for the code block.
> >
> > The key changes are:
> > - Rename ublk_auto_buf_reg() as ublk_do_auto_buf_reg()
> 
> Thanks, the type and the function having the same name was a minor annoyance.
> 
> > - Introduce an enum `auto_buf_reg_res` to represent the result of
> >   the buffer registration attempt (FAIL, FALLBACK, OK).
> > - Split the existing `ublk_do_auto_buf_reg` function into two:
> >   - `__ublk_do_auto_buf_reg`: Performs the actual buffer registration
> >     and returns the `auto_buf_reg_res` status.
> >   - `ublk_do_auto_buf_reg`: A wrapper that calls the internal function
> >     and handles the I/O preparation based on the result.
> > - Introduce `ublk_prep_auto_buf_reg_io` to encapsulate the logic for
> >   preparing the I/O for completion after buffer registration.
> > - Pass the `tag` directly to `ublk_auto_buf_reg_fallback` to avoid
> >   recalculating it.
> >
> > This refactoring makes the control flow clearer and isolates the different
> > stages of the auto buffer registration process.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 65 +++++++++++++++++++++++++++-------------
> >  1 file changed, 44 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 9185978abeb7..e53f623b0efe 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1205,17 +1205,36 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
> >  }
> >
> >  static void
> > -ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk_io *io)
> > +ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, unsigned tag)
> >  {
> > -       unsigned tag = io - ubq->ios;
> 
> The reason to calculate the tag like this was to avoid the pointer
> dereference in req->tag. But req->tag is already accessed just prior
> in ublk_dispatch_req(), so it should be cached and not too expensive
> to load again.

Ok, one thing is that ublk_auto_buf_reg_fallback() should be called in slow
path...

> 
> >         struct ublksrv_io_desc *iod = ublk_get_iod(ubq, tag);
> >
> >         iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
> >  }
> >
> > -static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
> > -                             struct ublk_io *io, struct io_uring_cmd *cmd,
> > -                             unsigned int issue_flags)
> > +enum auto_buf_reg_res {
> > +       AUTO_BUF_REG_FAIL,
> > +       AUTO_BUF_REG_FALLBACK,
> > +       AUTO_BUF_REG_OK,
> > +};
> 
> nit: move this enum definition next to the function that returns it?

Yeah, good point.

> 
> > +
> > +static void ublk_prep_auto_buf_reg_io(const struct ublk_queue *ubq,
> > +                                  struct request *req, struct ublk_io *io,
> > +                                  struct io_uring_cmd *cmd, bool registered)
> 
> How about passing enum auto_buf_reg_res instead of bool registered to
> avoid the duplicated == AUTO_BUF_REG_OK in the callers?

OK, either way is fine for me.

> 
> > +{
> > +       if (registered) {
> > +               io->task_registered_buffers = 1;
> > +               io->buf_ctx_handle = io_uring_cmd_ctx_handle(cmd);
> > +               io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
> > +       }
> > +       ublk_init_req_ref(ubq, io);
> > +       __ublk_prep_compl_io_cmd(io, req);
> > +}
> > +
> > +static enum auto_buf_reg_res
> > +__ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
> > +                      struct ublk_io *io, struct io_uring_cmd *cmd,
> > +                      unsigned int issue_flags)
> >  {
> >         int ret;
> >
> > @@ -1223,29 +1242,27 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
> >                                       io->buf.auto_reg.index, issue_flags);
> >         if (ret) {
> >                 if (io->buf.auto_reg.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
> > -                       ublk_auto_buf_reg_fallback(ubq, io);
> > -                       return true;
> > +                       ublk_auto_buf_reg_fallback(ubq, req->tag);
> > +                       return AUTO_BUF_REG_FALLBACK;
> >                 }
> >                 blk_mq_end_request(req, BLK_STS_IOERR);
> > -               return false;
> > +               return AUTO_BUF_REG_FAIL;
> >         }
> >
> > -       io->task_registered_buffers = 1;
> > -       io->buf_ctx_handle = io_uring_cmd_ctx_handle(cmd);
> > -       io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
> > -       return true;
> > +       return AUTO_BUF_REG_OK;
> >  }
> >
> > -static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
> > -                                  struct request *req, struct ublk_io *io,
> > -                                  struct io_uring_cmd *cmd,
> > -                                  unsigned int issue_flags)
> > +static void ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
> > +                                struct ublk_io *io, struct io_uring_cmd *cmd,
> > +                                unsigned int issue_flags)
> >  {
> > -       ublk_init_req_ref(ubq, io);
> > -       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> > -               return ublk_auto_buf_reg(ubq, req, io, cmd, issue_flags);
> > +       enum auto_buf_reg_res res = __ublk_do_auto_buf_reg(ubq, req, io, cmd,
> > +                       issue_flags);
> >
> > -       return true;
> > +       if (res != AUTO_BUF_REG_FAIL) {
> > +               ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res == AUTO_BUF_REG_OK);
> > +               io_uring_cmd_done(cmd, UBLK_IO_RES_OK, 0, issue_flags);
> > +       }
> >  }
> >
> >  static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
> > @@ -1318,8 +1335,14 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
> >         if (!ublk_start_io(ubq, req, io))
> >                 return;
> >
> > -       if (ublk_prep_auto_buf_reg(ubq, req, io, io->cmd, issue_flags))
> > +       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
> > +               struct io_uring_cmd *cmd = io->cmd;
> 
> Don't really see the need for this intermediate variable

Yes, will remove it, but the big thing is that there isn't io->cmd for BATCH_IO
any more.


Thanks, 
Ming

