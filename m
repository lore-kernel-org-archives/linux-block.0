Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014CA1DE2C9
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640545; cv=none; b=nN3i1Khep2dwF4wDvdLnc9ejvkJ56cEmFz/pYkbeE54sEcbYDK7erOI4Fa40ECVm7nC2/HG50e92pb6PgDc39u/iZZWzgD1LUt/UJpzfUUNQsgANdxRPpUgxabgwJ5pEaI1QmCNOLtJ8C0R2OKOAnW4PrONlA4w36wDP/hhiyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640545; c=relaxed/simple;
	bh=x7Q1fQW12VxZNaSDd2fcM9jDSUUzUscnj5qXxEFyFjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH8CmaSs2Ot95z57DBCST0p+bklC3vesoEHBRnxZgLni7+JrWGCYd18rSHryeE9fqlWar0+h22Yv6VsH+ZnfZFNObOrZa6WI/IDbchCaK7LF6CEq5W01cfA+nBW6mFFPkvJT82C9YpRZrS/Hit8c743+3MwQm4sll1UvgumQ/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfLH6rqY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfLH6rqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764640543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09J24jtWjAelTU1kgj8wXm1+XNQhAfnM1t5A9WZX5Q0=;
	b=BfLH6rqY8rgmvTPXNxJCH/zTixhPurA1tmI4eXHpHIRbTPFuKrsA4GUaUZeD1YNeE9kx9W
	CjUIXkJcV9C+FmJkF0TjGsJX2hMp78Txz7Cv2t8saq3BBajDHZVZLyYWfGENIHny42mNl2
	sE+HZmOGk63xdAhPddi8uLQyzYchVI0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-i2COzwKKPaGkhpDXN87CZA-1; Mon,
 01 Dec 2025 20:55:39 -0500
X-MC-Unique: i2COzwKKPaGkhpDXN87CZA-1
X-Mimecast-MFC-AGG-ID: i2COzwKKPaGkhpDXN87CZA_1764640538
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3913519560B2;
	Tue,  2 Dec 2025 01:55:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FA0A30001A4;
	Tue,  2 Dec 2025 01:55:33 +0000 (UTC)
Date: Tue, 2 Dec 2025 09:55:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 17/27] ublk: document feature UBLK_F_BATCH_IO
Message-ID: <aS5HEM4F4PuGWD17@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <20251121015851.3672073-18-ming.lei@redhat.com>
 <CADUfDZoDJhJqGpsYdoNUcPKOHeBAA8M+ow5ok4ySnKaU+XNQ3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoDJhJqGpsYdoNUcPKOHeBAA8M+ow5ok4ySnKaU+XNQ3w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Dec 01, 2025 at 01:46:19PM -0800, Caleb Sander Mateos wrote:
> On Thu, Nov 20, 2025 at 6:00 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Document feature UBLK_F_BATCH_IO.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  Documentation/block/ublk.rst | 60 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 56 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> > index 8c4030bcabb6..09a5604f8e10 100644
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
> > @@ -322,6 +325,55 @@ with specified IO tag in the command data:
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
> > +  Commits results for multiple I/O operations in batch. The server provides
> 
> And prepares the I/O descriptors to accept new requests?

Yeah, will add it in next version.

> 
> > +  a buffer containing the results of multiple completed I/Os, allowing
> > +  efficient bulk completion of requests.
> > +
> > +- ``UBLK_U_IO_FETCH_IO_CMDS``
> > +
> > +  **Multishot command** for fetching I/O commands in batch. This is the key
> > +  command that enables high-performance batch processing:
> > +
> > +  * Uses io_uring multishot capability for reduced submission overhead
> > +  * Single command can fetch multiple I/O requests over time
> > +  * Buffer size determines maximum batch size per operation
> > +  * Multiple fetch commands can be submitted for load balancing
> > +  * Only one fetch command is active at any time per queue
> 
> Can you clarify what the lifetime of the fetch command is? It looks
> like as long as the buffer selection and posting of the multishot CQE
> succeeds, the same UBLK_U_IO_FETCH_IO_CMDS will continue to be used.

Yeah, it means the provided buffer isn't full yet.

> If additional UBLK_U_IO_FETCH_IO_CMDS commands are issued to the queue
> (e.g. by other threads), they won't be used until the first one fails
> to select a buffer or post the CQE? Seems like this would make it
> difficult to load-balance incoming requests on a single ublk queue
> between multiple threads.

So far, fetch command is added in FIFO style, so new fetch command
can only be handled when old commands are done, ublk server can support
simple load balance by adjusting the fetch buffer size dynamically:

- if one pthread is close to saturate, the fetch buffer size can be reduced

- if one pthread has more capacity, the fetch buffer size can be increased

In future, it should be easy to introduce fetch command priority, so ublk
server can balance load by controlling either fetch buffer size or command
priority.


Thanks, 
Ming

