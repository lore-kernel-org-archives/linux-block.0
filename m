Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676D1F09B3
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670935; cv=none; b=ktyhiimyHCz9VwVBh8AAXQyjZ+6sqmoUsan4cCbvTDS/UBlNkxSVXYsT1vqLUc3TgnwHVr9ks4Ke6YzJNCpff+FUPW0iNtgb4ep/PpNvUyx5vIJ0oeYJTEEwSuVpFYxuZIc63LJau8ZEN7jTu4VJT9zPQILFbLJ15tkgry4YYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670935; c=relaxed/simple;
	bh=wNwfZkthuRMPNbOZKFlk10p6MBTua0jJPrBJpjbCgCc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=FicXoZePtMhhP06XGAE5GmeUwtNCnhw1uboaiofGU8lW//CQuB9l4B63wF3+1fJw6ndoLIdbGHNzxzbrMLEujw3SprBfSSmcsn2L+KJR+G6cBF0aEE/Syq8ouRJtDDxuJ2Fl7GASwMbSai8KTM2qrZZC4QmupwN4PbiHMtr+PZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=KPVQKLdD; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="KPVQKLdD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=VSC4VLuuqrdFvSXDA+rlUN6veLmxqQV+QLrJEvwX08Q=; b=KPVQKLdDPsClMuuVGMBe8LXrmh
	G53AnrgF1N0xpZMb7vXcrT8nZVluJTX4rQ/LRLftfz5UKOqEdL0GBeeuDsTy7tgCFVRzFNyCRXKEO
	nJvfOePPPlZU55A4uKaElhDrKoGWcpUAE4Fci4V8SiT7YJRF/6BrsEbiQ9q52347jWGSmvw76nv2h
	MWc7nuD8tRw3MGjeXYz6bhcEqV2sufkKd3YyLExMkLwVSQu3QMWc1zxSouXITaPWKcCAIe8NvsNOG
	BV/QDRryc6YZ1FDJ4iYDhF/XFyyEc5ymlChDCt/ezgz/wm0P4Q9QN+4fOnQ78+RgxgHcYDAR/9tG7
	vhbWMdIA==;
Received: from d172-219-145-75.abhsia.telus.net ([172.219.145.75] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1uPRKo-007k41-1S;
	Wed, 11 Jun 2025 13:42:05 -0600
Message-ID: <88fe6154-6086-409d-a180-665d62d72d47@deltatee.com>
Date: Wed, 11 Jun 2025 13:41:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de> <aEhROl2D89kFX8C7@kbusch-mbp>
 <20250611034316.GA2869@lst.de> <aEmuG1dUDGuci7VW@kbusch-mbp>
 <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com>
 <aEmxn0K6m34HsZeN@kbusch-mbp>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aEmxn0K6m34HsZeN@kbusch-mbp>
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



On 2025-06-11 10:41, Keith Busch wrote:
> On Wed, Jun 11, 2025 at 10:39:17AM -0600, Logan Gunthorpe wrote:
>> On 2025-06-11 10:26, Keith Busch wrote:
>> That is all correct. In order to use P2P on a switch, with the IOMMU
>> enabled, it is currently required to disable ACS for the devices in
>> question. This is done with the command line parameter disable_acs_redir
>> or config_acs.
> 
> Is there some other mechansim that ensures a host memory mapped IOVA
> doesn't collide with a PCI bus address then?

Yes, in the absence of a switch with ACS protection this can be a problem.

I haven't looked at this in a long time, but the iommu drivers reserve
regions where the PCI addresses are valid so no iova will be allocated
with a similar bus address. After a quick search, I believe today, this
is handled by iova_reserve_pci_windows().

Logan
