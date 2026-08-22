Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417B1A9F96
	for <linux-block@vger.kernel.org>; Sat, 22 Aug 2026 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787360566; cv=none; b=XxlkpaxJClFO4geQBDB1Ohieb4uNYx7+41gmh1RtzPaQuPNi6zSkswuP36uBfeJQ5wbqo3VeizysbJ+HRZF1sraMI4txl5sBcPwBpOk8Yhw4J6tVQujZrMGz8dowfmolNwNUB6liyHWlCuHRJDc2ssQgR7f34oETHbC54MsGhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787360566; c=relaxed/simple;
	bh=2GgCh0t0MFrL8n4SPYTLxUD310GG27/lTfTMfPU7nq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ek8u66vLTpAkRpd+2sk8p78eLd43IOAJtgk5+o6PO93I2OXoZHmjyWAJOJQsv6KjvzAQMwcfXN56Foxsim9TCst3JL5pnXSobW0yUhev4OEST7aClG7U5ffqHx+YwNpC4i3VdlmgqQt1FXkgfbcDUJFMQb+zzdmPoTHAxYWBywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67M12ZKE035784;
	Sat, 22 Aug 2026 10:02:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67M12ZFA035780
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 22 Aug 2026 10:02:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <34c3f72d-1d4f-4e0f-bc06-bc562e39a6f6@I-love.SAKURA.ne.jp>
Date: Sat, 22 Aug 2026 10:02:35 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [block] general protection fault in lo_rw_aio
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: Gary Guo <gary@garyguo.net>, Mark Brown <broonie@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Boqun Feng
 <boqun@kernel.org>, Theodore Tso <tytso@mit.edu>,
        kernel test robot <oliver.sang@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>
References: <cdf41ad3-783f-4a14-8343-c893d6c50524@I-love.SAKURA.ne.jp>
 <f5cb9935-1497-474a-8e96-661914f18a71@I-love.SAKURA.ne.jp>
 <4e62dfee-53f4-4cb0-b92d-f2ce9a5b0852@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <4e62dfee-53f4-4cb0-b92d-f2ce9a5b0852@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/08/22 2:32, Bart Van Assche wrote:
> On 8/21/26 5:46 AM, Tetsuo Handa wrote:
>> On 2026/08/03 22:34, Tetsuo Handa wrote:
>>> I am waiting for your response on
>>> "[PATCH v5] loop: Fix NULL pointer dereference in lo_rw_aio()" at
>>> https://lkml.kernel.org/r/30ccdd3c-6353-4a0f-bdc7-230ec3bf4765@I-love.SAKURA.ne.jp .
>>
>> You have never responded for 4 months since I first contacted you at
>> https://lkml.kernel.org/r/e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp .
>> Nobody being interested in this problem has caused multiple issues for linux-next tree.
>> Will you become responsive on this problem?
> 
> Since I didn't like the proposed solution I took a look at this issue
> myself. If nobody objects I will integrate the patch below in my loop
> driver patch series.

Here is a review comment from AI Mode in Google Search.
I and Google consider that your patch is not sufficient.
At least your patch should be reviewed by sashiko, by posting your patch to ML.

----------
Thanks for working on this patch. 

However, I am concerned that using blk_mq_freeze_queue() alone is insufficient 
to resolve the underlying synchronization issues in the loop driver. While 
freezing the queue successfully prevents new I/O requests from entering, it 
does not guarantee that all asynchronous work currently pending or executing 
in the driver's internal workqueue has completely finished.

If we rely solely on freezing the queue, we still leave the door open for several 
critical race conditions:

1. NULL Pointer Dereference: Asynchronous work items might still trigger and 
   attempt to access structures or resources that are freed during cleanup.
2. Deadlocks: Unsynchronized worker threads and queue management tasks can 
   easily end up waiting on each other, causing a complete lockup.
3. Incomplete Work: Internal worker threads might be cut off mid-execution, 
   leaving the block device state corrupted or uncleaned.

To safely prevent these issues, we need to ensure that the driver's internal 
workqueue is completely synchronized and emptied. Instead of just a queue freeze, 
we should incorporate a proper drain_workqueue() mechanism (or drain the specific 
workqueue handling the async tasks) to guarantee that no lingering asynchronous 
workers are active during the critical path.

Could you please update the patch to include a thorough flushing/draining of 
the loop driver's internal workqueue?

Thanks,
----------

