Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D179226D1F;
	Tue,  6 May 2025 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512835; cv=none; b=AM53zwNumTtSKBD9lVrDxtg4DF6ccnDqRt4w05NB4GDGqCfiOsriotmkqPGa32Zs6QOqKgS8UZHIku5/O7wwIt+YApiyFg021JUJFRMPd/p+VfpYAxebT29yyrZcsNP70jGD6HdAbmYr04q8VYwSiv5X+feGZ1e+Kb9zgE/PTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512835; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVW7js8ivMCSXrdiG66wRnVqaJQ72b9HhWSXljpib7/SwjwYUNf99msGeYXGjAxN8taOFb8bfIhC3Cf9Ts0x6tKLmskoq8GBj42TgnPVuJxVZtUvdgRJFcgqVsErQSIpgxVeqlCuf4tfHNTZ9uP0soTY29JJc1SZS+Ovrj7sR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2343F67373; Tue,  6 May 2025 08:27:08 +0200 (CEST)
Date: Tue, 6 May 2025 08:27:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH v3 for-6.16/block 1/3] brd: protect page with rcu
Message-ID: <20250506062707.GA29623@lst.de>
References: <20250506061756.2970934-1-yukuai1@huaweicloud.com> <20250506061756.2970934-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506061756.2970934-2-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

