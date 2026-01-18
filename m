Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4C1FF1B5
	for <linux-block@vger.kernel.org>; Sun, 18 Jan 2026 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768737025; cv=none; b=LhBCXnD3vL7WSspJd+Nba6r7lp9TtVM3WB7v43gdqKsFz+c4IVWwk5lwqpue/OeQouYv5RpG+9IqffJl1AaAYsWcNfGY1JgXZK7xSS8/dtQ20J9Xyy9pcGe3aFevQBOG9DdRYqH7lgkEQ72+la10Qbg0Pw3M29yJbjoZFE5d0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768737025; c=relaxed/simple;
	bh=haYEmqW1xYa28j7GsTwkouxqSs8l1i0GsLqCi0yGVbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFQDhP4DpwY/cgegpsTMReuvCFZZBlQHajqxBbdi1nc+Lb4xH0mqY8zWDL92JDjpsxmm2X5pkb12aMRT3DUPrc39ouHMGQ5F6y7X30QXBQO51tgaf5gUo3IyZwOTMcPDTbB9+fBaOSJo0E2Ae+Xq5M9hRL5toeXlMQJoCO81HrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5S5Z307; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5S5Z307"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768737022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Avyi4TcRtR7bl7jc4qokt46STDbO/fz8quOE93JAFSc=;
	b=c5S5Z307gnO0no9wNcurmqBZ7c90BTzbC2QaMS7JDSD46/V7qOPRpy6dr205frKgTTzuw0
	z1aXbsSSCSWg/qNvtocUhqnW4CtJ6n73M+ZjmhFGedVDlNkYcrKzLj4kwntXkTpl7JsoY9
	98vOcgp1Efla65sg8pFmP5sHwz1BTbg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-d24zxqkzPXuJVQj6kFne1Q-1; Sun,
 18 Jan 2026 06:50:18 -0500
X-MC-Unique: d24zxqkzPXuJVQj6kFne1Q-1
X-Mimecast-MFC-AGG-ID: d24zxqkzPXuJVQj6kFne1Q_1768737017
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 983241954B06;
	Sun, 18 Jan 2026 11:50:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.19])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE5211800285;
	Sun, 18 Jan 2026 11:50:14 +0000 (UTC)
Date: Sun, 18 Jan 2026 19:50:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: huang-jl <huang-jl@deepseek.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [BUG] ublk: ublk server hangs in D state during STOP_DEV
Message-ID: <aWzI8XXbN7z2JcNh@fedora>
References: <aWtvoHe3Yt8xbmdb@fedora>
 <20260117170319.51050-1-huang-jl@deepseek.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117170319.51050-1-huang-jl@deepseek.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, Jan 18, 2026 at 01:03:19AM +0800, huang-jl wrote:
> > > - Upon receiving SIGINT, our ublk server will sends UBLK_U_CMD_STOP_DEV to the
> > > driver.
> > 
> > Can you share how your server sends STOP_DEV when receiving SIGINT?
> > 
> > If it prevents normal IO command handling, ublk_stop_dev() will cause deadlock.
> > 
> > For example, follows the preferred IO handling in ublk server:
> > 
> > prepare UBLK_IO_FETCH_REQ uring_cmds;
> > while (1) {
> > io_uring_enter(submission & wait event);
> > }
> > 
> > If you send STOP_DEV command inside the above loop, you will get the
> > deadlock, because inflight and new IOs can't be handled any more.
> 
> My ublk server has two threads:
> 
> - The main thread: opens /dev/ublk-control and create an io uring. It handles
>   all control uring cmd (e.g., ADD_DEV, START_DEV, STOP_DEV).
> 
> - A worker thread: also creates an io uring. It will send UBLK_U_IO_FETCH_REQ
>   and UBLK_U_IO_COMMIT_AND_FETCH_REQ uring cmd, and handle IO request.
> 
> Main thread will first ADD and START device, then listens for SIGINT signal.
> Upon receiving SIGINT, main thread issues a STOP_DEV cmd.
> The worker thread continues running independently and is not directly affected
> by this signal.
> 
> (Implementation detail: I am using Rust and the Tokio async runtime. The SIGINT
> is handled within the userspace rather than directly inside the signal handler.)
> 
> > If that is the case, you may remove the sending of STOP_DEV simply in your
> > implementation, and let ublk server exit. Then delete the ublk device before
> > ublk server is exiting to kernel, or let your monitor process remove the
> > ublk device, which becomes DEAD state after ublk server exits.
> > 
> > Otherwise, you may have to investigate why ublk server can't handle IO
> > command after sending STOP_DEV command.
> 
> Based on my previous post [1], **the ublk server gets SIGKILL after sending
> STOP_DEV command**, so it cannot handle IO request.
> 
> In detail:
> 
> 1. Flush Kernel Thread: A kworker/flush thread attempts to write dirty pages
> to the ublk device. It acquires a folio lock but then enters a sleep state
> in wbt_wait() due to Writeback Throttling (WBT).
> 
> 2. STOP_DEV Command: The ublk server issues a STOP_DEV command. This uring cmd
> is processed by an uring kernel thread.
> 
> 3. Resource Conflict: When handle STOP_DEV, the uring kernel thread also tries
> to flush dirty pages. It needs to acquire the same folio lock held by the flush
> kworker to submit the I/O.
> 
> 4. Termination Signal: At this point, the ublk server receives a SIGKILL.

It is _not_ related with WBT or write cache.

When your monitor sends SIGKILL, do_exit() is actually called, but
io_uring_cancel_generic() blocks on io_wq_put_and_exit() because STOP_DEV
can't be completed, then do_exit() can't move on, and finally the ublk cancel
function can't be called, then ublk char device can't be closed.

Looks something which might be improved in future, but it highly depends on
(complicated) io_uring's cancel code path, and I believe there isn't
any way for ublk to get notified when do_exit() happens from `kill -9`.

> 
> Conclusion:
> This creates a circular dependency: the flush kworker cannot be woken from WBT
> because the ublk server is no longer processing I/O requests.
> Simultaneously, the ublk server cannot exit because it is waiting for the
> STOP_DEV command to complete. However, the uring kernel thread remains stuck
> waiting for the folio lock held by the flush kworker.
> 
> Should we avoid having the ublk server issue STOP_DEV command by it self? As it
> is highly prone to deadlocks if a SIGKILL occurs during the shutdown sequence.

So far there are at least two ways:

1) don't provide signal handler for SIGINT, or simply call exit() in the
signal handler, and ublk block device is removed automatically when ublk
server is done in case of !USER_RECOVERY.

OR

2) provide signal SIGINT handler to stop device, meantime not send SIGKILL
in your monitor process. This way works just fine if your ublk server is
well implemented, which often requires you to handle timeout in the server
implementation.


Thanks,
Ming

