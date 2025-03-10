Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3958226D08
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605090; cv=none; b=gsM92wlXBF+8UihqTO7gdW5Otqxgj6Nqxt4BAtjA+bliFRyCrPo7m3jz8MkcX0N1Ap5n8ArQilcwQokrebZSXNZtSuVLgCvO90EiMeSyFUKvYlnIrt3KNcp8k7p3vL5DMtp/z9dEZKs3V+Rd/oGFSQC9/1FPSOF6oO3SDMDJzds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605090; c=relaxed/simple;
	bh=VuMbVhjry8dlTVOt8jSKVNNt2dN9o2hZZ/9eSKdP+6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDsFEEqWBCkhhkn4NGPByMD+b8+2Hl7bNzzo/DmRcSJvUi9LBXAkdJdcnu4hocq7cbVFfwsb92k7INHTnyzMce7Xt6WMTlBVpgrSIKILfRI7g1StdcouZTAb5Z/KLOkVD3X6zFBC+E7g9WoPXEjo8v1PVC4O17htaCkRj2LvZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lkrCp5hR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lkrCp5hR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VuMbVhjry8dlTVOt8jSKVNNt2dN9o2hZZ/9eSKdP+6U=; b=lkrCp5hRThCVbTThLEv+4FX6EU
	g8RTIDEzkb65c6EY+slHhMMWO++zf9c6PBG+5nZfT4e6ZT0ho2F8jISGCXt2C+/QCOrFw/h2P5nI7
	xMLN92xiF6PbkM/29qjGppLE5WaSjztENetw7CKY1C/6AYAK5DeqsmwTBBR0jrbvWT3aAcCiBF3n8
	oAr7PyD+60PAX0cCV7ToacOtmIVsh/7gNW4HGs0EMDYgbhVLXGyYHDLf2H/hZb5w/C3PL5o0dNs91
	/UAWlXnCquKddZloOiA3TWyB3volq8bdUm+h0Djb3DyU5K79TJtC/U14woLeqTByi9kXCfc3Rgmdl
	fakwYAaw==;
Received: from [80.149.170.9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trb2d-00000002NrU-2HLe;
	Mon, 10 Mar 2025 11:11:28 +0000
Date: Mon, 10 Mar 2025 12:11:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [RESEND PATCH 3/5] loop: add helper loop_queue_work_prep
Message-ID: <Z87I2C-J6YxojQ6h@infradead.org>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
 <20250308162312.1640828-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308162312.1640828-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Mar 09, 2025 at 12:23:07AM +0800, Ming Lei wrote:
> Add helper loop_queue_work_prep() for making loop_queue_rq() more
> readable.

Looking at this and the finaly result I don't really see any advantage
over just moving the code into loop_queue_work.

