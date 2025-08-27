Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC1A3218AB
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281616; cv=none; b=a9hbbeYoMIgbVZh/46plnWvM/ilUDsWiGkgFYWMcXqbEka2oW0zizD2Y7h6hpLVTeNoBguBoVfH2Gr1u8rIIWo8WGyunHX835a2Gmoe9wU4kOwiDpb+CfBUPVv00wTT58epqyG+TJbrHnLr2ccR5e54x+zq2mMve6K8v5c4y7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281616; c=relaxed/simple;
	bh=Db7mAy9lRD9Rz4h3GmTmwEWFePJYNtUU6x7si20Uh98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqfd73iA0ORt+5JlDVdqswVMYSasPeVgjwVcMuijZpFuGjkLcXLIpgMbJc12hUdxIV5OKxUf15Z+zRVMvt8YDUFkZz2NkbQcyXtjChcoPeHAxXRwO13e+h3XeKihhqwlXVEpGESUbmVyTY7QWnRc/f4xscbKTGTbDLPR7bo4vus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2107568AA6; Wed, 27 Aug 2025 10:00:04 +0200 (CEST)
Date: Wed, 27 Aug 2025 10:00:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <20250827080003.GA26652@lst.de>
References: <20250618060045.37593-1-dlemoal@kernel.org> <175078375641.82625.9467584315092336312.b4-ty@kernel.dk> <20250827070705.4iWhHGPE@linutronix.de> <20250827073836.GA25169@lst.de> <20250827075221.6hTi-i7m@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827075221.6hTi-i7m@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 27, 2025 at 09:52:21AM +0200, Sebastian Andrzej Siewior wrote:
> > this for you, you could also reproduce it before by say doing a large
> > direct I/O read.
> 
> On a kernel without that commit in question? Booting Debian's current
> v6.12 and
> |  dd if=vmlinux.o of=/dev/null bs=1G count=1 iflag=direct
> 
> works like a charm. According to strace it does
> | openat(AT_FDCWD, "vmlinux.o", O_RDONLY|O_DIRECT) = 3
> | dup2(3, 0)                              = 0
> | lseek(0, 0, SEEK_CUR)                   = 0
> | read(0, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\1\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 1073741824) = 841980992
> 
> so it should be what you asked for. Asked for 1G, got ~800M.

This is probably splitting thing up into multiple bios because your
output memory is fragmented.  You'd have to do it into hugetlbfs or
vma otherwise backed by very larger folios.

