Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30524AD4B
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 05:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732771291; cv=none; b=n0BcZkLmvAPtBwp0mTRVcsd6bylsZL6+mZZfsGplSj9HhPana5L0YES3R41i8StoV3GFjousQADp+K04QahvpbyoOFiy5a4mL3hjjBk/G1EK2lHWJgGJ2mM1matDo/mYKA/Exgmoqe/YiA8OIMlXq+bmZLSbclCZUeXxckkO4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732771291; c=relaxed/simple;
	bh=X2oJEY9KdPlla5nKwZuJWzMFsor+sBgEBnTUDfmKjs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1EqasVAq3FAIsjaVoSikLuhtRF/h/IqJAg2sErS7745X41DOER87bZYpEYKD9Ia3Ompsjg3xYI/NpM7vtDmKDwCEtpvzrlH9iX9xmskiT4WBoG/CfX6/Y+OmYfyrMdFGoEKPplIz4K4coQUtaENBtm5PaCgaTUIcckLNDG9EFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kkS9pKtw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kkS9pKtw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8T7xNc20XgFELuoBVBDEtpFF3pUquLSdSTIQ453TvYk=; b=kkS9pKtwbmQA8Dxibjtgw8QyGs
	/ruiOe26bZycKJUk9+1CaAjrAXPF6HL3nKzYjIZWk1d7i4aWncgt+45lO24810tSxRowXYj9UQHoo
	Q6dN/Wq2FuXFWQ5XiWmelXWZxmOu0MwTErlHAzic7NWQABcUQZAzvfjimdO2o5CqvqKb9mRIE2pi9
	yrrWQLGdEwTe3dSXeHfqI4vd/HqHSZYJBVAv4qGOMiUQCsoguJ0kyfkkq+mWHr6tFeBZfpE30YNTK
	xIXNhVrtxnhxcxAtVq0Pvucgs1pQwhI55rH0XKJiwsyZ2acz0YSC5BiSN7ehIeWmVuBuZbGfhEev8
	It6/RPJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGWy1-0000000Ej3c-35bS;
	Thu, 28 Nov 2024 05:21:29 +0000
Date: Wed, 27 Nov 2024 21:21:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0f92dX_0_eQlDbL@infradead.org>
References: <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
 <Z0fhc8i-IbxY6pQr@infradead.org>
 <16e543dd-c4e6-4f79-b401-8030d7ba1514@kernel.org>
 <Z0f0B6Xf-jdc_fx-@infradead.org>
 <43c0f15e-7f3b-4ed9-bde9-dca2cff57afa@kernel.org>
 <Z0f47wft_sVto7pM@infradead.org>
 <a9ad27f7-b799-4322-ba05-944abfc0fa88@kernel.org>
 <Z0f8uAFz5C60fung@infradead.org>
 <684a3b59-776a-466a-8323-d92c0502e7a3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684a3b59-776a-466a-8323-d92c0502e7a3@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 28, 2024 at 02:19:23PM +0900, Damien Le Moal wrote:
> Sounds good. What do you think of adding the opportunistic "update zone wp"
> whenever we execute a user report zones ? It is very easy to do and should not
> slow down significantly report zones itself because we usually have very zone
> write plugs and the hash search is fast.

Just user or any report zones?  But I think updating it is probably a
good thing.  When the zone state is requested there is no excuse to
not have the write plug information in sync

