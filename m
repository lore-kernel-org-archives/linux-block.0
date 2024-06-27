Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B001304A3
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489836; cv=none; b=iuI5OtRxonZhw48pQcbVMSed0JDfl7IoSWxbAcGeGu/hGYh8GA9K905Q70Y1CtdPSnc1kdIqujigfJrXgnielLpkZrEJrmffEjaG5p3wAgLvVT2eYQtA0VS+g42UcbGfuzuX7SPFCiQVvgmy3Qf2RFnwgyqvML1bLIns49XprYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489836; c=relaxed/simple;
	bh=kicVUGG7T9DR3B7UgRJmBr4qz+a7vk6ydim48O4Zpe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrXGcPP/cubKAdeQwEw8NgqBRkZ5iMabhEWaB9n0URYZHEDiMRSbqE+Wor9vGe+IWxa7+/1zHBg1wxFo6IzFz7KfbQdU2a+A8gPvboetrBajUd8xCoMWGTI6uRX5GUmD2jUGx5tkNTXMoqKWzMvmKzCZ6rHXc7kw4rnJr9Aas1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TARzizBH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TARzizBH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cQHkUa/3HkzD4+9RTO7+x3BZNiIiWmDKbk5Y/WfqxaM=; b=TARzizBHvbe3i6QUax6Hs+S6yw
	hqq//8MJaPbgHPKbwHg3shsHL1garn3amAw+6PvGaLxKCFpbmbEkuz7IDpSQISZMkWzUfcCEEHnTw
	gYxBnEw8WSZniuLodoVxtaoOmvLPP0QJbsGJOmvCJPtOESQMfVNbzb63RzMonSwhtWyGqRLogtZ4v
	PDEw9bN7wQIdT2h25mTIjbQ8q/cVyT6fbFoYf4J+natu6xnW3d34fpcNUlvsYzEMPuVCPV3HYzrte
	F4kxdwbRfjiLM6wrSaT3ZjhhuG4qsZzmNIKCDQL9w9y95JO7oZC6BOaBgwe46jZibdfpNG+mishP9
	Bn3zbUJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMnqs-0000000AGiv-0s2e;
	Thu, 27 Jun 2024 12:03:46 +0000
Date: Thu, 27 Jun 2024 05:03:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v3 0/3] Add support to run against real target
Message-ID: <Zn1VInQSahym_HhZ@infradead.org>
References: <20240627091016.12752-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627091016.12752-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 27, 2024 at 11:10:13AM +0200, Daniel Wagner wrote:
> I've added a new hook so that the default variables can be configured via the

Please make your mails readable by following the normal 73 character
limit.

Also what is more "real" about these targets?  They mostly are
remote and more diverse.  Maybe say arbitrary?

