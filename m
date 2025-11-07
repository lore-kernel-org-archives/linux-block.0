Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E8927B4E1
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531623; cv=none; b=qy2h8w9U1zq2O96Cs5IaZHI2T/X47KwH06LD06vExLy5JqF39oKEr/I7uYUmvIQLjGVn9o73VWIwnq08mxgJaU7P/pJ83Ay3uPVM9e2kVzWLnVMZ9L3h5o6IfmORdyGlPH9VlCMZX0kh2XeTnf0F6oUJYBIwIg5kOx2hVBiH83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531623; c=relaxed/simple;
	bh=LM/Ythlg4ltfQt0M8jSMETHJEQv41Tdhfs/bqz30MDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clyja7HZxk5viFPe+xdnEsO5iAiSZ53bORXZsq57CQwZAf60q96mGq9DiXwson/HdH7d4QVf9VGaTNNZ5jf6VxzEeHSRnL/3+ML4tcFu3M7nymdO/hYByl2NZ55hGtGqNwSUwxKQEPoUkHiE5YML7hPhnELyhp23Sg6sOY7nSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=35A3QBMv; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="35A3QBMv"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d33pl1T00zm0ySP;
	Fri,  7 Nov 2025 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762531613; x=1765123614; bh=LM/Ythlg4ltfQt0M8jSMETHJ
	EQv41Tdhfs/bqz30MDY=; b=35A3QBMvVerKZAtGQrTy7urOIj2AoEuRv1k/i2D0
	3dSfmP/2VmOFxqDCFi1FED2mZPnjcmQWGKGodANIElZWPZJekxzfyj4l5iXikTdZ
	gG+5RwCVaelOzRehNslYM2EN8B2X2hhns9U4Lc/7c+pztke6g6+qbbpRXsYZJWKJ
	jtev2BrWLSn/0p0BJ5XxqKIrhzBDX7SVsHGkexjdOIN4VBthFbbMOTIYY+JwG/3O
	QGJiO/osncClHPPnrTxgMIidBvvERQYI1IqoqlFgUTc72jxk1mXC+B24LYzBJZRa
	LpokeevWDimqTF5KpCiHpd+Dr417kztVdg29ZfezNA8hRg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OTfSjMMZaQp5; Fri,  7 Nov 2025 16:06:53 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d33pf1djHzm0ySX;
	Fri,  7 Nov 2025 16:06:49 +0000 (UTC)
Message-ID: <e4a495ce-9cda-46d6-9857-dc5535414ea8@acm.org>
Date: Fri, 7 Nov 2025 08:06:47 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] block: improve blk_zone_wp_offset()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20251107063844.151103-1-dlemoal@kernel.org>
 <20251107063844.151103-2-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251107063844.151103-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/25 10:38 PM, Damien Le Moal wrote:
> blk_zone_wp_offset() is always called with a struct blk_zone obtained
> from the device, that is, it will never see the BLK_ZONE_COND_ACTIVE
> condition. However, handling this condition makes this function more
> solid and will also avoid issues when propagating cached report requests
> to underlying stacked devices is implemented. Add BLK_ZONE_COND_ACTIVE
> as a new case in blk_zone_wp_offset() switch.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
