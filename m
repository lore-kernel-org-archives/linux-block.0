Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375A2C0F65;
	Mon, 25 Aug 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118917; cv=none; b=YbaXgCSTg2Mil5hHVoRph6/h9NYZAunLWs/y0JYv+iXz47H3WsgU7mwmVxFq7n8PIJqFgT9UTnfYEw9IyFsUjrHtWotCIfKHvIxX3wDWOl/O8Oi0PyKFBuvfcT5NkzUqKpR5bqh75Hvtt7mCyRM3ksVl7NcCJYK5VGqgNM1ygow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118917; c=relaxed/simple;
	bh=xD9FPP25buVFQAn/WOe3jq6zmS/t4GpiNx/kT16n+Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vg1fYHpTBNLHmImO6kay4WVgWGxh2q/LOD+uiR/RKdMzkjtOEQ+Kog8ntVIfHToGxxWUWO1xt8OUlIuXQUm4cBMELifNCwkZwyw0efCqk9TZMeDQUN0vHre8/e+QRujaMB/1rbhbpxlfCd+trASRDSGgnDu9N7rTvaarYXo2PG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ql+1pj/I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ql+1pj/I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W0ePWJrL8zLHLI/7zOekLMIUKGVQyS1J9aNk1uCaSsE=; b=ql+1pj/I5lRDNImEjr8/n57jKn
	9csmYt8GcpuX08r7gfR2zBrKGulXo5ZSnQBVKJDErYatudJZdLH+/GJVszoYj7mtxP9T7cQsRjnYp
	/czeFy27mTZzSB4NdWfjk/5VwutUhEfFde3mcP7NjduXDgmN6t7WNZjwuTlolmeQrk9zzicOzhGgW
	QN7Zc2DFYmnmuX7BdcfXfSs2dma1EqRY5edxxbftKrK6HTQ5i5SvAjPIJCbPuKtddnCtFc9rU97E2
	8ruGP07GXqBEoqZwdkGZE+d/C5Y4SGUXwPyZyKR5ngvLP3i0V054EpP9NgcVzJxqDlhJb6BZJyzNo
	C6rGHkXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqUkW-00000007fvd-1yit;
	Mon, 25 Aug 2025 10:48:28 +0000
Date: Mon, 25 Aug 2025 03:48:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, hch@infradead.org, axboe@kernel.dk,
	yukuai3@huawei.com, rajeevm@hpe.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH v2] loop: fix zero sized loop for block special file
Message-ID: <aKw_fDgwfBG4jUWk@infradead.org>
References: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 05:32:05PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> By default, /dev/sda is block specail file from devtmpfs, getattr will

s/specail/special/

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
