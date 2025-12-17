Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B93595D
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765942407; cv=none; b=qiErXK6LL0Krd+lgXnyN+YRXrIsx7BDoTJDR4hG51av94Dw5ak/XLBrjdEuU3lmtOzpD1B17Y2LXzEZaB//aB+F8HDF441cI8FEVAUVnFIHBfHu4QAEhb0JyOoeqcRKGmDZPCLLxWcMJB81YOtqUQXKR+qx0bMlbusUOIa+oh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765942407; c=relaxed/simple;
	bh=0OItUMReWOXdAINeyoLJEACI/BMM0bcVFLKtS66mytw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pREV/wTujFKJTay9SCcYgvxjzOR3hE9SnDf7jJorV58beHAKvzVa/ds5Xy1piQRGfDOFzlgpQnBbpaNSvr4X9DF4Kjjmw1j1fBOGBid0BQeDwaT0GkSN7lj+HdusAi3zbg7nRa6tFjr+TlC74VG+lQQoTtQrjttaDXovGVhKAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRWXZObt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRWXZObt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765942404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TR4/9DQfLsUywb8OENEg5Gokz/dC8Lcukpp92dPYzdg=;
	b=BRWXZObtP/Ito1l9gx78dZXZksi1mCqmPJpHUFaLN1zr5L0crhn9Z7KKR+aHrbomHY7tVd
	74o0beREAW4p3BzeyPmS06yawTWKpgUbKYyxFPbNdUnS9hpicU9/7HCWTv9VNBPrtuoz8Z
	e0e3ilQBsIhA/ePncqHZvxOeXmp7Q8c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-rVgwKczoMZ29-eKMt2VFPw-1; Tue,
 16 Dec 2025 22:33:20 -0500
X-MC-Unique: rVgwKczoMZ29-eKMt2VFPw-1
X-Mimecast-MFC-AGG-ID: rVgwKczoMZ29-eKMt2VFPw_1765942399
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B91031800343;
	Wed, 17 Dec 2025 03:33:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.190])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AED8519560A7;
	Wed, 17 Dec 2025 03:33:15 +0000 (UTC)
Date: Wed, 17 Dec 2025 11:33:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V2] ublk: fix deadlock when reading partition table
Message-ID: <aUIkd9Nt9oSmHKKp@fedora>
References: <20251212143415.485359-1-ming.lei@redhat.com>
 <8dd3c141-3e92-44f3-91e2-2bf4827b36a4@kernel.dk>
 <aTzPUzyZ21lVOk1L@fedora>
 <93163617-11bb-4700-aca9-940c0df7429f@kernel.dk>
 <aUEeu9luJ9ZNvJzA@fedora>
 <6d40e8a0-14e9-45f4-bbea-360678524767@kernel.dk>
 <5e2038e1-efcf-4313-8a14-565b970370f2@kernel.dk>
 <aUIe3RXASOEKKc0m@fedora>
 <8b2d7335-fd49-4c15-87d9-0eb50e0a09a1@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2d7335-fd49-4c15-87d9-0eb50e0a09a1@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Dec 16, 2025 at 08:19:15PM -0700, Jens Axboe wrote:
> On 12/16/25 8:09 PM, Ming Lei wrote:
> > On Tue, Dec 16, 2025 at 10:57:25AM -0700, Jens Axboe wrote:
> >> On 12/16/25 8:03 AM, Jens Axboe wrote:
> >>>> The issue for ublk is actually triggered by something abnormal: submit AIO
> >>>> & close(ublk disk) in client application, then fput() is called when the
> >>>> submitted AIO is done, it will cause deferred fput handler to wq for any block
> >>>> IO completed from irq handler.
> >>>
> >>> My suggested logic is something ala this in bdev_release():
> >>>
> >>> 	if (current->flags & PF_KTHREAD) {
> >>> 		mutex_lock(&disk->open_mutex);
> >>> 	} else {
> >>> 		if (!mutex_trylock(&disk->open_mutex)) {
> >>> 			deferred_put(file);
> >>> 			return;
> >>> 		}
> >>> 	}
> >>>
> >>> and that's about it.
> >>
> >> I took a look at the bug report, and now it makes more sense to me -
> >> this is an aio only issue, as it does fput() from ->bi_end_io() context.
> >> That's pretty nasty, as you don't really know what context that might
> >> be, both in terms of irq/bh state, but also in terms of locks. The
> >> former fput() does work around.
> >>
> >> Why isn't the fix something as simple as the below, with your comment
> >> added on top? I'm not aware of anyone else that would do fput off
> >> ->bi_end_io, so we migt as well treat the source of the issue rather
> >> than work around it in ublk. THAT makes a lot more sense to me.
> > 
> > It doesn't matter if fput is called from ->bi_end_io() directly, it can
> > be triggered on io-uring indirectly too, in which fput() is called from
> > __io_submit_flush_completions() in case of non-registerd file.
> 
> Because of the work-around in io_req_post_cqe()? Or just because of
> !DEFER_TASKRUN?

When fput() is called from __io_submit_flush_completions(), its release
handler will be deferred to run task work, where the current task
is blocked because of ->open_mutex.

It is actually one ublk specific issue which relies on the current task
for handling IO and providing forward progress, so cause deadlock since
reading partition table(with ->open_mutex) requires the task for handling IO.

> 
> The real problem is holding ->open_mutex over IO, and then also
> requiring it to put the file as well. bdev_release() should be able to
> work-around that, rather than need anyone to paper around it.

deferred bdev_release is not safe, for example of suggestion:

        if (current->flags & PF_KTHREAD) {
                mutex_lock(&disk->open_mutex);
        } else {
                if (!mutex_trylock(&disk->open_mutex)) {
                        deferred_put(file);
                        return;
                }
        }

deferred_put(file) will cause disk released after returning to userspace.

Yes, __fput_deferred() allows that in case of in_interrupt(), which usually
means one abnormal application(close(disk) before completing/handling IO),
but it will cause normal application to release disk after returning to
userspace, it may cause -EBUSY for following syscall.


Thanks,
Ming

