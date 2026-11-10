Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300129;
	b=40drp6WdadKri+0/zhew3FmwEmio+B2lTkadVMjqoNAPFQe0BAp8DaE8b6IBq5hfVDOA
	 VvMHJx0yo5DrA2Sezr08mdtWULtJPQz3Aoi7IySWqSJaCvytoJNMs8g+N7yPB0WmHcDC4
	 6shIcRFYwCLeE236hPcrCvu+t/EHzkOemOyhj+084TX+0EtTF3UMjJw+vpdfblQ6jmmNH
	 iFJw+PId6y9E7aoO1IEidAwwVbV5YLz/BOeT0jzMY2hTF1cg6mxcxMzAkal4Yp9Rv5rrA
	 0ffL0tVVX12kqRHsxsrK8j+DQgdLm6Z7WPYSlikdf2FYyBQUgmwRIN6AHHLTdypk+7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300129;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=i4brgHD7VQEv4fdV28u/B9VtbZT4Ktb9wxX1zeKCj/Q=;
	b=CxuK/yvgPJhshvcFcp1fL66CjemMclTPcZvZfve/tKKyFoow36/aZjyuz3Z+bKz3g8kG
	 WyWKHj8Bl0ZQp+BkIAk832Ksx55JF7IQTurulcjCCouScjMb5wsWXdNqNOvBkoHbIckZ7
	 rrwqofodw0cc7QmfTAN40e8ge8fp+c4EuzQmFTTvVuyIZs79AlekaXY/tPhpTGDBnDx59
	 0fWBRMT+C4baiT+Ejx6mFd1UyPqMv66yNcXy3wIBhmPe5ZUklCrrbnSgqN4X7ueRwWwEG
	 91G+GhWEknwZyU13fQrHEfBEfvu5+YrsgiXxbBL9+IF5ggK8T2xC2A3dyHKZyOnHsrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N3tgEyP7;
	arc=none smtp.remote-ip=91.218.175.219
Received: from mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B90606A333
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 08:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00B90606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N3tgEyP7
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MpAEUXW15AK0vZ7aMmJr1Fk1OrZcbJXYROoJ2MHayrg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794300126; v=1; x=1794904926;
 b=N3tgEyP7RxctFPQmoRdYR2r4Te36Wz0U9e2Jct14oyePSp0EbUx9bDvtkzxhbSetWpo1+OP7
 cJy6r2e9T2feyomyfktBlQnPxtQ7baonVCFJ6E39tmLyotgwDwFe1fOP/kNujdeNvZ5mTGUBeoD
 BbxFRpmWO7pzAoD9byh2vOJI=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 6fd72c2406077e29;
	Tue, 10 Nov 2026 08:42:06 +0000
X-Mizu-Trace-ID: 6fd72c2406077e29
X-Migadu-Flow: FLOW_OUT
Message-ID: <f9fd6fc0-8694-45e5-bf00-77bd961ab788@linux.dev>
Date: Tue, 10 Nov 2026 08:42:05 +0000
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
Subject: Re: [PATCH 2/2] iomap: remove the atomic write length check in
 iomap_dio_bio_iter_one()
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
 <20261107-blkdev-atomic-bounce-v1-2-f66344262096@columbia.edu>
 <3fc46788-d86d-44c5-8606-385d96fede4d@linux.dev>
 <c27b9521-7c4f-41ff-88f8-55313b5f395c@columbia.edu>
 <4022d4f9-5e2e-45d1-b9b8-208c80f82ecf@linux.dev>
 <21793564-61f4-4d57-b375-1271ad9bc70c@columbia.edu>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <21793564-61f4-4d57-b375-1271ad9bc70c@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/26 22:46, Tal Zussman wrote:
>>> What specifically would you want to see tested? I can do an atomic write with
>>> a partially unmapped buffer, with and without stable writes, and check that it
>>> fails and that nothing is written.
>> Just something similar to the blktests case which you added.
>>
> Sounds good, I'll add it to the queue.

Thanks

> 
>> BTW, have you tested this partially-unmapped case for CoW-based atomics
>> on xfs? You can just do that by setting atomic_wr=0
>>
> Yeah, I just tested it. It behaves as expected: returns -EFAULT with the file
> unchanged, both with and without bouncing.
> 
> The single-bio check depends on REQ_ATOMIC, which only the HW atomic path sets,
> so it doesn't apply to CoW writes, both before and after this series.
> 
> In terms of consistency, the unmapped buffer returns -EINVAL on the non-bounce
> HW path (from bio_iov_iter_get_pages()) but -EFAULT for all other paths. That
> should probably be made consistent across HW and SW and bounce vs. non-bounce,
> but that's a separate change.

Yeah, we should fail for the same reason on HW- and CoW-based atomics. I 
would like if any such rules could be documented and we ensure that both 
HW- and CoW-based atomics always fail for non-adherence to the rules.

cheers
