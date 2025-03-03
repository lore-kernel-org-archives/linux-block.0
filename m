Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B561C5D5E
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016393; cv=none; b=oV5/+epOo8KL1h/fL2SCitxe0ZBFNGrb2M+hyqRYtoDPBAJjrNFFCS+RvFvjwIA4ppb1Mag8iXrD3zbig9c0XJlbjx0nNJjO+GWdcymE7rhJNELRJ+1v2K8N654Yk/XlejLsL1gugqHvQ/1CZQ1SqvMaKvwIpsTxCtWbH2z1hnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016393; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onataa9gPgH62HcE/Sni7FlDolCm9yRSGvpENQDG7w2uunPuBWyowYDAQV0C2Dqv3Pqi/kEawOqC39Gdr3D9qvxnchWfdcrTMl1XgZJiw0JPua7Q49wfqgW6pYJhjBnCW2+g/IQAY93uPOYNkaUOWyTu0hR9ZPXq4nrmnl7EgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nMK2Rz4l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nMK2Rz4l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=nMK2Rz4lnCRTe0zWSRIzHBquHX
	fIyDrVi7Pbnu59jDZJlUFKFs/WwzmOocqsEz6SJuKkfYBaALvNnREFwPQm2sce7yx2d5uO/1XCLbQ
	vzhm+7NIWQkBJCj6U5j3pISM1TWCnp0/yJGjrdrFBa/gpIOFyVdNfSjJL3VhqK9N9o4wNvwuiSD9O
	bIccog2Mda5pHwY/jtkHVh55BGRHhCVP3BWVdAJRVF99bUErIk3sGqh55AEHKX3Nmxp+w8re//y/E
	AzW+mOkQfNY3aQ8i402cpXHmxmqpn67i9ms/FFUsUEcUGm3VK5yIYAwnZ9uNC86sQMPLLyfAFKjbI
	SgBmtbrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp7tY-00000001MDz-0Ih8;
	Mon, 03 Mar 2025 15:39:52 +0000
Date: Mon, 3 Mar 2025 07:39:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] loop: Remove struct loop_func_table
Message-ID: <Z8XNSOCQtp9ToyZo@infradead.org>
References: <20250227163343.55952-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227163343.55952-1-yanjun.zhu@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

