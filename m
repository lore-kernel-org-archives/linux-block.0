Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075922882BC
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211418; cv=none; b=J1/0hQqbEx15tlufA85Apl8T6yPKIm4ugdlA0QXY/UEdhixQ8gcKChz51GcNNn//eW69h66s13nkoHmV5n33gdb6OYUXzVPdTUDIvFawm5jX3dJzUvS7EWHUPxDuOWQaOzdqnDB+5mgg7UONudFhlGH0fK9Y2QFyEE9SsKQJ4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211418; c=relaxed/simple;
	bh=h89U6Qw/O7+zWjtR0rRZpwPXVVrxvuHqF05CLmLssdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Exsew/qxJ5dx6zpDjjO7KAKzSJJiRAKq2e3GBYcg1sdFFNzlEkMC1bXY0Zs3kem5Gowa3Nvp3WRY3nuxf2IEwKhUq10rz+Xga7All6g3IkYqlOzmFJZ8B2jW56ZxN6MViVxkTkYlBkUfhvwp/zvdTTkW4NoZPBc7wDkEi8jrRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfvBfa/L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfvBfa/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749211412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rZWMf5A/8ML9Zgbk1gnnvgyhUXpIeGhMtrap/ltBdk=;
	b=KfvBfa/LgAZgX5AUcRaS7/dROFfSxpLkDUDDK1NzNDkAc+cAdxzUxOeNi56dWhFDiyTqAb
	IbL2DxtM7DRgCNcqV36IZIaOSK19Ahd2xVFi0RzCFjCEPk75B64+eXEcbEyZznJRUsj7kt
	BYy2ugfLdfxUuZCFZ+anzsZYJX0ovCQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-8YHooEKpOCOMMsZ-HlVsmQ-1; Fri,
 06 Jun 2025 08:03:29 -0400
X-MC-Unique: 8YHooEKpOCOMMsZ-HlVsmQ-1
X-Mimecast-MFC-AGG-ID: 8YHooEKpOCOMMsZ-HlVsmQ_1749211407
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DE0619560A2;
	Fri,  6 Jun 2025 12:03:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.163])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D6FE18002A5;
	Fri,  6 Jun 2025 12:03:20 +0000 (UTC)
Date: Fri, 6 Jun 2025 20:03:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>,
	Ofer Oshri <ofer@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
	Guy Eisenberg <geisenberg@nvidia.com>, Omri Levi <omril@nvidia.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: ublk: RFC fetch_req_multishot
Message-ID: <aELZBPmYUMHDbusQ@fedora>
References: <IA1PR12MB606744884B96E0103570A1E9B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
 <CADUfDZo=uEno=4-3PJAD+_5sLRMaoFvMUGpckbD3tdbhCxTW4A@mail.gmail.com>
 <IA1PR12MB60672D37508D641368D211B8B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
 <CADUfDZqUQ+n5tr=XG+sJWR_q55fzNSzLHvUZXkysOw=c+vfVGg@mail.gmail.com>
 <aAscRPVcTBiBHNe7@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAscRPVcTBiBHNe7@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Apr 25, 2025 at 01:23:16PM +0800, Ming Lei wrote:
