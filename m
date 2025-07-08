Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F72E4264
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991110; cv=none; b=Hk3IWwSbeVZH88tnyASYIPjJ6eCPGI60M4zbCc0As+R5l6lNIMULkEbqO1ehLFlfIUrT8qgS7VdnrDf63c2fji7Rla+DJItsYfqoBQQnzJqwqOqgKYkI50MEPenDCQ3KuLjqGw3+DDPuTJn/VQ6BY3uiBqjilBLZPlTNWrCgY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991110; c=relaxed/simple;
	bh=Nt1OhngUp2vLVCwYepPmx6F0BX9J31zlXuv8oHxwxss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hh6ubQsNP6DGlGMvQBA43BCesbo4rhc6OEFWkpEuN5/zuMqoHzGAaQekDqLtmS9AlK41tFMr0b9K04AChfc3sVppRh5lwLx2ojtX9noH7y6xAMcViVAAqDHNoYjZQt6N7gG8nv4ufINs451vNTrKHYB5IhFEhm/GQjW4NKQh0AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=f+hbE5Fx; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="f+hbE5Fx"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bc5hg0vLyzlfnCV;
	Tue,  8 Jul 2025 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751991106; x=1754583107; bh=a1utIRAbDvpkVaoplAtruh1J
	zA+Gd2Cpy9tKzJAzh4o=; b=f+hbE5FxQOBKijJAgtO9ZZBCES0TC8oDKvzD6KKb
	snc/FoDWL9KO4p6gjSth/WoGrKcpzkvabX/uDV5r9OfrnESECL+udXpiyAT6w0/A
	3cb2w4un3gf14IaUs5Yqq/39prKDIx9pXsj25jENI04PK0W2wtK4B87RkuwlUsk8
	QkQBsVJAGt0L23qQUY6N7cBkpalXQgvzGfRYtiP+jvKjr36voqOHScXanO9AaQY3
	1NL93g+aldKnQoaYz3nbWCl1s6nz62Hxq7zgFBPPL5eUJiUD/4PS2PMpjloqiZNu
	wOpJCx/RQ1LWSnyX1RYl8YJge3tFpArbnnBw7kAWA/oxVQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 54xF69uiw6s1; Tue,  8 Jul 2025 16:11:46 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bc5hc2NTZzlh0dn;
	Tue,  8 Jul 2025 16:11:42 +0000 (UTC)
Message-ID: <b23c05be-2bde-424a-a275-811ccc01567c@acm.org>
Date: Tue, 8 Jul 2025 09:11:41 -0700
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250708095707.GA28737@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 2:57 AM, Christoph Hellwig wrote:
> That still doesn't make it sensible to keep the q usage counter
> elevator for unlimited time.  See nvme multipath for how we can keep
> bios around forever without elevating the usage counter which is
> supposed to be transient.  Note that dm-multipath should in fact
> already be doing the right thing in bio based mode as well.

Hi Christoph,

I will look into modifying the SRP tests in the blktests repository such
that these use bio-based mode instead of request-based mode.

However, that won't make the regressions disappear that I have reported.
Many users prefer the request-based dm-multipath mode because of better
support for I/O scheduling and merging. For more information, see also
this cover letter from 2008: [PATCH 00/13] request-based dm-multipath
(https://lwn.net/Articles/298882/).

So the question remains what to do about these two regressions:
* The deadlock triggered by modifying a sysfs attribute of a
   dm-multipath device configured with "queue_if_no_path" and no paths
   (temporarily).
* Slower booting of Linux devices that modify sysfs attributes
   synchronously during boot.

Thanks,

Bart.
