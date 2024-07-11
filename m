Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672B16D9B3
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721678; cv=none; b=rMXJLdFcCbvONjpYFPlO2TwWbeoZNbDk6Fx6rOYaHih8LSPkooe2bcL/xlo2FYxUCh5xU0RSDmqCDKpTgrx/x8B3Q6PTY/IbYDOn0mDXlNOjhmwe0q6nvA+u0SekvL4ImPkoKPHwvZPB0vVV0J4T9qR+dS1+pD6M9wFYDWdKbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721678; c=relaxed/simple;
	bh=L5CKpWHBQe3EMXcvVNDhnjAARgpKZkTMh+eETvfBFco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ei369NoAdT2MxunTZCyeKlN8TaoyXeZP9aJdzGEHunOyOeQJq8vZmwqWtrrwAQWWWkfBNQ9bDd+dVBsF5y4ZVvoWRIbbfV/82w04PgZZx+A/w/Zxm6+iEjjTPff2rfFDbidhoStD6ljtBQlsO+pcyE8AFqz3gG+OPM/EnrZMlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DR36QqqK; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DR36QqqK"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WKjYS2DCTz6CmM6f;
	Thu, 11 Jul 2024 18:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720721674; x=1723313675; bh=L5CKpWHBQe3EMXcvVNDhnjAA
	RgpKZkTMh+eETvfBFco=; b=DR36QqqKR7hZZ3AN5WJSnlMDLl7mB8mwQUTu9fWo
	VqmEa2zpxzb1k3LWhD6wL/B9eYAbFbVSHXmmpr3asPPmgSwK50BkN45U57yzNY5w
	oHvobmJQGz+LBd3oFQLrrcTo/Wz8yMGo691gYP33dS8xdIW4t6AXzOGybMoxmVUZ
	GzLYaWJO6P2mshJ45vpI5Kfo+Ue8TsSCNiOh8vgxvEA4yuH8GskIdxXVdOe8iEjq
	CJk5EIv9gSbQTEWp38U6XSsWi7+RHoZmfUN7b8ETx/rGMLUTUOhKX7o83BaeaRCJ
	lpnXTvO5wzds8WKfq5a/0etQ6ks6PrCq92PDZFPa22j7cQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VV6mPQEYZnkA; Thu, 11 Jul 2024 18:14:34 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjYQ3lR4z6CmM6X;
	Thu, 11 Jul 2024 18:14:34 +0000 (UTC)
Message-ID: <a8216b7b-39e4-43a3-89de-116164ea0722@acm.org>
Date: Thu, 11 Jul 2024 11:14:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] block: Add zone write plugging entry to
 rqf_name[]
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-12-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711082339.1155658-12-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 1:23 AM, John Garry wrote:
> Add missing entry.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
