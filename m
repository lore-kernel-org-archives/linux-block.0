Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793684452;
	b=Ym+hYyCuZKCUn9DtXmFPAxVz+RquFuO2+NiiubvQhY2nAxbGfd0Cxy4W6BKGGKXnTL8o
	 8dWA8syggkQ6bMeLchhGbzrb10pGe1GT31kGPGLFKF2brCiB+/2hoPWuNqmTYekNLg6lE
	 Ddd2L+t0FlQED62t/JzCwNgMnn7jKifB0WcQQfQ/iJUZzuwicLTL8IldCB/lsNLMMn6Au
	 slVApkJO1lFZ9DMq4kieVNJhB6lPQG5qectPt6yk+Q/r5yuKvXS2YfuRJI/MR24P11zrC
	 IJEDBQIHAZ9Z9UWiiARs9uvVYcO3HmsQqUM88lgbBk7SPwnxpTlItUatWE25nhb+4oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793684452;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=AvCUEwQSIreg5CL/vufBjSlcILAywMvegDr8nUmLAR7+1S7bD/Lxwph54ryOJ3vpvb83
	 nY/CPpOlJIcWWCyW9v2WXv0QLBVf57poPKTWKza4Rv1ztiYQNcG0gEw6KdXeC0MhMScMs
	 ItlARtt0Mx8XU7lknK/8JW1OLzTtGKcxj7w5iaGnIdQ6FafT1SfZa0G0QaQKdV5plvCrm
	 hbo/r061Xa7afJDrxnsjqe9+joY7DZ2OmY9fsslykIVaWrlW0m3yuku5rlnSiRrsA1Ixn
	 qF/lu9gMSmeWNg4r2cYTUDl9bVijSS8MIUm3J5aUZUbd0867D5YZAHjeoZ2UoVKgxZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260A606A324;
	Tue,  3 Nov 2026 05:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F260A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6C34268BEB; Tue,  3 Nov 2026 06:40:47 +0100 (CET)
Date: Tue, 3 Nov 2026 06:40:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kyle Bader <kbader@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	Kyle Bader <kbader@ibm.com>, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tushar Gohad <tushar.gohad@intel.com>, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: only fail dma-buf bios that need block layer
 PI
Message-ID: <20261103054047.GA1559@lst.de>
References: <20261029155821.2983229-1-kbader@redhat.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155821.2983229-1-kbader@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

