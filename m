Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616713B797
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736312849; cv=none; b=Os41jnxZrKfhN4ak3rQs58RsXt7iKwTrcre/a5BYZuKGC4W9HNjdhUJLlMQFym9iVl1HF0NimoVFxhhWdnax27TraddiW6mAhW74xRJlNWMtJYtsW3SzqM244kmS2V4DbHRP2QGLJtVFCkWHMtgoTkR6I2PziBDrRVWWlFs3QEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736312849; c=relaxed/simple;
	bh=bqBr0xW1d3V1i8oRWCeSSgfU3zxuO9CeO+qfm1RfjuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3I9mgKhHReR5sXov89BQ0nYxH0x7DH3i5hCOj9+xM7chKIxzQmY2ZHXpF3jxDRc9DsHFgLv8qJkmTskWAqVqsoyOmTRaj0a4iP1EC8/u8NrFi99J3P7iRwvReOiCRE6Oaycu85QfgIf0zayMFmMOdwzzCTuKlkwDexnKWuCh6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opb/HkYP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opb/HkYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01743C4CED0;
	Wed,  8 Jan 2025 05:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736312848;
	bh=bqBr0xW1d3V1i8oRWCeSSgfU3zxuO9CeO+qfm1RfjuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=opb/HkYPc4/zy8l+mI7dAHl+mstJgDq1t+iqsCcDCDU8oto6F5n1I7iVdbBBlNHDM
	 hmWjbMdq98xkhyyHRyvJPJG7Ls2lzbpdInYiYhdGbOsefYvEYhWWeVgV/3EE+viwf5
	 k2NmESgMek2VJu3SHNHmVoinMLiOva/sdjplLBBlgpAhf6D7MnBesJ80urYf19A5z7
	 oOzixJMNqmOjmD3zoF3s5jJk4yl4ycuMrxnTDkkbvXDYpuFdq45EP7mGY5FVtDnjso
	 VxQCBe2JO0ZipLdz638d8/eEGGGd6XCAj2KPTyG90sayASCIt51SDMt9P21s7q2Zoz
	 jb4QcSsuavzfQ==
Message-ID: <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
Date: Wed, 8 Jan 2025 14:06:44 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de> <Z33jJV6x1RnOLXvm@fedora>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z33jJV6x1RnOLXvm@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 11:29 AM, Ming Lei wrote:
> On Mon, Jan 06, 2025 at 04:21:18PM +0100, Christoph Hellwig wrote:
>> On Mon, Jan 06, 2025 at 07:54:05AM -0700, Jens Axboe wrote:
>>> On 1/6/25 7:24 AM, Damien Le Moal wrote:
>>>> The first patch implements the new "zloop" zoned block device driver
>>>> which allows creating zoned block devices using one regular file per
>>>> zone as backing storage.
>>>
>>> Couldn't we do this with ublk and keep most of this stuff in userspace
>>> rather than need a whole new loop driver?
>>
>> I'm pretty sure we could do that.  But dealing with ublk is complete
>> pain especially when setting up and tearing it down all the time for
>> test, and would require a lot more code, so why?  As-is I can directly
> 
> You can link with libublk or add it to rublk, which supports ramdisk zone
> already, then install rublk from crates.io directly for setup the
> test.

Thanks, but memory backing is not what we want. We need to emulate large drives
for FS tests (to catch problems such as overflows), and for that, a file based
storage backing is better.

> Forking one new loop could add much more pain since you may have to address
> everything we have fixed for loop, please look at 'git log loop'

Which is why Christoph initially started with the kernel driver approach in the
first place. To avoid such issues/difficulties.

-- 
Damien Le Moal
Western Digital Research
