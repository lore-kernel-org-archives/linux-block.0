Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361F214205
	for <linux-block@vger.kernel.org>; Fri, 16 May 2025 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374162; cv=none; b=HolxBlQ3nDqfcsSHXdQfHjra8V6A9hA9nUPc3ApwSUxM7yPympdGrNjmdlIcCe5Zjhp7tH40cXcROaUvXboXX5/7kPYc16SJYMaqusIumesSZmGg2w6qmv2ptFqtT4k3I5cVG+ew9wZScq/onRLXGyvAq/EkeBLi8TdiL4SxZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374162; c=relaxed/simple;
	bh=Eo4Y+G+NhLTJwpYETmLc/HNXVYKrqi5K1VncKLuO8ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyijCdlZQvJarvjzWaLSwxzgCvcQVnzTg4N3WF93ROC2Zd+BYSsstLczKF4uShh7CY5LpTuwC+RSyPRroquu/HfAoVUISDdOpAseEjhbFTx0T19XqC0HWECYc/jpl3QfdLzk8rYgc1BVIJoSZ1AYlLX/SyP9e7VJnRvJgspt1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C673F68AA6; Fri, 16 May 2025 07:42:36 +0200 (CEST)
Date: Fri, 16 May 2025 07:42:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: move the DMA mapping code to a separate
 file
Message-ID: <20250516054236.GA13922@lst.de>
References: <20250513071433.836797-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513071433.836797-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Any comments? I was trying to get this out of the way before converting
the metadata mapping to the iterator.

