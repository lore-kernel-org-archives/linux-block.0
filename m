Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97F4A07
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732770032; cv=none; b=dOzDstQAX0v7h++8ut+FaBDiZP68lTZuhuZGBKZjK6zDcc4tuyYSzsMDujo9Lg9l0j0ENeUlsqZZwHMZbnwvyNaaXmjI13LkFQ0Qiunx3QsyYapSoPseuWKgKVSTahzVs3dsJcHJZAnPiD41A4cFypuxSFuc4LEMW5eaKfhq2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732770032; c=relaxed/simple;
	bh=yZWPPUk51d9LJqs7WAxMru7s0eHVIEUOW/etkpCFEK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odegwMspKaDQHfYj73msXaTQpGLqkIWFjTseiFwQs/kFBgLs+6h0o7MTVWiYDQ/wb7k2es8/aAYnuje/ZNlLrgbuciaXLZkHqqjZH6wsY5jqa7p9tIK0UsBUnNEX6COrc2uPiU2Ty3ogujDrCzQcg/wJSj2FiG/Yk3BF882o6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UaT6rWxg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UaT6rWxg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UkoRFQ5/sajBT6vYe14W/fhDQXvpQVJNTzQxX52Crl4=; b=UaT6rWxg2J6AeBNpDTIYOMERSi
	+otoZ5QUhxG44DAGYHEYC113TUpA+2ZFVUpFvB33FTB934UPdCdMjkBUXT9itEKX0LAJFyVo3qElI
	HrGE+4EEIV5Jje3+d29cZxidgYSrHh0iWvaMFM3pUI+oe0If5cYqKSnjMRiOGN3UV3gjoiejEj02w
	yrfWdh9L/jnLc2941LMu2QW5qXksXCXjBV9Ap04i4ZUF0Cy9MQdA2r9DCvVKN0ZOO+t8OuHzQlcLB
	yoA24xBYYeR0R2Mnc1pEbJtTEccDtYmAyWxYJpxxx27stTLpeAoRQae4A8VWkk4wwl+oXWWUjgdZH
	baqTdD8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGWdj-0000000Ehz9-0gCm;
	Thu, 28 Nov 2024 05:00:31 +0000
Date: Wed, 27 Nov 2024 21:00:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0f47wft_sVto7pM@infradead.org>
References: <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
 <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
 <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
 <Z0fhc8i-IbxY6pQr@infradead.org>
 <16e543dd-c4e6-4f79-b401-8030d7ba1514@kernel.org>
 <Z0f0B6Xf-jdc_fx-@infradead.org>
 <43c0f15e-7f3b-4ed9-bde9-dca2cff57afa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c0f15e-7f3b-4ed9-bde9-dca2cff57afa@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 28, 2024 at 01:52:55PM +0900, Damien Le Moal wrote:
> Same: the user must do a report zones to update the zone wp.
> Otherwise, it is hard to guarantee that we can get a valid wp offset value after
> an error. I looked into trying to get a valid value even in the case of a
> partial request failure, but that is easily douable.

Well, we'll better document that.  Then again, what kinds of error types
do we have where a write fails, but another write to the same zone later
on will work again?

