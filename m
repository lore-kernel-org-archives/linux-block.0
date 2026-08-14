Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E9377AAA;
	Fri, 14 Aug 2026 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689744; cv=none; b=Xbofj1c3GFOtuodYj0YlIqNn4wXPPNmfdOUSvjIQyS6b0UeKFPtIyrCAGB6JvixOZ0srVMTYESa0wBgSf4S3OEU9lvGrUFvwXOpUsEavOkKmAnkh4WR7BKOQU3FT+YkiF6CrtGMVHhmdLlxxvbLF6v8QiSLKKbDcL3vZfpqGeAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689744; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUsObpcAn7/7YQOpvukzfUEESJgpvGDiZSZbtqIchRrPRZx3pGLq1jHlPOqqvgcD6kjQE01Kzh1B+WwQoV8cX3yYEtnfPOlu7c3tpLI2v1pVHgkTlivHaJ/RUEPD6GzItzrvLG9UIWQ7ei8zpbYxX6Mc6VnePZjmVxkMFPgSdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AT7nNbOq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AT7nNbOq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AT7nNbOqpO+4uUmTFP/IFltimk
	qoea6QlKhDliVEXsjrVMkmhxaNOT6y37QJ/73cUpQvlJIVc5ulNrCA/ceaAJEoOaEy6P9BbXJetuY
	9DvvoVd2u9qGjKhPuSfx5EJQyOpwLXa9Z8MtySbpEE/XlTTNLP2uQnYPED4DsVyPmV4YoNzkIXPMH
	y45JZ+gNv67BaisLJ5OVCM16/CzpFAw1rEyDweLoy4iuUHFnQqYtVSrwq+1sr8o1Iu+ccqhKTAzMY
	/aUO/55R1zQ0Hi7/XMnT6bCTmVMGORXVBjRaBZ778LW5BU/28QgU2GDws4okPYRuggArmxnDQILUr
	Uy2l61ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wulcT-000000023IZ-38k4;
	Fri, 14 Aug 2026 06:42:21 +0000
Date: Thu, 13 Aug 2026 23:42:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hongfu Li <hongfu.li@linux.dev>
Cc: axboe@kernel.dk, bvanassche@acm.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hongfu Li <lihongfu@kylinos.cn>
Subject: Re: [PATCH v2] block/mq-deadline: Drop unused dd parameters
Message-ID: <an64zd5fEHPjNm3o@infradead.org>
References: <20260812040729.27551-1-hongfu.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812040729.27551-1-hongfu.li@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

