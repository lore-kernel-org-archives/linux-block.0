Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6F2563
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615923; cv=none; b=jSAG4NVrGZeITmDnu3o+1mOhiaFmN3iA75tWWiQGrA+4z/MJTEpCVOZRizLFdm0kircO61URz1bOrzLTRQrQEoc5RHXYhuCa9HSouhSfA9u5ZvX3bdBs1ok3HS6vshbEKhhFl/peMkrTLlRBTjIotS+RJLX72eaQT4poP9uI9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615923; c=relaxed/simple;
	bh=xfxO5f3SaaWSCzedr4Qrpy5t3DN3009tDqOgDwP1BiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7BoI9WtY7fkE80X8Frt5+fEM2JfkcNUqrvvrIvodbL84YsB4NK1jvcFNZ2oABDk/MoKSxa8d+qEMH66l+4zuLt4sO7JF6S+z9vdkKM98TzUCJJ0S8jxKjngpHQE7wr5LiLKY7pXPQUEUIsnSbWczkvACfk12crHQb62LdkIoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+YKHTnu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+YKHTnu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740615920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNjZSG9VYIK67lUJC2qFm+MVqGoqkKRhIJoW7H5gEqA=;
	b=X+YKHTnu2G0gyxUWxMU5tQebTsJgDVYMj7+eec6fXusETMibMTry6ctBn2xS9L8DWUL/fR
	Yeg/FT0D2R2hTnI1y4mhYHs8ouOotVrU9xcilfIXno9YcwzBt79BDtytiIJdoZsztu27aV
	MjcaQGAmUnmGEz8eLNQcA/CUW2WycVo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-jS_HZGrhPKKgbX9Hye7kww-1; Wed,
 26 Feb 2025 19:25:15 -0500
X-MC-Unique: jS_HZGrhPKKgbX9Hye7kww-1
X-Mimecast-MFC-AGG-ID: jS_HZGrhPKKgbX9Hye7kww_1740615914
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E90CA18EAA85;
	Thu, 27 Feb 2025 00:25:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.7])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 651D7180094B;
	Thu, 27 Feb 2025 00:25:08 +0000 (UTC)
Date: Thu, 27 Feb 2025 08:25:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH V2 3/3] selftests: ublk: add ublk zero copy test
Message-ID: <Z7-w3PAczKYn-d6s@fedora>
References: <20250226155841.2489284-1-ming.lei@redhat.com>
 <20250226155841.2489284-4-ming.lei@redhat.com>
 <Z79SV8gD1hah9PVD@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z79SV8gD1hah9PVD@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Feb 26, 2025 at 10:41:43AM -0700, Keith Busch wrote:
> On Wed, Feb 26, 2025 at 11:58:38PM +0800, Ming Lei wrote:
> > +	struct io_uring_sqe *reg;
> > +	struct io_uring_sqe *rw;
> > +	struct io_uring_sqe *ureg;
> > +
> > +	if (!zc) {
> > +		rw = ublk_queue_alloc_sqe(q);
> > +		if (!rw)
> > +			return -ENOMEM;
> > +
> > +		io_uring_prep_rw(op, rw, 1 /*fds[1]*/,
> > +				(void *)iod->addr,
> > +				iod->nr_sectors << 9,
> > +				iod->start_sector << 9);
> > +		io_uring_sqe_set_flags(rw, IOSQE_FIXED_FILE);
> > +		q->io_inflight++;
> > +		/* bit63 marks us as tgt io */
> > +		rw->user_data = build_user_data(tag, op, UBLK_IO_TGT_NORMAL, 1);
> > +		return 0;
> > +	}
> > +
> > +	ublk_queue_alloc_sqe3(q, &reg, &rw, &ureg);
> > +
> > +	io_uring_prep_buf_register(reg, 0, tag, q->q_id, tag);
> > +	reg->user_data = build_user_data(tag, 0xfe, 1, 1);
> > +	reg->flags |= IOSQE_CQE_SKIP_SUCCESS;
> > +	reg->flags |= IOSQE_IO_LINK;
> > +
> > +	io_uring_prep_rw(op, rw, 1 /*fds[1]*/, 0,
> > +		iod->nr_sectors << 9,
> > +		iod->start_sector << 9);
> > +	rw->buf_index = tag;
> > +	rw->flags |= IOSQE_FIXED_FILE;
> > +	rw->flags |= IOSQE_IO_LINK;
> > +	rw->user_data = build_user_data(tag, op, UBLK_IO_TGT_ZC_OP, 1);
> > +	q->io_inflight++;
> > +
> > +	io_uring_prep_buf_unregister(ureg, 0, tag, q->q_id, tag);
> > +	ureg->user_data = build_user_data(tag, 0xff, UBLK_IO_TGT_ZC_BUF, 1);
> 
> You don't have anything handling the unregister command's completion so
> I think you want the IOSQE_CQE_SKIP_SUCCESS flag on it otherwise you get
> an unexpected CQE for it.

Please see ublk_loop_io_done() which does handle unregister command by
the flag of UBLK_IO_TGT_ZC_BUF. And it is reasonable to complete the
io command after the whole link is done.

BTW, with this way, one ublk bug is actually triggered, and Caleb's patch
fixes it.


Thanks,
Ming

