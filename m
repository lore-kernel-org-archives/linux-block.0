Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1501A257D
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425168; cv=none; b=LNdckLIs/pRgL2UxOnn6GLSzoujumxALkVcYf/UB9xfFMM4syjCe8xsaGTMphJiPq+txGdNnY0mid0vndQgGKfYlxgcU6KJ9PmwDydrzVEcHa33Fm8nSjzkdWuEYi3Af2iX36QLbR012lGO/W47panIweW3Sr7UuoUF7uNnsh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425168; c=relaxed/simple;
	bh=omaMeU+nxe3aZxVYVsf0LhwtItymk1Cm5rvWm0crrbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6REnjg9nbjL/UiaE3/YrXbhL6baNHyhMSdRnjIWW4gArD0vnVqnFSeTQSg6ihnjwj50v6Gv+1oiFVPZlQs8hv9xlGEexs4O9PV3+78j3nGUqZdDj5L7F1hDOSWZweBPe+YbXK9IXkqZCuHNiN5ugaWs8KRoNEYq/2gTa/Vmlow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1l09Yb/L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1l09Yb/L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b0De+QGErYDqOUM6JXItpXsTKPmFLCa73RRe8V3pY50=; b=1l09Yb/Ld0PuWa/dExTOhszcCe
	YAprN/8Wc+belCtSXdz1MKYz+8tC2DX1S71xgHAzNclRXyotrwf9nrn0zRvGvvUk7LJlnhxOkl7QQ
	pXHg2C0asFVUbgfsaPiSpS9vJ8imAqcGd3ggSl451cYPOHvoDlXqK36/9dP3tdNHKzamrnEddbWhK
	WQsLpBoFLN9GVmTQeGQvUwrxFdSeKXBXDZkfTaYVz/78n0VIXnGD4rtAYFh0ozQ2YUmxIsC00L5YU
	nKzcPias3ihWs56xvscouQoWiekFz4RlcfJik+OVakCr22QXNLlcyrvf11SmtfUbssS19NM6y2iW5
	OkildZhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7coo-0000000B6Kt-0TIh;
	Wed, 23 Apr 2025 16:19:26 +0000
Date: Wed, 23 Apr 2025 09:19:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: linux-block <linux-block@vger.kernel.org>, martin.petersen@oracle.com
Subject: Re: Block device's sysfs setting getting lost after suspend-resume
 cycle
Message-ID: <aAkTDtmOQhBP4NBa@infradead.org>
References: <32c5ca62-eeef-5fb5-51f5-80dac4effc98@applied-asynchrony.com>
 <aAiKM0-1JJulHLW7@infradead.org>
 <cceea022-a5e3-97b3-62ed-7ead174565a3@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cceea022-a5e3-97b3-62ed-7ead174565a3@applied-asynchrony.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

So I tried to figure out how this happened, but AFAIK even
the pre atomic limits code (blk_queue_io_opt) always overrode
ra_pages.  So for nvme in particular this either was introduced by

81adb863349157c67ccec871e5ae5574600c50be (HEAD)
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Fri Jun 28 09:53:31 2019 -0700

    nvme: set physical block size and optimal I/O size

which is so old that my current compiler refuses to build that
kernel to verify it, or by the fact that you either upgraded your SSD
or the SSD firmware to set the relevant limit which was added to
nvme only a little before that.

No good fixes tag I guess, but I'll formally send out the patch anyway.

