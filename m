Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2E34B697
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155819; cv=none; b=YU/pXM6YHyWuL/xX677pCgoetaGV3JZ3cpQx1GBZy4bx8Vxrq6Yi9NKnbGv465efxv/wVAYDkOX7PIQUXqgqOVtxKZPMEJINRVKJdVgfUwi0ernE1KqsT7rPXpcWWBGdANaHH2SENHlOL0zALVF2ZxPssoFZZR+uGl3xVC2Dsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155819; c=relaxed/simple;
	bh=Ug+cK5jN/M8ellkQcNc1f+fwm7teU76UpPmc2H8n/E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E37eUR9DT1rUQjJferK5oQkHaLl0+Zy/x5wa/oUW8YjEZ6QL1F3y7PtbymWu0AVs/E7Fq7Ik929eeXY6Ae9zSPZSlCddoU6X9zP+H2d3pCoObitF6Z6GY85j4+WR2q2ar02tVHdO6cSAeMgGr/HoFT16xyBzaUSN3019RzIEtNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QckCu4SY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QckCu4SY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769155816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8m3aPj//q6I+eduAIT6csbcyQZCPkPTUCoY2xsRL2pM=;
	b=QckCu4SYLjY0FqSrpO0kyAwn8pP9q1SSJB0b7lAaX+0D/bfdjRbF5YgwBE0X3JZFQyvqIh
	Mpa/P5+KEk93jJHdnXc+uRidWHE62MvTapPtLLJZlgzbRrpSmT7L8gcBiVfFzD3YCVzxGl
	LBAT59fNLvOoH0ZrpBxLOR/ewGOfxBU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-FWeRBKWTOvqyefkuagZi5A-1; Fri,
 23 Jan 2026 03:10:13 -0500
X-MC-Unique: FWeRBKWTOvqyefkuagZi5A-1
X-Mimecast-MFC-AGG-ID: FWeRBKWTOvqyefkuagZi5A_1769155812
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D281B19775A3;
	Fri, 23 Jan 2026 08:10:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A3131958DC1;
	Fri, 23 Jan 2026 08:10:07 +0000 (UTC)
Date: Fri, 23 Jan 2026 16:10:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V6 07/24] ublk: add batch I/O dispatch infrastructure
Message-ID: <aXMs2q9nGO4yehYt@fedora>
References: <20260116141859.719929-1-ming.lei@redhat.com>
 <20260116141859.719929-8-ming.lei@redhat.com>
 <a56a1182-72da-47ff-98fc-d1d33afcd557@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56a1182-72da-47ff-98fc-d1d33afcd557@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jan 22, 2026 at 08:32:25PM -0700, Jens Axboe wrote:
> Claude says:
> 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index e5db5a552357..e7bd7e7b1731 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> 
> [ ... ]
> 
> > +static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
> > +				       const struct ublk_batch_io_data *data,
> > +				       unsigned short tag)
> > +{
> > +	struct ublk_device *ub = data->ub;
> > +	struct ublk_io *io = &ubq->ios[tag];
> > +	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
> > +	enum auto_buf_reg_res res = AUTO_BUF_REG_FALLBACK;
> > +	struct io_uring_cmd *cmd = data->cmd;
> > +
> > +	if (!ublk_start_io(ubq, req, io))
> > +		return false;
> > +
> > +	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
> > +		res = __ublk_do_auto_buf_reg(ubq, req, io, cmd,
> > +				data->issue_flags);
> > +
> > +		if (res == AUTO_BUF_REG_FAIL)
> > +			return false;
> > +	}
> > +
> > +	ublk_io_lock(io);
> > +	ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
> > +	ublk_io_unlock(io);
> > +
> > +	return true;
> > +}
> 
> [ ... ]
> 
> > +#define MAX_NR_TAG 128
> > +static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> > +				 const struct ublk_batch_io_data *data,
> > +				 struct ublk_batch_fetch_cmd *fcmd)
> > +{
> 
> [ ... ]
> 
> > +	sel.val = ublk_batch_copy_io_tags(fcmd, sel.addr, tag_buf, len * tag_sz);
> > +	ret = ublk_batch_fetch_post_cqe(fcmd, &sel, data->issue_flags);
> > +	if (unlikely(ret < 0)) {
> > +		int i, res;
> > +
> > +		/*
> > +		 * Undo prep state for all IOs since userspace never received them.
> > +		 * This restores IOs to pre-prepared state so they can be cleanly
> > +		 * re-prepared when tags are pulled from FIFO again.
> > +		 */
> > +		for (i = 0; i < len; i++) {
> > +			struct ublk_io *io = &ubq->ios[tag_buf[i]];
> > +			int index = -1;
> > +
> > +			ublk_io_lock(io);
> > +			if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
> > +				index = io->buf.auto_reg.index;
> > +			io->flags &= ~(UBLK_IO_FLAG_OWNED_BY_SRV | UBLK_IO_FLAG_AUTO_BUF_REG);
> > +			io->flags |= UBLK_IO_FLAG_ACTIVE;
> > +			ublk_io_unlock(io);
> > +
> > +			if (index != -1)
> > +				io_buffer_unregister_bvec(data->cmd, index,
> > +						data->issue_flags);
> > +		}
> 
> Should io->task_registered_buffers also be cleared here?

No, io_buffer_unregister_bvec() and the callback(ublk_io_release()) consumes
io->task_registered_buffers actually.



Thanks,
Ming

