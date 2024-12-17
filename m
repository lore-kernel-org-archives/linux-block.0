Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFFA1F8AD1
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463737; cv=none; b=HAi9J0O2aKUB0H/NTWoUeBkAeHQ2OaGjKO9pK68BMga6f0mQatqjCELie6wV1vBQmBtnKHgyvPxOENaX19W7jzwnK4jQlzbONHbN7UW1wBKjpa1WJ52FuFilYjC8ZoBeIRp2cd+jWt7QURlzhcc4+A1BsXJb52vfuGMXqWosTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463737; c=relaxed/simple;
	bh=2MK+L0JkwAjOv26dTxEjR6k5jOKo9PmWJx4QX6OOu0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1RY77fpnS19ZiviMWxTInxlFI91lWUGeA1s1LO6cGArYuLMWyTRXg2GcrZKzUyvfVJAsfO89cLJPiFW9PZ3/cmyBRqIUuYAajovt8utrpOwocjcgIbIxf8SQtJnSi0n8/0O/JYdBwLIDfEcaSmglnp/dWGN7TJts/UEnhsU/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biYiznNU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biYiznNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018FDC4CED3;
	Tue, 17 Dec 2024 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734463737;
	bh=2MK+L0JkwAjOv26dTxEjR6k5jOKo9PmWJx4QX6OOu0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=biYiznNUSnnR1ecAXqGGG+7eBCHAmeodKzCWGezMM11h7844435OMr5dSIxZmZop7
	 dhYXL/TFsBqffdfE+3wmj/ULKDDywLQcvQBGAJQ1yDT+qyWQhm6fGop4dt9bv5sX30
	 DcBd8ab2s9NmyZjxB9UvdA5uzkOjObwRo8h3Ty+/TjpH7tZgLXV96hh06tPMMwCIzt
	 c8YyJMzQEAD7KnzmudKbC0fNuCMBTBs8RVg9s+XbwG0ryqvt2bFOLiznwdI3LAsivE
	 gMJjzshplXz7dYN8p4WZS4xaah6V1rmDLx5039ES4Dhp69ZOTOJUmla3YtXnbQLDWb
	 4gSkMb3DFJSTw==
Message-ID: <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
Date: Tue, 17 Dec 2024 11:28:56 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
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
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 11:25, Bart Van Assche wrote:
> On 12/17/24 11:20 AM, Damien Le Moal wrote:
>> For a simple fio "--zonemode=zbd --rw=randwrite --numjobs=X" for X > 1
> 
> Please note that this e-mail thread started by discussing a testcase
> with --numjobs=1.

I missed that. Then io_uring should be fine and behave the same way as libaio.
Since it seems to not be working, we may have a bug beyond the recently fixed
REQ_NOWAIT handling I think. That needs to be looked at.


-- 
Damien Le Moal
Western Digital Research
