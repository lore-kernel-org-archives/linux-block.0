Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C1C13DDAE;
	Sat, 28 Jun 2025 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751151542; cv=none; b=GCzzRQAPno4zjAFfSX4U7i5FZSPSzUmQLRC3cKZz8mH1ak0ai0wQFq01wsYcIjwf+v14y1H6CZsTP+5czd/aeX2hB5UK3a6PFuHoksJan6cXT3qAXyJAKJYgUpH0b4lPt3HiY+j5ur6dA8O5B6pk7R8n258Ufo7A6ZIlbgEXkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751151542; c=relaxed/simple;
	bh=+jzkSM2A9zgoV3VybZGZYGv8wbcXdSGxPnbEMCyOZc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=To4hxMeBG875geZw9c0qyAnQZ74VBBOFjXlzxZtyWioUJzzUvd6+rFl8EwdwPFK9QNMIJAne01tkrdyrrCeGLSumgSq+Usaxqm5whi5z/EGM3UFztuBDZQq+TAQRWZIyo60nob1CYm59BThUQxHmTyAf33iKGg6zne5ET6oeiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aVUFYSU+; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aVUFYSU+"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bV7C24GRSzlgqV0;
	Sat, 28 Jun 2025 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751151533; x=1753743534; bh=Y/jSSs6jyPDYUAf6whi66yCP
	J+ejH/UOR/g6IA5dr+U=; b=aVUFYSU+vQeuukVKNj70aXs6du4zcx6NxUaGuxPh
	HIHxj9wAxxS2oVb6VyV1xX6mOLZm+8k1+pF9G1h5iebDgoSf3McE1AAyto/O/STJ
	gKguHq2/23quVzkm5Rn3+3nlLZpI4DiSaTlO4ZqRLeB7zqHavu/06tb1YKzHpCG/
	p9hd2ASPS/xplE+0Xsv2EVWrU04tKdB68f6LUO+ub8RQaxsmz2AB8W3lsH9A4hWd
	Mm6rfDeuAozY2B0L65C1wV/STaKqQoPTRrUSSgiRz5ybSfWU3Y8/kP71fRt64g5J
	qIYDPd9Ujb1RNLQAAUXAQbrk3I7e5RpYaxx9zQEuEkBZXw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id V9wAqjNWhz3R; Sat, 28 Jun 2025 22:58:53 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bV7Bx2g9yzlgqTr;
	Sat, 28 Jun 2025 22:58:47 +0000 (UTC)
Message-ID: <bb5df3e6-ba72-47c1-846d-b6e7f2d5a5c1@acm.org>
Date: Sat, 28 Jun 2025 15:58:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Fix a deadlock related to modifying the
 readahead attribute
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Nilay Shroff <nilay@linux.ibm.com>, stable@vger.kernel.org
References: <20250626203713.2258558-1-bvanassche@acm.org>
 <20250627071702.GA992@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250627071702.GA992@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/25 12:17 AM, Christoph Hellwig wrote:
> On Thu, Jun 26, 2025 at 01:37:13PM -0700, Bart Van Assche wrote:
>> This deadlock happens because blk_mq_freeze_queue_nomemsave() waits for
>> pending requests to finish. The pending requests do never complete because
>> the dm-multipath queue_if_no_path option is enabled and the only path in
>> the dm-multipath configuration is being removed.
> 
> Well, if there are queued never completed bios the freeze will obviously
> fail.  I don't see how this freeze is special vs other freezes or other
> attributes that freeze.

Hi Christoph,

There is a difference: there are Linux distros, e.g. openSUSE, that set 
the read_ahead_kb attribute from a udev rule. I'm not aware of any Linux
distros that set any of the other attributes from a udev rule for which
the queue gets frozen from the .store callback (nr_requests, nomerges,
rq_affinity, io_poll, io_timeout and wbt_lat_usec).

Thanks,

Bart.
