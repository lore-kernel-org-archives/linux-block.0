Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116115E5D4
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464252; cv=none; b=KZoglsc9ZjjrOFCFn+Iwpn0HHlM8KubidTDWp32XQsl5EJ8vYDEkTYUoIBLjHIbNH/98gg9l5voDp9I1N2vlfdVq8MFbOdZEArkluN4uo9h9e/WpmbUnS+e9O987N8fm8Oqb8PG+bjwOR/YrTe/jhjbJVIoOpEeMjiX127ZAmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464252; c=relaxed/simple;
	bh=9mJHFffX3yduY43liuwocwAGLRK6z9b4B1pkX6+fICw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkBLq9m9P+rcmQHthYPDDMWCIw4qq/RJzd3Dq/0BZSo8/AWlHKp5r+ZzycVKB6r4S/s1xSl7OOXFeJvyy8JD+yg1HmshZb8MMRDXS2BbAZCGyRzcKUBz510nHCCZ2KiaHTXJ6Z/TXQV0zmJXmKdeYL9qIurI+UPFISOqjE7lpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obmos7ZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obmos7ZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9CDC4CED3;
	Tue, 17 Dec 2024 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464251;
	bh=9mJHFffX3yduY43liuwocwAGLRK6z9b4B1pkX6+fICw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Obmos7ZSMzPiDUkRfB/rezy2D0BT0rLJ0L79+WyqMtPTW8PmT6b6P5USLpce2Ajpm
	 9E3K93ayJIO7398oPkwH4WHGfsX//x8ck2h3bGPP9mdQar/od2ghJ2b9VyH7ncbzFZ
	 stotM3RFioeyAwNgEtuNuzTBBIcDr5Y5shadXAVmFsqToG+RZLmjKe+GQvH7dcZOEL
	 +SDJmUoSUPcc/jYgu5g3vLgGyZ+BjfyoxB6RFu9BnMkXVuvzg+i6T5MmDGpSt5+HlC
	 b3/YJ9cm2BZHfx1rj8uMSzy7fgWShNdXbSHKR3UYQhaueO7UzI9sg/wbtj7EEP7juD
	 Hx83bFCj1k+7g==
Message-ID: <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
Date: Tue, 17 Dec 2024 11:37:31 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 11:33, Jens Axboe wrote:
> On 12/17/24 12:28 PM, Damien Le Moal wrote:
>> On 2024/12/17 11:25, Bart Van Assche wrote:
>>> On 12/17/24 11:20 AM, Damien Le Moal wrote:
>>>> For a simple fio "--zonemode=zbd --rw=randwrite --numjobs=X" for X > 1
>>>
>>> Please note that this e-mail thread started by discussing a testcase
>>> with --numjobs=1.
>>
>> I missed that. Then io_uring should be fine and behave the same way as libaio.
>> Since it seems to not be working, we may have a bug beyond the recently fixed
>> REQ_NOWAIT handling I think. That needs to be looked at.
> 
> Inflight collision, yes that's what I was getting at - there seems to be
> another bug here, and misunderstandings on how io_uring works is causing
> it to be ignored and/or not understood.

OK. Will dig into this because I definitely do not fully understand where the
issue is.


-- 
Damien Le Moal
Western Digital Research
