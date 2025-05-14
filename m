Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FAB1E480
	for <linux-block@vger.kernel.org>; Wed, 14 May 2025 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747200596; cv=none; b=oz6A+KtY2eiWx7Y3dFg5slf7a/h3VfLyvTUdjVUDQOP5RpaxjxqyTO9XxxQ8wjd6iB6PFADjMMeMZMq+tVK86bydiJ95auRSXTPSRpCtFvC9wGQjXrzndkTVxBkwaBTkV1Ksvp80PiU1Gxw25bwBh0AFi1UN9mklJWR9si277bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747200596; c=relaxed/simple;
	bh=cXnpRVR9dvHB9+qUx8UmYcKg19kVgscCsfkzCa09lME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FI4fxmHpwuW/Mty4cuaizkaxMuxzOFkHi1MLljGL4IFEZa5a4DH5CAY7fmZfPcmMJsowlTKh/Gp981/jzNI1mi8dFSPoGV5Oe4xSdJQv/9PwtbzuL8F5B3A0ZkpfkSF7m/QL6UmpiJ7WJ3LUGYBBJlLjjGVGyF7yBdD6WrePvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3E4D68AA6; Wed, 14 May 2025 07:29:43 +0200 (CEST)
Date: Wed, 14 May 2025 07:29:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH] block: Split bios in LBA order
Message-ID: <20250514052943.GA24724@lst.de>
References: <20250512225623.243507-1-bvanassche@acm.org> <20250513064434.GA1199@lst.de> <9e9164e6-b0d9-4940-9fa8-340f06d9d77b@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9164e6-b0d9-4940-9fa8-340f06d9d77b@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 13, 2025 at 01:36:10PM -0700, Bart Van Assche wrote:
> Thanks Christoph and Yu for having taken a look. This much shorter patch
> seems to work too, and this patch shows that the reordering only
> happens if a dm driver is stacked on top of a zoned block device:

This reads like a catch walking over the keyboard with the overly long
lines in your code wrapped my your mailer.

I guess the missing names for the lists also doesn't help, so you'll
have to explain what it actually changes, preferably in the code.

