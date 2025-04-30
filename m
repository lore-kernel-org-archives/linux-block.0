Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F611448E3
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022737; cv=none; b=XtH8tpfyqSZT9mzs2GcimUz7ZO+sE7r9+hMyI5IKA7ZoCFTy7lqA6u5831ASHnrC1XuVa9nCYlGL9kFt6fiYppYeBWsBAuh96a3Ip+z1G42mKZZZncninuYwgoRF1ILlneyVU1Y2IUpq3f/2aXh2FU24CT177D7WBup7DVdWNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022737; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udkRwPn1wUMVvtW0UDdBeAw4UeW5P36IY9hCX1s+SK4Bx8JE1lqOf+2HFDE71bMxwxTlbnFvmeWGEW8JCQl8z3+5jzQ+fHfCK/ktPUYB3INVYMLYR8+6KuxhwCcf04OENO2ULWQ7dGseWHAmySi0KFLW7qSfak8KXeNDMDesk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9DEFD68CFE; Wed, 30 Apr 2025 16:18:52 +0200 (CEST)
Date: Wed, 30 Apr 2025 16:18:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 17/24] block: remove elevator queue's type check in
 elv_attr_show/store()
Message-ID: <20250430141852.GG6702@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com> <20250430043529.1950194-18-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430043529.1950194-18-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
