Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47C17A2FA
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765940971; cv=none; b=HcXhMg91SnJS5lqtyY+GNTe0uh+j6Ihn/Opz/hgYDAEcMXy67+3aI/gMnjvOkus3pfcBu5+xfod5dUZTu5ycf1/8C5BVklvUwwOyMgvoL7JnnCRpCDIcE/sylNvvmUfS6Zr+DBbJqCMXmMHgSQWis7JiThh1kELQz3q0jPiPUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765940971; c=relaxed/simple;
	bh=w7hIa6c6KUayC4lX3usTsv64WgM6BMgYRorvpkShH+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE2zvqCfWWWfS/gISehwABB+dgQ4g4B6AyFniR6GoLbQWQllQdMQwPeMzH5ommoeOtpviG2BC17sNaKGYUHqODAVLKpAf1aPq6xelWjaRtVk1DPvPJThxJ19qaeJRP36qUjGO3peAMcRpBzS5f73yp/g/OVbQLM0k2cmnwAWliQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1INiYn7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1INiYn7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765940968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iCrAfKX9VhEAPJ3Wo+2SHLz+Hk/pZhINLq268t5w2w=;
	b=R1INiYn7dOuIP5MN0xLszd3PNvllPFH5JqceR+tlKkU2fAh6B6WW3TcmXStLHI3bt6rqDq
	y90SFA9oRiunQ9Qpw4KP2yxgnh8e48dC91lBZD7V9dffpHrUiYv1FE57Mrqo0qdO0bhCAc
	ZXW3Du7n1zBAZ1jhDL7Qbm7Ygz0zN3Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-1aq8xhuoMCmhNZ59c80j7Q-1; Tue,
 16 Dec 2025 22:09:26 -0500
X-MC-Unique: 1aq8xhuoMCmhNZ59c80j7Q-1
X-Mimecast-MFC-AGG-ID: 1aq8xhuoMCmhNZ59c80j7Q_1765940965
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A13811956058;
	Wed, 17 Dec 2025 03:09:25 +0000 (UTC)
Received: from fedora (unknown [10.72.116.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D7DA180044F;
	Wed, 17 Dec 2025 03:09:21 +0000 (UTC)
Date: Wed, 17 Dec 2025 11:09:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V2] ublk: fix deadlock when reading partition table
Message-ID: <aUIe3RXASOEKKc0m@fedora>
References: <20251212143415.485359-1-ming.lei@redhat.com>
 <8dd3c141-3e92-44f3-91e2-2bf4827b36a4@kernel.dk>
 <aTzPUzyZ21lVOk1L@fedora>
 <93163617-11bb-4700-aca9-940c0df7429f@kernel.dk>
 <aUEeu9luJ9ZNvJzA@fedora>
 <6d40e8a0-14e9-45f4-bbea-360678524767@kernel.dk>
 <5e2038e1-efcf-4313-8a14-565b970370f2@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e2038e1-efcf-4313-8a14-565b970370f2@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Dec 16, 2025 at 10:57:25AM -0700, Jens Axboe wrote:
> On 12/16/25 8:03 AM, Jens Axboe wrote:
> >> The issue for ublk is actually triggered by something abnormal: submit AIO
> >> & close(ublk disk) in client application, then fput() is called when the
> >> submitted AIO is done, it will cause deferred fput handler to wq for any block
> >> IO completed from irq handler.
> > 
> > My suggested logic is something ala this in bdev_release():
> > 
> > 	if (current->flags & PF_KTHREAD) {
> > 		mutex_lock(&disk->open_mutex);
> > 	} else {
> > 		if (!mutex_trylock(&disk->open_mutex)) {
> > 			deferred_put(file);
> > 			return;
> > 		}
> > 	}
> > 
> > and that's about it.
> 
> I took a look at the bug report, and now it makes more sense to me -
> this is an aio only issue, as it does fput() from ->bi_end_io() context.
> That's pretty nasty, as you don't really know what context that might
> be, both in terms of irq/bh state, but also in terms of locks. The
> former fput() does work around.
> 
> Why isn't the fix something as simple as the below, with your comment
> added on top? I'm not aware of anyone else that would do fput off
> ->bi_end_io, so we migt as well treat the source of the issue rather
> than work around it in ublk. THAT makes a lot more sense to me.

It doesn't matter if fput is called from ->bi_end_io() directly, it can
be triggered on io-uring indirectly too, in which fput() is called from
__io_submit_flush_completions() in case of non-registerd file.


Thanks,
Ming

