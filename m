Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8FE33711E
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432171; cv=none; b=hzXhIVWlLgPtz5WBeea6c/qqEV0HkB+z1sgo4RG+iwWmTZYxnp410zB+7X2vjTsy4xC3CWS8xEgeAVzr69lNbIvTtGvwEM4sJRt5UT3mlI4t3rX3R1G1Z168pNaGunLm8ezTlb4Xifycjx7zNaIlH0uvcsNSe3M4q+b2fqVcGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432171; c=relaxed/simple;
	bh=DC3JdBBPBevJt1kFz1ti+SF84cCqtkMxF2BSlxFMOeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU+BGq5BQRnXbjoEco28uhTIxg5iPk17eXZIyjfIPI+Y3XOBcB4tTW1n1SUQlp5BUse7i78alZ91ulgxQfPZQ+JaqH0UmSJ2hNwWFdCkj7+6/um81XpzeIkE/Mwx1PB9MLgCDLBGipF8YdPfD6ZWtJDTGtu7b5Zjgx2gLoWY5xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F665227AAE; Mon, 26 Jan 2026 13:56:06 +0100 (CET)
Date: Mon, 26 Jan 2026 13:56:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <20260126125606.GC28035@lst.de>
References: <aG7fArgdSWIjXcp9@kbusch-mbp> <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com> <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com> <501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com> <e7873ec2-c447-4eda-9725-80e614c3e210@oracle.com> <eaeaaf10-2e60-4ce1-9a84-42aaff1b7fc5@linux.ibm.com> <4023a0ad-ef60-4307-aca6-514ee790d6c6@linux.ibm.com> <d2ce6a5d-f6e4-441c-957c-fefc33f3758d@oracle.com> <fd73dd79-b314-4514-86b7-74f1862aae1c@linux.ibm.com> <c5ad03b7-b5e3-41ee-977c-f0ef1002bf1c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ad03b7-b5e3-41ee-977c-f0ef1002bf1c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 22, 2026 at 10:16:53AM +0000, John Garry wrote:
>> - Recommending other vendors adopt the same reporting model, and
>> - As it was already proposed earlier, updating the Linux NVMe kernel driver to disregard
>>    atomic write support for devices that report a non-zero AWUPF at the controller level.
>
> Yeah, we can just stop using AWUPF always. Or can further consider my 
> proposed change to allow AWUPF to be used based on an opt-in, below.
>
> Keith, Christoph, Any further thoughts on this?
>
> https://lore.kernel.org/linux-nvme/20250820150220.1923826-1-john.g.garry@oracle.com/

I'd love to drop support for the controller-level AWUPF.

