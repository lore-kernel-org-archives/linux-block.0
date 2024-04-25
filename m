Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F0208BA
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047252; cv=none; b=ffiyBtZAn2a2xhW1bFr04H7ujemjZzzxzk4yATwV66NBaSuzzJOrbfgxUbwhZmbliAB+W18HbgADKS4Nw6HfAY+oicI+4SdoKsFQTb5JiYRfUzPxjUGhIKM866rv8nHM3g7iltq1dIn1zmdw0tF2W3du3XmJazulN2f0nXmvKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047252; c=relaxed/simple;
	bh=qRqRdKEhPXp9h+M8J627at9lMsnIBM00lN+fTJU8t2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0W75VeBaue89mtv1QsHP0AFNoh5im/o/VJ16j8A3LSeIoXFhzdZqy45og6FW9EnHUO5oz4PMWI5/41gJETfMKQl9Hec8xgIwpnY7Dpf6ijuwRazrlsi/gSbnx8mQ45Pv8+DRNGzy7DIywUzJ4/sXf4XgsFRKDjFKHRxpfA3c/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIxGl9ri; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIxGl9ri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB5EC113CC;
	Thu, 25 Apr 2024 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714047252;
	bh=qRqRdKEhPXp9h+M8J627at9lMsnIBM00lN+fTJU8t2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mIxGl9ri6i/9BsVII9VrsxdhndQT7hNd1pAfhEA8/OoaUc9ih/1X+DSRuBrPkJ5YT
	 faATcYzOtwgymHRHMgHvUbAcN1wZ5EIExy6ZE6LylxAWs76dbQPReauw+4A3fykcAk
	 bR+1HX412wCUWCa21ds1yn3dpWdqX4Quo2WW/t9b/ro3UBy/8IVyBFuuNq88giH7yk
	 sHkSxalxdSLu6NAK0ByauxFWh1GRGNNMGk1WfiFG9wcQMyVrxiwEr/PkD0YdpJOcoR
	 gzWCpjsTfJHQjENIQtFMdFeWw/07Y1hV6P8TH85ZfGiKV4tjKQkia0YUz0cdFQIB+C
	 h1yh1Y/crldbw==
Message-ID: <3e9c410c-3bf8-4a82-83e3-1268304744c3@kernel.org>
Date: Thu, 25 Apr 2024 22:14:08 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: check if zone_wplugs_hash exists in
 queue_zone_wplugs_show
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, Changhui Zhong <czhong@redhat.com>
References: <e5fec079dfca448cc21c425cfa5d7b291f5faa67.1714046443.git.johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e5fec079dfca448cc21c425cfa5d7b291f5faa67.1714046443.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/25 22:02, Johannes Thumshirn wrote:
> Changhui reported a kernel crash when running this simple shell
> reproducer:
>  # cd /sys/kernel/debug/block && find  . -type f   -exec grep -aH . {} \;
> 
> The above results in a NULL pointer dereference if a device does not have
> a zone_wplugs_hash allocated.
> 
> To fix this, return early if we don't have a zone_wplugs_hash.
> 
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Fixes: a98b05b02f0f ("block: Replace zone_wlock debugfs entry with zone_wplugs entry")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

My bad... Thanks for the fix.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/blk-zoned.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 3a796420f240..bad68277c0b2 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1774,6 +1774,9 @@ int queue_zone_wplugs_show(void *data, struct seq_file *m)
>  	unsigned int zwp_bio_list_size, i;
>  	unsigned long flags;
>  
> +	if (!disk->zone_wplugs_hash)
> +		return 0;
> +
>  	rcu_read_lock();
>  	for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++) {
>  		hlist_for_each_entry_rcu(zwplug,

-- 
Damien Le Moal
Western Digital Research

