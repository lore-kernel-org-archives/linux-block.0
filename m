Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0CA15EFB4
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842140; cv=none; b=pE4KcriEkzi8rDKx8L9zVwLOwhx7mKLcDjoMEJk9AoEm+Jb9bdOI1IQw4UQ/K0UqEJuJf/LkQk5ENKVvmEOHtPI9VBE4ASTcTkpaFM7Z9ZAQXwXvVIVDm/CStd1xAG8r8QVwO5uBNS11Cuafg5pRfLvKKgzSnor7YEVHDu2eBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842140; c=relaxed/simple;
	bh=zKCeN1svAYfKXmpP5QCWCwWbylE06deDSOE1rh6xc9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuBsjgts+oBKsb4Eog5MXIVv8KXJC3cS+SFQiDH8GbmA/IyY/5oeaIvLwHeP76ruY8OEjT9IZcJ6Df0ute1xHXPD28IeUo28N4YSUuFm1wwQsYY65YezStfDQ0PJ5HATNMHyeBgO4IO5nW7m2yH+DJTbLIhQ8Ptpcaj7Lg4EgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVlHdsan; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVlHdsan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C2BC2BD10;
	Mon,  1 Jul 2024 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719842139;
	bh=zKCeN1svAYfKXmpP5QCWCwWbylE06deDSOE1rh6xc9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVlHdsan4UwN8cZv+xgM09c5euTJvJnZeIfl+XynzX5k2EbHfXVVxWwhYjp+SP66G
	 UvlDflMj5HzhLZHssOZGuDlaB+263YwznQiQBSDKbze4B7n5i13rDALLUQtj4vkwB7
	 qXBgQeKnSVRFjz9XcWd/K/8OLsw6ZL3Yhoa0rXGgaoc65+PW5yEqQPauCtEwS8PYRw
	 mMrp6/LlIBZAUzDP97jQa4ROUNgEExbZs2VXSS4ZYPMf6qJi5PqlniCCPiLZXBURpM
	 OJgT4Qj8Et0vBN8oXJqVO7nujJb/k+DA/jcX5vDTlixqfjSO43kvTl8IRBw6U2ARCZ
	 VC9qjzCk2PD7A==
Date: Mon, 1 Jul 2024 07:55:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: don't set io_opt if NOWS is zero
Message-ID: <ZoK1WRFbr1dK86FK@kbusch-mbp>
References: <20240701051800.1245240-1-hch@lst.de>
 <20240701051800.1245240-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701051800.1245240-4-hch@lst.de>

On Mon, Jul 01, 2024 at 07:17:52AM +0200, Christoph Hellwig wrote:
> NOWS is one of the annoying "0's based values" in NVMe, where 0 means one
> and we thus can't detect if it isn't set.  

We can detect if it is set based on the namespace features flags,
though.

> Thus a NOWS value of 0 means
> that the Namespace Optimal Write Size is a single LBA, which is clearly
> bogus.  Ignore the value in that case and don't propagate an io_opt
> value to the block layer.

Hm, why is that clearly bogus? Optane SSDs were optimized for
single-sector writes.
