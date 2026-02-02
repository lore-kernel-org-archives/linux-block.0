Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC22A1AA;
	Mon,  2 Feb 2026 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770072467; cv=none; b=cW+h13T3Ygz0HYrym6lKNUoPkcLkW02vjKj8+DvRv+Z6t1Eh8o68IQmHFSEVdrmfMVg1W5rMe1JOqtTmZB3zw5OXtimLiv5EETu+bG+ZB9WBE58V08qcBE5e2gKiPOx81BzLbCQpUoBtVxl4RLXVR6JJMsy5+IN2M+eK7CXijbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770072467; c=relaxed/simple;
	bh=SPpBEUvu6r8zw8PNhiYZfHfRjOBsvaCErYOCwPHwVZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXg+tHW8sn0eGiqzTgURz+cotl1RpLUAe8l4T3KjEpUvcJnZ3swe6onC49KRphHyU9odOqyYN3wlHHBvUgG3kpuRmwnPFoluKe8uWMlTIVQWmGN/gW6OKmjn3vDEEwqCvhJG1VkeCAtBZ+oPJhV1w3s93qIO3FkeUqZm620UJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qgNAskiP; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qgNAskiP"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f4hZz4Bt7z1XLwWq;
	Mon,  2 Feb 2026 22:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770072457; x=1772664458; bh=kMLi0PRdQ2R4Lc8dp/YJ9+g2
	e2BNpL4rDmGrhxAGpGc=; b=qgNAskiPgtyPs88fYXCcTcy8TuKMyQcdilZV/wIr
	+1wLHZoN9hZ+uPCPcHHAEE5kGNKvhDj9K74yGZB7Ap15YfO6xalexA9r9LzVxhfc
	kAyPzkRqtI3d62EXp0JtscfFGRWv4aPT0edWzrw8tzAoCrvqczbzvEMc14xpUW8z
	gAccdKKlxVIpgXcaqE6uxq8AB8RtZn/e3YWYTS+y77mrRS2uX+P+eh/p94WsDsIR
	liFCDFGTjWhEeXdHTtmg6LW1ADrCn2b+3WRiy3QwllNMRCuUYHXhpJE9YwT/PvsC
	qg+1pnoIJhWHjAWGEl/KCufqESgemUFlFoDIEJqNpT7ajA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nui1yG5mA9PR; Mon,  2 Feb 2026 22:47:37 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f4hZw0Qwcz1XM6Jk;
	Mon,  2 Feb 2026 22:47:35 +0000 (UTC)
Message-ID: <dc1ac2e5-1db1-49b5-847d-a10a611027ae@acm.org>
Date: Mon, 2 Feb 2026 14:47:35 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ricky WU <ricky_wu@realtek.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev>
 <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com>
 <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
 <380f75c7adc04cbab38cfd2f82bd0c6d@realtek.com>
 <d46dcebe-ca58-44c4-87ee-cade2e478572@linux.dev>
 <4205fde06ecd4a7489b03ef25e5e4011@realtek.com>
 <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
 <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org>
 <CAPDyKFqic-rFe95g657MdZHtdPXTmFmYQG4ZSBV56S3DhMEF-A@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAPDyKFqic-rFe95g657MdZHtdPXTmFmYQG4ZSBV56S3DhMEF-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/26 8:30 AM, Ulf Hansson wrote:
> Seems reasonable to me, but how do we distinguish that it's a
> battery-powered device?

RPM can be enabled or disabled from the scripts executed during boot.
At build time it should be known whether or not the device is battery-
powered.

> Are we considering UFS a technology that is used solely for
> battery-powered devices or is there something else we consider?

I think there are devices that use UFS and that are not battery-powered,
e.g. smart TVs.

> Although, a tricky part when moving it upwards into the more common
> layers, is that those latency constraint values may have a very
> different impact, as the numbers are platform specific, right?

 From the UFS driver:

cpu_latency_qos_update_request(&hba->pm_qos_req, on ?
                                0 : PM_QOS_DEFAULT_VALUE);

In other words, if no block I/O is ongoing the CPU latency is set to
PM_QOS_DEFAULT_VALUE (-1 or no constraint) and if block I/O is ongoing
the maximum CPU latency is set to 0 (no CPU power savings allowed). I
think these parameters are independent of the platform and storage
device :-)

Bart.

