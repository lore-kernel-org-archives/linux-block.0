Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D62D47EF;
	Tue, 12 Aug 2025 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980803; cv=none; b=Rropmj3XwCkZ4+i7R4lAuQ/s+jimI02EOPwhFLapPpUBNmgdDcgSAUfi0rliu8/je0DLRtlOsAeLwNZADvdRAC9/5eEgrA8MFtH94LPvHH9k9SLZ8Xe2rYvyNBl8y53/TYBRPKTKb6aAuAk+1g1bREDAyyI0UxFjxP9FJMVhEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980803; c=relaxed/simple;
	bh=X+KxCS2Uhbsew3KgO4hOa0KHv118lmYhJfEXIpizQLA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jszI2vPneo+nZ0I+l67MrtHEy3tZ0JeOy4Fu21r/LCiCRUpgZxXe0IVq4Kab2sip233nMTqm5K7MVanE++RwjtDz8iOAGAW6+kHuX7JnqcA1jhg8YPOktOoRv06gSTIsKcstojYxYdql5Z94Xia/XrGjvTJc5dSwSP3wYIbqCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGeUgAKq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGeUgAKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4B1C4CEF5;
	Tue, 12 Aug 2025 06:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754980802;
	bh=X+KxCS2Uhbsew3KgO4hOa0KHv118lmYhJfEXIpizQLA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uGeUgAKqMGN0+X2IcvnNoBIjhaf/7kQ6km8AFYlefJxFOCmWfvaXIhAMN8NzRBM0L
	 rnc2gcYwUNVARLgR45xTNlChn0mDazpPUAefuhVjB6m96DUmWWkP5PLu6IG29+D5Mz
	 RqTtyvjz6xrBcw8ehMGyp82K6gQZFoJQsgH6odkTn44TJUxOeNLcCVX26Fo/7Tf8Vg
	 RxxX+56f42ROpsPP34MyJHPI3cQBWweNbS1ydIzDnYxduxMhNG5jbmNMbHgumRELnK
	 pXS/kAuDiDr8OjyjLcN92VFKzePQFtO1cBF+6DgxmGxViz987NCEgLEJdhxWar9w3K
	 7t4w4Famri2HA==
Message-ID: <5c44c233-50ea-4cf2-9de9-b99c9e197bce@kernel.org>
Date: Tue, 12 Aug 2025 14:39:58 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: introduce flush_policy sysfs entry
To: Bart Van Assche <bvanassche@acm.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20250807034838.3829794-1-chao@kernel.org>
 <aJnLXmepVBD4V2QH@infradead.org>
 <7a2534f5-bf20-4d3c-afe7-afcb8f340929@acm.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <7a2534f5-bf20-4d3c-afe7-afcb8f340929@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/25 21:44, Bart Van Assche wrote:
> On 8/11/25 3:52 AM, Christoph Hellwig wrote:
>> On Thu, Aug 07, 2025 at 11:48:38AM +0800, Chao Yu wrote:
>>> This patch introduces a new sysfs entry /sys/fs/f2fs/<disk>/flush_policy
>>> in order to tune performance of f2fs data flush flow.
>>>
>>> For example, checkpoint will use REQ_FUA to persist CP metadata, however,
>>> some kind device has bad performance on REQ_FUA command, result in that
>>> checkpoint being blocked for long time, w/ this sysfs entry, we can give
>>> an option to use REQ_PREFLUSH command instead of REQ_FUA during checkpoint,
>>> it can help to mitigate long latency of checkpoint.
>>
>> That's and odd place to deal with this.  If that's a real issue it
>> should be a block layer tweak to disable FUA, potentially with a quirk
>> entry in the driver to disable it rather than having to touch a file
>> system sysfs attribute.
> 
> Chao, two years ago Christoph already suggested to integrate this
> functionality in the UFS driver. From
> https://lore.kernel.org/linux-scsi/Y+NCDzvuLJYGwyhC@infradead.org/:
> "Please add quirks for the actually affected devices, and do not
> block fua for an entire transport."
> 
> See also the ufs_fixups[] array in drivers/ufs/core/ufshcd.c.

Bart, thank you for letting me know the history and decision there. I had a
qemu option here to resolve my current issue, thanks.

Thanks,

> 
> Bart.

