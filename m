Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C87464
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162502; cv=none; b=O3vAx5MGVhhBwjnusP+TWaA0zsr/s54Ymt5RnAWhRLPcZBMXv8qcavs835STeBFMtvm3Xnh/N1iVvoLvUrsbIdNuVwiGwROBYClRG6DDAkz7jONz2jQjFXLoa0W/Sj/d6+U0ko/B97te0hck6THFeLzYjmRcbYcGBeOFTjQzdE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162502; c=relaxed/simple;
	bh=tnQKFNF2ML9qE8sOhuW78OH2gG28qOibo74knhANYXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EC+Uvnbt3QS7I2h9TaJ9M5ihXKqqp89E8qSiRlYDbFiPfGrrStqF+l871nFe6i7mOTiiRMdnK10n4rswt6A3L47LG2wEDAKxCAei612O3M4LJ5kLXYyA02JauQptFcxyae+//AnycMnVuTYY5Na4KsxRdg1PQFnK2Cwrwnwuyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0nhSzLCc; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0nhSzLCc"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bdK4h2mDwzlgqV0;
	Thu, 10 Jul 2025 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752162498; x=1754754499; bh=XkW5z0auvUe4gdmDZooqpENG
	27GTNmUude0Ncg0H1KM=; b=0nhSzLCcxKBleCQde7dqVlqb4jzAIH+/oGYUZlSH
	77UcumYMqqUCrBsseuc+B6vO30AkgXaSxClx06TG3fJhy73PtiqYqsYcPwjwNzW1
	MofiYLxgiMEsRGV8OE+d/GDf0If+2nU+XK2qOdLrlD4Er8fS59kPJqtjV5zd6Rau
	ys8mI9zJZnnL836rdQyCjBGs26ihsEo8RIsgwN/7l+3GSOz4NbipXaznOQO/xUDO
	R8PStDBeTdWJj5NWU2SFa8tElhqMjUG0aXAigaxmmAXrpyCSW3TaC9Shqo4sPYTW
	KnhT9pgsby5DgIGHnI32HLIcISP5cn6j05QJx0sUyDFqQg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jzvNp15BGNrw; Thu, 10 Jul 2025 15:48:18 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bdK4X6RBJzlgqTw;
	Thu, 10 Jul 2025 15:48:11 +0000 (UTC)
Message-ID: <6e25e109-33bf-413f-812a-69a7f33e783e@acm.org>
Date: Thu, 10 Jul 2025 08:48:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, hch <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-2-johannes.thumshirn@wdc.com>
 <de8c6c73-3647-4cc7-a8a2-6848b2f4607e@acm.org>
 <07fa0a60-1541-4201-b4e9-b02a994c915c@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <07fa0a60-1541-4201-b4e9-b02a994c915c@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 10:55 PM, Johannes Thumshirn wrote:
> On 09.07.25 17:31, Bart Van Assche wrote:
>> Has it been considered to add a warning statement in blk_fill_rwbs()
>> that verifies that blk_fill_rwbs() does not write outside the bounds of
>> the rwbs array? See also the RWBS_LEN definition.
> 
> $ git grep -E "#define\sRWBS_LEN"
> include/trace/events/block.h:#define RWBS_LEN   9
> 
> So even if we would have
> 
> opf = (REQ_PREFLUSH | REQ_OP_ZONE_APPEND | REQ_FUA | REQ_RAHEAD |
> 	 REQ_SYNC | REQ_META | REQ_ATOMIC);
> 
> it'll be 8 including the trailing \0 it'll be 9.
> 
> If you look closely, REQ_OP_SECURE_ERASE already is 'DE' so no changes.

It seems like my comment was not clear enough. I am aware that the
current code does not trigger a buffer overflow. Adding a length check
would help in my opinion because:
- It would catch potential future changes of blk_fill_rwbs() that
   introduce a buffer overflow.
- It would document the length of the rwbs output buffer. Today there
   are no references to RWBS_LEN in the blk_fill_rwbs() function -
   neither in the code nor in any comments.

Thanks,

Bart.
