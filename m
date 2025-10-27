Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F512F5B
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 07:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548656; cv=none; b=UtoL5otOQPaGcfC6UnB2DkFkn3eHZjOS+6l/JEw50r/MkEomU8pyWgiwe2r2zcI5WmfnEnNmqiMPI8k6y9G0SP8Ayt8O9DC9mm1foJWQCpaO5tklxu7sDxUL+u3B9cTmuuFtKTlYQxsLfXYXy8fCNLhA6/AH5WBB1zisgLsp7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548656; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2o5MN1mOK47o5VsR0ago1DzOz/Y/QlYY1G9uZj9Rches0T14MrgB8ctB04bqHdBDBbjW6JgOTRLcJryt1awM6R4freLSN6rllYcgv/ZzdDgc9rrnJEdifl+IfS0Y0qcsy5rwTS7xgyHj9TLki7J3AR1xm5zOEeRpS+SBYBmvIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nr60Suev; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nr60Suev"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Nr60Suev729hQEM+gk9QLrT4ln
	AxFjpq6BDdIDaR1OJagbaaYXppLIoYuI5pkIHqo0wtT9a56MISazrcCJ7VObLf0EBwmShqY9oreK5
	utLlefxoAXZdHjV8F9GAG5gvAHzRAFEYzeQAiTm5IGvrMDdLDlBpCmRxJu8R7zbi8YfVHTmBgUejS
	L1qs2uuHvmZWCWVWDFPZw0evhf50mS2CbG/i3Kb/HDxaIPZ/MkuwzYurZXz8krLRis+M6ZMalWNKM
	LvHy9u0Nbf9hgmhw9YSHqzwIwaf7jasOtav9wpEg+QfubSyDoW+JxloYITPc4VI1QqFG8XgM92uHg
	6/CkcPgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHH4-0000000DFUH-0nDu;
	Mon, 27 Oct 2025 07:04:14 +0000
Date: Mon, 27 Oct 2025 00:04:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: make REQ_OP_ZONE_OPEN a write operation
Message-ID: <aP8Zbm493b-9Lmyd@infradead.org>
References: <20251027002733.567121-1-dlemoal@kernel.org>
 <20251027002733.567121-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027002733.567121-3-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

