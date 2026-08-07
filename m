Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246AB41A576
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116899; cv=none; b=D6xGRJHexWk4ltURt5T7RXbyVpcM2m05wGxsc+P+3g0KDYGf2ABwEv4j6dHuxcXTR55pRVO+gHI8rIPyhbjXti1CuZbEuO0qVjh56UvOX6h+8MLSAQnJCiGlLTBUK4CEqIh9XdAjYUaLRS/wHHWYDRU+VPyZNt9whGNlaGaX+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116899; c=relaxed/simple;
	bh=ZOUqsD5WK21+xjVWc7907en/CyGRN3K5ETEfjKz/E8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbykL6WDKZu4b5x8X4cB2wtP5/5+A4au4ty9FS5Y5ahzY1oDNoV1d37nWz4zKmxvrfUAkjuBfqNWS+wQmlSt3lv1Nz5lFW5WF7B5W/YHI3BPHEJEJS4lFknpUl6NrybNX/lLbhLrJKjhVbnhxrlU4W68C+2d4t4J4PTAByk4ygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=excZ9Y8p; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="excZ9Y8p"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hGp9s3fPmz1XM6Jk;
	Fri,  7 Aug 2026 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1786116894; x=1788708895; bh=ZOUqsD5WK21+xjVWc7907en/
	CyGRN3K5ETEfjKz/E8Y=; b=excZ9Y8poRMBw2z0UVuAUihnwuk9pQZY8wDRsx5F
	OFN3n3aR7QBfqE68fKWYjXNczHmlaaDFsGFQ1DQuDSo1k12pKwAY6jqbxd9tJIec
	dO5R57jpzMxfGXa1nu/Ul78we8XB8CtyZ5M2495pnAyexFpZWqooHctBB8wKV+Rc
	hG5i7a85TurnoTykAxTCXX5bvPjyKaTxhCznKoPKqIbFLHMJunxnRfWXnVcvgjT3
	jsa9DU32+unn0k9sZBCjkfF7+gk2Y+kFXThiyN/rix0wCvq+P60RguYGat+bvJrm
	Q3PKAiOnvVKip+oVYKiHxkOcMp+NKJZYMtoloT32OnSuJg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DBhLfxCwW7xF; Fri,  7 Aug 2026 15:34:54 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hGp9n66xfz1XM6J9;
	Fri,  7 Aug 2026 15:34:53 +0000 (UTC)
Message-ID: <8f662584-7124-4aac-bd04-497eed3f188c@acm.org>
Date: Fri, 7 Aug 2026 08:34:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] Improve handling of offline and read-only zones
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260806160445.848337-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 9:04 AM, Damien Le Moal wrote:
> This patch series refactor some zone related code and improves the
> caching iof zone information and the management of zone write plugs in
> preparation for fully supporting storage element depopulation.
> Most of the functional changes here are around the management of zone
> write plugs to better handle read-only and offline zones as these
> conditions can become more common with storage element being depopulated.

For the series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
