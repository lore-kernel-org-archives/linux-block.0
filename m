Received: from mail-m82199.xmail.ntesmail.com (mail-m82199.xmail.ntesmail.com [156.224.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC30197A7D
	for <linux-block@vger.kernel.org>; Sat, 17 Jan 2026 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768693999; cv=none; b=S4SBal/cUxQ3BorpB8p6pM4epcdoXX/M6FwYmbbCs4Uzj/BQ6/lJtjh/28omIQn+QSrQ1de57ApJ9OVVSg4OzGmG+DzdfzB3BCiQ7UdpgNxuPTB99UiEuoHLp6jR6yWmTtQwiqwg2tIrIODNsS1IKbyVO6B07VAJ/hybylpmMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768693999; c=relaxed/simple;
	bh=e+Vqax/BuQkaT9Z3A50Be90HXCv2Tsa8HACcXaqlGd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7HG6vJHqmn52RzsCfcXMHJN3gy29yAzUHtzn4A6yMTa9yVvwBBhxO6ql7YG/ZLV+0O0egvIYOExQ4i1QuCrDF+RIeFG/rNOovsmek3WUSgJZzjLclPWs1Nom3xEjCFqdiaQdCd5mOIkifQ4B0gFt5FXmKiOBppA60LkvlFRpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com; spf=pass smtp.mailfrom=deepseek.com; dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b=CQGamB1R; arc=none smtp.client-ip=156.224.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepseek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b="CQGamB1R"
Received: from localhost.localdomain (unknown [IPV6:2402:f000:5:c001:5d8e:8961:95e5:4104])
	by smtp.qiye.163.com (Hmail) with ESMTP id 310158bf6;
	Sun, 18 Jan 2026 01:03:19 +0800 (GMT+08:00)
From: huang-jl <huang-jl@deepseek.com>
To: ming.lei@redhat.com
Cc: huang-jl@deepseek.com,
	linux-block@vger.kernel.org
Subject: Re: [BUG] ublk: ublk server hangs in D state during STOP_DEV
Date: Sun, 18 Jan 2026 01:03:19 +0800
Message-Id: <20260117170319.51050-1-huang-jl@deepseek.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <aWtvoHe3Yt8xbmdb@fedora>
References: <aWtvoHe3Yt8xbmdb@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bcce94a8d09d9kunm107a9fd8769302
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaShlKVkoYSR9LSkNCTUgYGlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJT0tJQR1LS0tBTkEYS0tKQU4fQx5BQ0JNSkFCTh5OQU9KS09ZV1kWGg
	8SFR0UWUFZT0tIVUlJTUtNTkpVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=CQGamB1R9W4KpfgmqjVC1ldw0b49rLP8vT0KiE2P0vnWzWYQNOaD8rITO74d1oZEO2wWwhCuT/FrQ73+GCNJo0mOKROq1u56A+CN73hAESjeoRLWpksqn2yNjuKjUDWoYpKrSBwdrbietDliguhKBScEeiQKMOePPXCt4UKKop0=; c=relaxed/relaxed; s=default; d=deepseek.com; v=1;
	bh=saft5v32MGJEFwZXUGq387ACC2HNVobO04cpzfMTIRY=;
	h=date:mime-version:subject:message-id:from;

> > - Upon receiving SIGINT, our ublk server will sends UBLK_U_CMD_STOP_DEV to the
> > driver.
> 
> Can you share how your server sends STOP_DEV when receiving SIGINT?
> 
> If it prevents normal IO command handling, ublk_stop_dev() will cause deadlock.
> 
> For example, follows the preferred IO handling in ublk server:
> 
> prepare UBLK_IO_FETCH_REQ uring_cmds;
> while (1) {
> io_uring_enter(submission & wait event);
> }
> 
> If you send STOP_DEV command inside the above loop, you will get the
> deadlock, because inflight and new IOs can't be handled any more.

My ublk server has two threads:

- The main thread: opens /dev/ublk-control and create an io uring. It handles
  all control uring cmd (e.g., ADD_DEV, START_DEV, STOP_DEV).

- A worker thread: also creates an io uring. It will send UBLK_U_IO_FETCH_REQ
  and UBLK_U_IO_COMMIT_AND_FETCH_REQ uring cmd, and handle IO request.

Main thread will first ADD and START device, then listens for SIGINT signal.
Upon receiving SIGINT, main thread issues a STOP_DEV cmd.
The worker thread continues running independently and is not directly affected
by this signal.

(Implementation detail: I am using Rust and the Tokio async runtime. The SIGINT
is handled within the userspace rather than directly inside the signal handler.)

> If that is the case, you may remove the sending of STOP_DEV simply in your
> implementation, and let ublk server exit. Then delete the ublk device before
> ublk server is exiting to kernel, or let your monitor process remove the
> ublk device, which becomes DEAD state after ublk server exits.
> 
> Otherwise, you may have to investigate why ublk server can't handle IO
> command after sending STOP_DEV command.

Based on my previous post [1], **the ublk server gets SIGKILL after sending
STOP_DEV command**, so it cannot handle IO request.

In detail:

1. Flush Kernel Thread: A kworker/flush thread attempts to write dirty pages
to the ublk device. It acquires a folio lock but then enters a sleep state
in wbt_wait() due to Writeback Throttling (WBT).

2. STOP_DEV Command: The ublk server issues a STOP_DEV command. This uring cmd
is processed by an uring kernel thread.

3. Resource Conflict: When handle STOP_DEV, the uring kernel thread also tries
to flush dirty pages. It needs to acquire the same folio lock held by the flush
kworker to submit the I/O.

4. Termination Signal: At this point, the ublk server receives a SIGKILL.

Conclusion:
This creates a circular dependency: the flush kworker cannot be woken from WBT
because the ublk server is no longer processing I/O requests.
Simultaneously, the ublk server cannot exit because it is waiting for the
STOP_DEV command to complete. However, the uring kernel thread remains stuck
waiting for the folio lock held by the flush kworker.

Should we avoid having the ublk server issue STOP_DEV command by it self? As it
is highly prone to deadlocks if a SIGKILL occurs during the shutdown sequence.

Thanks,
huang-jl

[1]: https://lore.kernel.org/linux-block/aWtvoHe3Yt8xbmdb@fedora/T/#mdd14011f6830a7e93a7df9b8df1ea93db91ebc77

