Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E72905
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239443; cv=none; b=D8tqa/OpEXB6PWmROTvb/GRgjFEiMTZ4FDixiBD3PXAVLkd6rkjlDzy6fs2GN6TTFHqFSC83B5/cF4MiTPoNVJh13/CBmYNixo7vHQ/lsOzepyd4Q0VtUdwmMmc+wKmsa+vfYby3xAGrzJg9hkXPyUu/AQr0j/ErnKMtivah078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239443; c=relaxed/simple;
	bh=n4BY39W+znCY9hhzfD2C+9cg/5afLCgo5DX1878kH7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu+GDt64bDR7928jTIcQo8JUqIZ/Vl+2ajTUQccgzu7fatjc32YdFQLc0ZJYeWoCZclpBdAQHrh/jYcQrz2sPnZ01yAFDqPnYJuxjmBZydm9dFcoHK+QlWQ+6GfOGihxq+8Gr8T9ofj61p4SopNabadjRachPuzlfHFV5f4oYiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vULFXVqZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vULFXVqZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cx9AceHZy5wU3gdWoj0AJfXJavcSRE302ZOaVbrHd4A=; b=vULFXVqZIdnZx793ooDxGRm2Sa
	QaBNCcJb8c3q1s0D/TYIWsk6Eq5eM97+AOzxI9Q6ogdHSj0RqKOf3gz/GFkJSmPsIsoCPL6di+dJi
	K7Nr/awLaIHce4dnQEHKHl/85PPF+aVEbrdsDmEr9bp5t/n+aLEVRz5ZBB/D1hkrl7tj63O7MnbUJ
	RQyqPPW+PRCErXQjybOrDec/aHCIbuzuRC3yTrkobD9npLyWoItG2Ap0E4Yw7//A/htbX1evOzru3
	hrjUHKYk78oTLb8DveSxE/KcRGtKsXDIf62zgANQb/FG39YYzIp1msV5ppz8PRbJOc5XOIdU28tSq
	IyiJ35ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6qVC-00000004HuL-2Bsu;
	Mon, 21 Apr 2025 12:43:58 +0000
Date: Mon, 21 Apr 2025 05:43:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, yangerkun@huawei.com,
	yukuai3@huawei.com, ming.lei@redhat.com, tj@kernel.org
Subject: Re: [PATCH V3 4/7] blk-throttle: Introduce flag
 "BIO_TG_BPS_THROTTLED"
Message-ID: <aAY9jhJr1VOh0sMm@infradead.org>
References: <20250418040924.486324-1-wozizhi@huaweicloud.com>
 <20250418040924.486324-5-wozizhi@huaweicloud.com>
 <aAY0GNzcJH28OEtA@infradead.org>
 <818c7a4b-50b7-4933-ae01-e6fbb93417b9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <818c7a4b-50b7-4933-ae01-e6fbb93417b9@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 21, 2025 at 08:22:53PM +0800, Zizhi Wo wrote:
> > 
> > But I also don't understand what "level" even means here.
> > 
> 
> The first "level" refers to the granularity of the tg; this flag needs
> to be cleared when bio moving up to the upper-level tg, for example:
> tg_dispatch_one_bio->throtl_add_bio_tg.
> 
> The second "level" refers to the fact that throttle and rq_qos are not
> on the same layer, so reuse this flag.

So the flag is only set while the bio is queued up in the throttling
lists, and it can't be in rq_qos lists at the same time?

