Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F619755B
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210858; cv=none; b=UM8vecfjE2ydTnpWAnKCJmZ+ZTiqrCpvTMlD4wo4Q2PWJ7f3xDM6MuLaWGvWmkMjQhfxEoS3uF8N83KzZKe3MF34x9BCzxia31Insv/BWc2kkEIjdX08rBoU98dblvij74BYNU37Kde7PA0ZtXF9GiT08qsO4YhLHIeTkMu4cOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210858; c=relaxed/simple;
	bh=JGMTKrGbi/V5kt5McxmYaELYtsIeAOHCFjIOGo8ZMOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltHQzuazBK3rin668GCHiCenXFj+oA1COWUfuYs+RRu4h3UpMqWd9jXp/q+HQ9UQrBrTP6ajwenIrYSpQEa/my0uIHxFxfHPNatcNDo7CCqP8oEjGvm6NKbKSEa82ghreuJrs2Y2SzegSWl8hHVK+hMuSxSx7OlY2vnV4ph/Nmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7DnkBP2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7DnkBP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102E8C4CEE3;
	Wed, 18 Jun 2025 01:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750210857;
	bh=JGMTKrGbi/V5kt5McxmYaELYtsIeAOHCFjIOGo8ZMOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b7DnkBP2d1006uAwsaoF1kBwmAvvpwC0uM/MnJDBy+P7ZnU2dIyh3fgY5YeyzXdsv
	 2ODSqi8k8QeW+keWKtH9lAx0VbFDt0LIvf9mOHmaYY1FN86U2J7elGfEJeTyczEHi9
	 biC8PzOcCc4aM6LixcGJcBZi/w8nIw4ZtfvltyqeVEYmPqMRZHlvCMS0xOMwuqTt8V
	 EIduO0Um/j/txfOZSJpf+6UtjLAX4vVtdwQYAzaMmmoDSly8B0wKvwBrAQAhv0eLZU
	 TMVTQUyNzHwu4vpO4c+bYquU8Te19r4yUQ6yZ17xnINZgpsb2ve9Ck3lAQG3I4U5/A
	 eZrQOwSrdxjzw==
Message-ID: <8c2943a8-ffaa-43b7-a28f-f6da4403208c@kernel.org>
Date: Wed, 18 Jun 2025 10:40:55 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250617063430.668899-1-dlemoal@kernel.org>
 <aFGBJwK-doBF6fBz@fedora>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aFGBJwK-doBF6fBz@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 23:52, Ming Lei wrote:
> On Tue, Jun 17, 2025 at 03:34:30PM +0900, Damien Le Moal wrote:
>> Back in 2015, commit d2be537c3ba3 ("block: bump BLK_DEF_MAX_SECTORS to
>> 2560") increased the default maximum size of a block device I/O to 2560
>> sectors (1280 KiB) to "accommodate a 10-data-disk stripe write with
>> chunk size 128k". This choice is rather arbitrary and since then,
>> improvements to the block layer have software RAID drivers correctly
>> advertize their stripe width through chunk_sectors and abuses of
>> BLK_DEF_MAX_SECTORS_CAP by drivers (to set the HW limit rather than the
>> default user controlled maximum I/O size) have been fixed.
>>
>> Since many block devices can benefit from a larger value of
>> BLK_DEF_MAX_SECTORS_CAP, and in particular HDDs, increase this value to
>> be 4MiB, or 8192 sectors.
>>
>> Suggested-by: Martin K . Petersen <martin.petersen@oracle.com>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  include/linux/blkdev.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 85aab8bc96e7..7c35b2462048 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1238,7 +1238,7 @@ enum blk_default_limits {
>>   * Not to be confused with the max_hw_sector limit that is entirely
>>   * controlled by the driver, usually based on hardware limits.
>>   */
>> -#define BLK_DEF_MAX_SECTORS_CAP	2560u
>> +#define BLK_DEF_MAX_SECTORS_CAP	8192u
> 
> The change itself looks good, but the definition should belong to block
> layer internal, so why not move it into internal header?

Good point. Now that no driver uses this macro directly, we can do that. I will
send a V2.

-- 
Damien Le Moal
Western Digital Research
