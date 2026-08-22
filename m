Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748503793D2
	for <linux-block@vger.kernel.org>; Sat, 22 Aug 2026 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406633; cv=none; b=U1p8ZqUtvMtnRk6yv/h8kmK//hCxCtB/XkPRQIZOfD/Atn0YoghNeJJJj9TWQQLV0wBeTQAFDp1whZO5BfxYeW3Wq+GFQM8xg60iVKmEdnvfrD5si6hXrBZgTR3jLIrv+JyuWOpNU/9G6lyaKXodN/QQbMBEnWYYISZLikw+J4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406633; c=relaxed/simple;
	bh=hqDBzTvUVVC05n6vEn5M4UmGwvFCGNJk8e/Rv2ko+s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXJj3Ed3xr6DopU9vWK5G9/GWmkEPsK+wx1uT+Lj9Tk12f3LUKHkfro/ff5nhnXxC0GIEiR2C4iXAzXCu386qst5YVc7/Yvi1BzSkGQEyXoUt5KnD+cdY7Mps/26wJdDGlCriSmndFNh/FxMTf1ZJ4aUzasiPsn6qWZnUtzbIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=viq2RaMV; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="viq2RaMV"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hRz8R0ltFz1XM30h;
	Sat, 22 Aug 2026 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787406628; x=1789998629; bh=hqDBzTvUVVC05n6vEn5M4UmG
	wvFCGNJk8e/Rv2ko+s8=; b=viq2RaMVZsEbX/o4MupiMErbAN3NYMcFtl0TWnXj
	fzBcF9DRCMgzZFu5OkJOmti1QQUCHmWg2lsWf030G045N6P6g70URgloAhqxf+3Z
	wHXPq9JiNCFUhZ77DcOs7NE/YGRGbZeG/ZbpRfrQ3qvxNvqzsttcw4ac3pRsd0fs
	0TFGqWbtoMO57su6VtDcPv1x39l1uhR7gFCCWQymtXR+48WzfrJiEFctzCm0EQ7W
	8kMEhAEsFd9Uy/ivNyjhye81d8L4DGS5FpC07SfhhjUQHgjHuGy56hHuo8jOCayc
	SaWazC/Gj5kHOvPmkx+MNlGF8a/6aXNSsjG6Xcl5lRvpyQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6YmKW7993lKm; Sat, 22 Aug 2026 13:50:28 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hRz8M29YRz1XM5kt;
	Sat, 22 Aug 2026 13:50:26 +0000 (UTC)
Message-ID: <470917eb-987d-47e1-98af-1628b4fb3c08@acm.org>
Date: Sat, 22 Aug 2026 06:50:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] block/{029,030,031}: relicense from GPL-2.0 to
 GPL-3.0+
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Li Zhijian <lizhijian@fujitsu.com>,
 Akinobu Mita <akinobu.mita@gmail.com>
References: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/26 3:53 AM, Shin'ichiro Kawasaki wrote:
> Relicense these test scripts under GPL-3.0 or later to resolve this
> incompatibility.
Acked-by: Bart Van Assche <bvanassche@acm.org>
