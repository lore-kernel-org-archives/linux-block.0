Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171442E975A
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370597; cv=none; b=hs7jeU1zIJmlUi+T1noV7/qo0jvTRtc44AQGaDdwc/Z332LITz92eLhXgD/DBqZ13z/1eZvP4SSM7awd91bxfxkLwuPKhde1vh8NX6BBtjq4Nish/zB4rOro3ua2vnsggB7umrbdwzR1rdfeD3DLpYrKqcD1/BZBdVu8BXojvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370597; c=relaxed/simple;
	bh=WVhyXZAo2cv1mDh422eaH3vMQv79QAatUA0sXja/nCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPkp7W+nD/UTJn9UkYompyuXgHogN0tZlO4OBQ6JN1RdHSJ6V72kEOExE5TxJXUkPxnyF8UXhsDqUJbBsCFV1B/q9FCwnOxpqj0pK4LRGRG4c2NaXl5eOBSu+oO0Uz6SZrCe4+dXaYlQjN2d8yTsniD0pj/8TP2b7B52OvRvyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=V9qcYSfR; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="V9qcYSfR"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bnvnh5tLHzlvRxX;
	Thu, 24 Jul 2025 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753370407; x=1755962408; bh=M9f0x7a8MX/CVxSwpiDqBysj
	pkArUliOuktnwaCDZwA=; b=V9qcYSfRT0thRzUSkpi89SnJtTVm0+f30+dpx371
	ceJzyWrSN70AmLpEOP16dYHKk/5nAb8OeUkHwRucs46tfKOp+aPLnOYJ7HPbD657
	Na+seUGrcNKwUeWFyXsTqriegsmsbkk4j/Q9JOVA7DZVYK/ntgdH4u/yQXMd9sEO
	oFTc4/Lta90FYCMOZN7eZHBGYlop5IOgYLNQ37b6JX4D5lha9c2ij9abxJMxP0F4
	8D4O9uaDupSghSKWn0mdllDmpIz8zngiZd+yDoWYr3SwbQvTZ7o8biuJntbbp12F
	Y4ubbz2VX/qvALvRZb5gKHTHfomtdVsTfQb4yNGg4YXeiQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id c0OGfExe26Xn; Thu, 24 Jul 2025 15:20:07 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bnvnZ4ZCqzlhdxd;
	Thu, 24 Jul 2025 15:20:01 +0000 (UTC)
Message-ID: <df09b7ce-0f25-488f-89ee-ffffa7f0ded6@acm.org>
Date: Thu, 24 Jul 2025 08:20:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] block: Enforce power-of-2 physical block size
To: John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.com>,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
 dlemoal@kernel.org
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
 <20250722102620.3208878-3-john.g.garry@oracle.com>
 <f0605f62-0562-420a-b121-67dc247638c9@oracle.com>
 <2969b760-2f7a-4cbb-895a-097dbd88974a@suse.com>
 <87cf53b6-2426-4d33-893b-479128cb38c7@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <87cf53b6-2426-4d33-893b-479128cb38c7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 4:09 AM, John Garry wrote:
> There is code in the queue limits checking and also merging/splitting 
> code which relies on physical block size being a power-of-2, so that is 
> why I wanted to enforce it.

I'm OK with enforcing this.

Thanks,

Bart.
