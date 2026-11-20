Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189690;
	b=vCcZlFDBest6zu+9hYi1DX3NmOvRsWAuBtjppi8jXBlVkvdoEh+D0EWZQYazUg33+GVz
	 +sXGaYyzMkX1rfpxrCWIikNvt6/gvSAvyiYQQRs08MRYPa65KUBnjTn4MzAQbLM9rCy1x
	 YjOcWJD3F82fS3+7fAZZGiBhFBJfRtl+7heqPA5pyAPK8zcWNeidAfmQoEyT+UucgsP35
	 yz0M+GSmQa3SljbhRn88R0elua+2U2l5FfpwGQHNyXPVitg3gkyB6uMIcJrLBFQHnBDvo
	 t2oyI2sidFTwM7GzBDbrueUaf/pobwHfhaQSCqbarYdZGCoGDrVBZv67Lsvu37cDlIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189690;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=O9sgv0Xtuy4Ab3/HyLD7kYrQOtr3uhHOKGiF8EK8M6c=;
	b=ooCRJOXwAD43ZN6LtDUtyq7ihatOQSYDkucZi9g5XwT7k4ysukR01eEivyO6cMSEnx8t
	 4wDzouJ+TTovEgD6fqgTUGFHgxy8+XcYg1gG4OG3sQits3xPF1PdwVTeuhUiXvF7KMaUh
	 7D7T86iBl6rGvNzt3CfP/pYQUq7sPqMb7UQfgb/BLkHwP2MGRo2Y06FCuN08kALmUyIQe
	 nQGwnYWlhD51FtmoFq9zOq38NO4XG+obfPPRGzlK032Vsaxn9WrNELplnBydkvVQkXBCz
	 cULztRay91nSuzJSh6fu5nru6ZLvgcgvqYJGf1Lnx48GR5Jr8n+bfRoOg1a73u4ZWjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B4606A32A
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 15:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 018B4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C25B68AFE; Fri, 20 Nov 2026 16:48:02 +0100 (CET)
Date: Fri, 20 Nov 2026 16:48:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Nilay Shroff <nilay@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] block: rename need_dispatch to
 piecemeal_dispatch in blk-mq sched
Message-ID: <20261120154801.GA29236@lst.de>
References: <20261119071728.3145752-1-kanie@linux.alibaba.com>
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
In-Reply-To: <20261119071728.3145752-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Not sure there's much of a point, but at least this doesn't make
things worse:

Reviewed-by: Christoph Hellwig <hch@lst.de>
