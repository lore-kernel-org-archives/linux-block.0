Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F3135A6F;
	Mon,  3 Jun 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434270; cv=none; b=o6gvRNOrsBrnD2LAApQMu6apnQv3T/YpIJoZp6tNIWcQ03XYDglR+FjzOjedXB/BKk5m5yenZvjBR2yBCEs2X6YStt3TzUOBOGp9GWbpy3qFot9jPCYoBNgVw2y3ChQOlV3CXjaeLO3wiul4jQBze+PW2qdSQCWoXYCSNNBTiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434270; c=relaxed/simple;
	bh=E3oU8M74cdXayBkUvHSW5fNZ5YRYFFx9Gb/AKu/gim8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcEwVT/n58/G+8Z8k284QjpbgDb+/YDoD9doYg0GD7232L47Qp1j4/U/g6UiNS1ZnA6LXJUOMh+WIQD1yNfCl/h+P9SVjP8K0hPzjpb4LP2pwzAHVnGBG1ZjIMexNqdhYoYvD5Y9f79csrOZopP8JK6PVbzXSDrfaHaZL5NrOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aEbsEkmu; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aEbsEkmu"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VtKlP3PFXzlgMVb;
	Mon,  3 Jun 2024 17:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717434127; x=1720026128; bh=JtY12Dsp1tQBEk/6vfbTHTst
	26MVwHCkWKlqOeK2IPQ=; b=aEbsEkmu1IKfdgF91m8UlP2hhbJQP6PmNRrkPIf5
	uMJZRhEETTpG146movR80k0eNKOcLCboIi+0MWcxFDo+seiVOYZRTqsbDCaSZ9SG
	Ma3AjQ0HnMy3ZUmJbgJ/29IVBg9pXuBJhUEie7+58pwi7P/b+NX4AgNrDTx2l+f9
	X7Oy5dSPeWxsOBY5E1vuamsrFf12emaY04d3u7pOz6+gVjBmDlMr19aLe1qnGp28
	Lm7tGKC/p4qQj50dVjsPVzC5EKl2xp2Bgtb2DDpzea20Gzm51+JSS43xPYw+b2N8
	1X+gEh8mm837cDSlghj4Jy3E3qr/v+j4+2y0xA8MLGB3SA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fZxuwoU9O47G; Mon,  3 Jun 2024 17:02:07 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VtKlM0Q6TzlgMVV;
	Mon,  3 Jun 2024 17:02:06 +0000 (UTC)
Message-ID: <28fc5c30-ece5-4436-b066-3142147a4547@acm.org>
Date: Mon, 3 Jun 2024 10:02:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: fix validation of block size
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Keith Busch
 <kbusch@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240601202351.691952-1-nmi@metaspace.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240601202351.691952-1-nmi@metaspace.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/24 13:23, Andreas Hindborg wrote:
> +	    ((dev->blocksize & (dev->blocksize - 1)) != 0)) {

Please use is_power_of_2() instead of open-coding it.

Bart.
