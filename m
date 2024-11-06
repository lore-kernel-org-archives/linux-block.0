Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F597645
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730933524; cv=none; b=gahUpSOASCgsWRin+MJsPGLNMLdXz9zXP98PcJsO/qFjz6Px/PqrAjuE1ZMGhw6HacW44OIPS+p1SN/1+qIlBVjfr9jGtl8InwBZuJAJIKD2mmg3Wu8+unNhn+zGF9D3xrrK634p87qpBmr8z2rQAHsWl18j0+rW8zv3wKWSlXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730933524; c=relaxed/simple;
	bh=IsuIgrKRyLfDJVLxmRNUvDRrW9tTMKp18hN5rtgkqHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBW995k2W0eM1ErMyQyqP4lrbx4edKc9adctJvT/qlvCCHgbqQyqS5CmUvWJiTKGn85fpN+sXjxaB7K8oDrNjU9tDfqehEWuzImU/jFfycKScK4nkPuue0FR+7rV1Tjq2lHYPbK7kCEXaF9xNTwObQpdCxsv5N+a9KnGCLP5AH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS+eSOwD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS+eSOwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5DAC4CEC6;
	Wed,  6 Nov 2024 22:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730933523;
	bh=IsuIgrKRyLfDJVLxmRNUvDRrW9tTMKp18hN5rtgkqHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MS+eSOwDe2g3lgWb/hj6nFRph3KcE0RUojv9Eef1J5aU72F+3EeOKo9XKJLO1ufRS
	 3d5a10W4wz6AGaGQMiD+hrZx8Y6A9wjROx6AbaNmKYo61sN9RZTRYU4zYe/HYO9OSm
	 MHXVUo/1UxXQOmT8Zsndx0fr1eWL6dYqF0z1TvGYRR01oEtSxn8ASz14bIa2wpaQ6w
	 w1mLAvQ+8KOQ23t2DlHWRfsacOTxYMCXn1vks3UmRgsq2hDTegpZ5vADDqMUT47Rti
	 F7+p00JvXiPzl/8ol9kn7GAA4wye/Pjc4K845bXIlPWKOgEu/8KeXG6u+LWC701sXX
	 cCKXhLCiVh89g==
Message-ID: <ad82020d-e34e-4ce7-88e5-a0f31762777c@kernel.org>
Date: Thu, 7 Nov 2024 07:52:01 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: fix the initial value of wp_offset for npo2
 zone size
To: Bart Van Assche <bvanassche@acm.org>, LongPing Wei
 <weilongping@oppo.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20241106000216.1633346-1-weilongping@oppo.com>
 <ce0d9452-8eac-49e1-97c6-c0e9c9ee6d2b@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ce0d9452-8eac-49e1-97c6-c0e9c9ee6d2b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 12:16, Bart Van Assche wrote:
> On 11/5/24 4:02 PM, LongPing Wei wrote:
>> The zone size of Zoned UFS may be not power of 2.
>> It should be better to get wp_offset by bdev_offset_from_zone_start
>>   instead of open-coding it.
> 
> Hi LongPing,
> 
> As Christoph already explained, only zone sizes that are a power of 2
> are supported by the Linux kernel. Hence, patches that mention npo2
> zone size support in the patch description probably will be ignored.
> 
> I'm wondering if this patch would become acceptable if the description
> would be changed into something like "Call bdev_offset_from_zone_start()
> instead of open-coding it."

Agreed. That is a much better commit message.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
