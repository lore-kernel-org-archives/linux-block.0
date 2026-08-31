Received: from mta1.migadu.com (out-139.mta1.migadu.com [95.215.58.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9A46D2DC
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183304; cv=none; b=N5Gi8UzjS3i1epkpM8c0JW3pZDFzAJ3kVKA93fcAzOI8ZLbWhESP2MRXgCISWe/iLfz95M/pLzS2iE3smFtgJRzMbEZrf4xBFe90IzqheoKqP/7U1BOLsKPyvEBagV0O1KHP9OD+SYw0GjxhKSUhqOY4QzItoO0j8ozGWta4HAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183304; c=relaxed/simple;
	bh=3zboqoQNZPjTHn/l/zdkdP5Y2VXiLpVjxZ81GqIMhq0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f5tJlz43uXnbxCnkCWdfqicmRc7SQsZF0OX3rBRz59wQ8o3FGSAOUL+dEDKwqU5uGvk8qtvHOgs8oXOlDuPFoWwRqNOCVIEUmYAnUp/9TxEvmg3yV1Wjtx/E045Wq7wK2SLQ5yo68XxDMJDaaGbxCDtxpdaAxTGT1dkKntio9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PsJ+9orI; arc=none smtp.client-ip=95.215.58.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PsJ+9orI"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3zboqoQNZPjTHn/l/zdkdP5Y2VXiLpVjxZ81GqIMhq0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788183299; v=1; x=1788788099;
 b=PsJ+9orIVsWUPH79D+nqDztdS3OQ7hSx8FVXU72CQHrStYr/UsfYA786aQ4S6i0DL/AX2JZt
 8cuEEA3xrUCkrkX6ozOE5KfAq+QHcHzcbQcB347SUYgdFXI/dj2Zf2Wf5fWV3Cijo2f+OqFPBba
 wfaC8eMaXE1INvHq4MB1+UcU=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1f4d91dd9895fa46;
	Mon, 31 Aug 2026 13:34:49 +0000
X-Mizu-Trace-ID: 1f4d91dd9895fa46
X-Migadu-Flow: FLOW_OUT
Message-ID: <db25197c-b25e-4a05-8e1d-894d19c880d4@linux.dev>
Date: Mon, 31 Aug 2026 21:34:47 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] loop: defer the queue limits clear to a workqueue
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de
References: <20260828072004.273519-1-cui.tao@linux.dev>
 <638dd174-99ba-43d9-b379-5ade06982259@acm.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <638dd174-99ba-43d9-b379-5ade06982259@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bart,

在 2026/8/29 00:34, Bart Van Assche 写道:
> On 8/28/26 12:20 AM, Tao Cui wrote:
>> loop_clear_limits() calls queue_limits_commit_update() directly from
>> the loop workqueue that processes the request.  That does a
>> non-atomic struct assignment to q->limits without freezing the queue,
>> which races with lockless readers of q->limits on other CPUs - bio
>> splitting reads max_hw_sectors, the discard path reads
>> max_hw_discard_sectors - and can let them observe torn values.  The
>> trigger is a discard or write-zeroes request on a loop device whose
>> backing file does not support the corresponding fallocate operation.
>>
>> The code already has an XXX comment saying this should move to a
>> workqueue.  Do that: schedule a work item on the system workqueue,
>> where it is safe to freeze the queue and update the limits using
>> queue_limits_commit_update_frozen().  Accumulate pending modes in
>> lo->clear_limits_mode so that failures between scheduling and
>> execution of the work item are not lost, and cancel the work item
>> before the device is freed.  If the device is reconfigured to a
>> backing file that does support the operation in that window, the
>> stale clear takes effect and discard is disabled until the next
>> reconfiguration.
> Please help with reviewing this patch, which seems more complete to me
> than this patch:
> https://lore.kernel.org/linux-block/c2ab2547-63b3-48cf-87c1-fc53219e360a@I-love.SAKURA.ne.jp/
> 

Thanks for the pointer.  The two patches fix different races though,
so they are not alternatives to each other.

Tetsuo's v7 fixes the teardown path: __loop_clr_fd() racing with
in-flight requests, which is the syzbot NULL deref in lo_rw_aio().
My patch fixes a runtime race: loop_clear_limits() still updates
q->limits from the loop workqueue without freezing the queue when a
discard or write-zeroes request fails with -EOPNOTSUPP, so lockless
readers of q->limits can observe torn values.  The freeze in
Tetsuo's patch only happens at teardown and does not cover that
path - the XXX comment and the unfrozen queue_limits_commit_update()
in loop_clear_limits() are still there in his tree.  The two patches
can coexist.

I'll go review Tetsuo's v7 and reply to his thread.

Thanks,
Tao

> Thanks,
> 
> Bart.

