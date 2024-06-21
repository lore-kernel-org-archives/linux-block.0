Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3AF5B1E0
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 05:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946876; cv=none; b=ZaZzhFQQF+kW+BdbZyhHFID4N7G7GrWHqnVGPIjbDEkqt+9DYeI8dqMUh4iqSUDVjObKB/SdXP9hi8YjXfzeZkKA6LOM9lWs+5OI3zYyN1GemwvITTFjNjq6n1IbVmU7e/E2T4QNa4dvXoKQUTXaDyIYcXiOieNY+2FVLVRfdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946876; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNOU0Turom2Ap+qQYXxJiuqPtNiON8qDClWMZhJMMobz8FlBngHHnz74leeP1JEpjk8LxZLClB/VDXF90znWk6ZiFZVMw7V+eSHKmiScaTvEAiqKLyU0QXUNVgz0xBYaFSAi+0FDb5iAMTbVk4rXb1TYI2VwMKglcXiv2vzK63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BRPI4FDK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BRPI4FDK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=BRPI4FDKwAiqHlgvwNZch6qrGK
	fTdUidzlC/8/UCnMlMYAGCY8XsngCKXNiE3MUqFgDErPZfsk1z1jqQOU/Ly0COIF7YsyUX25yH1ay
	0gYzuNncZYm7DV9lOsZjQ5UlA0I05n7gNYjdziXw854/0litxo+G0I4Kx8X7aZqqwtMICEMLqlWjn
	CXCM7AqBj2pAeMGL/RoOTttFXZna1VF9mn2uDpwoGeqPZiCHo6wdyYIzhlnUMIt63bU39K4ExaeTk
	jMddfMyUEGVw3Emf8hhGakDsKTzHS8oOpb0aw98TBF+rzlXhXPfugH+NXNmZNh8YS/TdnPMWjxbw9
	4rsd6THA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKWbY-00000007kNW-1Ua3;
	Fri, 21 Jun 2024 05:14:32 +0000
Date: Thu, 20 Jun 2024 22:14:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] null_blk: Do not set disk->nr_zones
Message-ID: <ZnUMOBY6UGRCiBcw@infradead.org>
References: <20240621031506.759397-1-dlemoal@kernel.org>
 <20240621031506.759397-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621031506.759397-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
