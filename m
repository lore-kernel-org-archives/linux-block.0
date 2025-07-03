Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C12D3A64;
	Thu,  3 Jul 2025 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533612; cv=none; b=SuH5xhIlqUuTdvvRx1PoV+t906qmE6b9w/vyMCixR6wMGUwsxLsyp3gtWK4eS713EBmYBsEVT5Xjw+GlAS7f/lOTgB9YrPEHPjeJ5oBEJAHyAeSpW0hI2Tvv3agmdn9Ya5pYyRUj1hZd8RmiFbKpa5+j+1dt19Yd/lDJn56i8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533612; c=relaxed/simple;
	bh=nJA4nqGXv0EWh5ojZuseHx0QT9uTGQ0YX/u7wtMxzrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NksMyhz4d7+ZhkdzTU0yeckKUo7Qy9ZbcJn19nC4dnAm2SJRZRkvToqw0Hjf6Paf2ew80fWxniBNVtqqfZnowUlBMKz80hgKGSoV5ZjJDc/O46yZSRGpzhRtoIMm7oGJ31UxkZKYDafh3Jz8UHSIczADTtI6Xkcy8dWHvg0BdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 31E2868B05; Thu,  3 Jul 2025 11:06:47 +0200 (CEST)
Date: Thu, 3 Jul 2025 11:06:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Remove queue freezing from several sysfs
 store callbacks
Message-ID: <20250703090646.GE4757@lst.de>
References: <20250702182430.3764163-1-bvanassche@acm.org> <20250702182430.3764163-2-bvanassche@acm.org> <aGXmJg-ZIuFO9WnP@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGXmJg-ZIuFO9WnP@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 03, 2025 at 10:08:38AM +0800, Ming Lei wrote:
> On Wed, Jul 02, 2025 at 11:24:28AM -0700, Bart Van Assche wrote:
> > Freezing the request queue from inside sysfs store callbacks may cause a
> > deadlock in combination with the dm-multipath driver and the
> > queue_if_no_path option. Additionally, freezing the request queue slows
> > down system boot on systems where sysfs attributes are set synchronously.
> > 
> > Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
> > calls from the store callbacks that do not strictly need these callbacks.
> 
> Please add commit log why freeze isn't needed for these sysfs attributes
> callbacks.

Yes.  I'm rather doubtful about some of them, but waiting for a full
explanation.  The explanation might be easier to deliver by doing one
patch per attribute.

