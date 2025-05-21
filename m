Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69C148827
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747791737; cv=none; b=rXaV4iNDvY5MVl3sIiSKTlgViPTWdE9U6EOURHzAr3tA9T4H4sv/jhrOrR4Bq6JdXVlVtkSnOXaQPHaRQjbHynSvKGi+HDJ0WhF8jsO7VqdqusXn7O8Xw3316uYVte1fT2hHiu81YD67MXAIvajHLtMuCKiQIu3ycmINj08xhOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747791737; c=relaxed/simple;
	bh=MhMLsi2eNIZ43j4QiBsTiTUc0Grb7qVaIxPJrSdrGDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiblVMMaB6gEeoZETY50KV2iPr76pYCtEpVbdV8XcNLgJb9j0LcwaRXCFiVtL/vrNTgtclsjKN1wSbTa+4ZQwMnaddf/gMR313ttnQutxpJUdjfjvrCbYqQ20U91wpXrZOGyl397wuKW9CvgbqKkn/5uCXfl2aTajU2tzqw1KTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3ZAHlz+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3ZAHlz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gek8JT1U5e2kAe6UT9wBM59+Qvm6pXCJ8M1w/o9kzd8=;
	b=O3ZAHlz+GBvD/fHozfI2yroB39m0KXvfZ77amcdPvl015B6HHLHob/wszuJgCl3ipg+8+A
	ymteCZKfoS8A6Og140Wn9T/gwkIi+cPNjDuWy/qHpDuDimRPksudVUkhF2e+loTJMefuCF
	XI4ObAsw8bF4rdkCy4zUwqU4xflqa4w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-00u3mfQUO06Yn4jwAt9W1w-1; Tue,
 20 May 2025 21:42:10 -0400
X-MC-Unique: 00u3mfQUO06Yn4jwAt9W1w-1
X-Mimecast-MFC-AGG-ID: 00u3mfQUO06Yn4jwAt9W1w_1747791729
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6D0C195608C;
	Wed, 21 May 2025 01:42:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.109])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5ADAA19560A3;
	Wed, 21 May 2025 01:42:05 +0000 (UTC)
Date: Wed, 21 May 2025 09:42:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V5 2/6] ublk: prepare for supporting to register request
 buffer automatically
Message-ID: <aC0vabQ_jm2b8hfq@fedora>
References: <20250520045455.515691-1-ming.lei@redhat.com>
 <20250520045455.515691-3-ming.lei@redhat.com>
 <CADUfDZrLLGDf2yYSuuTnbK_WDNQCxUyCbC2bziUg7_BB3vWAtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrLLGDf2yYSuuTnbK_WDNQCxUyCbC2bziUg7_BB3vWAtA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, May 20, 2025 at 10:40:01AM -0700, Caleb Sander Mateos wrote:
