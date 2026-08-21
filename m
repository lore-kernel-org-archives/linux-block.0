Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA142AD16
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333570; cv=none; b=CWBQFRRdbYwsG1ycoYjFNMSTxsRphkFWVgeqv2m8SDop3J9wIA+F2DFoX4VP7eVSNonOI30Sz0g9PDZ5K9Ei9eazARf2pB6oZU5Zu4VLgcVDW7eaT6m8MEYQ2dlH6kiVj7JoLtlmE0MPhKndD+R1TRX/8YUD+B16UdB3skTHNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333570; c=relaxed/simple;
	bh=DrXklj97TBbMne+LgsyMWmWRfQzbkI2ZyzVcXOYF9qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7eH+hFzr8gE8rimb0Ugb/SQnfzcVW0xJ9GfqlQ6j3ReFspqMkME1quehtqvKKr9Be9FFw8XlcpAYmCCLA1noVcE/B0Kji1J+2/OT5ppgWABuEq9evfWltstTQvKkVsSsOAY1L0Kw/e9QwcrJ/5gweeE1cM640gBl2tScEv3kdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=27EglJAx; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="27EglJAx"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hRS7N4kRrzlfqB0;
	Fri, 21 Aug 2026 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787333561; x=1789925562; bh=2DDbspAaTTS29HC9vbVfCv+k
	sJNmh3RbbAG4eXaFWtE=; b=27EglJAx2NG8tAoYRIAPgou7Wk+zVBjcPIteuwUA
	Xslt3g5ja86DuHTKq8OxEf7kKf4xHsHpCS15ckQj9HHm9mxpaqmfJOoiGUqdHjij
	JabOcIF8TJYSbOOKgeozEQdhCm5hPmrbFciJuVJdItGOwwcVjom/EVcktgD8d/TH
	EOf5alUcnvi0Mti0McfFv+j5QkgohedcaY8SB4fSkNUX/QdyuP6p85LABjbI+WHW
	T6LAO18xanYsD2Hder/OMGIg3yxPPX6MotVvUR24wjh0z8v2DpBycf2OGk6ACxTf
	xMYEx6tS4y9QfDphXx9/4kW9cjUxhU5BRySSN6jwfyAIMg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8PYIlmz1Hycu; Fri, 21 Aug 2026 17:32:41 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hRS795hfbzlfvpS;
	Fri, 21 Aug 2026 17:32:37 +0000 (UTC)
Message-ID: <4e62dfee-53f4-4cb0-b92d-f2ce9a5b0852@acm.org>
Date: Fri, 21 Aug 2026 10:32:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [block] general protection fault in lo_rw_aio
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>
Cc: Gary Guo <gary@garyguo.net>, Mark Brown <broonie@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Boqun Feng
 <boqun@kernel.org>, Theodore Tso <tytso@mit.edu>,
 kernel test robot <oliver.sang@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <cdf41ad3-783f-4a14-8343-c893d6c50524@I-love.SAKURA.ne.jp>
 <f5cb9935-1497-474a-8e96-661914f18a71@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f5cb9935-1497-474a-8e96-661914f18a71@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/26 5:46 AM, Tetsuo Handa wrote:
> On 2026/08/03 22:34, Tetsuo Handa wrote:
>> I am waiting for your response on
>> "[PATCH v5] loop: Fix NULL pointer dereference in lo_rw_aio()" at
>> https://lkml.kernel.org/r/30ccdd3c-6353-4a0f-bdc7-230ec3bf4765@I-love.SAKURA.ne.jp .
> 
> You have never responded for 4 months since I first contacted you at
> https://lkml.kernel.org/r/e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp .
> Nobody being interested in this problem has caused multiple issues for linux-next tree.
> Will you become responsive on this problem?

Since I didn't like the proposed solution I took a look at this issue
myself. If nobody objects I will integrate the patch below in my loop
driver patch series.

Bart.


From: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] loop: Freeze the request queue in __loop_clr_fd()

When closing a loop device, lo_release() invokes __loop_clr_fd() when
disk_openers(disk) == 0. However, disk_openers(disk) == 0 does not
guarantee that all I/O submitted by loop_queue_rq() has completed.
Asynchronous direct I/O requests submitted via io_uring or Linux AIO can
remain in-flight while the device is closed, and worker threads may still
be processing enqueued commands.

If __loop_clr_fd() clears lo->lo_backing_file to NULL without freezing
the request queue, in-flight commands may read a NULL backing file pointer
or access backing structures after fput(), resulting in NULL pointer
dereferences or use-after-free bugs.

Fix this by freezing lo->lo_queue in __loop_clr_fd() before clearing
lo->lo_backing_file and unfreezing the queue after updating the queue
limits. Hold lo->lo_mutex before calling queue_limits_start_update() and
blk_mq_freeze_queue() to follow the established lock ordering
(&lo->lo_mutex -> &q->limits_lock -> &q->q_usage_counter) and prevent
circular lock dependencies with fs_reclaim.

Fixes: 18048c1af783 ("loop: Fix a race between loop detach and loop open")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/block/loop.c | 14 ++++++--------
  1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 619759cb28d2..de50f17e7d7a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1182,29 +1182,27 @@ static void __loop_clr_fd(struct loop_device *lo)
  	struct queue_limits lim;
  	struct file *filp;
  	gfp_t gfp = lo->old_gfp_mask;
+	unsigned int memflags;
  	int err;

  	mutex_lock(&lo->lo_mutex);
+	lim = queue_limits_start_update(lo->lo_queue);
+	memflags = blk_mq_freeze_queue(lo->lo_queue);
  	filp = lo->lo_backing_file;
  	lo->lo_backing_file = NULL;
-	mutex_unlock(&lo->lo_mutex);

  	lo->lo_device = NULL;
  	lo->lo_offset = 0;
  	lo->lo_sizelimit = 0;
  	memset(lo->lo_file_name, 0, LO_NAME_SIZE);

-	/*
-	 * Reset the block size to the default.
-	 *
-	 * No queue freezing needed because this is called from the final
-	 * ->release call only, so there can't be any outstanding I/O.
-	 */
-	lim = queue_limits_start_update(lo->lo_queue);
+	/* Reset the block size to the default. */
  	lim.logical_block_size = SECTOR_SIZE;
  	lim.physical_block_size = SECTOR_SIZE;
  	lim.io_min = SECTOR_SIZE;
  	queue_limits_commit_update(lo->lo_queue, &lim);
+	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
+	mutex_unlock(&lo->lo_mutex);

  	invalidate_disk(lo->lo_disk);
  	loop_sysfs_exit(lo);



