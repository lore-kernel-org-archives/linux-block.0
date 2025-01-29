Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04916EB4C;
	Wed, 29 Jan 2025 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130761; cv=none; b=dqGYLGlPMrj9Y0GWclI2whYuXBuRlb/0VWfMpVquyaRFvHQy6y8XxrGqyfzmKSWw/Ki4Q0TcSLVmpgDoZH8F3xF3scjcunT7VQgEojewmsuizLhvIuiQmuC3arqLZqbnAfIhaxiy76k9jFR7xCoYcbgA17gKAUbJFYrAYOP4o8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130761; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfEqzPb4TWg9WG9qvN5AenHbIgMnzGMBFI5IzIn3n6v2i/rR5GpSNvhAsPQ5sB0NJ9ZbTlwaslqhhyPa8rYlvMxm+Tei8YoH6wQQJmKsOKIdJ+TaoYoTg87Nu/y43GJjJJeGamsfGwgdAb2a68sa8GsJSshqSgObZTDMSndzpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 290E368D13; Wed, 29 Jan 2025 07:05:55 +0100 (CET)
Date: Wed, 29 Jan 2025 07:05:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] nvme-fc: use ctrl state getter
Message-ID: <20250129060554.GB29266@lst.de>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org> <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

