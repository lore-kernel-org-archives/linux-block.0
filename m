Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127081A5B8C
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786688711; cv=none; b=dWl8jV3ePdIIknWf1lraVeaZIPZCw5ZTXNYL4sG949JoUB+2CE22G1PHJZrOMsKti5N/VVFMe90/cYW0i0dSSWOaH1BuqMK0rL2Ya8ri7nR1zT7aA7pfF4REEGhZZbsKs1FjnR7bznaQqWd791/O6gm/qVcJxMhz5wtsDmDTQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786688711; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4+F8zf51guNo1GOAL9VMla783dL3Tn3s/QTgsCACQ5P0uD4wlmaS5LWtSV3OO/1HMUvjyy7DQDWx5nZkH4bn9a0Q6fXzsit1QKlQ1wDa2DuFN/ikZuvuoMOW1OMi70dxqPNv5jOhTbasdX/NETI9iJ/P8y0lUvwxzXU4sERsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1635468B05; Fri, 14 Aug 2026 08:25:05 +0200 (CEST)
Date: Fri, 14 Aug 2026 08:25:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	syzbot+cc0de396bac84da51919@syzkaller.appspotmail.com,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH] loop: Fix recently introduced lock inversion
Message-ID: <20260814062504.GB8819@lst.de>
References: <d919f5285d16afbec6c51ecdf201692a484566e5.1786637565.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d919f5285d16afbec6c51ecdf201692a484566e5.1786637565.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

