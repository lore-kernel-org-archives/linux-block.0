Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDC34F250
	for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930423; cv=none; b=YJYP4yMCHIulqXUaZME5eZX+weYbrbDNPF8BsK2F6VL6j33iNTnyWbo6EGbKbs6uLWr2T1jntWoV+8YoEBVCKaNj2+BNluS/1tD2i5+ZhTRvd6xVdWWbp6hqNpnuAB87OtDaK4FC52XCJtqTBmMb0QPTOPBPyo7KHZYrAOgaSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930423; c=relaxed/simple;
	bh=tFagLQqAn7jYHLggxD6ukov+XHeQpRISyFhpdf47eNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FL4zXeJP4+rLJeP03qR6bx/T1FwD9HbsUxta4rQezAdnaA1HFvzfub17JaqhiVmjsanrqz0PBxcs/u/Xjx7wacVOkWYXdJuFdj941fbzXcDpfFJ+0vM47p/EtsPgL8ADsSXnuzMf3qsGj8BR4KaSKqDYPenybCEGHin/ERLSgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fDGaqV3f; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fDGaqV3f"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dwZDb5m5Xz1XLyhN;
	Tue, 20 Jan 2026 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1768930414; x=1771522415; bh=tFagLQqAn7jYHLggxD6ukov+
	XHeQpRISyFhpdf47eNo=; b=fDGaqV3f51qXc08EZMT4BnFBh1ABuYa8vO1LfDUa
	pbMH4wPnzs+AxXMDUCa16LkXmmPoN6AXqUgjm1hlsjcH7qNxeb5M48g6SQVAEPk/
	ORqFMm+AiYUcG5V2T3w0I3s1pg3pccLE0ZPkniHIVHS8eOdc0woFBqhi88PAU8CO
	VltoOBrOqRePe4CZo2Kc4jwbffggQHTZg5CpSAx8KSyv77R8jRfkAFFacFWZ3cBB
	TnIfL2tBVBekODtx6VhbX5MkmbePgdGuClLgQpGIXJyEEvdbZFUJBDMNyhczFW3O
	68fF5OAyvZXGaT0OGq3Jhll6kq4EqnvEpQHI+PPa2HwNUg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PQBnCEWnSR38; Tue, 20 Jan 2026 17:33:34 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dwZDY3p1fz1XM5jn;
	Tue, 20 Jan 2026 17:33:33 +0000 (UTC)
Message-ID: <56e64af8-6a9e-4221-8a63-f6626c47e92b@acm.org>
Date: Tue, 20 Jan 2026 09:33:32 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v7 0/3] replace module removal with patient
 module removal
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: mcgrof@kernel.org, sw.prabhu6@gmail.com,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 1:10 AM, Shin'ichiro Kawasaki wrote:
> The patient module remover addresses race conditions where module removal
> can fail due to userspace temporarily bumping the refcount (e.g., via
> blkdev_open() calls). If your version of kmod supports modprobe --wait,
> we use that. Otherwise we implement our own patient module remover.
For the series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

