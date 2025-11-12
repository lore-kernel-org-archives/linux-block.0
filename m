Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CA28697
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966859; cv=none; b=YdQbPYR3XRE2jZqU32QGZri8IbtstGQ8/oOMxWfteSkOHwp8Z90/KP+Z9SONsPOIrUGH2Rbf6ctMdolD6JbDa1pON1o+UuPqN/QF7RKomZEcI0sH12lQxnG42ToCeQ4lsphU0PD4zpwZBat2KPiKcTKCxptx/yO2cErg6HtgHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966859; c=relaxed/simple;
	bh=PK8EBuM/15le0lrVkU3Q+A/Oa/4WjH5R9dh6AJ3HDdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E829lNg2kf+lvP5TGRoJMUG/ZFNbDeDXvbcDnGCZH3V78dcKfY9YpWsbR48LOOd8k9uW6lOjrI9JiraiJxf7uQRiomnzTUaOjYgQsydq/LeTcme2UTZqSnOu65BOuZoC7Spi05gsEeMJ5Wv61Br8LRCE74XW30xE3KEM9wXk6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=j8hoG2Qx; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="j8hoG2Qx"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d68mf6ZGZzlmm7l;
	Wed, 12 Nov 2025 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762966849; x=1765558850; bh=PK8EBuM/15le0lrVkU3Q+A/O
	a/4WjH5R9dh6AJ3HDdA=; b=j8hoG2QxakSzmzG84SjrYAjGgtxhqSWqzUohuz9o
	lllGW/T6geVBgAoemh4IQLpr4BTI4SPsc/buyWk6wxW3u1U/YVfCFCkqBMNJnZ2+
	O8uO/H7dQQPS+Clfsmoh+KmO3iz4baqPHNr58aGw5mehN1rTK6vV3QMSnFq15Hrl
	Q6Meu0VqShAqWQ+UmkVnqVhr+rUVEnfeUlI9Ki6Am9LopBupuPgmGlV7vxi4C77n
	blaq5OLQvn4EdFiioptbnRhBu/WVL2luy9rmDBr9Ja6ZE4XZFIBst+7ggI3jjAYv
	xvljKDGvCM1CFFs47HT0cETxNwqZG8w984Cwu0Uke0Ux3g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 297Z62K-SpnN; Wed, 12 Nov 2025 17:00:49 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d68mV0YVCzlrnS6;
	Wed, 12 Nov 2025 17:00:39 +0000 (UTC)
Message-ID: <4e9652f1-b2c6-4672-a39f-cdaa5560041b@acm.org>
Date: Wed, 12 Nov 2025 09:00:38 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: fix zone read length beyond write pointer
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, dlemoal@kernel.org,
 johannes.thumshirn@wdc.com, linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20251112164218.816774-1-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251112164218.816774-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 8:42 AM, Keith Busch wrote:
> Fix up the divisor calculating the number of zone sectors being read and
> handle a read that straddles the zone write pointer. The length is
> rounded up a sector boundary, so be sure to truncate any excess bytes
> off to avoid copying past the data segment.

Tested-by: Bart van Assche <bvanassche@acm.org>

