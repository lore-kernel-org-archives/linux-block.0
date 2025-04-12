Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF390BA53
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744417639; cv=none; b=Uppl0qg78cFOzCwRli/iXSFR3/Nq1VBgZlTbRyoyB9FXY8AirSrEG1Ts2KkzXAq1rtIIGtCB8pjVvTg13FnHD6h3JXc+H+pE+i3OcQ2swLaX/zM17sejo/ePZFMfNJPKQz3yhmHJuj5KYN3BaaAyNdAYEpjXE0vpX1hT6SdDAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744417639; c=relaxed/simple;
	bh=mbrNuOcxatOeQm/8IvyJAHLa9B8ylm9/Z1cMEu1tjKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASAkS7hXf/KCd4XAy08+QgEB6SVJvurw+MXi5vDtgQf5IJK7PFv9VXSGHAYSdeRoCDk92J0pP7QCDTN1soGXgPqh4Xq/+C/uJu3U02QidLXD/6Gb3hAu1zV5gEw7/1wzplJSLZjv+yNuEd4Hje68dPE3jMAboU1t8yzBLcL9bD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRLH071m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRLH071m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744417633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xak2iqKVntiO7WTDrCa3ZaOdZVGURMb1d8EHFqm35Hw=;
	b=NRLH071mXLIAqwa63VcpqLjdslLr0ka0RWTQYH6gujC1dI5zOq2RpCPuQRArvSd3+hpC8f
	cMYuHKmPX9aW4Pz06D92uXneN9gJe3SxZg/mS9wHRbH1CnNCu6lBiBo6pBzSoxMb76bsW8
	0H73cSyvAYwjC/NE6V7hHXfnzONS0B8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-uhRPIy70P4qYjMVmIOy8_w-1; Fri,
 11 Apr 2025 20:27:11 -0400
X-MC-Unique: uhRPIy70P4qYjMVmIOy8_w-1
X-Mimecast-MFC-AGG-ID: uhRPIy70P4qYjMVmIOy8_w_1744417630
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA2A11956048;
	Sat, 12 Apr 2025 00:27:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 064561801A69;
	Sat, 12 Apr 2025 00:27:06 +0000 (UTC)
Date: Sat, 12 Apr 2025 08:27:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: skip blk_mq_tag_to_rq() bounds check
Message-ID: <Z_mzVa5Ny1Go1PHk@fedora>
References: <20250409024955.3626275-1-csander@purestorage.com>
 <Z_jLNGzRJAQBN8Nx@fedora>
 <CADUfDZp=CDAh-2gNB9_LQ4cdhFm--apgRB94cuzqjV4O93hUeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp=CDAh-2gNB9_LQ4cdhFm--apgRB94cuzqjV4O93hUeQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Apr 11, 2025 at 12:51:10PM -0700, Caleb Sander Mateos wrote:
> On Fri, Apr 11, 2025 at 12:56 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Apr 08, 2025 at 08:49:54PM -0600, Caleb Sander Mateos wrote:
> > > The ublk driver calls blk_mq_tag_to_rq() in several places.
> > > blk_mq_tag_to_rq() tolerates an invalid tag for the tagset, checking it
> > > against the number of tags and returning NULL if it is out of bounds.
> > > But all the calls from the ublk driver have already verified the tag
> > > against the ublk queue's queue depth. In ublk_commit_completion(),
> > > ublk_handle_need_get_data(), and case UBLK_IO_COMMIT_AND_FETCH_REQ, the
> > > tag has already been checked in __ublk_ch_uring_cmd(). In
> > > ublk_abort_queue(), the loop bounds the tag by the queue depth. In
> > > __ublk_check_and_get_req(), the tag has already been checked in
> > > __ublk_ch_uring_cmd(), in the case of ublk_register_io_buf(), or in
> > > ublk_check_and_get_req().
> > >
> > > So just index the tagset's rqs array directly in the ublk driver.
> > > Convert the tags to unsigned, as blk_mq_tag_to_rq() does.
> >
> > If blk_mq_tag_to_rq() turns out to be not efficient enough, we can kill it
> > in fast path by storing it in ublk_io and sharing space with 'struct io_uring_cmd *',
> > since the two's lifetime isn't overlapped basically.
> 
> I agree it would be nice to just store a pointer from in struct
> ublk_io to its current struct request. I guess we would set it in
> ubq_complete_io_cmd() and clear it in ublk_commit_completion()
> (matching when UBLK_IO_FLAG_OWNED_BY_SRV is set), as well as in
> ublk_timeout() for UBLK_F_UNPRIVILEGED_DEV?
> 
> I'm not sure it is possible to overlap the fields, though. When using
> UBLK_U_IO_NEED_GET_DATA, the cmd field is overwritten with the a
> pointer to the UBLK_U_IO_NEED_GET_DATA command, but the req would need

Both UBLK_U_IO_NEED_GET_DATA & UBLK_IO_COMMIT_AND_FETCH_REQ share same
usage on uring_cmd/request actually. 

Especially for UBLK_U_IO_NEED_GET_DATA, the uring cmd pointer needn't to be
stored in ublk_io.  Or just keep to use blk_mq_tag_to_rq() simply for it
only.

> to be recorded earlier upon completion of the
> UBLK_U_IO_(COMMIT_AND_)FETCH_REQ command.

Each one can be moved in local variable first, then store it.

If we do this way, helper can be added for set/get cmd/req from ublk_io,
then the implementation can be reliable & readable.

> Would you be okay with 2 separate fields?

Yeah, I think it is fine to do it first.


Thanks,
Ming