> On Thu, Apr 24, 2025 at 12:07:32PM -0700, Caleb Sander Mateos wrote:
> > On Thu, Apr 24, 2025 at 11:58 AM Ofer Oshri <ofer@nvidia.com> wrote:
> > >
> > >
> > >
> > > ________________________________
> > > From: Caleb Sander Mateos <csander@purestorage.com>
> > > Sent: Thursday, April 24, 2025 9:28 PM
> > > To: Ofer Oshri <ofer@nvidia.com>
> > > Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; ming.lei@redhat.com <ming.lei@redhat.com>; axboe@kernel.dk <axboe@kernel.dk>; Jared Holzman <jholzman@nvidia.com>; Yoav Cohen <yoav@nvidia.com>; Guy Eisenberg <geisenberg@nvidia.com>; Omri Levi <omril@nvidia.com>
> > > Subject: Re: ublk: RFC fetch_req_multishot
> > >
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > On Thu, Apr 24, 2025 at 11:19 AM Ofer Oshri <ofer@nvidia.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Our code uses a single io_uring per core, which is shared among all block devices - meaning each block device on a core uses the same io_uring.
> > > >
> > > > Let’s say the size of the io_uring is N. Each block device submits M UBLK_U_IO_FETCH_REQ requests. As a result, with the current implementation, we can only support up to P block devices, where P = N / M. This means that when we attempt to support block device P+1, it will fail due to io_uring exhaustion.
> > >
> > > What do you mean by "size of the io_uring", the submission queue size?
> > > Why can't you submit all P * M UBLK_U_IO_FETCH_REQ operations in
> > > batches of N?
> > >
> > > Best,
> > > Caleb
> > >
> > > N is the size of the submission queue, and P is not fixed and unknown at the time of ring initialization....
> > 
> > I don't think it matters whether P (the number of ublk devices) is
> > known ahead of time or changes dynamically. My point is that you can
> > submit the UBLK_U_IO_FETCH_REQ operations in batches of N to avoid
> > exceeding the io_uring SQ depth. (If there are other operations
> > potentially interleaved with the UBLK_U_IO_FETCH_REQ ones, then just
> > submit each time the io_uring SQ fills up.) Any values of P, M, and N
> > should work. Perhaps I'm misunderstanding you, because I don't know
> > what "io_uring exhaustion" refers to.
> > 
> > Multishot ublk io_uring operations don't seem like a trivial feature
> > to implement. Currently, incoming ublk requests are posted to the ublk
> > server using io_uring's "task work" mechanism, which inserts the
> > io_uring operation into an intrusive linked list. If you wanted a
> > single ublk io_uring operation to post multiple completions, it would
> > need to allocate some structure for each incoming request to insert
> > into the task work list. There is also an assumption that the ublk
> > io_uring operations correspond 1-1 with the blk-mq requests for the
> > ublk device, which would be broken by multishot ublk io_uring
> > operations.
> 
> For delivering ublk io command to ublk server, I feel multishot can be
> used in the following way:
> 
> - use IORING_OP_READ_MULTISHOT to read from ublk char device, do it for
>   each queue, queue id may be passed via offset
> 
> - block in ublk_ch_read_iter() if nothing comes from this queue of the
> ublk block device
> 
> - if any ublk block io comes, fill `ublksrv_io_desc` in mmapped area, and
> push the 'tag' to the read ring buffer(provided buffer)
> 
> - wakeup the read IO after one whole IO batch is done
> 
> For commit ublk io command result to ublk driver, it can be similar with
> delivering by writing 'tag' to ublk char device via IORING_OP_WRITE_FIXED or
> IORING_OP_WRITE, still per queue via ring_buf approach, but need one mmapped
> buffer for storing the io command result, 4 bytes should be enough for each io.
> 
> With the above way:
> 
> - use read/write to deliver io command & commit io command result, so
>   single read/write replaces one batch of uring_cmd
> 
> - needn't uring command any more, big security_uring_cmd() cost can be avoided
> 
> - memory footprint is reduced a lot, no extra uring_cmd for each IO
> 
> - extra task work scheduling is avoided
> 
> - Probably uring exiting handling can be simplified too.
> 
> 
> Sounds like ublk 2.0 prototype, :-)

I have been working towards this direction:

https://github.com/ming1/linux/commits/ublk2-cmd-batch/

by adding three new batch commands, all are per-queue:

`UBLK_U_IO_FETCH_IO_CMDS`
	
	- multishot with provided buffer

	- issued once, CQE is posted after new io/io batch is coming by filling
	io tag into the provided buffer

	- re-issue after the whole buffer is used up, so issue cost is reduced

	- multiple `UBLK_U_IO_FETCH_IO_CMDS` are allowed to be issued concurrently
	from different task contexts for supporting load balance

	- each `UBLK_U_IO_FETCH_IO_CMDS` can carry 'priority' info for supporting
	prioritized schedule, not done yet, should be easier to implement

`UBLK_U_IO_COMMIT_IO_CMDS`

	- this command has a fixed buffer, in which io tag, io command result
	and other info(buf_index) for FETCH is provided, and multiple IOs or
	batch IO are covered

`UBLK_U_IO_PREP_IO_CMDS`:

	batch version of `UBLK_IO_FETCH_REQ`, still has one fixed buffer for
	carrying io tag, info for fetch, similar with `UBLK_U_IO_COMMIT_IO_CMDS`

In this way, lots of existing ublk constraint are relaxed:

- any of the three command can be issued from any task context, there isn't
  per-io task or ubq_daemon limit any more. But AUTO_BUF_REG is one
  exception, which requires FETCH and COMMIT command are in same io_ring_ctx.

- easier to support load balance, any IO commands fetched by the command
of `UBLK_U_IO_FETCH_IO_CMDS` can be handled in the task for issuing
UBLK_U_IO_FETCH_IO_CMDS

- both FETCH and COMMIT are handled in batch way, communication cost is
reduced.

One drawback is that cost is added in client IO issue side(ublk_queue_rq() and
ublk_queue_rqs()), goodness is that communication cost is reduced in ublk server
side. 

Simple test running on one server shows that performance is good

- kublk(`--batch --auto_zc -q 2` vs. `--auto_zc -q 2`): ~10% IOPS improvement

The feature is still in very early stage, and any comments are welcome!



Thanks,
Ming

