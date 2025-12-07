Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4DE1F30AD
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765119809; cv=none; b=Ix9xhvMab2BV0NU9qtyIM8CVS4kW6XBEaYSqrmqTkrvadUJ7SSg6RYsjX0diiEfhnsulMENFw0OTReWOITfLr44FBuvKNeqh1BMUkrM/7TI6OmnOm4MoKZE00w1z9y2GWOcTj+MlRmFF4zaKiLPoGLAA6kNzi0bWq3TS6ewUvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765119809; c=relaxed/simple;
	bh=vQNf5ujpa85XPTkR1bGASXvPIk5ODKZ1cOnCV08Dvbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCuJ7XY6G/jpvdZF2lng/ZRRYp51vIgTRvCrPqYzxE+nqgArJAzo5qkDfC7ND2MK6AKc8DwbIfg0A9EnQBnv8ZxxLj2oeKGev3W+ffSR3coS4/3Zwdi4+JECkAfFY7c3zsvqb21PWy1Rg39ScV1PtdahfcoYrUQvtZlgURZiS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RERN0r3F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RERN0r3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765119805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXWrvEs4CNz6kXvKSRTumYLDHNLdtCDFvhzogppeBCE=;
	b=RERN0r3F6/Z9WXB95Dcv8dGnZ/p46wobU6IjQIgHWhxeHqggHnKWmrr6ioIRafhoxavlDq
	Od8uSqjOWFjCO2rMzvjhv85axKqk9GnDFIAvqIpV12IySqwu2EdDjLH8ZNbuSuKStTeyhI
	R4Ml96KnDp7D+UtSUMyQS38o7YG8kCw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-GOq577pOMg6o9buvr924ew-1; Sun,
 07 Dec 2025 10:03:21 -0500
X-MC-Unique: GOq577pOMg6o9buvr924ew-1
X-Mimecast-MFC-AGG-ID: GOq577pOMg6o9buvr924ew_1765119800
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83F3F195608E;
	Sun,  7 Dec 2025 15:03:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4468180049F;
	Sun,  7 Dec 2025 15:03:16 +0000 (UTC)
Date: Sun, 7 Dec 2025 23:03:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V5 11/21] ublk: document feature UBLK_F_BATCH_IO
Message-ID: <aTWXJRh9wqW4KG4g@fedora>
References: <20251202121917.1412280-1-ming.lei@redhat.com>
 <20251202121917.1412280-12-ming.lei@redhat.com>
 <CADUfDZpLrrjmxsmW-JyqLMLR_vFj0gropue9rTSns6ty+OxvCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpLrrjmxsmW-JyqLMLR_vFj0gropue9rTSns6ty+OxvCg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Dec 07, 2025 at 12:22:38AM -0800, Caleb Sander Mateos wrote:
> On Tue, Dec 2, 2025 at 4:21 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Document feature UBLK_F_BATCH_IO.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  Documentation/block/ublk.rst | 64 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 60 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> > index 8c4030bcabb6..6ad28039663d 100644
> > --- a/Documentation/block/ublk.rst
> > +++ b/Documentation/block/ublk.rst
> > @@ -260,9 +260,12 @@ The following IO commands are communicated via io_uring passthrough command,
> >  and each command is only for forwarding the IO and committing the result
> >  with specified IO tag in the command data:
> >
> > -- ``UBLK_IO_FETCH_REQ``
> > +Traditional Per-I/O Commands
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > -  Sent from the server IO pthread for fetching future incoming IO requests
> > +- ``UBLK_U_IO_FETCH_REQ``
> > +
> > +  Sent from the server I/O pthread for fetching future incoming I/O requests
> >    destined to ``/dev/ublkb*``. This command is sent only once from the server
> >    IO pthread for ublk driver to setup IO forward environment.
> >
> > @@ -278,7 +281,7 @@ with specified IO tag in the command data:
> >    supported by the driver, daemons must be per-queue instead - i.e. all I/Os
> >    associated to a single qid must be handled by the same task.
> >
> > -- ``UBLK_IO_COMMIT_AND_FETCH_REQ``
> > +- ``UBLK_U_IO_COMMIT_AND_FETCH_REQ``
> >
> >    When an IO request is destined to ``/dev/ublkb*``, the driver stores
> >    the IO's ``ublksrv_io_desc`` to the specified mapped area; then the
> > @@ -293,7 +296,7 @@ with specified IO tag in the command data:
> >    requests with the same IO tag. That is, ``UBLK_IO_COMMIT_AND_FETCH_REQ``
> >    is reused for both fetching request and committing back IO result.
> >
> > -- ``UBLK_IO_NEED_GET_DATA``
> > +- ``UBLK_U_IO_NEED_GET_DATA``
> >
> >    With ``UBLK_F_NEED_GET_DATA`` enabled, the WRITE request will be firstly
> >    issued to ublk server without data copy. Then, IO backend of ublk server
> > @@ -322,6 +325,59 @@ with specified IO tag in the command data:
> >    ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
> >    the server buffer (pages) read to the IO request pages.
> >
> > +Batch I/O Commands (UBLK_F_BATCH_IO)
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The ``UBLK_F_BATCH_IO`` feature provides an alternative high-performance
> > +I/O handling model that replaces the traditional per-I/O commands with
> > +per-queue batch commands. This significantly reduces communication overhead
> > +and enables better load balancing across multiple server tasks.
> > +
> > +Key differences from traditional mode:
> > +
> > +- **Per-queue vs Per-I/O**: Commands operate on queues rather than individual I/Os
> > +- **Batch processing**: Multiple I/Os are handled in single operations
> > +- **Multishot commands**: Use io_uring multishot for reduced submission overhead
> > +- **Flexible task assignment**: Any task can handle any I/O (no per-I/O daemons)
> > +- **Better load balancing**: Tasks can adjust their workload dynamically
> > +
> > +Batch I/O Commands:
> > +
> > +- ``UBLK_U_IO_PREP_IO_CMDS``
> > +
> > +  Prepares multiple I/O commands in batch. The server provides a buffer
> > +  containing multiple I/O descriptors that will be processed together.
> > +  This reduces the number of individual command submissions required.
> > +
> > +- ``UBLK_U_IO_COMMIT_IO_CMDS``
> > +
> > +  Commits results for multiple I/O operations in batch, and prepares the
> > +  I/O descriptors to accept new requests. The server provides a buffer
> > +  containing the results of multiple completed I/Os, allowing efficient
> > +  bulk completion of requests.
> > +
> > +- ``UBLK_U_IO_FETCH_IO_CMDS``
> > +
> > +  **Multishot command** for fetching I/O commands in batch. This is the key
> > +  command that enables high-performance batch processing:
> > +
> > +  * Uses io_uring multishot capability for reduced submission overhead
> > +  * Single command can fetch multiple I/O requests over time
> > +  * Buffer size determines maximum batch size per operation
> 
> The UBLK_U_IO_FETCH_IO_CMDS command specifies a buffer group, so is
> the expectation that there would be a single buffer in the group and

It is same with other mulishot request with provided buffer, and the group
can include 1 or more buffers.

> each command would use a different buffer group?

Yes, each command should use different buffer group like
io_uring_prep_read_multishot(), because tag may be read into the buffer when
the userspace is parsing/handling previous completed FETCH completion.


Thanks,
Ming

