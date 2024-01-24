Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024818641
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089971; cv=none; b=XVTq56GrVHlXl3KRcpahpz0XP5cJ71+51Ji7R/H3fkJrA0p/bZ/A0o05Gife3Sn0UGPp489n1CIaDt74uTnItMxXCAwySS4o/t6yqJlZsHSKzNxGlhMCWaZsJ8i8mV2rB5aNswNqgkdCRj7qeFaQ11erojew2wVcMLFZy7bCbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089971; c=relaxed/simple;
	bh=9T7ucpBbFF4EtQca8+tPr/q0Tb9hvpUNmutYanQ/5d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ0EeaxEEdFBj2uEDgK6lTZLMMFCjChL2HAVZlg2uHWrNtel5+istezZej5TcG2KYoIJO5z70AKMEPuOymCMT8ZV1nveCdc/h3P+YDwklMNwyyHhlzG86jrIFum1ZXQIW0qZ7kXenypsiw6UVuYhSION7r3fkqAW0yATwOJnq+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC2BF68AFE; Wed, 24 Jan 2024 10:52:45 +0100 (CET)
Date: Wed, 24 Jan 2024 10:52:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: nvme-pci timeout issue
Message-ID: <20240124095245.GA31389@lst.de>
References: <287b9ed9-6eb3-46d0-a6f0-a9d283245b90@nvidia.com> <094bf7ce-b5da-4325-93ab-fef6b76671a6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <094bf7ce-b5da-4325-93ab-fef6b76671a6@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 23, 2024 at 10:19:28PM +0000, Chaitanya Kulkarni wrote:
> Can someone please provide an insight on this behavior so we can merge 
> testcase into blktests? Please note that Shinichiro also observed the 
> same behavior.

Can you provide the test case?

