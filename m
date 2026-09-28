Received: from mta1.migadu.com (out-253.mta1.migadu.com [95.215.58.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD930EF9A
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590625; cv=none; b=jcFsVrto9JucagYQiPCZK76NwZ2BeTFG+yJBDbWwUIJ873VQMCR6D4UywYWu6qvl8lkg6o2mwPdActpwJST6oUjm+WXOQ5A3tBAHUL++Q8yWUy9RhuFzK8phoZHpU2e/zp3f/jbkXgzqAUy4o1+FxyohPZ0sCmqeG38ttYgVPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590625; c=relaxed/simple;
	bh=S7HtiBzV+yUVKZNtjNQwGaJxuNAlauHZCZOJNOl8s7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWNwBLa519HyhcxSODgMxbQIXYQ43GsOsCGnOUWmQ7KXgtiJh1HYO6vxCMvrspTEJZ6bo2SAPpdNj2xtH/ZYmzSWa0TUt7gLJM1S5+icGpu502wq/ARWZCQQ99fPAqxZjbAvd5RYW+bw5jGe2fI8fOXayOhSuz5f590MqvMxiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i/6+7XK5; arc=none smtp.client-ip=95.215.58.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i/6+7XK5"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=S7HtiBzV+yUVKZNtjNQwGaJxuNAlauHZCZOJNOl8s7s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790590620; v=1; x=1791195420;
 b=i/6+7XK5BIJzUq7myo9J/2fbAPlOher3Z0TrsisQS+8D5qmGHb874cptiUkxyzwKusR27YOF
 rIO/tmoQwJfWvUYdDDbKEZnMbBT98mgU4qE8KPfKX3oOXLSm9TJGjgYYHeN9fjy9dwMXomLbmQn
 zVum6wgvDIwN06pBivbsYLK0=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 951cb6a3c28291de;
	Mon, 28 Sep 2026 10:17:00 +0000
X-Mizu-Trace-ID: 951cb6a3c28291de
X-Migadu-Flow: FLOW_OUT
Message-ID: <2258be48-9e35-4139-b423-82400746db8c@linux.dev>
Date: Mon, 28 Sep 2026 11:16:59 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] fix NVMe multipath partition diskstats
To: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260921083752.1154316-1-john.garry@linux.dev>
 <5fe0a938-aaf4-46cb-8fba-3524586ac5b4@oracle.com>
 <20260928091428.GA29876@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260928091428.GA29876@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 10:14, Christoph Hellwig wrote:
> On Mon, Sep 28, 2026 at 08:30:10AM +0100, John Garry wrote:
>> On 21/09/2026 09:37, John Garry wrote:
>>
>> A reminder on this one ... or are we just going to leave this broken?
> 
> I find the amount of overhead and relatively invasive code very
> offputting, and I still don't understand why we now have a strong
> urge to address this after 10 years.

Nobody noticed (that the values are not maintained), I guess.

It may also be useful to have the per-path disk partition table in 
future for other reasons.

Anyway, your call, so I'll leave it for now.
