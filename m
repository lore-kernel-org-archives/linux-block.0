Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D164246BDE
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456883; cv=none; b=lcNZ7XrozpLH5dVCW3q8RuCiv3elPh3NgLpdn0WtSR3XbTVir+IEcjXyWLyV0h8Wnh/bz3EW953UCd8uPzMQS3QkVUovZt7uEkKZtewmIYsCseK5NvwS88iBD+iuNSANVgVenOXyuWZxRY+GkLgATAUhDMIFlGFhwhf2rTMQSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456883; c=relaxed/simple;
	bh=nhPGd9PCaDzDuxF17T96SeMunV1TR4d+6h1oHReWWzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmeCndSAnPiPnmAMVdFMopCtCjjNauOxf1cRQxdfYZcnaSGLSkM2IXfnPm4ewYlUWO3tG3Z7X5+ZeTRAZAgXfKlBfq+GbVMmQGigdnJXdCzd2P5yHx/eGRRE3vpomGDpt1C9LvMG27CESazRZiwsXNnyrNSZlh+TYXM5BMGIzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wK7RHXCm; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wK7RHXCm"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cmJX073RTzlrvt3;
	Tue, 14 Oct 2025 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1760456877; x=1763048878; bh=+oXw0FN+pObrP6aDKz4d/pRj
	XdbenAm6a7iGxsvp4Ac=; b=wK7RHXCm0M3YaBrzG6TnNuRu5+sVMtY9AtQUhuRh
	wNpPwNpQUET2gnRHniP5bwqRVok9lS7whbhLGlXhbh2dSWq4B1YlU0O2D22mHetU
	f9cZ0f6Pn92TqRf1e9Dj6FZNVSO/rw6vhwMOg7ytjIf5Ol1bM9OaIWv+cZ8ECx6r
	hdLTTrnGkTlkRF64Q0hcDlpDAOCqvBBf4xAtjIOSaJmQDtqGsyeXc6hA9ksZuxlb
	2zBCdK7+ULqe5Z+O2E8ltZJxItR4Gbl5wIdocPl5IWX5WP+Er0V08OloxaDmG9VA
	rr9cTprFWIAAVS/Kj04Y9bgRoK74mR+atz1DwDPUQeMxBA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id P6xNjNA1cQ1h; Tue, 14 Oct 2025 15:47:57 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cmJWr4hxBzlgqVj;
	Tue, 14 Oct 2025 15:47:51 +0000 (UTC)
Message-ID: <7d946913-9662-44f4-b364-a4e7dc26c87a@acm.org>
Date: Tue, 14 Oct 2025 08:47:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/mq-deadline: Introduce dd_start_request()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Yu Kuai <yukuai@kernel.org>, chengkaitao <chengkaitao@kylinos.cn>
References: <20251013192803.4168772-1-bvanassche@acm.org>
 <20251013192803.4168772-2-bvanassche@acm.org>
 <063353d7-9d79-461e-a974-4419a5b6421c@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <063353d7-9d79-461e-a974-4419a5b6421c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 9:16 PM, Damien Le Moal wrote:
> On 2025/10/14 4:28, Bart Van Assche wrote:
>> +static struct request *dd_start_request(struct deadline_data *dd,
>> +					enum dd_data_dir data_dir,
>> +					struct request *rq)
> 
> Why return the request that is passed ? Not sure that is necessary.

If anyone wants to modify the return type of dd_start_request() into
void that's fine with me.

Thanks,

Bart.
