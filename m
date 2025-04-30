Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6481B5EB5
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022125; cv=none; b=Ws0Q1QylPQ7XS0HpQKdS+l7akswDhaR1ACe+DgrbdhAECHRiHND1nGtTSdnsi1Nmm65oHefBcASKRgbA93gi2aNJoJaTmskbR9MAGTCA88oV4vweAMWhb3kSMGc1C3bt4SN23kdvJCgABdZ5ZoN3ER5GqrENvUoj0ttEpZmNMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022125; c=relaxed/simple;
	bh=NscGTF2n+PAXdZI7d+fbx6tZDzQEQM4JvLFRaEFhqJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxsZp85Run3mRkdvcKpbRleur8sTi0N6dwuoU+QAJPyHm23lDQEmA+UiZeTWs9qhGDgD0XnPW9s2IVeWS0z7ADKtb0hNRxMO1VecSLDTnBwqbygGJY/+vOuUi8USMdTYQ4WrSQ+9DVJ2UVG4j3i7JmH4T8Ly2O0h83h0ejyq3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D4D868CFE; Wed, 30 Apr 2025 16:08:37 +0200 (CEST)
Date: Wed, 30 Apr 2025 16:08:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 00/24] block: unify elevator changing and fix
 lockdep warning
Message-ID: <20250430140837.GA6702@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

What tree is this based on?  it fails to apply to all of block-6.15,
for-6.16/block and Linus' master branch for me.

