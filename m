Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792454429;
	b=omCo9106HZisiLtYXw5gvy1RChFtC18ZMY7nyraTsu6TwuYLIOW2/cbd8M4aW1zlYxJb
	 03dewrIun8PxnOxLHSHdKhm/bIA3cQQIZV29BX08uh2mmMm2zLnZpQsDBLldtZCYOr1wT
	 LMygMiCz32iMpCxhGBLg34yTgUMqDS5sO9rPQ9Wp/rtn3eI77IOy+TNArtGXefC/+as9I
	 fEs+JerKmBj+fmLWcVMfX0X02Pbqd1Z/hmuE+2soV3V8fZwExyA6lDME520zE6tiVp5Zf
	 oFc7nnctz/ZhMarvS/c94ZTWs/D8atrScKXsZza1SsHugQcskH5LPmngyFB+In7KF+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792454429;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Anti-Virus-Server:
	 X-Virus-Status;
	bh=V3XtfME5nYJFtnV1k0UzBEiJjpdPUomFxwMCJHrj+FI=;
	b=LRVSbvGhfWqi+nOVERxEGeOLXvlgqJjv5dfYhgKx3ey+2oCn0JXVgganyh4mBTtrkGcN
	 yNJ67T85p+t2uhhJMLsu5TTpvsfg7iGY6GTk8nIpxn1QZqZBQ5kh58hw8hnu4a2QsAI0Q
	 61IXd0+4lBG6FRo4BuOAzFcCABTwKV4TvXeq67+VKPvyn+LRRhXkXsj6kVQu3wvgBI5qa
	 Bf6/kAGmfhs9B3IzFAx7dGXNByQEbBwwJ6qQ6RdhWqlHcBoSHYDB79sdAycYpjIOH/ZI6
	 muQ5wRbo2bnME8jSVRS+JvsXxmoxPJLUvT3lQE6gJjUn4Tl9RTyUrT/WGE/SE32F3vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F510606A31B
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 00:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F510606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 69K002Tr060355;
	Tue, 20 Oct 2026 09:00:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 69K002u9060351
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 20 Oct 2026 09:00:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <851dd22f-4091-4fc3-b500-dd7f02f8922e@I-love.SAKURA.ne.jp>
Date: Tue, 20 Oct 2026 09:00:02 +0900
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] block: avoid long sync_blockdev() under
 disk->open_mutex during parallel close
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
References: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
 <20261007130851.GA30117@lst.de>
 <4d7c7365-259c-402e-9cf5-d55ad9333200@I-love.SAKURA.ne.jp>
 <380f04ef-902d-4664-9ae3-228692d2efb9@I-love.SAKURA.ne.jp>
 <696e5e7c-e3f1-4181-be2a-8915fd1753cf@I-love.SAKURA.ne.jp>
 <cc2910d3-3113-44d4-94ef-0c8d365fac9c@I-love.SAKURA.ne.jp>
 <53c3ccf7-1a5e-4861-afc0-7cbfd3284655@I-love.SAKURA.ne.jp>
 <d05d7049-70a1-4216-b268-1c209834dc84@I-love.SAKURA.ne.jp>
 <e8d48691-9e29-41e0-9326-fff961b10cdf@I-love.SAKURA.ne.jp>
 <675affec-24ef-4ad6-9987-a33b85b24eed@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <675affec-24ef-4ad6-9987-a33b85b24eed@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav311.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/10/20 6:18, Bart Van Assche wrote:
> An experimental LLM is not happy about this series of two patches.
> Please take a look at the report produced by that LLM and let me know
> whether or not you agree with the findings of that LLM. One way to view
> the attached file on Linux is by using the "glow" command.
For "[PATCH v8 1/2]", we can update the patch if we consider that the direction is an improvement.

For "[PATCH v8 2/2]", sashiko also suggested that we should not try to wait for block layer's queue to
become empty before open_mutex is held. Regardless of "[PATCH v8 1/2]", we can't go with this approach.

No response from Jens or Christoph on
https://lkml.kernel.org/r/4d7c7365-259c-402e-9cf5-d55ad9333200@I-love.SAKURA.ne.jp .

No response from Jens or Christoph on
https://lkml.kernel.org/r/d05d7049-70a1-4216-b268-1c209834dc84@I-love.SAKURA.ne.jp .

We are deadlocked by no response.


Unless we can find the commit that is causing "general protection fault in lo_rw_aio" report,
we will need to handle this report by waiting for block layer's queue to become empty after
lo->lo_state became Lo_rundown. I consider that LO_FLAGS_AUTOCLEAR is an irregular who is not
compatible with the block layer's rules. __loop_clr_fd() needs to be done asynchronously
while guaranteeing that __loop_clr_fd() completes before returning to usermode.

