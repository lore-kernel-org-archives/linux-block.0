Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5E3F23DB
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200287; cv=none; b=U1OQX/QlkVt2C0q8QED4AqSTaYKvVAJc4ORVRIMysrlnyUomcVhe5eMhUIZlJVpVg+DQnCo6vp/lFUCWJyfaaRjKe8dUCtEOaAMwkTHcsrTSwI0116iSiTFb1TeP0fONJ1uxGWjevoa2IRdMNm9TZTnEJ2FF1ehTpEE14R7uiKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200287; c=relaxed/simple;
	bh=ADBe0gmv0CkJQ5Df2E4/bfvE/p+CFSlWq6S+w3/6D1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNjIz+wglh32ad5nEbiDcahbocpVJGA0exs6F+60kRVdX8KlpMOjwcP3c1TXvkvmEJ8lphZr4E+O8e3kVPnu6RDvufsnYrjqhwvGC+dLZKGQgFtHpOV6IpJ0WjRBkcGAy2vSy73dg9BgO9Ul7WzqcZwo+KNMka1Qa7wzdFfGxp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C5F668B05; Fri, 27 Feb 2026 14:51:22 +0100 (CET)
Date: Fri, 27 Feb 2026 14:51:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: Correct comments on bio_alloc_clone() and
 bio_init_clone()
Message-ID: <20260227135122.GB20573@lst.de>
References: <20260227104438.1646405-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227104438.1646405-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> + * pointed to by @bio_Src->bi_io_vecs.

s/bio_Src/bio_src/

