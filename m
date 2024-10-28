Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74681DF974
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132031; cv=none; b=htACbbLQDsdg89qJqPyVjuOAjgvsK4v+s75J5j0tw8Y4IzExEqwRnGuMcid3V6hm5zCnmasJM5ee3MEe18Qr4N3eya71Oo79LFhZHs8uM2iEJjlMa2uv6UzwnGVlrgcJhgrozodGCk3vnW3/CIIsSUgDX8NhjDnexAPiKXMRIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132031; c=relaxed/simple;
	bh=6uGp1EeSwaOmY3vJJnh8frp66AqgxPjESm4eP8/8iF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE4JMVjFWpHVib03ubzL4rqpSVQQscCqqt8hoMaGIbNHFdLgfs/I3O/TrA65tlKr3rzATmOT3NZR3w4pcZrCoTAogpQf1i/arNNZb4VdFOwUsab/DcHp3pReI3tBrcYFU08cC6SykpWY3DWs9LWfwdH6OeIr+X27h/JF/ly3S6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F088E68BEB; Mon, 28 Oct 2024 17:13:46 +0100 (CET)
Date: Mon, 28 Oct 2024 17:13:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, Yang Erkun <yangerkun@huaweicloud.com>,
	axboe@kernel.dk, ulf.hansson@linaro.org, houtao1@huawei.com,
	penguin-kernel@i-love.sakura.ne.jp, linux-block@vger.kernel.org,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] brd: defer automatic disk creation until module
 initialization succeeds
Message-ID: <20241028161346.GA29122@lst.de>
References: <20241028090726.2958921-1-yangerkun@huaweicloud.com> <20241028094409.GA31248@lst.de> <c2ec4267-6cd6-43ec-2857-287d4610441c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ec4267-6cd6-43ec-2857-287d4610441c@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 28, 2024 at 07:29:54PM +0800, Yu Kuai wrote:
> I don't quite understand this, if the gendisk already exists,
> the probe callback won't be called from the open path, because
> ilookup() from blkdev_get_no_open() will found the bdev inode.
> Hence there will only be a small race windown for concurrent
> create on open callers to return -EEXIST here.

True.  I'd still avoid the noice printk for that corner case, though.

