Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C52D8DC4
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062223; cv=none; b=TP8Y7HKkpxSBKALdkziNt9tsl3WRx/nKuUwaNdhOTwQJdXeBIyzTQChOSUBs2fhjUzUndnTb4NJ6C5WD+q0KtqgYu5bVqu546POHQwo69qfSaZXYA1CNK3/ZYOdeHJ+GNtbBV+a3CVXxphFiL7ZkjtkbWqqn7tzi6dUZWc+6Grc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062223; c=relaxed/simple;
	bh=qFGbZT07CgcWK41hDsUpz62EpYLLM+dGrg4reJVV5X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI5CqLQIChHsuYVEkpW4uULgrOl028sBAWVw+NHwID9E8FISYR0UgfXf/Zjay+8xRgQpGPm1k9ul/qsvx6i6BSJOIKyFJa+UDEp7cSn369Ymxmvm6cSHtPP5zvt/OKSTYdX4LvLKmUx3IA1ad3jJ4AN9stDS8ubnVopNTbC2vP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IX7wosww; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IX7wosww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752062220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vz98EhfbifwMPNpu43xO/mYGZM7FqU1wVuZ4iAUNLc8=;
	b=IX7woswwrld+lmiBjFAkJyF/2uWDY4upKiam8QACBUuRDIS80VNG1qvBaRW0TrdSEps2Ge
	jSBT296V/GhbvfuDwgVsxr2iXe0KSnjl2t3eDqvYNEmpo+kCx+w/exBcTHecNFDUQzGZs/
	9RSz+7y53ZhW3tM30v6s04L/Rn6ZiYs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-lfovo3urPuWu_nyeKK79Qg-1; Wed,
 09 Jul 2025 07:56:59 -0400
X-MC-Unique: lfovo3urPuWu_nyeKK79Qg-1
X-Mimecast-MFC-AGG-ID: lfovo3urPuWu_nyeKK79Qg_1752062218
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0692180136B;
	Wed,  9 Jul 2025 11:56:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.141])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8BD51956089;
	Wed,  9 Jul 2025 11:56:54 +0000 (UTC)
Date: Wed, 9 Jul 2025 19:56:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 08/16] ublk: remove ublk_commit_and_fetch()
Message-ID: <aG5ZAQs4TSHovUyd@fedora>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
 <20250702040344.1544077-9-ming.lei@redhat.com>
 <CADUfDZo9SADywa6a_D5ZjwoU+3Y14CTg7Y1Ywhf-5Hsnu=fCyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZo9SADywa6a_D5ZjwoU+3Y14CTg7Y1Ywhf-5Hsnu=fCyQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Jul 08, 2025 at 09:27:57AM -0400, Caleb Sander Mateos wrote:
> On Wed, Jul 2, 2025 at 12:04 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Remove ublk_commit_and_fetch() and open code request completion.
> >
> > Now request reference is stored in 'ublk_io', which becomes one global
> > variable, the motivation is to centralize access 'struct ublk_io' reference,
> > then we can introduce lock to protect `ublk_io` in future for supporting
> > io batch.
> 
> I didn't follow this. What do you mean by "global variable"?

ublk server can send anything to driver with specified tag if batch io
extension is added and per-io task is relaxed, then 'ublk_io' instance can be
visible to any userpsace command, which needs protection, looks like one
global variable.

If reference is stored in request pdu, things becomes more like local
variable, since the early ublk_io flag check guarantees that concurrent
access can't reach 'request'.

> 
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 36 ++++++++++++++++++------------------
> >  1 file changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 7fd2fa493d6a..13c6b1e0e1ef 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -711,13 +711,12 @@ static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
> >                 __ublk_complete_rq(req);
> >  }
> >
> > -static inline void ublk_sub_req_ref(struct ublk_io *io, struct request *req)
> > +static inline bool ublk_sub_req_ref(struct ublk_io *io, struct request *req)
> >  {
> >         unsigned sub_refs = UBLK_REFCOUNT_INIT - io->task_registered_buffers;
> >
> >         io->task_registered_buffers = 0;
> > -       if (refcount_sub_and_test(sub_refs, &io->ref))
> > -               __ublk_complete_rq(req);
> > +       return refcount_sub_and_test(sub_refs, &io->ref);
> 
> The struct request *req parameter can be removed now. Looks like it
> can be removed from ublk_need_complete_req() too.

Good catch!

> 
> >  }
> >
> >  static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
> > @@ -2224,21 +2223,13 @@ static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
> >         return 0;
> >  }
> >
> > -static void ublk_commit_and_fetch(const struct ublk_queue *ubq,
> > -                                 struct ublk_io *io, struct io_uring_cmd *cmd,
> > -                                 struct request *req, unsigned int issue_flags,
> > -                                 __u64 zone_append_lba, u16 buf_idx)
> > +static bool ublk_need_complete_req(const struct ublk_queue *ubq,
> > +                                  struct ublk_io *io,
> > +                                  struct request *req)
> >  {
> > -       if (buf_idx != UBLK_INVALID_BUF_IDX)
> > -               io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
> > -
> > -       if (req_op(req) == REQ_OP_ZONE_APPEND)
> > -               req->__sector = zone_append_lba;
> > -
> >         if (ublk_need_req_ref(ubq))
> > -               ublk_sub_req_ref(io, req);
> > -       else
> > -               __ublk_complete_rq(req);
> > +               return ublk_sub_req_ref(io, req);
> > +       return true;
> >  }
> >
> >  static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
> > @@ -2271,6 +2262,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> >         unsigned tag = ub_cmd->tag;
> >         struct request *req;
> >         int ret;
> > +       bool compl;
> >
> >         pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
> >                         __func__, cmd->cmd_op, ub_cmd->q_id, tag,
> > @@ -2347,8 +2339,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> >                         goto out;
> >                 req = ublk_fill_io_cmd(io, cmd, ub_cmd->result);
> >                 ret = ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &buf_idx);
> > -               ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
> > -                                     ub_cmd->zone_append_lba, buf_idx);
> > +               compl = ublk_need_complete_req(ubq, io, req);
> > +
> > +               /* can't touch 'ublk_io' any more */
> > +               if (buf_idx != UBLK_INVALID_BUF_IDX)
> > +                       io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
> > +               if (req_op(req) == REQ_OP_ZONE_APPEND)
> > +                       req->__sector = ub_cmd->zone_append_lba;
> > +               if (compl)
> > +                       __ublk_complete_rq(req);
> 
> What is the benefit of separating the reference count decrement from
> the call to __ublk_complete_rq()? I can understand if you want to keep
> the code manipulating ublk_io separate from the code dispatching the
> completed request. But it seems like this could be written more simply
> as
> 
> if (ublk_need_complete_req(ubq, io, req))
>         __ublk_complete_rq(req);

ublk_need_complete_req() has to be protected, but the following code
(buffer unregister, complete req needn't and can't be covered with spin lock).

It is for putting anything needing protection in future together.


Thanks,
Ming

