Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B95D8F0
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661316; cv=none; b=Rddj6Cxs9DQnd5UetdO1YLb3B5W210mYjOXc2mZFkD0UgtUvr0nZsOA6nV7bPdePVHjrIXenR5kVyo1EUwPlMaYqjJwvuPiWwYCMXOdD8lYJk+uz/pD+s0ymi6b3GKpiIENQnNUEjeuih0+V7/Bus4Z8yXE8AWQTHB6Zh61xEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661316; c=relaxed/simple;
	bh=EQVL6mtiNDFLqPuKIgSWuOnvbVGk5OJefxbsS+/tAkA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=KJ6Q5MWONRwZgmy0syVrqjn+8VaXPZdAWt4unzlc5rPPecrCMu4U9JPlGsbZEWc3/w9Un5T04/p+ytPxH420HpmSDuIGbhQKdRXb8Pe0Of1QyLNWGOEEdLq2BBno2b77mxnXg+Io+ON8RNv1nyQYS3GD6c/gs4Yq2rYnpQTBzCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=qA1yO38m; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="qA1yO38m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=d6RRXHeZcPSRBj4idKDgkfQLTnwNHZAN9clsm2b0XBc=; b=qA1yO38mRxRbd4xGT6v0KcmgiE
	yUggBfZsHYzsbbrfDTIdjp9i2563S6AdusD6x6Vz5zhROHeYvKa/oNs9yllM5JQxUUPSxZYfbc371
	bdZKwShl1xQddBJSpC9203LiPiEmJ0or+PrBXAk+vVcZuFWemwkUR7tIwHtX9ANxeM13cYz5dNEpr
	8xVokJx5EA906S9iTmmRqr5vEXLdcV/WIcUqleq7VpXT/NMQijqpI1Zp+HHYV18/DVRljQZWeCAnP
	4VGOZWSFWWu3mZh8uNs/WMunTRBZNRqdHaJE5/nt27nxRgZBV3FNTsImgju1/C7ZCQ4eDuRYVZkGk
	DjgQtyGg==;
Received: from d172-219-145-75.abhsia.telus.net ([172.219.145.75] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1uPOUF-007hgw-2c;
	Wed, 11 Jun 2025 10:39:38 -0600
Message-ID: <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com>
Date: Wed, 11 Jun 2025 10:39:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de> <aEhROl2D89kFX8C7@kbusch-mbp>
 <20250611034316.GA2869@lst.de> <aEmuG1dUDGuci7VW@kbusch-mbp>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aEmuG1dUDGuci7VW@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.219.145.75
X-SA-Exim-Rcpt-To: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, kch@nvidia.com, joshi.k@samsung.com, leon@kernel.org, nj.shetty@samsung.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-06-11 10:26, Keith Busch wrote:
> If I recall correctly, the PCIe ACS features will default redirect
> everything up to the root-complex when you have the IOMMU on. A device
> can set its memory request TLP's Address Type field to have the switch
> direct the transaction directly to a peer device instead, but how does
> the nvme device know how to set the it memory request's AT field?
> There's nothing that says a command's addresses are untranslated IOVAs
> vs translated peer addresses, right?  Lacking some mechanism to specify
> what kind of address the nvme controller is dealing with, wouldn't you
> be forced to map peer addresses with the IOMMU, having P2P transactions
> make a round trip through it only using mapped IOVAs?

That is all correct. In order to use P2P on a switch, with the IOMMU
enabled, it is currently required to disable ACS for the devices in
question. This is done with the command line parameter disable_acs_redir
or config_acs.

Logan

