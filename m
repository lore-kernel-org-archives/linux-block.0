Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657DF386543
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344010; cv=none; b=NFkTuIa9PedbBp8SentqFnShKkw4zjx97ivqMWGSmXeWcO/VWM4+CDqhnqa6aA1aXTsE48IHUCowlXp7PxYm2Lrq6ygIDve2D2ebkJqP+DxQt7MYiullTsRQTguoEBM95p/ICpSbP1Dhipk1aQFQNwF98s09nVMIgnKT9vn/BII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344010; c=relaxed/simple;
	bh=LrJDfovB4yGL1CBtK6C385t4TOXfF5wcspYuwrk82ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHSvZZDUM0nvYly9B3qzbFTdKdI8fbL57BBE4qdXa8jE+qP9Bl37X805TLoSogaFcNSsuCrhH6uRK52Ns/U6MX8Ia1NgF9AhN8rng5Xu9wsaP8FYjaClOrTMhV3c2psF2jOS9meUqew7Zw9NPoU1lb7wGMgF87EEMcJE4I3b420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ocCJNgD3; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ocCJNgD3"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gTlDl62X4z1XM5kY;
	Mon,  1 Jun 2026 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780344004; x=1782936005; bh=flcdA6QPH+XCTgXPaIZ99hRa
	9STNINXAHwIUoj0Rkx8=; b=ocCJNgD3zf/20JVIfnN1CHVSPNZTxPYV/7f/JR3V
	mYoeuAfnn4o/TFDNLD2LNgQwqBd9RRphv9hNOt0B/Mm7IzmIEy8NVk1zc+eSO22m
	99wO3q54FkJZyxd6lFTcAlmtXta4sAlMFdsK4+36DQuOe4Qsp9HVFu1MOKNgjWQm
	sKqfP6Va/ti09zEmwA79HYfbLS9XGXmktoOa8NEbcYrcmQcitRyJrak63oYo5WMN
	W8OCUWwpz2b5tcQCwLON+pKq4kddw6t5Td1Ca/EWkkRsSkDDCc/TDgqNyrEyie5q
	haRoR0X9iA1yVLo6dlqO3DL6v099t7hVcKI4tnqpHFCFBg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8ATE-CCX6iUO; Mon,  1 Jun 2026 20:00:04 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gTlDf3QGQz1XM0nk;
	Mon,  1 Jun 2026 20:00:02 +0000 (UTC)
Message-ID: <c31283e4-b427-40c6-8659-8ee8ab4e37d2@acm.org>
Date: Mon, 1 Jun 2026 13:00:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] block/blk-mq-debugfs: Improve lock context
 annotations
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>
References: <cover.1779997063.git.bvanassche@acm.org>
 <b49bc91945356894b8ab1dc2de1aabad6db3ce16.1779997063.git.bvanassche@acm.org>
 <20260601073337.GE7799@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260601073337.GE7799@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/26 12:33 AM, Christoph Hellwig wrote:
> On Thu, May 28, 2026 at 12:45:46PM -0700, Bart Van Assche wrote:
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -20,7 +20,7 @@ static int queue_poll_stat_show(void *data, struct seq_file *m)
>>   }
>>   
>>   static void *queue_requeue_list_start(struct seq_file *m, loff_t *pos)
>> -	__acquires(&q->requeue_lock)
>> +	__acquires(&((struct request_queue *)m->private)->requeue_lock)
> 
> I try to member where we got stuck on this, but isn't there a way
> to at least have a macro for this dereference that can have a comment?
> 
> Also I guess most seq_file users will have a mess like this, but I
> don't really know a good way around it.

What was requested last time, to introduce macros for similar
expressions in the I/O schedulers, has been implemented. I will
introduce helper macros in blk-mq-debugfs.c too. Inline functions
can't be used for this purpose because Clang's alias analyzer
does not expand inline functions.

Thanks,

Bart.


