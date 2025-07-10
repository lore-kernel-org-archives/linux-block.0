Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9512E371A
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175786; cv=none; b=KvfpkNXvWEA+U26LLh7j8zti2BbfWHScZrLGOPf/ck0AcavHtJ8xalorhnEP/o/7vXDMK49TKHGGqMXQK9c8UdXQ6GPiJHT0BOmHyF+ihyy49ztvppO0+gPo94NP/zzXzaCe+afrkIiHWIqGRjslFG0rMIGShnbuXD5+jSwF4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175786; c=relaxed/simple;
	bh=PHExjR5sUCr/dIMwasPpvtJmrc1ZJu6Yd2geJFDUr/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LY96aj+15yoeSO8lk8hhb6L6Ro22N+zbddbHXrRUuOzACIXY0oSpajTXGNGqiTRgfwFzTVdHvKjmdPJ8CI+PtSau9a5NH0gvFVbFqmwPW8EzXQzCal8NgnnKsI2U2jgueC3sE9dEO/xmFNTCetWrzLX82leumFOPqsEKgMUfd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZehXJXq/; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZehXJXq/"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bdQ063B6zzlgqxq;
	Thu, 10 Jul 2025 19:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752175781; x=1754767782; bh=9oGuNN0a4KAnhpHlWwBA3Nzo
	aGuyNqZTFwK/IUJeZ8s=; b=ZehXJXq/8hQfJpENi9TVfLt9D24dKEZsP+pHcaUI
	9pYkOP+56EAr6s8QxKHtgTWyizcriNNw+QrxpfuWd72pItu5ZkvFrJ1Hoq/75U86
	yeNhm5JpjE0e+Ze5MUmYIH8YcGTN1Jn9G5vuqN+IlJK8P5n20jdca2KYZMX90B52
	yZsVWC1aaLvbx+tvpT2XXRp1ht4VohOO8nCiDG2w1K5R5c0ZUctIDS9WEwfBRm3b
	p8jqWE4NNd/Fizvfl4g/p88V0yG+qNMf9jzdpTMoA+ZBcjEPaVhuhhDK8XuWV8ok
	CnEq40Kiou2Nn+mbioyDVgywi3kfqhpwcf5NrE5K7G3reQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AUr03zJnOpha; Thu, 10 Jul 2025 19:29:41 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bdQ036dcSzlgqyn;
	Thu, 10 Jul 2025 19:29:38 +0000 (UTC)
Message-ID: <750d4fbd-b3f4-40b6-b07e-f0c47fef6dba@acm.org>
Date: Thu, 10 Jul 2025 12:29:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue attributes
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20250702182430.3764163-1-bvanassche@acm.org>
 <20250703090906.GG4757@lst.de> <918963a5-a349-433a-80a8-6d06c609f20e@acm.org>
 <20250708095707.GA28737@lst.de>
 <b23c05be-2bde-424a-a275-811ccc01567c@acm.org> <20250710080341.GA8622@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250710080341.GA8622@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/25 1:03 AM, Christoph Hellwig wrote:
> On Tue, Jul 08, 2025 at 09:11:41AM -0700, Bart Van Assche wrote:
>> * Slower booting of Linux devices that modify sysfs attributes
>>    synchronously during boot.
> 
> So which attributes are regularly modified?  Note that for read-ahead
> it should be safe to drop the freeze as unlike the others it is not
> used for splitting I/O to the limits accepted by the hardware.  So
> we could probably drop the freeze IFF the patch documents that it is
> safe.  But it still won't fix the root cause.

I can't answer the above question for all Linux distros. But I can
answer this question for Android. Here is what I found in the AOSP
platform code, which includes startup (.rc) scripts for all Android
vendors:

$ repo-grep -nHE 'write (/sys/block|/sys/class/block)' '**rc' | \
     sed 's,.*/,,;s/ .*//' | sort | uniq -c | sort -rn | head -n5
      46 read_ahead_kb      # Implemented in block/blk-sysfs.c
      27 scheduler          # Implemented in block/blk-sysfs.c
      20 slice_idle         # BFQ I/O scheduler
      17 comp_algorithm     # zram kernel driver
       4 discard_max_bytes  # Implemented in block/blk-sysfs.c

Thanks,

Bart.

