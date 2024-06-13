Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844E4C6B;
	Thu, 13 Jun 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298706; cv=none; b=DWVALZPs2DjC2B2W1QkhTfAAwolAih2IwgVEUyWvxc6q3aBNRtOKtrqbMgueFAMs2hPR16E8qvGVFLUKdhTNTAM0kxZ6cZ029MGjHQ3vIXAtLZC2FG4dzyf3YXvszWYWNpu7BlPxUMsUFqVRlP17VTZvGmyZiMB8mvXV2/GG6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298706; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOIhQlvvfDhvaj8VSajQOCPhBTq7i49glJXkxSMQXAVFZPa4p0KCT/U7jZHiy5h5QWs4TZ/KhVJwj8LAxilGNSDB1LFLAiQiHDOOJ6zPDvSJ2XcJqmnmOBavYlTMfencvOfD96BUTk2M/HvAqpgGnmHwuwCZMeDw5Y81VXvxoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OiUx7Vkz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OiUx7Vkz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OiUx7Vkze1gNFA2Oqpthb42cdX
	gNE1C8VABuJ/4ZXOTq8s1QwWxYN3OrpaLIhpPgKfzHxURqowEkLYol+yq2ASrq1iNFHJ1r0sEalti
	E2HatZORf70bQkh1jTFGXwdw7iU40qzEdxdGIJag1SEcvkgF9fkDM6Q1R9jTQQiYXaTCmLDdBqFXB
	ht5zYVPzkhMHYOOYxWEaca7Kvc6bQ8pV78+B+cOWxyS+/9DtzwmLhVfbNr0YKhBbzgtlc/GrNRDpH
	59E4oiX8VuPUOyR+puu5tikLkcl22pflqYG+GsRKhvHmizQZ69jFpPUQ+y6cnaTmhEG7e7ZQSraju
	Yz+rsHaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHnz8-0000000HTUX-3ZmG;
	Thu, 13 Jun 2024 17:11:38 +0000
Date: Thu, 13 Jun 2024 10:11:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] loop: Disable fallocate() zero and discard if not
 supported
Message-ID: <ZmsoSg74tzJ7SgoF@infradead.org>
References: <20240613163817.22640-1-chrubis@suse.cz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613163817.22640-1-chrubis@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
