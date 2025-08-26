Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5672F99B5
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197421; cv=none; b=db10w2sD1+lFVWnBNQcOI65zdzLKp3ICO2360fQnM9SjoplHB2dkvM7bwmetxy9R9DMN/FYdO6US2Tt81ws7k6Ay6Q32tZGh8U2kf9i6fcL3hxY7ctN1L2GnPcVwGhCkI5oOsVu+tkTgN9XgV93wgE/Bf71vQ6vhHtTZcCF2j0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197421; c=relaxed/simple;
	bh=6OgoAk934HTIV3WcXtzczGvOW9FgNkUuK1zXvn0N9Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTUHXvxzvH2TMjIzDC83yqpyOQkiWur3rsUoZ7Nh16EotSG/CW6t3upQW0VNUR+jfyXLEOnAOm7+vrfe9OmccBzy/OSA4P9UPceEVnV2zAOYR3j8sD5P92jtaPoev12+T8N8p9Ord+qAlt/GlXvEokFcrKclblyUjMp0JgNh+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZxtsFiB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZxtsFiB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756197418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcKsnR0+caJeVtwLFg0Jr6sfhvBW9VzwUJF/fLLk8ck=;
	b=VZxtsFiB9uoG6RuDzd6BT8qYKN7igl+jwuhdQ6v4hFJUhc70NEtMQD5GqJwyJ7skW3lU3m
	ZexVz9u+pXaPE0hOHHl1loxOwbOB06DQUpR2nqsOya7OJJ1xBNlylT5drnlC9mnPIARaDg
	q1GfS+Vh+836WJvimSSGysRC6ROod3Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-JIQ9KB3OOB6Lk-uylsVcgw-1; Tue,
 26 Aug 2025 04:36:57 -0400
X-MC-Unique: JIQ9KB3OOB6Lk-uylsVcgw-1
X-Mimecast-MFC-AGG-ID: JIQ9KB3OOB6Lk-uylsVcgw_1756197416
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98AED1800371;
	Tue, 26 Aug 2025 08:36:55 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF96C30001A2;
	Tue, 26 Aug 2025 08:36:51 +0000 (UTC)
Date: Tue, 26 Aug 2025 16:36:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 2/2] ublk selftests: add --no_ublk_fixed_fd for not
 using registered ublk char device
Message-ID: <aK1yG6mfYfkRKI3Z@fedora>
References: <20250825124827.2391820-1-ming.lei@redhat.com>
 <20250825124827.2391820-3-ming.lei@redhat.com>
 <CADUfDZrZLiD9r7AK+83HLgi-tXGvzNX_fasvwQ2_-wm6EVPifQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrZLiD9r7AK+83HLgi-tXGvzNX_fasvwQ2_-wm6EVPifQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Aug 25, 2025 at 09:53:27PM -0700, Caleb Sander Mateos wrote:
> On Mon, Aug 25, 2025 at 5:49 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add a new command line option --no_ublk_fixed_fd that excludes the ublk
> > control device (/dev/ublkcN) from io_uring's registered files array.
> > When this option is used, only backing files are registered starting
> > from index 1, while the ublk control device is accessed using its raw
> > file descriptor.
> >
> > Add ublk_get_registered_fd() helper function that returns the appropriate
> > file descriptor for use with io_uring operations, taking ublk_queue *
> > parameter instead of ublk_thread * for better performance.
> >
> > Key optimizations implemented:
> > - Cache UBLKS_Q_NO_UBLK_FIXED_FD flag in ublk_queue.flags to avoid
> >   reading dev->no_ublk_fixed_fd in fast path
> > - Cache ublk char device fd in ublk_queue.ublk_fd for fast access
> > - Update ublk_get_registered_fd() to use ublk_queue * parameter
> > - Update io_uring_prep_buf_register/unregister() to use ublk_queue *
> > - Replace ublk_device * access with ublk_queue * access in fast paths
> >
> > This improves performance by:
> > - Eliminating device structure traversal in hot paths
> > - Better cache locality with queue-local data access
> > - Reduced indirection for flag and fd lookups
> 
> Are you saying that performance is better when using the raw
> /dev/ublkcN fd instead of an io_uring registered file? That would be
> really surprising to me, since the whole point of io_uring file
> registration is to avoid the file reference counting in the I/O path.

No, here it just describes one implementation detail by caching per-device
flag(no_ublk_fixed_fd) in queue's flag.

The test can trigger hang with patch V1 by passing --no_ublk_fixed_fd
because /dev/ublkcN and io_uring closes can be depended, both are run
from task work context in current task.


Thanks,
Ming

