Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EDDE552
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350480; cv=none; b=n+lsoPiTCeQ1bpHsL5jCQMYuDFZX5hjtMdQJ2vTjj3E8BiIKUAPp07Ml17HOEVCVAu2f8kqQY8DU3pNmWl8p8aJFTQyTehVUaihS94WlFfJIB/ia9mxmHjBy54ApozyAsfGSd5C4vHOr53jYunpPX0OxUYOI5MEpUXHzyPK5ino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350480; c=relaxed/simple;
	bh=86rIqS+k57XN1YzaolyO+jO6xThnml4V6fYY7rA5ztU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iobxYt8RNf4EfF/qv5m2wnvaUW5ZthiwG7J3vWpuzaSuoJVlNGcLUpHwVePb4NHDngMowEEigHhLSWbSMFVWySPjDwYIwvvpVER6f9J2JtBW/7u4jjH4bQ9MbAtkBdKqXfVQiAJtkMXtvetXGgrxnrDnp87QzsbqYBV3RzAmPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXHGzMWi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXHGzMWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742350477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pGPE5KOnq6OjHgi5+NENtlsQxiyCcp16m9cCGbktzAA=;
	b=AXHGzMWixM09bo9g7f8iU4TWBUoHPB7cnRyF+iCK7NqvWHoUCv8I8wR9XU8T6BYu8pCkmO
	4gH/jiVN3N3VyR4GhaQe4S2MR1B6KSKkY53Fqi9fqfUd+t5OQA/zy7N3n6cUDTgBeCOrTf
	4orxso+hFRxwPFlpNRvNKULEDkW4TqE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-11EZZCQTOtyZCeFqMlTGyA-1; Tue,
 18 Mar 2025 22:14:35 -0400
X-MC-Unique: 11EZZCQTOtyZCeFqMlTGyA-1
X-Mimecast-MFC-AGG-ID: 11EZZCQTOtyZCeFqMlTGyA_1742350474
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C25D21800257;
	Wed, 19 Mar 2025 02:14:34 +0000 (UTC)
Received: from fedora (unknown [10.72.120.14])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 282C9180175B;
	Wed, 19 Mar 2025 02:14:30 +0000 (UTC)
Date: Wed, 19 Mar 2025 10:14:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: remove io_cmds list in ublk_queue
Message-ID: <Z9oogb9i70X0hjsP@fedora>
References: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Mar 18, 2025 at 12:14:17PM -0600, Uday Shankar wrote:
> The current I/O dispatch mechanism - queueing I/O by adding it to the
> io_cmds list (and poking task_work as needed), then dispatching it in
> ublk server task context by reversing io_cmds and completing the
> io_uring command associated to each one - was introduced by commit
> 7d4a93176e014 ("ublk_drv: don't forward io commands in reserve order")
> to ensure that the ublk server received I/O in the same order that the
> block layer submitted it to ublk_drv. This mechanism was only needed for
> the "raw" task_work submission mechanism, since the io_uring task work
> wrapper maintains FIFO ordering (using quite a similar mechanism in
> fact). The "raw" task_work submission mechanism is no longer supported
> in ublk_drv as of commit 29dc5d06613f2 ("ublk: kill queuing request by
> task_work_add"), so the explicit llist/reversal is no longer needed - it
> just duplicates logic already present in the underlying io_uring APIs.
> Remove it.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

