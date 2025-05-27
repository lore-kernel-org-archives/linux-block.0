Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B4F2882B4
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374485; cv=none; b=s++N5GTT0s3k9glgpfvvEE5zoGbogWzrk/H0TPXEXqILS+kvFEg4/FFJsOx2qES3E7EDb0OznGJ6PyqP27ngJ92TDAD8ycfdOyQ1g/0DXZoG4HN34dUP5tAq1og/MJiZquyht2QVlw4p4StwB+NZQnuqdj6CfR4V/wmmsuNfaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374485; c=relaxed/simple;
	bh=w56/6Afqs4RiUQ8ZaRDSMXvn4rGeu9/2mE9BRGN7DRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqX9koanu7bo2w/4fg386ikDt2ORzDKakRk2REt2NkPLohHcqoC8+jRjChHsiPS6zw65rFZRpgsxzSjNLmhBV7cuicXAs2BctUkoZLNe+Ylgja8eRbB25rAkLmU8MqjTrjBfVMmoguQWApiWJA4Dw/UWHOfnCswq5MqsVcUvufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YfwyJkLu; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YfwyJkLu"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4b6NBB5VSJzm1HbY;
	Tue, 27 May 2025 19:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748374481; x=1750966482; bh=x22uBIhsHKzCEuud1vyRhWg6
	ZYy+LLkpYQsWE7/ldrM=; b=YfwyJkLu6I1kxUQUZIWz/a8+jSkjhl0ZHl93fpuN
	r1H/8DRjXkDHATEJLTDdHyucPo8GENJ5y+7zlo2eVv8xQz7a7b9tpeZkiQGhsKBn
	0YiI40ZtYiRNltVXI7MDhh+q+whnqoLZcG5Co+SjdhC56rJLqgyA5cWXstClzuor
	o2uMe1nEzfqC/DSo6OoOTrvV6UJyV2mEujVaZ/zTx+PxdC806dWZMZOtf3XNXyam
	2uY6pwXJKgG523Gsr4JndujSlXs2aI2MiL8Eg0LUuIQU696uAn5hIp82LsIHjBhS
	pZS2NEmWmfKu6F0t1fr/7sXOjS5X+yE1MDzEUIBfV25QwQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qvjR_CTdfFV5; Tue, 27 May 2025 19:34:41 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b6NB72S79zm1HbX;
	Tue, 27 May 2025 19:34:38 +0000 (UTC)
Message-ID: <ca5d0fc8-e256-463a-bff5-d3a52ead800a@acm.org>
Date: Tue, 27 May 2025 12:34:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] zbd/013: Test stacked drivers and queue freezing
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, hch <hch@lst.de>
References: <20250523164956.883024-1-bvanassche@acm.org>
 <vuyvx3nkszifz3prglwbbyx7kekatzxktw2zhrpwsjnvl4zqus@3ouwvtkcekn6>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <vuyvx3nkszifz3prglwbbyx7kekatzxktw2zhrpwsjnvl4zqus@3ouwvtkcekn6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/25 1:25 AM, Shinichiro Kawasaki wrote:
> On May 23, 2025 / 09:49, Bart Van Assche wrote:
>> +	_init_null_blk nr_devices=0 queue_mode=2
> 
> This line can be removed by renameing the null_blk devices as follows:
> 
>    nullb0 -> nullb1
>    nullb1 -> nullb2
> 
> nullb0 is not recommended since it can not be reconfigured when the
> null_blk driver is built-in.
Isn't _remove_null_blk_devices() supposed to remove nullb0 no matter
whether null_blk is a kernel module or built-in to the kernel? And if
the null_blk driver has been built as a kernel module, how is it
supposed to be loaded without calling _init_null_blk()?

Thanks,

Bart.
