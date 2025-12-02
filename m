Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B921FA272
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764641019; cv=none; b=rgGLGpYeLqAJ9zoxpch9A7NEU8Gzl5LTBIRVQNN80tIhvV9i15QmKlc10AtYwVynwS3RW35fkBY15xmdk9XBlzHfoWCjZw3cYG4mOhnVosuz3bni9Q/ZsOEO/DvXoDTQTKLycKt618thAcJPlqredTSMhoKn1SWqTgIIclDXakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764641019; c=relaxed/simple;
	bh=K2MlQjWndxCsJYCZHTOYXZp6qXB3DmGfaofWpB5Vc2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXoaeHBfRdRHqSEcicbh9/Ray7QsipjutDvg+q4C0Uyx0LHfAgBazzeM1SPxDDY0oA3N62ksXq4igmljFiw5eEVlKv6tEmZNzKq83UnjN2aBrihl4kpiq4GnPwrZeYTukPCms7GjxYVyqUsxpQoovnCkBDeIXp+vQwwytCsvhds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZME01GU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZME01GU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764641016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rErjHguR0HApl9sfhbCduzj2os3RKCKgw52zKaHdH0=;
	b=VZME01GUWiW+PUggesAOw/Hdku+3nvE8RoeQnIcstg5bfPBN4WR9hwTGVTkJ9kiMmhqO75
	l3oT+A4Zy/hvQASFOwXVR3cIwWqBf8Jn04CZLzMFG6gvBfKfFP/UafcRyhanJ51U0IPifm
	EWSt93azKk9cnGfaIfbkUSeKgbFDn+0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623--mcmwsVmPj67lfcNGg2eeg-1; Mon,
 01 Dec 2025 21:03:35 -0500
X-MC-Unique: -mcmwsVmPj67lfcNGg2eeg-1
X-Mimecast-MFC-AGG-ID: -mcmwsVmPj67lfcNGg2eeg_1764641014
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B40C71800358;
	Tue,  2 Dec 2025 02:03:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BA0B195608E;
	Tue,  2 Dec 2025 02:03:28 +0000 (UTC)
Date: Tue, 2 Dec 2025 10:03:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 17/27] ublk: document feature UBLK_F_BATCH_IO
Message-ID: <aS5I66gaeTjnSkvY@fedora>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

The fetch command is live if the provided buffer isn't full, which aligns
with typical io_uring multishot req & provided buffer use case, such as
IORING_OP_READ_MULTISHOT.

Also the fetch command is completed in case of FETCH failure.

```
A multishot request will persist as long as no errors are encountered doing
handling of the request. For each CQE posted on behalf of this request, the
CQE flags will have IORING_CQE_F_MORE set if the application should expect
more completions from this request. If this flag isn’t set, then that signifies
termination of the multishot read request.
```

> like as long as the buffer selection and posting of the multishot CQE
> succeeds, the same UBLK_U_IO_FETCH_IO_CMDS will continue to be used.
> If additional UBLK_U_IO_FETCH_IO_CMDS commands are issued to the queue
> (e.g. by other threads), they won't be used until the first one fails
> to select a buffer or post the CQE? Seems like this would make it
> difficult to load-balance incoming requests on a single ublk queue
> between multiple threads.


Thanks,
Ming

