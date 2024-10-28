Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3418C28DA1
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108657; cv=none; b=NuxOO9xLnNedIDWaEgSnhVYRMuzH9VtVS1+JWk027/CxS+0SYPVIMIRZdnksvEcHaEvHOER/qa95pqppNwI6344I/YlSy6THq2BPxYYb1lRn/Z7xaebKgIloRy3g3IiTEmksG0LJeiMQ0V9+KuZhuDr5LM1CSPPP9k7Hvb9Xtl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108657; c=relaxed/simple;
	bh=WpU8gxZAfErhXHyxSihxk+JWwxn5hqYulZjB2QZ+g94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz6bfSkkbfgmwvrLy8rx1IZQUqJN+lvThyJEtew1g5BtQax8bBT266WTsB5m4qpj0Q57nl/SlGFJyaG/n5568VwNJ+HdhRyXmjnSmmpLRyTLGjSHH30wEjp9eU677V1tN+Yy95vZ2AbfVHFO2Rw87/WGmlyCa+xbs2ufXv5YzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F35B68BEB; Mon, 28 Oct 2024 10:44:09 +0100 (CET)
Date: Mon, 28 Oct 2024 10:44:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yang Erkun <yangerkun@huaweicloud.com>
Cc: axboe@kernel.dk, ulf.hansson@linaro.org, hch@lst.de, yukuai3@huawei.com,
	houtao1@huawei.com, penguin-kernel@i-love.sakura.ne.jp,
	linux-block@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH] brd: defer automatic disk creation until module
 initialization succeeds
Message-ID: <20241028094409.GA31248@lst.de>
References: <20241028090726.2958921-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028090726.2958921-1-yangerkun@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 28, 2024 at 05:07:26PM +0800, Yang Erkun wrote:
> Fix this problem by following what loop_init() does. Besides,
> reintroduce brd_devices_mutex to help serialize modifications to
> brd_list.

This looks generally good.  Minor comments below:

> +	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
> +	mutex_lock(&brd_devices_mutex);
> +	list_for_each_entry(brd, &brd_devices, brd_list) {
> +		if (brd->brd_number == i) {
> +			mutex_unlock(&brd_devices_mutex);
> +			err = -EEXIST;
> +			goto out;

This now prints an error message for an already existing
device, which should not happen for the module_init case,
but will happen all the time for the probe callback, and
is really annoying.  Please drop that part of the change.

> +		}
> +	}
>  	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
> +	if (!brd) {
> +		mutex_unlock(&brd_devices_mutex);
> +		err = -ENOMEM;
> +		goto out;
> +	}
>  	brd->brd_number		= i;
>  	list_add_tail(&brd->brd_list, &brd_devices);
> +	mutex_unlock(&brd_devices_mutex);

And maybe just split the whole locked section into a
brd_find_or_alloc_device helper to make verifying the locking easier?

> +	mutex_lock(&brd_devices_mutex);
>  	list_del(&brd->brd_list);
> +	mutex_unlock(&brd_devices_mutex);
>  	kfree(brd);

> +		mutex_lock(&brd_devices_mutex);
>  		list_del(&brd->brd_list);
> +		mutex_unlock(&brd_devices_mutex);
>  		kfree(brd);

Maybe a brd_free_device helper for this pattern would be nice as well.

> +	brd_check_and_reset_par();
> +	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
>  
>  	if (__register_blkdev(RAMDISK_MAJOR, "ramdisk", brd_probe)) {
> -		err = -EIO;
> -		goto out_free;
> +		pr_info("brd: module NOT loaded !!!\n");
> +		debugfs_remove_recursive(brd_debugfs_dir);
> +		return -EIO;

I'd keep an error handling goto for this to keep the main path
straight.

