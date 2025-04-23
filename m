Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB8DDAD
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427933; cv=none; b=s8vVy1HkKWXsEo49naKDckLLXVwsq8ZCgI0Zo3wYAubonFnDeIePi2NvueUi64JIm2I9PQNGbHUqSoFMdLHU5oNdpj9xbM6+dKCsvGDKygr/dgZsfndi5x+9M2GLkAT4AyNsNsVA0nZAEbPDcYzxd39QcRu4zw6nHiPvewVaj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427933; c=relaxed/simple;
	bh=FcvyhXpxH+/r0Wp28VCvhQTMBSaXJJZ12VZJpHc/+2E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IL1SBkZx7MxO6VMRJ3p4c1jY9CjXANY3UtTGvkDhK7sQDcP2k5n7Ky6BpSWvXUpRyk5GgrZ68jw4pHSYs8HWiXhCceOlpB8iIpLTQvgUh1VWYBDHXC4E53Iww2cd88Or2y+VsI0p91S/nQIsCpUdx3HYRAsOoOkDPHB8KyWPBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 55AF4108B;
	Wed, 23 Apr 2025 19:05:27 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 0093160108083;
	Wed, 23 Apr 2025 19:05:26 +0200 (CEST)
Subject: Re: Block device's sysfs setting getting lost after suspend-resume
 cycle
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block <linux-block@vger.kernel.org>, martin.petersen@oracle.com
References: <32c5ca62-eeef-5fb5-51f5-80dac4effc98@applied-asynchrony.com>
 <aAiKM0-1JJulHLW7@infradead.org>
 <cceea022-a5e3-97b3-62ed-7ead174565a3@applied-asynchrony.com>
 <aAkTDtmOQhBP4NBa@infradead.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <cacb5382-3352-9835-9774-e7c17b5e93fc@applied-asynchrony.com>
Date: Wed, 23 Apr 2025 19:05:26 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aAkTDtmOQhBP4NBa@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2025-04-23 18:19, Christoph Hellwig wrote:
> So I tried to figure out how this happened, but AFAIK even
> the pre atomic limits code (blk_queue_io_opt) always overrode
> ra_pages.  So for nvme in particular this either was introduced by
> 
> 81adb863349157c67ccec871e5ae5574600c50be (HEAD)
> Author: Bart Van Assche <bvanassche@acm.org>
> Date:   Fri Jun 28 09:53:31 2019 -0700
> 
>      nvme: set physical block size and optimal I/O size
> 
> which is so old that my current compiler refuses to build that
> kernel to verify it, or by the fact that you either upgraded your SSD
> or the SSD firmware to set the relevant limit which was added to
> nvme only a little before that.
> 
> No good fixes tag I guess, but I'll formally send out the patch anyway.

There may have been a misunderstanding. I first noticed this on an old
machine with SATA SSDs where I *do* have an udev rule for readahead.
I only used my laptop with NVME drive (from ~2021) to reproduce the problem
and send the email. On that machine I do not have any udev rule to set
readahead since it's plenty fast.

Not sure if that matters, as it was a valid bug after all and now
it's fixed, so thanks again!

cheers
Holger
