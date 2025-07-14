Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6001A256C83
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507467; cv=none; b=MnJJV+54amw63207i8C5c3PXXG9E8UaJZnrRe/uiZLv344Db6z1vSqbE9etXTwlaKuc8WVfOhpWEdtChPydNXhw/Fag1VbCCV5s8zRWMUsIXHYHPnllhrX8c2E14CbWVHB8uzJMRFKdNkf/1SRkcoDj9JLebZy70/YuB5fkEqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507467; c=relaxed/simple;
	bh=vaAnbrI5uq7iMJpD2BD5+F0RVGFRQwRpOPxMRG1Egc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bybBRpNEJR9FZI1uPjMwOxn26tSBHzuH4QrUwj5lqCy3yiv6J2jpDk6/ec/fbp5ZwkcdYElS6vm8APNWq2WHxa89QeUJOxe6b3WtTDb6XSqZZzs9vejr9z6FF0ou5pJxdEhplAALn3uZW/uC9Ot030GYxm20fXoBgBTkZ7sQYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=S1S01BhO; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="S1S01BhO"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bgmfd35kMzm174N;
	Mon, 14 Jul 2025 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752507464; x=1755099465; bh=BjiJ7VFA27JIQl/CEHXy3j0W
	K/CJIyArxf+MoEkRgPA=; b=S1S01BhOdOq5j+RQTLaEStu7WlkYUHBX50LZGLob
	R9ay1lgRsfop/xbMgQxIdnRycE02k9dDAgDrQNPW8PYXOYjI3m54Z3UuqHN8R7iI
	hD2gFsq3dxcEIz80qEOg/+grFHh0wRxB0tfqan8Oiiavfgl3POn5sp6xAuQ8JCFH
	qDEh0r1bjBYlaZ/KMo0BIXgPuPRP/Ea8WRRWlHjkiHnvoMR1KFfllM6TiEOouO/W
	86TbdrrSWNkiU/gSFkv2M+xnpXiM2MSlPtrMneRIMXWWnCQjENY9yysNUwPFCydL
	o4KCifigUd7CmqB9+3DIka7ZY0w1vSDsICKnlBs6KkxF5A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9FuKuD0AboZ5; Mon, 14 Jul 2025 15:37:44 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bgmfY0px5zm1743;
	Mon, 14 Jul 2025 15:37:39 +0000 (UTC)
Message-ID: <90252dfa-6913-49e2-883d-bbbd1ed4b7ae@acm.org>
Date: Mon, 14 Jul 2025 08:37:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix bio splitting in the crypto fallback code
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Eric Biggers <ebiggers@kernel.org>
References: <20250711171853.68596-1-bvanassche@acm.org>
 <20250714113534.GA1471@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250714113534.GA1471@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 4:35 AM, Christoph Hellwig wrote:
> On Fri, Jul 11, 2025 at 10:18:50AM -0700, Bart Van Assche wrote:
>> When using the crypto fallback code, large bios are split twice. A first
>> time by bio_split_to_limits() and a second time by the crypto fallback
>> code. This causes bios not to be submitted in LBA error and hence triggers
>> write errors for zoned block devices. This patch series fixes this by
>> splitting bios once. Please consider this patch series for the next merge
>> window.
> 
> I can't get patch 2 to apply.  What tree is this against?

Jens' for-next branch from July 11 (commit d7d3914e6d4a ("Merge branch
'for-6.17/block' into for-next"). Is that the right starting point for
this patch series?

Thanks,

Bart.
