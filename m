Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08C1527A0
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487133; cv=none; b=koyvJ/vSmBiZZnyPvLGISToH/l0vJ1P6teKLyXiJFqE9YUSGf2lfFqAhEqyJmw0PPXdoYp/+ESdpfbwt+c4qGom3pVjYJkMdGCfdWC1bmkq7+RTCce0DGT1m9t+XpRACBwJY8s3G0AfpnlFl6cxSy83Ak4FKFgEfGNWLZzl9KUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487133; c=relaxed/simple;
	bh=uF5B0kdmO8toyju99TBJ9SGhc3Ndnz96xx3a7bPXzIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmPzcweZjtceG4NXchFbsP0BoduRaOinfce0kgv3tAe/PZAUXUWyBYud/OTeNJ7y6Z2AMgYA49Ww4Ae+RH6x7SrgUfbBMfAlCxySvxE7G0kpfFSPC/a/HlQxZR1XigAKjU0su/YvquaPB3mcghBl6mdRyFOxPS4SIYZ5nd791Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net; spf=pass smtp.mailfrom=poettering.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poettering.net
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id D549DE80F29;
	Tue, 30 Apr 2024 16:25:21 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 306211600A1; Tue, 30 Apr 2024 16:25:21 +0200 (CEST)
Date: Tue, 30 Apr 2024 16:25:20 +0200
From: Lennart Poettering <lennart@poettering.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: add a partscan sysfs attribute
Message-ID: <ZjD_UM34AL2fGkne@gardel-login>
References: <20240429174901.1643909-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429174901.1643909-1-hch@lst.de>

On Mo, 29.04.24 19:48, Christoph Hellwig (hch@lst.de) wrote:

> Hi all,
>
> this series adds a patscan sysfs attribute so that userspace
> (e.g. systemd) can check if partition scanning is enabled for a given
> gendisk.

thanks!

lgtm for our uses!

Lennart

--
Lennart Poettering, Berlin
