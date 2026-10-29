Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276867;
	b=H7ZX0Aiq70QRPnXVII+A1yfaU9I5gy0qZQOQcq9/PvTT3+5ZZf77kccS9DLohstk9AKm
	 imLT/w6XBMXeh2vmrHNSi4hKxnU/h8E0CB+Y8kbRXXjLAdRrrB+5Z8wKo2iQCCSq3ZNPp
	 G1xUOFAaaDm3/2g93+hJneuEEtLz+/o5cp+0ovvdtXCgEABZZk1fzaWvD49zt7w+0Re6J
	 Ob1X8XnYxrxoJNNstTHx3rJA4fSdM+lzXsgMzr/UE5LrTZD5ChtE55hH6vBBhlDsdQupC
	 zl/q/CKiCj1z707oKCyCcTbkBoq6YLHe+7MkyWKo47NtXzHPKEaol/bdOVGZloG3ong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276867;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=kE/aup/iAkKSyqA1EGcSzojt0yBgl10lJYtlTnXTIYM=;
	b=Q1+33I6H4cESwI7dEccVKLhLJCSAJyJ4q6iIRAuCf+BCTbo0+L86IjFPdWSKS/11fcBC
	 TmIk14Sj0x1zpFScSbOvwzHOnubBzJie1b1TGNcm0ERM6B60q60nOhAWDLW8Wy3RfPD92
	 WDJgBh3SJrxlKCv4g02sNfI+05ZZpg2fxCbwAMYKkRCa4hf2gVilpia81om7ZRb2T98gL
	 6I8pNNRGay9uhxzBV1NoPADzY4gqWifptFW1D3RkMBv2m/f876Vjz8W9Fk731/vVq9yef
	 jAE1sP8QK5io1C15FeIKLhisD50+idGiUtcla+F7MJYhMDJ1ecr0PVHHFhzIy+dXGNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528E606A31E;
	Thu, 29 Oct 2026 12:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2528E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 00C3E68D07; Thu, 29 Oct 2026 13:27:41 +0100 (CET)
Date: Thu, 29 Oct 2026 13:27:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Kyle Bader <kbader@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Kyle Bader <kbader@ibm.com>, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tushar Gohad <tushar.gohad@intel.com>, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: only fail dma-buf bios that need block layer PI
Message-ID: <20261029122741.GB25162@lst.de>
References: <20261028181412.1919506-1-kbader@redhat.com> <134aa376-7441-46e1-8d04-be327747b4a9@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134aa376-7441-46e1-8d04-be327747b4a9@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 29, 2026 at 11:51:31AM +0000, Pavel Begunkov wrote:
> Thanks, looks good from a quick glance, I'll take another look in
> a bit. It might be nice to somehow support kernel generated PI
> as well later, looks like there will be a good bunch of cases that
> might want to have CPU access.

I don't think the kernel auto-PI makes sense for P2P.  The data lives
on a remote device, so generating PI for it would have to transfer
the data to the host.  Instead we probably should just force PRACT
for that case.  It would make sense to support PI generation for
dmabufs using local memory, though.
