Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207733C9;
	Mon, 21 Apr 2025 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745213104; cv=none; b=tHPE/wxqXiog2vvYH6Tessus7xGGA7mtQ054P/9GIHXpN1mGYlHch9X636qxhp48aDBZ0BLr3fPMaPtnd+5XVfSF5bxMXPlAgsIpnNT0pz4PfjZuEPW6MlQKDjvfKLq4XbulUQyIPXtvQaoQ+lsiSAG2RL8f3bh/4IdC4fsSLLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745213104; c=relaxed/simple;
	bh=kVwvBmn3oBFHYmTKHKv828F0W06L7f6Pi0rJolvv/d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmZgROr2WbNUOoBaQZe++CKYgt9ORPHC/OMoBFRqS42bQjmTnrzTjCZ28d9xNVILDwtroEuDw5Li86aP4jF+x1jOxwZ2La+3SZeDdLxoAvPcPPle9wALjzZV6I6dCqd9yAycZOcCkacNMTytKF0cBwdg9yG3BHFnEQdbaHbz9nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ct+TsZyp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ct+TsZyp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S8rxOTYbfGpL0uUOFuGNfaUDDkmBvG1tW0kaspkCsrI=; b=ct+TsZypzDvwNunikb7LlAjDP+
	/zCFZafa2/w8oh6aB1PgfynUnqKTOwOgqIIYAuqlWwyTuM1yrXxK4WKvaut7OEOKbeEnKfwEFzCRu
	YKTXec72tiLoanQYKQPtA2KQr9C7wzvid6DWjt/YkbCLoOmdm6GlPZejIznpaM1J8tMRIbFYhAskg
	ZKI+j3Bh2Vy040kgbGr+O+Zvjb/xyYY9eSPFaP25PkAMGNwXYBxHP7CNbNNP8UsvcnxbLy6gYC37y
	nrBBI+gjarAQjMAzHxD+PXJiD2JQe1gGQmYcYqPSpmWb698cj4y7nqX1ZpZMrRV3+Tm21Acvp7McI
	Pog26WkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6jeQ-00000003cw7-3Dv6;
	Mon, 21 Apr 2025 05:25:02 +0000
Date: Sun, 20 Apr 2025 22:25:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 3/5] brd: fix aligned_sector from brd_do_discard()
Message-ID: <aAXWro5llPjjq6T4@infradead.org>
References: <20250418093826.3149293-1-yukuai1@huaweicloud.com>
 <20250418093826.3149293-4-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418093826.3149293-4-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 18, 2025 at 05:38:24PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The calculation is just wrong, fix it by round_up().
> 
> Fixes: 9ead7efc6f3f ("brd: implement discard support")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

