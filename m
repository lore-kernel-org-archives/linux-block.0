Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC632573C
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866240; cv=none; b=hVzB4uKBp7kYWCB13JYHgnmGC4qJOsyNh1FvUqbKnngiyY2Cqo0icI1ZUQTMpBBed6Iow0Ak1ejLsQHo0FKWi6I9jgymCeWZeeNzDKQKEQ2euFJkLdeK56iPVHva+8sUpVw5gnItmvNeeQVvVqvNLqIpPi/QGht+N0gAawLjm+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866240; c=relaxed/simple;
	bh=fVQ0IUcFgVdN70axL9Ep7LDecEpZSsT8MAQ6+wOqfz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a7hnHRJfvTxAj1bEOqUZ9PUNAb+qARBemUzuEOErB8As6B15qFDaB7atDl/xuL9g0o+q1C54D6PFdMoatssT27zH0CgYnFB5yKGEQvkRvmOUdF5c0kEuVXzyG+/OqVYD5ZJlX/N0HQNnm73Fwlh6HjGleZpy/ubJk9r+821v5ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=a8kbXRKs; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="a8kbXRKs"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fKRyd5ljyz1XLyhN;
	Mon, 23 Feb 2026 17:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771866232; x=1774458233; bh=Sx0fyg1u2VcoPteE5j9gj2yR
	wTX4TpMDDWgUOQFgDF4=; b=a8kbXRKsrOlrCQfHZ/WlYDQeyc2XeZ7hmifAhleu
	dX76Rad6E88CQ8SfgzDmb+8t7aPcZXQaNhvE0jghhHa+17EE/WEwMNsakSPdzQLK
	gJB6p1p0+bPj/UmFjn/8FIKiSz6PQyi5FQp/bUC+duuL4U8+4+djeQnRoVhFHnHB
	dOAYADWnKkmudhGw8AI2918R1GRfr2Ck8tS+/J7CFVSIPe8gkTEGqe6ixyvnO3ND
	Duk1HYNaSzFpTf277cx5rEf07QT9IKO/wIrzlg0hU5iISm4wpFl5nI27UCuTDFP0
	BMfUXeZOMJK8l//PKiYgvkqwFz0fh/dbr9xnkI/E4HrmmQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TmBfPu8wo_bF; Mon, 23 Feb 2026 17:03:52 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fKRyX5xFfz1XM0pk;
	Mon, 23 Feb 2026 17:03:45 +0000 (UTC)
Message-ID: <3ea1b7da-0639-4cf7-a8b4-132b26eedba8@acm.org>
Date: Mon, 23 Feb 2026 09:03:44 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Improve zoned (SMR) HDD write throughput
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260221004411.548482-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/26 4:44 PM, Damien Le Moal wrote:
> This patch series cleans up the zone write plugging code and introduces
> the ability to issue all write BIOs from a single context (a kthread)
> instead of allowing multiple zones to be written at the same time using
> a per zone work. As shown in patch 6, raw block device tests and XFS
> tests with an SMR HDD show that this can significantly increase write
> throughput (up to 40% over the current zone write plugging).
Hi Damien,

Is a new kthread necessary? Has the following approach been considered?
* Make the dm drivers that support rotational zoned storage devices
   request-based instead of bio-based.
* Modify blk_mq_get_tag() such that only one tag can be allocated at a
   time for zoned write requests.

I think that would be sufficient to serialize zoned writes. 
Additionally, this approach doesn't increase request processing latency
by forcing a context switch to a kthread.

For reference, from drivers/md/dm.h:

/*
  * To check whether the target type is request-based or not (bio-based).
  */
#define dm_target_request_based(t) ((t)->type->clone_and_map_rq != NULL)

Thanks,

Bart.
