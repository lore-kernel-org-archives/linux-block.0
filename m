Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC01F4712
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447844; cv=none; b=eZJQIONIyvVWhvfiOp4Gyle2YJUecTTrtjPtDUujVSOBG2QbV2nNAEop2Z9ocmHRTt3HOtVU6x70V4+z2+2dF0EejV6vvyPNRCUUdVl9Mq5CHHUGj0OcmfGriiZa/RWUBywUG16MirwTj88YLeELHdOt9HxLLV8+KVCoDBoTAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447844; c=relaxed/simple;
	bh=X8kPMBXq/B9zcZfzfbM361s5nCRZKSMDuC7SAEVGplA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqE54xTNa6+dUbtDnRyMdo+uT3ip6JsLy45KxecRFLVJLkFwuglQPBCKD1LvfULoSsCXysDHsDMPB1ZwUsZqB2Acqo8Ai0MJXcQtruHiaYWQfjbj9go+JBzZIk9tTdif/69zJfiecFRJ6gvgBDPFoSfHGEHEJNOyMAxVC7G9ohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCNFAqoa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCNFAqoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF945C4CED3;
	Tue, 17 Dec 2024 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447844;
	bh=X8kPMBXq/B9zcZfzfbM361s5nCRZKSMDuC7SAEVGplA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PCNFAqoalpTQLnjA9tPYUr9IViQjCwP5ba3boLHo6jfmLgrlHXvE72H1HS+j5gow5
	 8nmR1saFJYqFHRnRWHssMHzNzenLRXyurm3Wslq7x9z6MKK8ASojN5ir+pPsnEBfF5
	 dMMj+vUsS8dljGDbkjALgC0JXNbXM4PC4gxLDnhxwZBYTUe/stxeIW5pvxB6y6mbmV
	 WUzjitV8aUbaXIGw9Z6hK6jgl+FBJIezrbDjE462e5ypWdDZijiIdfyw8AC0knhVBQ
	 ygvEDCw1uyVHrlPSrDK0G4ZcCXaHwimUf+SwW2mXTmXOo2SuIEo6inLNmV/JRWVeqV
	 jdeNXDMCPBfow==
Message-ID: <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
Date: Tue, 17 Dec 2024 07:04:03 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241217041515.GA15100@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 20:15, Christoph Hellwig wrote:
> On Mon, Dec 16, 2024 at 11:24:24AM -0800, Bart Van Assche wrote:
>>
>> Hi Damien,
>>
>> If 'qd=1' is changed into 'qd=2' in tests/zbd/012 then this test fails
>> against all kernel versions I tried, including kernel version 6.9. Do
>> you agree that this test should pass?
> 
> That test case is not very well documented and you're not explaining
> how it fails.
> 
> As far as I can tell the test uses fio to write to a SCSI debug device
> using the zbd randwrite mode and the io_uring I/O engine of fio.

Of note about io_uring: if writes are submitted from multiple jobs to multiple
queues, then you will see unaligned write errors, but the same test with libaio
will work just fine. The reason is that io_uring fio engine IO submission only
adds write requests to the io rings, which will then be submitted by the kernel
ring handling later. But at that time, the ordering information is lost and if
the rings are processed in the wrong order, you'll get unaligned errors.

io_uring is thus unsafe for writes to zoned block devices. Trying to do
something about it has been on my to-do list for a while. Been too busy to do
anything yet. The best solution is of course zone append. If the user wants to
use regular writes, then it better tightly control its write IO issuing to be
QD=1 per zone itself as relying on zone write plugging will not be enough.

> We've ever guaranteed ordering of multiple outstanding asynchronous user
> writes on zoned block devices, so from that point of view a "failure" due
> to write pointer violations when changing the test to use QD=2 is
> entirely expected.

Not for libaio since the io_submit() call goes down to submit_bio(). So if the
issuer user application does the right synchronization (which fio does), libaio
is safe as we are guaranteed that the writes are placed in order in the zone
write plugs. As explained above, that is not the case with io_uring though.


-- 
Damien Le Moal
Western Digital Research
