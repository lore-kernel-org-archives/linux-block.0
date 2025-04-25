Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4C1F3BA9
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745558615; cv=none; b=qr3eaxUGj0phd8aBui6gGmm4VpnTKe6oU226CGl8lAZ12V99H3eYqTM0C/Vk25IDtgUVyzUpK/lVTT/lCnPJpN4kPGOdZQUqT328xYxspu2YP9nuGaPxZav9wU9oNHp7+L6JJKc+gQjjAuagVZNv/0oISFH27QC+cNDTU5nDrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745558615; c=relaxed/simple;
	bh=pfEpzHNDMWqO6cdzXkE6BhrOyr9OlCgFH+d/GRQs6sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8Siwmc9FcgduCq+ScJajCRbI1fKaO6ZBhbg6yUWvsArbPhJRnDpYoFhfII8eqEGDP7Dyz60tFf2eLENO3i8IrM/mUdou4U37NicpJt6VX0ekAU4YnlUnGW5ikoP4Gsvk1T0fNi1QfTRg16k03wOEXnNbQAKVNjNU9Y2G2zOC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrMPSaOM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrMPSaOM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745558612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0IrjgFo8p/HWOwa4PRNTBjQwYWjHnwFbzJYMwmDCtQ=;
	b=GrMPSaOM9nu3FRN9y/uog2Q9RmBko9StdH/xtzOWXSADqa8uBOcq1341ttibiXw9YeSYEc
	GWy+XazYl7WqP8Q84u2m5Kgsm7OReFpFoRCc414DG6u31vbKBJXOGGVA5lXyZpl4VycQnl
	cdPOIrbabBEqAGdD+yiKalF9A/DRWpk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-OURRnNuxNqqmx7YvzHOwpA-1; Fri,
 25 Apr 2025 01:23:28 -0400
X-MC-Unique: OURRnNuxNqqmx7YvzHOwpA-1
X-Mimecast-MFC-AGG-ID: OURRnNuxNqqmx7YvzHOwpA_1745558606
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE4961956089;
	Fri, 25 Apr 2025 05:23:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7442518002AD;
	Fri, 25 Apr 2025 05:23:21 +0000 (UTC)
Date: Fri, 25 Apr 2025 13:23:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ofer Oshri <ofer@nvidia.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
	Guy Eisenberg <geisenberg@nvidia.com>, Omri Levi <omril@nvidia.com>
Subject: Re: ublk: RFC fetch_req_multishot
Message-ID: <aAscRPVcTBiBHNe7@fedora>
References: <IA1PR12MB606744884B96E0103570A1E9B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
 <CADUfDZo=uEno=4-3PJAD+_5sLRMaoFvMUGpckbD3tdbhCxTW4A@mail.gmail.com>
 <IA1PR12MB60672D37508D641368D211B8B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
 <CADUfDZqUQ+n5tr=XG+sJWR_q55fzNSzLHvUZXkysOw=c+vfVGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqUQ+n5tr=XG+sJWR_q55fzNSzLHvUZXkysOw=c+vfVGg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Apr 24, 2025 at 12:07:32PM -0700, Caleb Sander Mateos wrote:
> On Thu, Apr 24, 2025 at 11:58 AM Ofer Oshri <ofer@nvidia.com> wrote:
> >
> >
> >
> > ________________________________
> > From: Caleb Sander Mateos <csander@purestorage.com>
> > Sent: Thursday, April 24, 2025 9:28 PM
> > To: Ofer Oshri <ofer@nvidia.com>
> > Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; ming.lei@redhat.com <ming.lei@redhat.com>; axboe@kernel.dk <axboe@kernel.dk>; Jared Holzman <jholzman@nvidia.com>; Yoav Cohen <yoav@nvidia.com>; Guy Eisenberg <geisenberg@nvidia.com>; Omri Levi <omril@nvidia.com>
> > Subject: Re: ublk: RFC fetch_req_multishot
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Thu, Apr 24, 2025 at 11:19 AM Ofer Oshri <ofer@nvidia.com> wrote:
> > >
> > > Hi,
> > >
> > > Our code uses a single io_uring per core, which is shared among all block devices - meaning each block device on a core uses the same io_uring.
> > >
> > > Let’s say the size of the io_uring is N. Each block device submits M UBLK_U_IO_FETCH_REQ requests. As a result, with the current implementation, we can only support up to P block devices, where P = N / M. This means that when we attempt to support block device P+1, it will fail due to io_uring exhaustion.
> >
> > What do you mean by "size of the io_uring", the submission queue size?
> > Why can't you submit all P * M UBLK_U_IO_FETCH_REQ operations in
> > batches of N?
> >
> > Best,
> > Caleb
> >
> > N is the size of the submission queue, and P is not fixed and unknown at the time of ring initialization....
> 
> I don't think it matters whether P (the number of ublk devices) is
> known ahead of time or changes dynamically. My point is that you can
> submit the UBLK_U_IO_FETCH_REQ operations in batches of N to avoid
> exceeding the io_uring SQ depth. (If there are other operations
> potentially interleaved with the UBLK_U_IO_FETCH_REQ ones, then just
> submit each time the io_uring SQ fills up.) Any values of P, M, and N
> should work. Perhaps I'm misunderstanding you, because I don't know
> what "io_uring exhaustion" refers to.
> 
> Multishot ublk io_uring operations don't seem like a trivial feature
> to implement. Currently, incoming ublk requests are posted to the ublk
> server using io_uring's "task work" mechanism, which inserts the
> io_uring operation into an intrusive linked list. If you wanted a
> single ublk io_uring operation to post multiple completions, it would
> need to allocate some structure for each incoming request to insert
> into the task work list. There is also an assumption that the ublk
> io_uring operations correspond 1-1 with the blk-mq requests for the
> ublk device, which would be broken by multishot ublk io_uring
> operations.

For delivering ublk io command to ublk server, I feel multishot can be
used in the following way:

- use IORING_OP_READ_MULTISHOT to read from ublk char device, do it for
  each queue, queue id may be passed via offset

- block in ublk_ch_read_iter() if nothing comes from this queue of the
ublk block device

- if any ublk block io comes, fill `ublksrv_io_desc` in mmapped area, and
push the 'tag' to the read ring buffer(provided buffer)

- wakeup the read IO after one whole IO batch is done

For commit ublk io command result to ublk driver, it can be similar with
delivering by writing 'tag' to ublk char device via IORING_OP_WRITE_FIXED or
IORING_OP_WRITE, still per queue via ring_buf approach, but need one mmapped
buffer for storing the io command result, 4 bytes should be enough for each io.

With the above way:

- use read/write to deliver io command & commit io command result, so
  single read/write replaces one batch of uring_cmd

- needn't uring command any more, big security_uring_cmd() cost can be avoided

- memory footprint is reduced a lot, no extra uring_cmd for each IO

- extra task work scheduling is avoided

- Probably uring exiting handling can be simplified too.


Sounds like ublk 2.0 prototype, :-)


Thanks,
Ming

