Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890A289344
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625781; cv=none; b=s2pVikZj+TSXijPC7+tiRH03yJhMoExnoUMUL3orKH4E7PT4MP95pNd1tS3nVTQPmdYgc+GgcAvYcEtyrsY41hq5dQlWwFojJlmoXJtEsfBBqWKzZSRKnR8JSgrXeaZp44riUj1GfVN+YuezuBmw7TQXlHHprbUAPejdm4Zp+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625781; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lzk1E5wUZx78+uogFu2lZgUx4s/noNtEtuhGcGFguKb4fWHqKmhBnRNHG4JFudBxf5D4LoDWiLH9Lrw3nQym/IpaZTllaBXeb9gg+Zx53RkvfAI1L8ea5Z9AX9cq8uENgNsq30wsFGBGCkFDUbn3HxTo1woheIRFuJGsDd52SHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 792BD68B05; Wed,  7 May 2025 15:49:33 +0200 (CEST)
Date: Wed, 7 May 2025 15:49:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH for-6.16] fs: aio: initialize .ki_write_stream of
 read-write request
Message-ID: <20250507134933.GA32210@lst.de>
References: <20250507133328.3040255-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507133328.3040255-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

