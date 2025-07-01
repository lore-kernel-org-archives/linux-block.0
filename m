Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D48469D;
	Tue,  1 Jul 2025 00:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751330573; cv=none; b=RIm2eykxbOkLqg9UXebz2zGE6StX3S31V0sOmuZNXv9c1Sr1XU/+zdzRAnJhTO7T1+Pec7afB4W3UxTiqTiX9aoph+kTEGOCVzs6+DqpwoXwW/UhuEXI04ZB3/HaZYJ/7UotaAHjtT1/hSiE9vf/8i3W3I6jiXeKLD9zHOQqJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751330573; c=relaxed/simple;
	bh=/lTqpiarDzs+etj+BWmU9oj+8JmdjMYiF15/FKEz5us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvhWn57NX3kdC7i9n88gFRjay22XYU7dBx9iN4Ke3NO9+UaR//xkGZ/TkfoCrFGQ7Nw6rMDKrIAat2c0pO2ljYSKICTGsJuzqjbORsnU7afGZUqtOqZrwXL9Kq+VQITOyX8VuUvxgOTFhleUfXHgtCaLPNxY5uP9Lg7b3DIPnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXqlUlQG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXqlUlQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D0FC4CEE3;
	Tue,  1 Jul 2025 00:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751330573;
	bh=/lTqpiarDzs+etj+BWmU9oj+8JmdjMYiF15/FKEz5us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXqlUlQGkuMU3IRNtIJeLP1Nd/UZHOPyHTXFcyP6hcXrEVbiGWQ0EAeOye+dMFWAZ
	 UFV6O8F5Ql5pMgVDGgCaTKpSmU3CKyRUPDpxgNAKpTqhE9hZ0usl59qyrWcOyXPgeX
	 80zYopIvvUQFyLhJj44ES1FOzNAKJh21EyX/ny66AV0qrfYgbhi9VKCul0wBvZ4zx+
	 Muxr/Ne+XKFjWoiY5ou8K/oh5UNZvm8luCuGxHrWAYZb3tewZPzgWfm7bvHgl0T9NB
	 Wv6QhUfNn61JgouqTOHzptUKStys0F+kwVUaxQr+ODpdTUxfe7gFXk8X6jvljXsNcv
	 Wy00dCmXauj/g==
Date: Mon, 30 Jun 2025 18:42:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix a deadlock related to modifying the
 readahead attribute
Message-ID: <aGMvCXklxJ_rlZOM@kbusch-mbp>
References: <20250626203713.2258558-1-bvanassche@acm.org>
 <20250627071702.GA992@lst.de>
 <d03ccb5c-f44c-40e7-9964-2e9ec67bb96f@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03ccb5c-f44c-40e7-9964-2e9ec67bb96f@acm.org>

On Mon, Jun 30, 2025 at 03:39:18PM -0700, Bart Van Assche wrote:
> On 6/27/25 12:17 AM, Christoph Hellwig wrote:
> > Well, if there are queued never completed bios the freeze will obviously
> > fail.  I don't see how this freeze is special vs other freezes or other
> > attributes that freeze.
> 
> Hi Christoph,
> 
> Do you perhaps want me to remove the freeze/unfreeze calls from all
> sysfs store callbacks from which it is safe to remove these callbacks?

But don't the remaining attributes that are not safe remain susceptible
to this deadlock?
