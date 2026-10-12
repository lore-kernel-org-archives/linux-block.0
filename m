Received: from mta1.migadu.com (out-236.mta1.migadu.com [95.215.58.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91665339B41
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792740; cv=none; b=d/CkCYgHGLnjcyE6VWQowup5EOQzzJKkqTUyivC3OzPow1pFcoN/yLyKA9Tle6L6e2NI5nu8ms6c3N7Uz5aPm6E3Q3YJ2LI0zgVJ1EgxdQZvylEwxPqcjZ3m4NBKovmfc0y4K5V98Tks2or9m0F6HeZM7RUq+9tT03Nx4AiD2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792740; c=relaxed/simple;
	bh=XLJPITQZKsw44OZ97abkcVkwSGp8wEmGJ174ENO+1wg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XZM+fYs5T38AmOeYCqPi4mNKDFttvf0urDYWLeqROgSeXpAlbFnNPXSIwSG45q+ZOS98WFRl6Y0qer3ebDawlTeo3KGYPcaCii/4rd8qLXswffuvbU90YBrARQWO4O26pc/28OQ6Ywc8Gw+iyuJgrG/dHo0a8Z6ED0dUXC62adU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oh2w/wxN; arc=none smtp.client-ip=95.215.58.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oh2w/wxN"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XLJPITQZKsw44OZ97abkcVkwSGp8wEmGJ174ENO+1wg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791792736; v=1; x=1792397536;
 b=oh2w/wxNrnBA6MJsrg0O4++JaoE7hQK+NGzYZ9quOa/OUBRK7GSN2Ia6z1aPtio7wVhV4wWH
 5SQXOrCO7dolVMH3P58LeqEPDohDpCwTMfRD5U+kWshRjN8de90GkJ3yuRZT78CMvY5H+8OSepX
 BpmAGJJjdO7MPTvk9F93qtcI=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 929dcb69c7496456;
	Mon, 12 Oct 2026 08:12:16 +0000
X-Mizu-Trace-ID: 929dcb69c7496456
X-Migadu-Flow: FLOW_OUT
Message-ID: <7e6e2875-29f7-4cad-94f6-5f0e07569481@linux.dev>
Date: Mon, 12 Oct 2026 09:12:10 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Garry <john.garry@linux.dev>
Subject: Re: [PATCH blktests v2 4/4] block/052: add a torn atomic write test
 for block devices
To: Tal Zussman <tz2294@columbia.edu>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
 <20261009-blkdev-fixes-tests-v2-4-fcb3599e47f7@columbia.edu>
Content-Language: en-US
In-Reply-To: <20261009-blkdev-fixes-tests-v2-4-fcb3599e47f7@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/26 00:53, Tal Zussman wrote:
> An atomic write is submitted as a single bio,

nit: A HW-based atomic write is always a single bio. A SW-based atomic 
write - like which xfs supports - does not have such a limit.

> so when its buffer can't
> be fully pinned, the direct I/O path has to fail the write rather than
> submit the pinned part. Otherwise, it submits what was pinned with
> REQ_ATOMIC set and leaves the rest to the buffered fallback, tearing the
> write at the pin boundary.
> 
> This is a regression test for that issue, fixed in the kernel patch
> "block: fail a short atomic pin in bio_iov_iter_get_pages()" [1].
> 
> Issue pwritev2() with RWF_ATOMIC to a scsi_debug device with atomic_wr=1
> from a buffer whose last page is PROT_NONE, so that pinning the buffer
> stops one page short, then read the range back with O_DIRECT and fail if
> it holds a mix of old and new data.
> 
> The write has to span at least two pages so that one can be left
> unpinnable, and the device has to support it atomically. Use the largest
> power of two up to 16K that the device's atomic write unit max allows,
> and skip the test if that is below two pages.

As you probably saw, we have other atomic writes tests and they use 
xfsprogs (xfs_io, specifically) to issue the atomic write and statx.

Is there scope to use xfsprogs again here? I suppose that the gap is the 
mmap and mprotect call.


