Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467217A2E8
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762496067; cv=none; b=Pjja7zyqWLCHaTzFH8JGvgBQIU9Q2kfLbTTLEAATgVWMfEycvRsQ3GX9fUN1rK9OGlYb9cFLPKtpjcZNDBzmKMnnJVS8qfMH2GRf4Kd+gWOCDeLd448LYQmXGXJlov5lz/DxT44bHhPlD8FP8lHTOIekF8ksFbxr/j7uk7G/G+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762496067; c=relaxed/simple;
	bh=+oCRrc9iILPHmnmpxVM35fhBbi0Cqzdopy7sgDreMfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLrNGUqRPIKlJyl24gsNtWCd8abk4ZjdoezJWByqI7QQ+9u/fil/iI0gvHCIvIQYqt2oD2gd0KZ04HNWXxD6/tQYu+91hbAgnOgBXhL+SQImROMGq47mCGAEh1ioqPmq2v7Itz/zDsLOORur6yAe85vE5Z7fjVQ/NTQjiE9I/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeQHRyBK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeQHRyBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2844C116C6;
	Fri,  7 Nov 2025 06:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762496067;
	bh=+oCRrc9iILPHmnmpxVM35fhBbi0Cqzdopy7sgDreMfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TeQHRyBKAHMld/ueUG9rI96D5DTl3Ur1T5I41y5V8QXW42nUR2SrybDR4AsfFSzkS
	 xzhe7CzzG8koe+ySoIVEuaw0L8v05BL5JPnfx1G+RR+07c+agart/i1S1fup866mMP
	 OG5qyEqOAGm4+vnWG6ZFFed5mhLIjJAjN4dNuHQyM0r5mxzjyMCqvPctv/2K5Q6EcJ
	 doYpXRtMBh2qGRjQz0lrFrm+NoeaQqVKL7ddPVw4f/obtz7gVN7s4l0sWCFIOw6dkA
	 nBFa3YHa0ppCwa2mpto3ofSVK9QvG0xSjKvD1H5FO57DoXBrBwzz/0JCIZOzrFEYG9
	 oCY1a4hkUU4bg==
Message-ID: <6f85828c-a6a6-4bef-8b31-b48dfa173f91@kernel.org>
Date: Fri, 7 Nov 2025 15:14:20 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/2] block: don't return 1 for the fallback case in
 blkdev_get_zone_info
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20251106145332.GA15681@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251106145332.GA15681@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 23:53, Christoph Hellwig wrote:
> blkdev_do_report_zones returns the number of reported zones, but
> blkdev_get_zone_info returns 0 or an errno.  Translate to the expected
> return value in blkdev_report_zone_fallback.
> 
> Fixes: b037d41762fd ("block: introduce blkdev_get_zone_info()")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Doh! Of course...

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Note: Is this patch alone or part of a series ? (the subject has the odd 3/2...)


-- 
Damien Le Moal
Western Digital Research
