Received: from mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415333D969B
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215403; cv=none; b=G4Fk/7HV8byNEnNpx0CdVIscBNz8vqQAk/bsCzNCWAZDWF6Em8E/allc/NP674IXGmvgwvDwobXmjctCS3qrMpV3l7/79XjHx1B25HusyuDW+kENKDMiLK0FGGxGyPQ9oiaPfcpRXB4XiiXfeK6Ljoj/EE7lXvzEJIHfEOk+Ssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215403; c=relaxed/simple;
	bh=GQHuhxJCAncBaQVKo7GMRXj7Nh6OWCBUlL5cJMK8x2Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PZCqW+QQ3KO4q9OOrCrJ8YcEZiE2S5mr8VUfk0+5GLuiO6sBYogL4O+77iQ/xgSsywuGsV6TJ3vdSWySeBnChVp2GLAHAPYPTgKLUjJiwYsB7o6kJT1GUxNbmXL54bBreFB116+IxW1gV52wk6WoqLB8HV+Xxe/6W0s4b+8KjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vKbj6H9+; arc=none smtp.client-ip=91.218.175.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vKbj6H9+"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GQHuhxJCAncBaQVKo7GMRXj7Nh6OWCBUlL5cJMK8x2Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787215399; v=1; x=1787820199;
 b=vKbj6H9+3k82aiflthCz2NaNrBntyKxGMa0nROpI3wP1MfBMVE5nYAxZLWHIhS/U8R3Fn+8d
 ClkpRpirWaCAZT1yluaGSGMjUdsq+AGR7pV1W3O3QK28s9SBdEpbeYTjw3UNMX4NI9BTcZUGzJJ
 fRHnYmSloI0Y/GPhjdbg+HOM=
X-Envelope-To: linux-block@vger.kernel.org
Received: from [192.168.110.173] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 361b6ab4fee2842c;
	Thu, 20 Aug 2026 08:43:08 +0000
X-Mizu-Trace-ID: 361b6ab4fee2842c
X-Migadu-Flow: FLOW_OUT
Message-ID: <8cd35439-66b6-4bc2-94bf-dd2dde47aad7@linux.dev>
Date: Thu, 20 Aug 2026 16:43:02 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-block@vger.kernel.org, hch@lst.de,
 yukuai@kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH blktests] tests/throtl: add a new test 009
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20260813144041.1715866-1-cui.tao@linux.dev>
 <aoRRlY5AeMaRBXMh@shinhome>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <aoRRlY5AeMaRBXMh@shinhome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi Shin'ichiro,

在 2026/8/18 20:42, Shin'ichiro Kawasaki 写道:
> On Aug 13, 2026 / 22:40, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> Test the boundary condition of removing a cgroup while it still has IO
>> queued in the blk-throttle queue.  The queued bios must be flushed through
>> without any blk-cgroup or blk-throttle warning.
>>
>> The dmesg check matches any blk-cgroup / blk-throttle warning rather than a
>> single call site, so it is not tied to one symbol.
> 
> Tao, thanks for the patch. Does this test case have corresponding kernel side
> fix? I'm guessing that your recent kernel patch is the fix. If so, I suggest
> to mention the kernel commit in here and the test case header comment below.
> 


Thanks for the review.

No.  Christoph asked me to add the reproducer to blktests in that RFC
thread [1], that's how this patch came about.

The WARN it catches came from yukuai's "store blkcg in bio" RFC v1, which
is not merged: bio_pinned_blkg() re-looked up a blkg that blkg_destroy()
had already removed from the radix tree, while a queued throttled bio
still pinned it.  RFC v2 fixed it with blkg_lookup_any(), and mainline
passes this test too, since the blkg stays findable until queued bios
drain.

>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>> See also the related blkcg "store blkcg in bio" RFC:
>> https://lore.kernel.org/r/20260804065313.2092022-1-yukuai@kernel.org
>>
>>  tests/throtl/009     | 67 ++++++++++++++++++++++++++++++++++++++++++++
>>  tests/throtl/009.out |  2 ++
>>  2 files changed, 69 insertions(+)
>>  create mode 100755 tests/throtl/009
>>  create mode 100644 tests/throtl/009.out
>>
>> diff --git a/tests/throtl/009 b/tests/throtl/009
>> new file mode 100755
>> index 0000000..1f4ed67
>> --- /dev/null
>> +++ b/tests/throtl/009
>> @@ -0,0 +1,67 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2026 Tao Cui <cuitao@kylinos.cn>
>> +#
>> +# Regression test for removing a cgroup while IO is still queued in the
>> +# blk-throttle queue.  The queued bios must be flushed without any
>> +# blk-cgroup or blk-throttle warning, and without leaking the blkg
>> +# reference they pin.
>> +
>> +. tests/throtl/rc
>> +
>> +THROTL_BLKDEV_TYPES="nullb"
> 
> Is there any reason to run this test case only for nullb? If not, I suggest to
> remove the line above to run it for both nullb and scsi_debug.

> Is there any reason to run this test case only for nullb?

The test just exercises the blk-throttle/blk-cgroup path on cgroup
removal and doesn't depend on the device type, nullb is simply the most
convenient.  Dropping THROTL_BLKDEV_TYPES is fine with me if you want
scsi_debug covered too.

[1] https://lore.kernel.org/r/20260804065313.2092022-1-yukuai@kernel.org

Thanks,
Tao


