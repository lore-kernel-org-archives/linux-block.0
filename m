Received: from mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7845C6E5
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268462; cv=none; b=NozBopdGgP9JlVLaqMfKrkj117AAX1VLt9YAzRnZ6wCLENukM6XLBeTpBnz9wT0LNeYVRZNv6YKyTuOQU3Vw2wuxfqEzWRRsI+jWap0xS64F2c/3bALhesIXBxge/lgbIqpkyGUG/9Eo5HxJ0XwYZ6VrzePTKyPHMsHXiPx1UGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268462; c=relaxed/simple;
	bh=Ui+mJOf5LU8s3yfba7wVbaGkl51oufP84X8Ob0k+YYI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zfpakq46MgbRf6IToQP9ldQw1NhFNsuDZQAEK8KRQpmIVdbqnmpOuwE5lz1/kSfcca7BBj+m27VcuY/3FpZx7+itsN3sOrMVeJaUX6rHie7cP6mVjF6dt60zIRrf7HcGM6RjHSNJfa4syFw1CyI6oniHXdLsGbdCHOLWZ1v7bB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iC0oWZs0; arc=none smtp.client-ip=95.215.58.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iC0oWZs0"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ui+mJOf5LU8s3yfba7wVbaGkl51oufP84X8Ob0k+YYI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788268458; v=1; x=1788873258;
 b=iC0oWZs018nWMeEafe1s569Uf3+T9JHLubhpc1X0xPT+EdgvSpuzwVkSwGmzOO1VTQ99lkv7
 8EqKquZcLSv+aB29dIl+BW3akJ5DqfaPdABNIVp3aqYQGlQ7AA27QqZSuz3KqrIqCq7i6NCqov6
 59fbRwhWKAPfAW5Vj33dfMTw=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0a8609c32ae38dfd;
	Tue, 01 Sep 2026 13:14:18 +0000
X-Mizu-Trace-ID: 0a8609c32ae38dfd
X-Migadu-Flow: FLOW_OUT
Message-ID: <583d8fd2-3f10-4714-8cdb-5b9d27f3cf11@linux.dev>
Date: Tue, 1 Sep 2026 21:14:14 +0800
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
 <b6af880e-66df-484d-b776-8ca72aac3b1a@acm.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <b6af880e-66df-484d-b776-8ca72aac3b1a@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bart,

在 2026/9/1 00:25, Bart Van Assche 写道:
> On 8/28/26 12:20 AM, Tao Cui wrote:
>> The code already has an XXX comment saying this should move to a
>> workqueue.  Do that: schedule a work item on the system workqueue,
>> where it is safe to freeze the queue and update the limits using
>> queue_limits_commit_update_frozen().
> The patch description explains why queue freezing is necessary but
> does not add queue freeze and unfreeze calls. Is that perhaps an
> oversight?
> 

Good question, I should have spelled this out in the commit
message.  The freeze and unfreeze are inside
queue_limits_commit_update_frozen() itself (block/blk-settings.c):

	memflags = blk_mq_freeze_queue(q);
	ret = queue_limits_commit_update(q, lim);
	blk_mq_unfreeze_queue(q, memflags);

The naming is a bit counterintuitive: the _frozen variant is the
one that freezes the queue itself, while the plain
queue_limits_commit_update() expects the caller to have frozen the
queue already ("The caller must have frozen the queue or ensure
that there are no outstanding I/Os by other means").  The in-tree
callers use it that way too - blk_integrity_unregister() and the
sd.c revalidation paths call the _frozen variant without freezing
the queue themselves.

The old loop_clear_limits() was exactly a caller that did not meet
that expectation, since it ran in the loop workqueue where the
queue cannot be frozen, so moving to the work item and using the
_frozen wrapper is the fix.

Thanks,
Tao

> Thanks,
> 
> Bart.

