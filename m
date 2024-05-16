Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E61474B4;
	Thu, 16 May 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867134; cv=none; b=Fu3L8V/RGRsbyrEjk26mscwseYEpV2eVzPeM+Hja+obnUam5U/485/rpsz2TAu17WtYg8dgCQqgmfqnIwriZBslBXQqZr+/dCQ2Nzvk4LpYPIqHbjax0SCt5jrOcIqJ9nCHnBh/7dEMDbBWXir/BBvz10gu2SFTrRXx/bI+GsXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867134; c=relaxed/simple;
	bh=SyLiGL7iHwYcUTCQzV17dRHo+K34vzQ26/nHK00U0Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luzbjnyYc4T4ZfLPBQY2yIyLHOdfcp3cw4qB1AHbmY+KF7eVZ+LhxO1DXMcNUXw6MkoUO+SUPiKRfQIv5IOh68EKXA+6iHhReuEUEHowPAbekRsQhURnjchvqxyICKEGaQDwqEmCXSSIR7Ldm3q4eauPntLS1WvP5osVrkiR1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4ZQtU7XF; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4ZQtU7XF"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VgBDk4qyGzlgMVL;
	Thu, 16 May 2024 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715867124; x=1718459125; bh=x8LBwIIWWmPk2MeweSlKgqm+
	Gv+UrO9eXS3tAe90WIo=; b=4ZQtU7XF4CMymS5TSAMJ5b5KAsIt7Ywz68MLKbUF
	oxJe9nquoFJzSO96q4E99kXvqUrIj27mz/4Qp8FLwK7wY5O4g2Y9t7nabRO9ST8x
	60iQQDrj8kFhHwKf1sJLoX/zQRC+VeCQfPmQ234Gug4xYhjynDlaLNqNltQCo1tW
	LUIkxa68gpQtqaSf01JHHCx8+qDcxWpCj+6NqY/UULBK9p82a7Uz6zaZXo0nlA+7
	Yg6WMRsY+n+OgHVK0+TcuWUBdZxNWUuPlJpmIHx4oriiza1e0gc/frKjsa3SOVgK
	rhzLpcu0vgfGTUChxsqjoH1FqKaA2IsLOTFhO08Gmb2Ntw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NXC3SSf5GU_H; Thu, 16 May 2024 13:45:24 +0000 (UTC)
Received: from [172.20.0.79] (unknown [8.9.45.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VgBDg2Zv2zlgT1K;
	Thu, 16 May 2024 13:45:23 +0000 (UTC)
Message-ID: <a1c24153-007c-4510-9cb3-bc207e9a75e8@acm.org>
Date: Thu, 16 May 2024 07:45:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable] block/mq-deadline: fix different priority request
 on the same zone
To: Wu Bo <bo.wu@vivo.com>, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Wu Bo <wubo.oduw@gmail.com>, stable@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>
References: <20240516092838.1790674-1-bo.wu@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240516092838.1790674-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/24 03:28, Wu Bo wrote:
> Zoned devices request sequential writing on the same zone. That means
> if 2 requests on the saem zone, the lower pos request need to dispatch
> to device first.
> While different priority has it's own tree & list, request with high
> priority will be disptch first.
> So if requestA & requestB are on the same zone. RequestA is BE and pos
> is X+0. ReqeustB is RT and pos is X+1. RequestB will be disptched before
> requestA, which got an ERROR from zoned device.
> 
> This is found in a practice scenario when using F2FS on zoned device.
> And it is very easy to reproduce:
> 1. Use fsstress to run 8 test processes
> 2. Use ionice to change 4/8 processes to RT priority

Hi Wu,

I agree that there is a problem related to the interaction of I/O
priority and zoned storage. A solution with a lower runtime overhead
is available here:
https://lore.kernel.org/linux-block/20231218211342.2179689-1-bvanassche@acm.org/T/#me97b088c535278fe3d1dc5846b388ed58aa53f46

Are you OK with that alternative solution?

Thanks,

Bart.
