Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A14746CA;
	Fri, 14 Aug 2026 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723688; cv=none; b=CnepbT6Aw3QJWpaJcQXoPIlJrBi2OgInrVUHGlMf0aOViKx+HoALAPCpl29Ktyc0EdOrCTNHVRxLriin4U6BMyXNstRxK8MfskgcXF0FMuIhk6PNSg3TP0ul/pTJHoD08NzVsaHc78FatGupbMV58YLdnCuB2Zixh8bJwq8tqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723688; c=relaxed/simple;
	bh=toLXBceoHTdDGjb5JnOeYXVuzpEdGFl/QjV0EWKDRAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6Plaid4MsHnoy95x8ejRB8/8tONhO4XRz0MCtu7qUFWoGsU53Ai8G5tBG+GaxzyGYPEuZCI5y16mg3nf377qSz5yfOgBc4eqdsKF7oRdA3myPEwoopcZO+PwAhiY9s4vVTuQtTcRF7zmqVxBkSlD/3x6lXAEGYCRNZgb1Xj5hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yv6nKSN3; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yv6nKSN3"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hM6Zc4fXyzlfpM0;
	Fri, 14 Aug 2026 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1786723670; x=1789315671; bh=H5JhwSEyGhcIz+KhLBeqFpOg
	AP7YfPkfpmay+3X54wg=; b=yv6nKSN3gVKRuCTWzQSnFIRMkxo3enEQkIloEu5I
	YX1975CaIoVKhyjPLd2K6UM6LhfyZCuCpsM63a9TSOFBxWvWaFBxiJt0AXS6UbQM
	qf31mwLnrvZDS9uQAgqaW3Y9YW2EjXUI9NQBD3yImpx0agMPxDy+NXQZY5iNGl3F
	Y/0AQ9rNJwhbWtMKV3XmyFSOuQkrSU02dEUD1rafMEHUGhlTwSbN9ODLHVD65I/1
	YL+OiuCGhD24PbVDrHUcIjlItzmrqvYgqdLKkegGPZp0BJ/OOBjpodH9tsUtZD15
	yaWf/+ZhMZ9h9eLlXSzEx3yPdqeVsqGsslRkzScQrkT6BA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id J4vW2hlDccvK; Fri, 14 Aug 2026 16:07:50 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hM6ZY04L1zlfvpG;
	Fri, 14 Aug 2026 16:07:48 +0000 (UTC)
Message-ID: <a03aad1d-3253-4485-9e99-b73e74ed88ef@acm.org>
Date: Fri, 14 Aug 2026 09:07:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/mq-deadline: Drop unused dd parameters
To: Hongfu Li <hongfu.li@linux.dev>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hongfu Li <lihongfu@kylinos.cn>
References: <20260812040729.27551-1-hongfu.li@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260812040729.27551-1-hongfu.li@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/26 9:07 PM, Hongfu Li wrote:
> Commit c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
> left the dd parameter unused in deadline_move_request().
> 
> Commit fde02699c242 ("block: mq-deadline: Remove support for zone
> write locking") left dd unused in deadline_fifo_request() and
> deadline_next_request().
> 
> Remove these unused function parameters.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

