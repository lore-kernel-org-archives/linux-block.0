Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C7A3B440F
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904847; cv=none; b=ZzHXvFdRIgH0SjJWhBXj45OvThNkW+6lMu7pUc0Ir0zagFsJ4roOMjlr0p/m6F7TjfN3yRG74Fk9kJx1CH6Fmp771Qs4VKNMcTqb8Gnkvw+uG6vHlyseikPgNbyUTY0pXpmCOQGE2SNEO7bB5DxveZ5ZFEPHt1atNSvp0A47kLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904847; c=relaxed/simple;
	bh=XLX7xUN0STtbaswLUVy039LSW+Xs+KrNDznhT2Gm/LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs6rS7dIBRMX5dwzxCT8YQbcxchgOJCI8vG1DcnPOmrO0LKH2+ri0i+cXOP3e7U50sa/3b6XjhNrFPv3fDWtyZawQQWdlX1XK5p2ichY60VTFd/ezzASPmAFUvx5KysKWnCJdkf2KKOU9BFvj+2KXSSztCSOqN7o/Dm/YAJefb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 58F0568BFE; Wed,  1 Jul 2026 13:20:42 +0200 (CEST)
Date: Wed, 1 Jul 2026 13:20:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] block: avoid potential deadlock on zone
 revalidation failure
Message-ID: <20260701112041.GA16055@lst.de>
References: <20260701082155.1369996-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701082155.1369996-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Still looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

