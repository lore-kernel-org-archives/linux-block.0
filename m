Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611105;
	b=xQF3ZHZtCMHMSPh7UoZhspUREL7Ho8lAp4Y3P+0xktkfYi4s9tH++P9Pc/Lfj8Z+8tFm
	 fAg1PEYlHOCWr5ooJfwBR96NkifQTMHFxWDEAYdv7e6tiw1VNZ7L2eBsLRzwY+vOFw3AN
	 3XAbPk9oogtUMY+N7N0ykBlb1bfOgVa5bqBVFbZKi6SQcYIMuyvd4i/moBElv/3qh0rfk
	 7GJcEbJyTWZsK4J39361byHcSlkLtwVPIl1nDsY0olddexKLdkGBB0Bg1K0lI2EGgmMP4
	 1AJZkZYPE2ImtKScyrkqIkTsrVxQ23hQhnGTMJdAc/89Yh9p+WFDlJGNEjgCa6X6nTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611105;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=3H435okC2aPXlVW2Fa6W7wxw/Z7vF5pGv8km0V299YM=;
	b=mAJHcFAtKGDsNV6htOqetoyWVXC1gIINoir8pnPSIK2GPoRrdiQBt5YVwKfZsVvh4unJ
	 JwRfp4a2DiXutaaVAw6WWw8ijOZLay0k0LeyKEAmGXEWxeRnF2AjhKnl1iLibTLfPVOe0
	 ws9gmTlpnNES+LkrqcBaXoGVY742QYzcA70VLeqYzX5eu+nbiTxVwjtJ1gtqsvv12Ij7h
	 G+cse3Lqw7DC46CD5Kj5s9JM79iWS4P2g6wjoSOPuqrfMW9ahKQq82B5mGGlemPvW40zt
	 WuyCSYU6vT2tGplHK/WwjZDis5B85CuUNTdiMMmbZvoxraDf9+o6/R/GWzlu8bcTjVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SAGoAVTh;
	arc=none smtp.remote-ip=95.215.58.186
Received: from mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD6606A327
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 09:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4FD6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SAGoAVTh
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Vu4fFR9w5iyps3r6yy8OCCAMf7XPPfdrsicoyufrmbg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793611103; v=1; x=1794215903;
 b=SAGoAVThMOcQ8uiU+u4xQ1R1epHUZHA0vW84KY0eMlpW12L6bYKXlVcffihKoxjTzk5lhdSJ
 4f590JnlDiHMwsGbYviwDiLjTYQab644FQ5xen8kcd1Lq5Xj/9EcIK+jkuI7LW+DApgZ34NY/62
 fv8ns8RJx618/nzk87E7erwA=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 3234581548410805;
	Mon, 02 Nov 2026 09:18:22 +0000
X-Mizu-Trace-ID: 3234581548410805
X-Migadu-Flow: FLOW_OUT
Message-ID: <6fd764c2-a74a-4455-ab8c-ad9a1345eb04@linux.dev>
Date: Mon, 2 Nov 2026 09:18:22 +0000
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
Subject: Re: [PATCH blktests v4] block/053: add a torn atomic write test for
 block devices
To: Tal Zussman <tz2294@columbia.edu>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20261030-blkdev-fixes-tests-v4-1-d8d18808e965@columbia.edu>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20261030-blkdev-fixes-tests-v4-1-d8d18808e965@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 23:26, Tal Zussman wrote:
> A block device atomic write is a hardware atomic write, submitted as a
> single bio, so when its buffer can't be fully pinned, the direct I/O
> path has to fail the write rather than submit the pinned part.
> Otherwise, it submits what was pinned with REQ_ATOMIC set and leaves
> the rest to the buffered fallback, tearing the write at the pin
> boundary.
> 
> This is a regression test for that issue, fixed by commit 73a0ff6030af
> ("block: fail a short atomic pin in bio_iov_iter_get_pages()").
> 
> Issue a two-page pwritev2() with RWF_ATOMIC to a scsi_debug device with
> atomic_wr=1 from a buffer whose last page is PROT_NONE, so that pinning
> the buffer stops one page short. Check with statx() that the device
> supports an atomic write of that size, then check that the write fails
> with EINVAL and that the range still reads back as the old data.
> 
> Two pages is the smallest write that leaves one page unpinnable, and
> atomic_wr_max_length=256 raises the atomic write unit max to 128K so
> that two pages fit for any page size up to 64K.
> 
> Signed-off-by: Tal Zussman<tz2294@columbia.edu>

This generally looks ok, thanks.

Reviewed-by: John Garry <john.garry@linux.dev>
