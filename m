Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D991581EB;
	Tue, 23 Jul 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752114; cv=none; b=gCmL/B1ECeQ2ullMOk/HtPFs+Uj1Xr+oC39UWuIvSVV+NWO8ycq2Hnl66ght1jZvDzxHQKC7QzMP1xZ+vJIcTNWZuDJcyn2lHeWjMtAtQxf8OQAPLb1iF0BXrtshKotxMh3hZz7xJvl/jIl9fLo8mhMoM3+P4HU5nORkZQ/k5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752114; c=relaxed/simple;
	bh=RbOdrvcsDjEz/icRhaCs+TKTGqgAzQUcydt4ZuKFJTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PoJNnNXovwigkNo+q0F3VVGgo3CuhJsdpkw6D/KF7aly1/Jk+BrIEM11JKcrJzwiuTU9KBvUzdJvQuKsTo7SHAw9F3plbf747ogaqLpIdupQvvG1+h2yUgJgf4JohOxe1s7kFx0VGc1G4NGffCWK26A0RfyvAgn7ZZJmleJCK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FNSjfJDi; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FNSjfJDi"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WT2dW2twpzlgVnY;
	Tue, 23 Jul 2024 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721752110; x=1724344111; bh=iX6Rbk01cfhxdEBIAeNsq9o7
	6Ulzdi/G4DWyZljlrv4=; b=FNSjfJDiO7wDugYnGz8MiekqoEBIUixTpqS2IbI+
	1QgwfsayLBMkWz/oeXdI8qrS0rmsB7+W+LSoi/7Dg0F85HowxI5fH8DbEbOHL1n2
	Z+UriPOYkLQAHCt0p+EBsphBUbPdiKsZZm6iva6SLuoE/PBmeaZMWNb2YgQLUOqN
	/3oWnSNhK0xOgKwq9P6PoGCoqcsiuXBimCFIMCuiZCiv04d6oGQYfw8lbkS4pP8x
	TQOox200SyItADeLkwZ6t04ZvA+luELPlXO4KEASy1qiYtx2mxVZzVKC+6uNHoJW
	By+3llWORI847x6ibG5x8ujUC931H6M2GdMQqkJu0teaoA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Creij_MQ9KzB; Tue, 23 Jul 2024 16:28:30 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WT2dT1fYkzlgTGW;
	Tue, 23 Jul 2024 16:28:28 +0000 (UTC)
Message-ID: <51421cc8-ef09-4d13-ae92-bc0839a8b3b3@acm.org>
Date: Tue, 23 Jul 2024 09:28:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: fix deadlock between sd_remove & sd_release
To: Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240722091633.13128-1-yang.yang@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240722091633.13128-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/24 2:16 AM, Yang Yang wrote:
> SCSI does not set GD_OWNS_QUEUE, so QUEUE_FLAG_DYING is not set in
> this scenario. This is a classic ABBA deadlock. To fix the deadlock,
> make sure we don't try to acquire disk->open_mutex after freezing
> the queue.
> 
> Signed-off-by: Yang Yang <yang.yang@vivo.com>

Fixes: and Cc: stable tags are missing. Otherwise this patch looks fine
to me, hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
