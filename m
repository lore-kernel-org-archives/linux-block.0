Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D95191F8E
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732751001; cv=none; b=lbONOs4tV6Y472Tg0cxc7Y+lDtPDJPGnFRJ2uNnTAO/xAsXaO36wlg/cxpIZeCBQXFjzWuzj84wHX40ZLunbDsZDT9EoGUz631PI0dU3Xpn9kpz3Phuqdx12aDRK0XKuSahuUqiH71RF8SEec+VpVIKou7YRE7R7CNfE2qlR2YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732751001; c=relaxed/simple;
	bh=d84hEf18U64jd4I3Hup4xV7rk5MSv5Y9wyfckl38tw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9YHx4KtOiHHkYVG4C/woSzQIDiPPwqzUdtd9CCImo9QvjXKTjXNO3SATYaAGkarfuW3oJllt7L/cMZ56Th+MZilaa2Tfvo64naVfujsRGIbmXOOcZOXiBu4XQAIwuJCucb1/RU9GSaM/DB7HKhGD3T3mpD9KFNvuGBzTzMFe8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baVlDvxe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baVlDvxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F98C4CECC;
	Wed, 27 Nov 2024 23:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732751001;
	bh=d84hEf18U64jd4I3Hup4xV7rk5MSv5Y9wyfckl38tw8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=baVlDvxeg/e4hm6mA6zytWo2NeXbOt6P7+xnf8x3QK//s07w1iO1VY7ifcyq9AxNO
	 EBVv4doGOx7f6OERB9YnFdocTqRyQWOqdLtOROLXZZ2+oOF/4epI1RSNqJ7jX894zM
	 roWy/4gZBhRRkRUQqjEnIuDOjj0MsBgAxkVB24JhffTfdEQjxEi1KABlAMg+eZ8sbW
	 PwXHpnVCYDQoiTdrVbFKc2Te1CR2a5gARJkudHsDqBw/VTZA/zM4ZsQEXtMHSHDrsS
	 decEhZSrK1a347GhlyELDHo1S9wI6NQnxeYRNAitCWK9GibWY+0yWXlm6R2LJOWpIO
	 6WiFMr5pCg8uQ==
Message-ID: <f6dde4df-e775-47ea-bcc3-c3a1e6874ca4@kernel.org>
Date: Thu, 28 Nov 2024 08:43:18 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Bart Van Assche <bvanassche@acm.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
 <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
 <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
 <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
 <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
 <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
 <992ba839-5b7b-4db5-bc64-286ca47b216e@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <992ba839-5b7b-4db5-bc64-286ca47b216e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 08:36, Bart Van Assche wrote:
> 
> On 11/27/24 3:18 PM, Damien Le Moal wrote:
>> The BIO that failed is not recovered. The user will see the failure. The error
>> recovery report zones is all about avoiding more failures of plugged zone append
>> BIOs behind that failed BIO. These can succeed with the error recovery.
>>
>> So sure, we can fail all BIOs. The user will see more failures. If that is OK,
>> that's easy to do. But in the end, that is not a solution because we still need
>> to get an updated zone write pointer to be able to restart zone append
>> emulation. Otherwise, we are in the dark and will not know where to send the
>> regular writes emulating zone append. That means that we still need to issue a
>> zone report and that is racing with queue freeze and reception of a new BIO. We
>> cannot have new BIOs "wait" for the zone report as that would create a hang
>> situation again if a queue freeze is started between reception of the new BIO
>> and the zone report. Do we fail these new BIOs too ? That seems extreme.
> 
> This patch removes the disk->fops->report_zones() call from the
> blk-zoned.c code:
> https://lore.kernel.org/linux-block/20241119002815.600608-6-bvanassche@acm.org/. 
> Is it really not possible to get that
> approach working for SAS SMR drives? If a torn write happens, is the
> residual information in the response from the drive reliable?

Let me dig into this again and see if that can work.


-- 
Damien Le Moal
Western Digital Research
