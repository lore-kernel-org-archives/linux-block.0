Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F14DF71
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177579; cv=none; b=FcUPKIhcrqtw5YGjDAUPXIbfMKI2PYa9zzDLEHEfc5VkN9d1k/Jy7+CvdauNihQUGfhMJb7hKgqIR08XKh5X05oTx0b/olf3uwBLzCzj6TuV3bN4Q79P+W0i8i8L47eas6vux3agpILTZjotZFRXGTUR1McgJqfGzSS19B6Eq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177579; c=relaxed/simple;
	bh=EPHLckuLqptyx8t7JdBANyT5wzd762/Yu5w6oOuQwXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2m+byxryUfSOtwkv8v5xdRJZmTjY2CwNL1/u435ZQ1eWafiV2jMIUrLbAoutkCjJ9601W56u9OcmdWekqfg0yMqMLn/VzxzsxNsBgh2+qCygcR27U+8uWvP85mEnkh9aYOvqOVe+oYX2ueWI1zoZuwt8Wxpr6CZYdUDAJ9hf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D5C868C7B; Mon,  6 Jan 2025 16:32:52 +0100 (CET)
Date: Mon, 6 Jan 2025 16:32:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <20250106153252.GA27739@lst.de>
References: <20250106142439.216598-1-dlemoal@kernel.org> <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk> <20250106152118.GB27324@lst.de> <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 06, 2025 at 08:24:06AM -0700, Jens Axboe wrote:
> A lot more code where?

Very good and relevant question.  Some random new repo that no one knows
about?  Not very helpful.  xfstests itself?  Maybe, but that would just
means other users have to fork it.

> Not in the kernel. And now we're stuck with a new
> driver for a relatively niche use case. Seems like a bad tradeoff to me.

Seriously, if you can't Damien and me to maintain a little driver
using completely standard interfaces without any magic you'll have
different problems keepign the block layer alive :)

