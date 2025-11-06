Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC81862A
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402215; cv=none; b=Pw82BzWrRcE1Gy2k4KvELvgSchCXlsSV35oCF4ybsJDCoknBqk8BdoLvP8bcNpgxYH5wQxq2/K3pmoWXw7T7pUPDeUc+GUeRygIeqP8pBS7bhh/tyscFD1fiObf+NSn+KvSUWagQ0IkOOijYfwgC8jVeJtJbeV+b9z814CIINxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402215; c=relaxed/simple;
	bh=T+PKIAf1fnbP2f5khzCN53kEpkgYyi8/+DCHAwCpCdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwjylPHjxksPGuGy0YEF9UxW24zNA85WSrPHJkCOnmKyXaL13PhFyxUO4oaWPi+oiMNOCf1fUZLSPk3+30YzcwNv907/Zn5SEF//pk5g+LbizPVuUVG25WWTUz/BwL3Ez3qXKF+PiAvAQizXBKeetVqjuVP2LXlEOw54MfDTJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOWt3w5e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOWt3w5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70809C116C6;
	Thu,  6 Nov 2025 04:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762402215;
	bh=T+PKIAf1fnbP2f5khzCN53kEpkgYyi8/+DCHAwCpCdI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kOWt3w5eXtvKt5VrTf8fcX+y2Fd1LYQIjcUyJs4Qpb91VHxr95K8iuaooXC8fAN6v
	 BveBWORjc2UKKPUe8N7zqY7lBmesXWi614Vk81JqrLbeVdeBPG48cOSv5dIo5RNJPc
	 A95VlC/m11p/w5RCjq+yVpLFIQOVjzOa0sVomC/iRBrKV6Vkg+Jx5jN+ksd0f2CtKV
	 IZdKvsGfjA1NC5Gq6trhfduellB97RPMwvbTWNFVK1GGjXB34CgA7vmgW0+S6zhy0C
	 l+8salU5wh8+OOBm7cuIKIDSa3bmcTBT3n22DX0grZxT6oY6uJWO7zYzlSNsZVcFVP
	 3SnFhGM4kpxUQ==
Message-ID: <7ef27d50-d67d-4c17-9b93-0caf05bd44eb@kernel.org>
Date: Thu, 6 Nov 2025 13:06:21 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: don't leak disk->zones_cond for
 !disk_need_zone_resources
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20251105195225.2733142-1-hch@lst.de>
 <20251105195225.2733142-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251105195225.2733142-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 4:52 AM, Christoph Hellwig wrote:
> disk->zones_cond is allocated for all zoned devices, but
> disk_free_zone_resources skips it when the zone write plug hash is not
> allocated, leaking the allocation for non-mq devices that don't emulate
> zone append.  This is reported by kmemleak-enabled xfstests for various
> tests that use simple device mapper targets.
> 
> Fix this by moving all code that requires writes plugs from
> disk_free_zone_resources into disk_destroy_zone_wplugs_hash_table
> and executing the rest of the code, including the disk->zones_cond
> freeing unconditionally.
> 
> Fixes: 6e945ffb6555 ("block: use zone condition to determine conventional zones")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the fix. Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
