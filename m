Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA01E3DC4
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107218; cv=none; b=eWKWCrRl/ks7Vo5xMXDIqtSjuZCIEiDWoq3hNTrw3NnaToQIyfSWAeXf4Jes2TZ7QITXfIhZwZz1YgxoGn4IMS8LyxvQhALpPnicxMJqTjC69keQITKkZfoXXYHsUw3390fywbLC/9ebAf5Ggd9ad8rh3CsLpS6HBBjdHJ4Yy+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107218; c=relaxed/simple;
	bh=t9uUYn7FXJf3DyErtJP571abEiJcq9vAwPK5Sq5flJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSfCwsLhdFZ11M8J0vLzkFetGsnejD+LXX5y7Fu/8NS639+8mGY/HcWe6lMtBXggd9zsNfWf3bVP5Cg4ZS8X5ulVOg98lQbYHIuoNYAcfyFapIFQSilEpfYOmtjoFOAYCdr2e81mY6MHSGWM50RXgGlDcOQvx7ZisZf8Wx8xLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sCFmYUpF; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sCFmYUpF"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Y8vqZ13cxzlff05;
	Fri, 13 Dec 2024 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734107208; x=1736699209; bh=s5s3NkdmjGElpsH5FsFf4or4
	stF03C2uY6pc+Qj0XwQ=; b=sCFmYUpFk8pV70nBpcgI6nn9xZwjRS/y4/GUOhDb
	lzPQhKS+/t7Q7pBAy5wQTgOovo1/wqRCndwH+PcdDG5Yj1CK8X5BkihJs0SLOw1J
	jzHUEkexGU9VDl2zWn2MDq5EEB1CTqSIlg0/pD4VfzDuNSrapLEaHwkFLP6DufSX
	aFYtu8zzd2tj6Wy6O3UKBrlc2catGmY0zez5ooQ7h+H6y4p/xXzxeTdKnU04aIM8
	TeRnHhx4mbOxeGa8r2GA86HsgvAVefn+Tuz1HqDhxmhS4SaemIiHsnCyRN6EtzSy
	BGcZp0GhDX9g3EFH3GwLkUz0wAZR+KZ9+E9Qdwas1ciq9g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OQ4qNgmJXL6n; Fri, 13 Dec 2024 16:26:48 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Y8vqV2lSvzlff0Z;
	Fri, 13 Dec 2024 16:26:45 +0000 (UTC)
Message-ID: <7399171c-6cf3-4e07-b4e5-1d5d362198ba@acm.org>
Date: Fri, 13 Dec 2024 08:26:44 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: Fix queue_iostats_passthrough_show()
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20241212212941.1268662-1-bvanassche@acm.org>
 <20241212212941.1268662-4-bvanassche@acm.org> <20241213044615.GC5281@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241213044615.GC5281@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 8:46 PM, Christoph Hellwig wrote:
> On Thu, Dec 12, 2024 at 01:29:41PM -0800, Bart Van Assche wrote:
>> Make queue_iostats_passthrough_show() report 0/1 in sysfs instead of 0/4.
>>
>> This patch fixes the following sparse warning:
>> block/blk-sysfs.c:266:31: warning: incorrect type in argument 1 (different base types)
>> block/blk-sysfs.c:266:31:    expected unsigned long var
>> block/blk-sysfs.c:266:31:    got restricted blk_flags_t
> 
> Maybe turn blk_queue_passthrough_stat into a an inline wrapper so
> that it automatically does the bool propagation and callers don't
> have to bother?

Hi Christoph,

There are about 16 functions in include/linux/blkdev.h that test a 
single bit in q->queue_flags or q->limits.features. Do you really want
me to convert all these macros into inline functions?

Thanks,

Bart.
