Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5735970F
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769654411; cv=none; b=DOgo1tVXE8lhUWZk0Kpdzoe9yC6glq1OaX9fBuupPmRYWzpRgYHsBBbDq15gI+Bm6T1QnLNDEU7cfmGFpPxNRN/eYhfF9BfNQdvvs9i3xHOfyMvIYysE1Vsw80kMBJGEimLiqC4HHsd9UjvaIICy/nHqbbUmFC04GuQ7jj/1vO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769654411; c=relaxed/simple;
	bh=S3zfKGGjnnX5JYcUqr7E/4Z+DinBSD6FPgBBGDJPKrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liN0q8ccZ1R68hm50E3C/oVPs5UGfcxamYngR21J65njpOXHqbwNgXlCD4qN+nI/mMgh716OloCHaoOrvHeXzprf2LLOO4O7Wiy3TZJF+2MOlSsgNxB/tq1iP2qBeCPh+IC4QELsWjqZew7b9qTm+RGqh8RKvXdo7URn373lrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcVdg8t8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcVdg8t8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769654401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hzn8xt/VC7xP73OrFJshmnid6BYmsG+xL4LmDDIC3KU=;
	b=HcVdg8t8SNg9VFGUr7avKRAgme4/UrlZFmntiGXOdiwf7wLXERrE2x0fzMWkiqsFcSHpCg
	8lZggY1hDjeA7jEN/b7wUtDuQH59bktB3fLE0HKVvmy8fD1DkqOi/PXtlHJfmFE7S5T+TK
	DB5YSIfM0lmpOg3L/fZFrOSG2HdQPF8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-mrHtw6-ANXW2t55HevyW0A-1; Wed,
 28 Jan 2026 21:39:58 -0500
X-MC-Unique: mrHtw6-ANXW2t55HevyW0A-1
X-Mimecast-MFC-AGG-ID: mrHtw6-ANXW2t55HevyW0A_1769654397
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2EBB1800447;
	Thu, 29 Jan 2026 02:39:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.182])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37DA21800994;
	Thu, 29 Jan 2026 02:39:52 +0000 (UTC)
Date: Thu, 29 Jan 2026 10:39:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: restore auto buf unregister refcount optimization
Message-ID: <aXrIc3pZ-h_hME8_@fedora>
References: <20260128205636.4003327-1-csander@purestorage.com>
 <CADUfDZqH9NZrQGOkYP9cpWRVkhPT9uiPc3XUfW6X4G=97oeE9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqH9NZrQGOkYP9cpWRVkhPT9uiPc3XUfW6X4G=97oeE9w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Jan 28, 2026 at 01:08:17PM -0800, Caleb Sander Mateos wrote:
> On Wed, Jan 28, 2026 at 12:56 PM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > Commit 1ceeedb59749 ("ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon
> > task") optimized ublk request buffer unregistration to use a non-atomic
> > reference count decrement when performed on the ublk_io's daemon task.
> > The optimization applied to auto buffer unregistration, which happens as
> > part of handling UBLK_IO_COMMIT_AND_FETCH_REQ on the daemon task.
> > However, commit b749965edda8 ("ublk: remove ublk_commit_and_fetch()")
> > reordered the ublk_sub_req_ref() for the completed request before the
> > io_buffer_unregister_bvec() call. As a result, task_registered_buffers
> > is already 0 when io_buffer_unregister_bvec() calls ublk_io_release()
> > and the non-atomic refcount optimization doesn't apply.
> > Move the io_buffer_unregister_bvec() call back to before
> > ublk_need_complete_req() to restore the reference counting optimization.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > Fixes: b749965edda8 ("ublk: remove ublk_commit_and_fetch()")
> > ---
> >  drivers/block/ublk_drv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 7981decd1cee..f864a0f2f572 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -3243,15 +3243,15 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
> >                 if (ret)
> >                         goto out;
> >                 io->res = result;
> >                 req = ublk_fill_io_cmd(io, cmd);
> >                 ret = ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
> > +               if (buf_idx != UBLK_INVALID_BUF_IDX)
> > +                       io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
> >                 compl = ublk_need_complete_req(ub, io);
> >
> >                 /* can't touch 'ublk_io' any more */
> > -               if (buf_idx != UBLK_INVALID_BUF_IDX)
> > -                       io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
> >                 if (req_op(req) == REQ_OP_ZONE_APPEND)
> >                         req->__sector = addr;
> >                 if (compl)
> >                         __ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
> 
> I also noticed that the "can't touch 'ublk_io' any more" comment
> doesn't make much sense, as __ublk_complete_rq() still accesses (and
> even mutates) the struct ublk_io. Am I misunderstanding the comment?

Yes, it can be removed, originally this code block may be reused for
BATCH_IO, but finally it doesn't work toward this way, so can you remove
it in this patch given it is introduced in b749965edda8 ("ublk: remove ublk_commit_and_fetch()")?

> It looks like this might be a race condition for
> UBLK_U_IO_COMMIT_IO_CMDS, as __ublk_complete_rq() is called without
> holding the ublk_io spinlock.

It is actually fine for __ublk_complete_rq() to manipulate io->res lockless:

1) UBLK_IO_FLAG_OWNED_BY_SRV is cleared & checked with io->lock, so any new
UBLK_U_IO_COMMIT_IO_CMDS will be failed

2) the current IO request isn't completed yet, so new io command handling
won't be started.


Thanks,
Ming

