Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3664320EB
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 04:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409013; cv=none; b=FVz3mGGdjakxRHXvnDfv2RFttqtQ87ByEz5IyDu6V1f491WLiD9I1Xc5drjcoLZ7v/8pdjyQYCyxLCZvhdfpZK2TWkntViMoeAFONIfj3QYV3eo57902YM+QElFSws83BipwUPeTxL+n9mn2ErYuVQtOixuLjSo+zUiSDuYMH8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409013; c=relaxed/simple;
	bh=6dbItUdxlD4HEU27SnWfKmR8bUZ510Crs+pHt8b+2qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ddn4llq7MZDYkYII8NNL+97wMibrEuQTN8aWia3S9IwB9M1jbqPgEYH3yseXRe6buP6jVwcn7LwZSTHXSt4ThWIAg7eyR60tJTnJq3yGlO+nIKs5EmX4aBNHht4bTjFkdezLjyDFFbxClGDxa4SFNKIzLP9c6g35tNYBISj5tJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E8E968BEB; Tue, 17 Dec 2024 05:16:48 +0100 (CET)
Date: Tue, 17 Dec 2024 05:16:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/2] block: Optimize blk_mq_submit_bio() for the cache
 hit scenario
Message-ID: <20241217041647.GA15286@lst.de>
References: <20241216201901.2670237-1-bvanassche@acm.org> <20241216201901.2670237-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216201901.2670237-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 16, 2024 at 12:19:00PM -0800, Bart Van Assche wrote:
> Help the CPU branch predictor in case of a cache hit by handling the cache
> hit scenario first.

Numbers, please.

