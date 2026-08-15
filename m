Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2030C366
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786805630; cv=none; b=d61tGzwWS6cVLq+VYgoyDANW6Xa3e2ZS9lTc7D7OnjDSaT0yf6/ZaOHXMjt5iVuyQngRQ+EXxu0NbR9eVIDz2/6qlYQ2MHcFoP95gBS3wMwlfqM1qoeJ4F9tW+h+KxleLxnQ1X75vKeN7BfY6UskPDp3fQe5M2p3FYPb6zv9sYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786805630; c=relaxed/simple;
	bh=B3A1zgaVkv1xGxXjKL0MF6b7IdTYZGIK4x2IcZqtA1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJSZpXFiqXKzBhfYbq/Ea7klapPkwFGZmNWftiAlLeKa3wpS0vjaRhZMv59+/bTb+jDw7W5wfBiXYqstb8iUEcM5o+EbO3g27SQNfq/QrIYBlJzpn6tVis1z0nsvPXhO7eh56vrrMj6zsxYXGCRrjEJpvBv/tO/c2k62NQn/flA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mxx2Rx59; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mxx2Rx59"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hMhtZ0Hd4z1XLyhF;
	Sat, 15 Aug 2026 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1786805617; x=1789397618; bh=9r4kofoaDLpKFKfrYj2be6vD
	G6j8psunfYC0hXG3H+c=; b=mxx2Rx598RhwB21tuQNIHbqmagMWHFK/799zNDJB
	OxZYEtLeGI7ep1Zjpjc5cncXuu+uCduFzQcRZdqnJzkvtm7gT2zglRxpbcPMB0b+
	VwVIU+SDS0uxeWM8ogYT5VeEG9FYDjjmXSFDnEyoxU4cUDYZgiOYrsSx+iB0UuWs
	smTghobvcKlIQ+jjdQgEv5If4T2r9iwOs+YKT9ZBTxKoNcu+CdtkQ+HvB+hWMSpl
	ASmfC+KVZi8lMvqnc+qzG73zyNKwV5CP1dNSZ7kdyOMTeXJ8tXaLrnv1ptiy989J
	tXILOKGq2dDTCvVKJ2yg3yYS5YjdZgr+tr9xo7xIbXDM5Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id F9BXe1GVqUKt; Sat, 15 Aug 2026 14:53:37 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hMhtN6ch0z1XM30w;
	Sat, 15 Aug 2026 14:53:32 +0000 (UTC)
Message-ID: <5aa41f8f-91e2-4883-8706-5bd5c1a8d273@acm.org>
Date: Sat, 15 Aug 2026 07:53:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 00/10] null_blk: fix init/exit races and memleaks
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, yukuai@fygo.io, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org, linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20260725022509.714271-1-wozizhi@huaweicloud.com>
 <d16887c3-8ebe-4bf3-8a11-9cecb39e315b@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d16887c3-8ebe-4bf3-8a11-9cecb39e315b@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 7:13 PM, Zizhi Wo wrote:
> Gentle ping on this series.
> 
> It's been a while since I posted it back in July. The series fixes
> several issues in null_blk. Most of the patches have already collected
> Reviewed-by tags.
> 
> In the meantime, I've noticed others starting to send patches for the
> same problems, which suggests these fixes may have gone unnoticed.
> Reviews on the remaining patches would be very welcome so the series can
> move forward.

Hi Zizhi,

If no feedback from a maintainer has been received after two weeks, a
good way to draw the attention of that maintainer is to rebase, retest
and repost your patch series.

If Linus Torvalds releases kernel 7.2 this weekend then the merge window
for kernel 7.3 will open on Monday. Reposting of this series probably
should wait until the merge window for kernel 7.3 has closed.

Thanks,

Bart.
