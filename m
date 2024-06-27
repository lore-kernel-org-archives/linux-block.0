Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8817E9
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719451087; cv=none; b=Je0Roxrmkw0CPFhYGej+kwUZnq4fMng7UniYshNK6a+aYmmjQ3B18I0svRfsyIpAImFbMT8JQKIiP2KxfeoeGz8xin05+G7qUwUcPMK4wqqpuSA5Wuh0058bJqL8SqRfvXyRTLdQ/hp0g9nLJTQFlYvD1Teh6rSTzguMc/3Yv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719451087; c=relaxed/simple;
	bh=Iu4VxMXTKgcdQVLF+y6tVDtxFjBBguB86mD+5zt4W5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWUHW3jVdVh/HELY9XR2qLUgB8TSMPwJo21mbfJRDNSFl/UTCoI9WFQy7AretiQdVCxyMlkO3iZ9s8fj9Os1wGG3FajbzA8d7xDqK4taIqCCNxsLlfZ39V5MR+z8gFqfnvSR2htbcMgvctvrvRNvgFaOGNVxL7DpMrek11yCD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUBIcgn8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUBIcgn8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719451084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ABEcaaZBAbz+HG3L93P6o0S5XyX63mDoJBSbvJQY4k=;
	b=QUBIcgn8d8yVMxphOj9hyQ3dEBpZnB0ZYYXWzck84HpUuGhpMZ7JBtKnuCr6hNXkJynPnp
	kJ2rgIMIa2fhyR5RIsmJ99NtycXST/wqsIDnCEul03R5bzPS3SRE2LVDcDscsPyPp+7SE7
	RwEBeADjvT9Hxwm9xFOqdg5h8HPpRZ0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-OUly0LGwMMKCbfRH0P0Hvw-1; Wed,
 26 Jun 2024 21:18:00 -0400
X-MC-Unique: OUly0LGwMMKCbfRH0P0Hvw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 254D3195609F;
	Thu, 27 Jun 2024 01:17:59 +0000 (UTC)
Received: from fedora (unknown [10.72.112.95])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5D5D1955E84;
	Thu, 27 Jun 2024 01:17:55 +0000 (UTC)
Date: Thu, 27 Jun 2024 09:17:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] ublk: refactor recovery configuration flag helpers
Message-ID: <Zny9vr/2iHIkc2bC@fedora>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-3-ushankar@purestorage.com>
 <ZnDs5zLc5oA1jPVA@fedora>
 <ZnxOYyWV/E54qOAM@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnxOYyWV/E54qOAM@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jun 26, 2024 at 11:22:43AM -0600, Uday Shankar wrote:
> On Tue, Jun 18, 2024 at 10:11:51AM +0800, Ming Lei wrote:
> > On Mon, Jun 17, 2024 at 01:44:49PM -0600, Uday Shankar wrote:
> > > ublk currently supports the following behaviors on ublk server exit:
> > > 
> > > A: outstanding I/Os get errors, subsequently issued I/Os get errors
> > > B: outstanding I/Os get errors, subsequently issued I/Os queue
> > > C: outstanding I/Os get reissued, subsequently issued I/Os queue
> > > 
> > > and the following behaviors for recovery of preexisting block devices by
> > > a future incarnation of the ublk server:
> > > 
> > > 1: ublk devices stopped on ublk server exit (no recovery possible)
> > > 2: ublk devices are recoverable using start/end_recovery commands
> > > 
> > > The userspace interface allows selection of combinations of these
> > > behaviors using flags specified at device creation time, namely:
> > > 
> > > default behavior: A + 1
> > > UBLK_F_USER_RECOVERY: B + 2
> > > UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2
> > 
> > ublk is supposed to support A, B & C for both 1 and both 2, but it may
> > depend on how ublk server is implemented.
> > 
> > In cover letter, it is mentioned that "A + 2 is a currently unsupported
> > behavior", can you explain it a bit? Such as, how does ublk server
> > handle the I/O error? And when/how to recover? why doesn't this way
> > work?
> 
> Sorry if this was unclear - the behaviors I describe in A, B, C, 1, 2
> are all referring to what is seen by the application using the ublk
> block device when the ublk server crashes. There is no sense in which

Yes, usually the app using ublk is supposed to be completely generic,
and won't be taken into account.

> the ublk server can "handle" the I/O error because during this time,
> there is no ublk server and all decisions on how to handle I/O are made
> by ublk_drv directly (based on configuration flags specified when the
> device was created).
> 
> If the ublk server created the device with UBLK_F_USER_RECOVERY, then
> when the ublk server has crashed (and not restarted yet), I/Os issued by
> the application will queue/hang until the ublk server comes back and
> recovers the device, because the underlying request_queue is left in a
> quiesced state. So in this case, behavior A is not possible.

When ublk server is crashed, ublk_abort_requests() will be called to fail
queued inflight requests. Meantime ubq->canceling is set to requeue
new request instead of forwarding it to ublk server.

So behavior A should be supported easily by failing request in
ublk_queue_rq() if ubq->canceling is set.

> 
> If the ublk server created the device without UBLK_F_USER_RECOVERY, then
> when the ublk server has crashed (and not restarted yet), I/Os issued by
> the application will immediately error (since in this case, ublk will
> call del_gendisk).  However, when the ublk server restarts, it cannot
> recover the existing ublk device - the disk has been deleted and the
> ublk device is in state UBLK_S_DEV_DEAD from which recovery is not
> permitted. So in this case, behavior 2 is not possible.

UBLK_F_USER_RECOVERY is supposed for supporting to recover device, and
if this flag isn't enabled, we don't support the feature simply, so
looks behavior 2 isn't one valid case, is it?

> 
> Hence A + 2 is impossible with the current ublk_drv implementation.
> Please correct me if I missed something.

Please see if the above reply can address this case.


Thanks,
Ming

