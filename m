Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F491AC44C
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617599; cv=none; b=qAFoOTq7lPm8bAL7rTi0fs6YWhupP8eZMUXSW+lioqr7Y6Pq6feMvXbHmAMw0g9gNDxqSPuWOdjc3A/bGijBSOGR2p5UgTt86lWcckPiPDkQDMGV4qUWly4BuYNJJJ3emOqkfONkAfxjyLYmD+BvdkftI/K9JNh+OUt9U6ZmHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617599; c=relaxed/simple;
	bh=Mvya6kkkCnoJat/mIwY1BClVaRQ62vQyvRqArNR/YdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvNE7c8fWHgWH3pXnoCZ6SQRyrCoF350aYcI/5wQWhleR5vFCPV5CLn5doA1bMqmGLjG1yx0mhsMFYFFmRImqV1kG+/m6JfGpvZF+2v0QQUtuF527BNcr0trQlPbcTAXKakAm6WkyNYxSPYMOdGBjffN0RwqriuiCCV4e5HJ2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQZm/Tfb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQZm/Tfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5C3C4CECF;
	Tue, 26 Nov 2024 10:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732617598;
	bh=Mvya6kkkCnoJat/mIwY1BClVaRQ62vQyvRqArNR/YdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZQZm/TfbNcep7iI6aHniP8WU3IhMUWX0lu6J/ZMG+lf/t049SkN7a1F+Bv53G7aMm
	 mtQjmxaGmUXidQqzdizc72ysZfhtovHNj5TTTpzKIbq0M2yr1YGkbnpY+MRqtrmgj3
	 +jyzRWqfZGDbLlbXPUtsusxDWYd+rfGMeeE5Efgs2udcf93dfugtZQ/1UgCK2e0YN3
	 phPH95jMwbwIa0m667pDl7tK8zvUDIlqFJOsThIIzoFARsJ1X59nczxG+rxmBADF/2
	 aGG9t7vmyGv4moBiEVb9+EEVASjgqRLVfzqR4jgdk2vukYxGuc7K0lVTAag+fgcmgn
	 mFbcfoDP5cx+Q==
Message-ID: <3838e566-8b85-4092-a828-b3b7198b7b1e@kernel.org>
Date: Tue, 26 Nov 2024 19:39:57 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Prevent potential deadlock in
 blk_revalidate_disk_zones()
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20241126085342.173158-1-dlemoal@kernel.org>
 <20241126103351.GA16537@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241126103351.GA16537@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/24 19:33, Christoph Hellwig wrote:
> On Tue, Nov 26, 2024 at 05:53:42PM +0900, Damien Le Moal wrote:
>> in disk_update_zone_resources(). disk_free_zone_resources() is also
>> modified to operate with the queue frozen as before by adding calls to
>> blk_mq_freeze_queue() and blk_mq_unfreeze_queue().
> 
> This now adds a queue freeze to disk_release for zoned device, which
> previously didn't have it.  Given that at this point no I/O on the
> disk is possible, and the freezes are quite expensive that's probably
> not a good idea.
> 
>> -	blk_mq_freeze_queue(q);
>>  	if (ret > 0)
>>  		ret = disk_update_zone_resources(disk, &args);
>>  	else
>>  		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
>>  	if (ret)
>>  		disk_free_zone_resources(disk);
>> -	blk_mq_unfreeze_queue(q);
> 
> So for a minimal version you could keep the freezing here.

Good point. Sending V2 with that fixed.


-- 
Damien Le Moal
Western Digital Research
