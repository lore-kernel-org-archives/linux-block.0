Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD6910F1
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849154; cv=none; b=Y/UYGkyI/4FTK4zZ2jElDXKv3RdbSpItQz9gUlzFLq9AXdkX5TJOhtifpiv1j5KnoiqIV3NLzZgEhh+xvAp03p0mS20czngd5mcLRiyDw3IQGqGptIvqTvyYNWLBB1Jx+3oAvARXTji2ugGLjE/Y1rJewWM36qUuSyZl5aPooic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849154; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0D/rmT25X7U0Ub3qJqOwLagMFHEHZGMQK8qEFZG/An9LgD+oYcRADfbDOpzGnQq0yS+GbcSPWvY4ugAtwZjDjVcqwB2FuRkXlCxH6pkvQxMa8UQttAhdg9VMEyS800B5nnEJibF4EWOVyj0us6HrrdPnc6pA2lKa8oyNhk1WBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7600F227AA8; Tue, 11 Nov 2025 09:19:06 +0100 (CET)
Date: Tue, 11 Nov 2025 09:19:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: add lockdep to queue_limits_commit_update()
Message-ID: <20251111081905.GA9141@lst.de>
References: <20251109074426.6674-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109074426.6674-1-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

