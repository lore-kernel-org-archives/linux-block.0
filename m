Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE913DDCF;
	Fri, 17 May 2024 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715968430; cv=none; b=ZTYQHropLJQEWqtdt+N+bUTLHHLvspycXgOtUHzox286CSlde+Cjkmp0/qgieHUCyF1d9abgfsxg5ublj7Vg7DYBs9V1o8DxVqXQ11xQOiboQjzY6/SFn7BhM3hnWj1QpQYAXgpC2yXg0CvQZIQgDMRLIFgu9eGMLT7+I1645C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715968430; c=relaxed/simple;
	bh=jQXTQPeZqoXtx1IhRfOgOt67vYHFNjCd5WEjfEKAqBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3H8/E1qw/l1SSdsm0oomy+RkEaP5C1m82Y7dMrAAt4Buh7wfJr5C/0vhHl0907xZaT6UkYcVOE1j2e+wVXzYNnUdPXw+Ue84oaHfyOGVPuuFDmiyXc/wDe2Je/wE4ktReq3Fh5qLgaNonO39M4q+xvoCWB/IJfYX1PxONnqQtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zOQCDy+J; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zOQCDy+J"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vgvhk527TzlgMVL;
	Fri, 17 May 2024 17:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715968420; x=1718560421; bh=jQXTQPeZqoXtx1IhRfOgOt67
	vYHFNjCd5WEjfEKAqBg=; b=zOQCDy+JXun87BS5Zf1SeRYgIF8oquMBhmi2cI2s
	T/GNXav015FLvig8Zf3b4+9nRFMOGWb1AFqXz4WazCD6cQEnWgbdT7twa69+XjK8
	6fSMg8c+fVFdT51/1k+Ik+sTZJrGk0fVCGMgQR19jz5Wl8jjbj/UMn7hIwaov7wX
	0PRZbf7N8K2P770egm5CcbcUYakflh5PpGCkHW60kBJqDntyKU5h9ZmLhjp/RnCe
	HO6z8GYSQUB9hgOPKUACsgDGehN/kYqekm8PvO2CR13JWeNhn7RDtDY/Q0k4wZK/
	JyWW8efzUmYLGZgSobKFedWmEc9fVyUto6l9bU51+glh+Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DHFzKuMgcXiC; Fri, 17 May 2024 17:53:40 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vgvhg0kSczlgT1K;
	Fri, 17 May 2024 17:53:38 +0000 (UTC)
Message-ID: <a1da2c7e-1b29-49cf-a45f-255d3b8b0da2@acm.org>
Date: Fri, 17 May 2024 10:53:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable] block/mq-deadline: fix different priority request
 on the same zone
To: Wu Bo <bo.wu@vivo.com>
Cc: axboe@kernel.dk, dlemoal@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, wubo.oduw@gmail.com
References: <a1c24153-007c-4510-9cb3-bc207e9a75e8@acm.org>
 <20240517014456.1919588-1-bo.wu@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240517014456.1919588-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/24 18:44, Wu Bo wrote:
> So I figured this solution to fix this priority issue on zoned device. It sure
> raises the overhead but can do fix it.

Something I should have realized earlier is that this patch is not
necessary with the latest upstream kernel (v6.10-rc1). Damien's zoned
write plugging patch series has been merged. Hence, I/O schedulers,
including the mq-deadline I/O schedulers, will only see a single
zoned write at a time per zone. So it is no longer possible that
zoned writes are reordered by the I/O scheduler because of their I/O
priorities.

Thanks,

Bart.