> On Mon, May 19, 2025 at 9:55 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > UBLK_F_SUPPORT_ZERO_COPY requires ublk server to issue explicit buffer
> > register/unregister uring_cmd for each IO, this way is not only inefficient,
> > but also introduce dependency between buffer consumer and buffer register/
> > unregister uring_cmd, please see tools/testing/selftests/ublk/stripe.c
> > in which backing file IO has to be issued one by one by IOSQE_IO_LINK.
> >
> > Prepare for adding feature UBLK_F_AUTO_BUF_REG for addressing the existing
> > zero copy limitation:
> >
> > - register request buffer automatically to ublk uring_cmd's io_uring
> >   context before delivering io command to ublk server
> >
> > - unregister request buffer automatically from the ublk uring_cmd's
> >   io_uring context when completing the request
> >
> > - io_uring will unregister the buffer automatically when uring is
> >   exiting, so we needn't worry about accident exit
> >
> > For using this feature, ublk server has to create one sparse buffer table
> >
> > Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 70 ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 64 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index ae2f47dc8224..3e56a9d267fb 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -133,6 +133,14 @@ struct ublk_uring_cmd_pdu {
> >   */
> >  #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
> >
> > +/*
> > + * request buffer is registered automatically, so we have to unregister it
> > + * before completing this request.
> > + *
> > + * io_uring will unregister buffer automatically for us during exiting.
> > + */
> > +#define UBLK_IO_FLAG_AUTO_BUF_REG      0x10
> > +
> >  /* atomic RW with ubq->cancel_lock */
> >  #define UBLK_IO_FLAG_CANCELED  0x80000000
> >
> > @@ -205,6 +213,7 @@ struct ublk_params_header {
> >         __u32   types;
> >  };
> >
> > +static void ublk_io_release(void *priv);
> >  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> >  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> >  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> > @@ -619,6 +628,11 @@ static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
> >         return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
> >  }
> >
> > +static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
> > +{
> > +       return false;
> > +}
> > +
> >  static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
> >  {
> >         return ubq->flags & UBLK_F_USER_COPY;
> > @@ -626,7 +640,8 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
> >
> >  static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
> >  {
> > -       return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq);
> > +       return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq) &&
> > +               !ublk_support_auto_buf_reg(ubq);
> >  }
> >
> >  static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
> > @@ -637,8 +652,13 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
> >          *
> >          * for zero copy, request buffer need to be registered to io_uring
> >          * buffer table, so reference is needed
> > +        *
> > +        * For auto buffer register, ublk server still may issue
> > +        * UBLK_IO_COMMIT_AND_FETCH_REQ before one registered buffer is used up,
> > +        * so reference is required too.
> >          */
> > -       return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq);
> > +       return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq) ||
> > +               ublk_support_auto_buf_reg(ubq);
> >  }
> >
> >  static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
> > @@ -1155,6 +1175,35 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
> >                 blk_mq_end_request(rq, BLK_STS_IOERR);
> >  }
> >
> > +static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
> > +                             unsigned int issue_flags)
> > +{
> > +       struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> > +       int ret;
> > +
> > +       ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release, 0,
> > +                                     issue_flags);
> > +       if (ret) {
> > +               blk_mq_end_request(req, BLK_STS_IOERR);
> > +               return false;
> > +       }
> > +       /* one extra reference is dropped by ublk_io_release */
> > +       refcount_set(&data->ref, 2);
> > +       io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
> > +       return true;
> > +}
> > +
> > +static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
> > +                                  struct request *req, struct ublk_io *io,
> > +                                  unsigned int issue_flags)
> > +{
> > +       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> > +               return ublk_auto_buf_reg(req, io, issue_flags);
> > +
> > +       ublk_init_req_ref(ubq, req);
> > +       return true;
> > +}
> > +
> >  static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
> >                           struct ublk_io *io)
> >  {
> > @@ -1180,7 +1229,6 @@ static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
> >                         mapped_bytes >> 9;
> >         }
> >
> > -       ublk_init_req_ref(ubq, req);
> >         return true;
> >  }
> >
> > @@ -1226,7 +1274,8 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
> >         if (!ublk_start_io(ubq, req, io))
> >                 return;
> >
> > -       ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
> > +       if (ublk_prep_auto_buf_reg(ubq, req, io, issue_flags))
> > +               ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
> >  }
> >
> >  static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
> > @@ -1994,7 +2043,8 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> >
> >  static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
> >                                  struct ublk_io *io, struct io_uring_cmd *cmd,
> > -                                const struct ublksrv_io_cmd *ub_cmd)
> > +                                const struct ublksrv_io_cmd *ub_cmd,
> > +                                unsigned int issue_flags)
> >  {
> >         struct request *req = io->req;
> >
> > @@ -2014,6 +2064,14 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
> >                 return -EINVAL;
> >         }
> >
> > +       if (ublk_support_auto_buf_reg(ubq)) {
> > +               if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
> > +                       WARN_ON_ONCE(io_buffer_unregister_bvec(cmd, 0,
> > +                                               issue_flags));
> 
> Since the io_ring_ctx is determined from the io_uring_cmd, this only
> works if the UBLK_IO_COMMIT_AND_FETCH_REQ is submitted to the same
> io_uring as the previous UBLK_IO_(COMMIT_AND_)FETCH_REQ for the ublk
> I/O. It would be good to document that. And I would probably drop the
> WARN_ON_ONCE() here, since it can be triggered from userspace.
> 
> Otherwise,
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

Thanks for the review!

Yeah, I thought of this thing yesterday when working on TASK_NEUTEAL or
IO_MIGRATION too, will send one fix later by tracking context id.



Thanks,
Ming

