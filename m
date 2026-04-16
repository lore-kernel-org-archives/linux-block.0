Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595F36604A;
	Thu, 16 Apr 2026 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316735; cv=none; b=WPQi/fahtzNS5cLTvQeMmHHDdYoRWGV6rsaPPUxxfrtJeSCOsvF8D+/pgiAcYOSVjhIK/Y7pSIkees/CznXx5vYhH6NaRfVjuxlFm5jbxCMu1d/iBxUFtIs20fF8YV8HF/+CU/HlQS42Fqbn2M0EFB2K+gltW4G4jGk2yqNMjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316735; c=relaxed/simple;
	bh=GXLuNDlyUwDSTttdvYziVCCk92uHcjuYyw1lxByPbiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgRl1cpT8jIAgoWqu3ekU46kf1I8Y24iqXEJhbxiVUjQfX51XnhTZ9rBhUx1cqWs9b51JYKWuMqsCVvdl+ODQbQHHsbspNCl7srO6cV+Vw6/JxUNfW/2qCYDA2BZNkqKpR7M10imADi2Xp/4HrLfDOAxH+nAHVvFxqe7QBT1P80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QVnHStS9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QVnHStS9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XU1X8pEsRJyoL1+OtoUYSm389j5smImoC1MKC6pLOx4=; b=QVnHStS90hFzYNhjFGALlLO1Bq
	R+HJoB+8AnzKOuvek18Pt9AkMOpwfOWFP0c4d/fKrkfovmAyhf5OzRoppZKWQkY2YX1NSXi6LiFgd
	LminbaUZMzvUjCIING2fmdSOja5v8GM+9RK9lQEthDQfd5UbOG3D/s8ItDJ5txjCLsqfOF64ClaZB
	eqmWIGVFFf7F6yyQA2GbsnYvhE+75Zvos50Ih2/ZDsusLZZ7YDJdMeN/yKRX8LGI0EI8YmjOSaC+o
	YKKM51nSo8Benp71N2hQAhGFBh3i/SV4brSZFYJj84dRFm12/35lfvj6vra5f8vuM2mJwwB2AzLeC
	dxuMrPgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDF7p-00000001zGY-475X;
	Thu, 16 Apr 2026 05:18:50 +0000
Date: Wed, 15 Apr 2026 22:18:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH v2] t10-pi: reduce ref tag code duplication
Message-ID: <aeBxOVmQ2bLli78f@infradead.org>
References: <20260415210847.1730016-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415210847.1730016-1-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 15, 2026 at 03:08:47PM -0600, Caleb Sander Mateos wrote:
>  #ifndef _LINUX_T10_PI_H
>  #define _LINUX_T10_PI_H
>  
>  #include <linux/types.h>
>  #include <linux/blk-mq.h>
> +#include <linux/wordpart.h>

We must have already gotten this implicitly given that the code
already uses lower_48_bits.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
