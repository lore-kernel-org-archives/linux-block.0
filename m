Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519EA2E5413
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995005; cv=none; b=SDDnQGC2EHud8el7IQ7wLSuFWp/M+vjQT1mpvYiAv0T1m9fbQmaUeJkZze0sH7jq+JvL395AZFTCE2obhiafLSOMG6fOLroLrop9sMhTRjqdmyu10vKmmtL6pykONkjMlHnuqMPwLqf2Rkn5ZKRPzB4PnH7+v1HjzVaq002kg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995005; c=relaxed/simple;
	bh=eUP3JaiXG+DMEzOAb2wgJ2VWKHPtTPNI0LO58wsrGLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p79wzPiGuKQw+dEzpfLz9ahg2kk8IR4QWa4NBrR2ntV8uycds1lA+0pn6gnZ2kjrk3VjwBWQDZ4tvdfD+PGbD0HHQdIaSI3mNLGJdULqoB+j3T7vSffPZnLe3YrzRjLm865fAaxNaTdgVlavhtmCRZnhX8GnbvJi5/JE0er35h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QCQdsRIH; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QCQdsRIH"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bc77Z2SjZzm174C;
	Tue,  8 Jul 2025 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751995001; x=1754587002; bh=oa3V0r8GVwOogBFXfFzHlk1B
	gIGONNISYt59L70T1SI=; b=QCQdsRIHKcXMYqSKwePVPl1vffoufIYsIB1GyRxq
	ZE/v6s5oC7UxbgOKQJp37VEQXjnsiEoTRhElDMAHhAJGNSU1F0VjDAA+GDXaVOW4
	8qgLM2lVbgLKXJU2qSg7tGTbxXYQQuq3kdjrcrOdO2XVRPiz5aDST3avVNzGapHs
	xjXO+lrGYlOkdqtV5hf/llh4LsXcSctSP58Jerje4mXuhzuDDFRWCstZqllRmq9Y
	1038stEY/TAEqu/rLxyKT3Dgd0PEIppc38DpG9uXjgoWBqBjFXcS+h9UVRqjUx3J
	m366g9NZ0LMxdPLxpFQvW3/dP3IediZTQQQRrV8IP/5KFA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9rj1NpAaYIa7; Tue,  8 Jul 2025 17:16:41 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bc77W4GNPzm10gS;
	Tue,  8 Jul 2025 17:16:38 +0000 (UTC)
Message-ID: <4e5f8e45-93c4-4833-97b9-c97d5db0c2e1@acm.org>
Date: Tue, 8 Jul 2025 10:16:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue attributes
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20250702182430.3764163-1-bvanassche@acm.org>
 <20250703090906.GG4757@lst.de> <918963a5-a349-433a-80a8-6d06c609f20e@acm.org>
 <20250708095707.GA28737@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250708095707.GA28737@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 2:57 AM, Christoph Hellwig wrote:
> That still doesn't make it sensible to keep the q usage counter
> elevator for unlimited time.  See nvme multipath for how we can keep
> bios around forever without elevating the usage counter which is
> supposed to be transient.  Note that dm-multipath should in fact
> already be doing the right thing in bio based mode as well.

This blktests patch should be sufficient to switch from rq-based to
bio-based dm-multipathing:

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index e157e0a19560..167428b1f53e 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -267,7 +267,7 @@ mpath_has_stale_dev() {
  # Check whether multipath definition $1 includes the queue_if_no_path 
keyword.
  is_qinp_def() {
         case "$1" in
-               *" 3 queue_if_no_path queue_mode mq "*)
+               *" 3 queue_if_no_path queue_mode "*)
                         return 0;;
                 *" 1 queue_if_no_path "*)
                         return 0;;
diff --git a/tests/srp/multipath.conf b/tests/srp/multipath.conf
index e0da32e29917..dffea925466f 100644
--- a/tests/srp/multipath.conf
+++ b/tests/srp/multipath.conf
@@ -8,6 +8,7 @@ devices {
                 vendor          "LIO-ORG|SCST_BIO|FUSIONIO"
                 product         ".*"
                 no_path_retry   queue
+               queue_mode      bio
                 path_checker    tur
         }
  }

With the above patch applied, the following deadlock is triggered by the
SRP tests:

Call Trace:
  <TASK>
  __schedule+0x8c1/0x1be0
  schedule+0xdd/0x270
  schedule_preempt_disabled+0x1c/0x30
  __mutex_lock+0xb89/0x1650
  mutex_lock_nested+0x1f/0x30 <- queue_limits_start_update()
  dm_table_set_restrictions+0x823/0xdf0
  __bind+0x166/0x5a0
  dm_swap_table+0x2a7/0x490
  do_resume+0x1b1/0x610
  dev_suspend+0x55/0x1a0
  ctl_ioctl+0x3a5/0x810
  dm_ctl_ioctl+0x12/0x20
  __x64_sys_ioctl+0x127/0x1a0
  x64_sys_call+0xe2b/0x17d0
  do_syscall_64+0x96/0x3a0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
task:(udev-worker)   state:D stack:27360 pid:8369  tgid:8369  ppid:1758 
  task_flags:0x480140 flags:0x00004002
Call Trace:
  <TASK>
  __schedule+0x8c1/0x1be0
  schedule+0xdd/0x270
  blk_mq_freeze_queue_wait+0xf2/0x140
  blk_mq_freeze_queue_nomemsave+0x23/0x30
  queue_ra_store+0x14e/0x290
  queue_attr_store+0x23e/0x2c0
  sysfs_kf_write+0xde/0x140
  kernfs_fop_write_iter+0x3b2/0x630
  vfs_write+0x4fd/0x1390
  ksys_write+0xfd/0x230
  __x64_sys_write+0x76/0xc0
  x64_sys_call+0x276/0x17d0
  do_syscall_64+0x96/0x3a0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Thanks,

Bart.
