Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A56528751F
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132386; cv=none; b=POMlSCSOGTFAHw+xbMygJCzC8KKySnqTZk7Gyb67EFMzznQd3skTV0po0vMwNtNpNf9KdHmTFdiNAsZsTon30iyXLBSlUWoQKlTikvDmIFuCySgFY3EqzjbhVvAQRXsNgrSsczkvwJ9NmK3hBuwUMobu6/QLiPKP/uF3GaI7EN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132386; c=relaxed/simple;
	bh=2sTuvZdNUUmeF/fIhKV/sNYge1hWlPtyQ+sUXHpCMrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivDIkjRnGkL5UhGIf1TfrZJD/PDr5jqhtJH7u4CkAfgHiVGwroPAWcHjkgQz2E/7kpLMvuCzi6ItY/X/lLUMFgODWeamvdRGz6C+LToDFy5aPK7Aj42NvdgdhWcObC3xJ1sgyTR/UWD2fCzRMc4TRIR672aWnxEqzZjd2HzI9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E941768CFE; Thu, 10 Jul 2025 09:17:41 +0200 (CEST)
Date: Thu, 10 Jul 2025 09:17:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <20250710071741.GA5273@lst.de>
References: <20250707141834.GA30198@lst.de> <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com> <aG7fArgdSWIjXcp9@kbusch-mbp> <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 10, 2025 at 10:37:19AM +0530, Nilay Shroff wrote:
> So in this case, it's actually the opposite of what one might assume:
> Users of namespaces with 4KB LBA format would see the best possible atomic write
> performance, while those using 512-byte LBA format may observe sub-optimal 
> performance, since the maximum atomic write size scales down with smaller LBAs.

The problem is that we need to deal with the worst case and not the
best case.  And NVMe royally messed up there.

