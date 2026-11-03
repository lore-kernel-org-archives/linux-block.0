Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683845;
	b=1y5MmuevpZMUp/bOtnLNGUTWOMIm4HLRl/GIm6OSPx9i82cqqKstL4BQgwm/fCxP1JMc
	 D6D74mUdT2q16ik0K6VXXztyqMbGilMyQWaEFOx6Ef1S4AEM9rP7Vu6NSkqlV+ctVHaQ8
	 PbRTvwOH4XJEiTEbuumJZ8BXg514Qh8yeXaek1L2NrfiYfQLgBXoPYR9mIxS21l9fn08i
	 WjS9PuwiNkYthfahLpzu03CdtaZ27F4zYjCUBPOZY/rsGYFcddw/eflbZtubVCIwPnmHI
	 jVYBteMb4ZfyqDcgqQr2SR4s9F8xKtQxmvG3eu4zf2N9ySj5CEVwl5XYJqzSQbnkeYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683845;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=d8Zf3GtxbnZx6TOCzMFUuf+hCO4kMZr6n5255bbz/0MiUWj+lDd42u21wsanpmfKddej
	 1p0Aq6Gffb1b0VvKKGok695jai1Z/w87Tcczb02VTVCXt+yJ/SznTwDDnMzl0kWBnFQkW
	 aiGVir/OpYV0ZP6Ev12NELlWM4U8pHQdzlGC1rSJn+uzxDkdn9PbinYNlMozWno4eo7qn
	 A5yCk3xnIeu3POBHNBAeyx0YyVaF+J1XOWlY5Evq3VwoIZ/SpJJdt8KMo5Mnx6vpBbTNM
	 LgMx22rMo5ieDPdHMq+4nP9wTGNXoXR2r+ecOXG6xMeN6Um0UXweKsh8ndOo/FlbUtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE981606A329;
	Tue,  3 Nov 2026 05:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE981606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 77EA368AFE; Tue,  3 Nov 2026 06:30:40 +0100 (CET)
Date: Tue, 3 Nov 2026 06:30:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: dlemoal@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zloop: fix the error code in the blk_mq_alloc_disk
 message
Message-ID: <20261103053040.GB1184@lst.de>
References: <20261031221737569WQ3bg8y80Ht7JdTCWwlkL@zte.com.cn>
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
In-Reply-To: <20261031221737569WQ3bg8y80Ht7JdTCWwlkL@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

