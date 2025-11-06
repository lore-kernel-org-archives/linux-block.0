Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1F329C41
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445215; cv=none; b=K7ss5bcG/2Yay0ZzAB6Er6cKciL+bD86hajwA73mnVN4jpaGax6zruZR38m2UiLu45Ri+k/GocJaksd6KtNfQq5j2nW2g36QDCJzIiyh/2VLLrkkQ+f3fnMpHtxVfls3IdQo1dqaL1jXTaZjlVg3wr+CllOMHv0PWuRNFVrpQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445215; c=relaxed/simple;
	bh=1zr6smHDD+phnrSORfXf64ygF9GGhPKJnFai9X25QW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZmiJFkJHcD94RnIItuPVqax1b7TL2pWLZhzdcrzMv2kZZAsujY8Q/sMttVsOGeNs5mP8K8sXDtm0qUNiEWF+bmJvduEtvnHXKOkZWdaDsix4EO9GRbkMcUKDM5UROnS5zQsWpK+T1c/UnoSr1wu6a6L+WO9GPxILQzTXgqdQcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=L2z27ja3; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="L2z27ja3"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d2Rs35gkRzmhZkv;
	Thu,  6 Nov 2025 16:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762445206; x=1765037207; bh=1zr6smHDD+phnrSORfXf64yg
	F9GGhPKJnFai9X25QW4=; b=L2z27ja38+cxSDRX0wNghYyxW9AqfR0yNgvQnEv0
	gSzWKtSDS70rFO9XkKrkSFsZUjzxBG5xQYmavphVl/pLnb/zyQNDGEjv29JWQMnY
	tSkwHUgeUgP5IOFstxDrRMN5K1pFpTNvyhbTCxlBwPp2ICBWsqoZ0OoGCBgGgjtS
	KxeY/RSdoqC/Si/Jo0GdYjcuvgleH58Bl10pM9J45OEYaLwilf+E3YKkZORtyyRx
	IO3Q/ZtRnhGgPC+ch4+W8aGfTkmQh43kMwvrObuleX6IKSE6kCOXYweiWhTdVYua
	7wlhbaFbj5vrCRP2wY6Q7xHUDHTK4dyRdH5+0dNUmB9iKA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WG_lf4nz_Nsz; Thu,  6 Nov 2025 16:06:46 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d2Rrz3CGRzm83Wk;
	Thu,  6 Nov 2025 16:06:41 +0000 (UTC)
Message-ID: <f47feb62-ed23-4b24-abf4-4239e76187af@acm.org>
Date: Thu, 6 Nov 2025 08:06:40 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cached zone reporting fixes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20251105195225.2733142-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251105195225.2733142-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 11:52 AM, Christoph Hellwig wrote:
> this series fixes two issues with the new zone writeplug caching code
> found running xfstests on ZNS devices.

For both patches:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

