Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D44400;
	Tue, 23 Jan 2024 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705987785; cv=none; b=NYcgkRV9ZudFjjdB8TfcMnNds7V4tD0UzhQZAA9v9gRGqrKy/8/CmoMKAx9hgLHvySfjZwmDw1IdGu+KpH+KNaxYsfTDNPOB1PcOfEN3fnmLTLNEej6UTGqSG9jSYztAhOUn7OCZevIU7g32eI0B5qFFGjEJa4sKrpjyEl6UFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705987785; c=relaxed/simple;
	bh=xil21I47/lurocEp3cUAko/kuJg5ucYLbHCkSbYk6Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFMBZbcBwmXtlmwZnDebs6vxmdGVzafcqoDiNM6//YdLgBqFlazVV3xhpe9Z1g1Sw8hyr1cIMnj0h4wWCi7hOhpRUWWcZ87rLQUFur1Biy5e4LdPXgc3jjmquDV1WpY9M715+1yjrPyMQwtHFe1xoYasP2N/3nbn+quhw0z2ccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb8cmKoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb8cmKoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6945C433F1;
	Tue, 23 Jan 2024 05:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987784;
	bh=xil21I47/lurocEp3cUAko/kuJg5ucYLbHCkSbYk6Yk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gb8cmKoertCfontV0aU/nDmqwwjk9ByY1Sa29Q51ruygiYRjIeJg3aqDhhDscDl6z
	 HgGJM7eMrVjLfJ71i8+ICXSCLT02yt/q4RQkenalDfD99+LWU2d4YystKlLDFJGorz
	 Va2L7bLWYmhCrd+/fSCpRvqHiQuaigSfmGo1oTD7PqI3TBAFEU8ZgNt0Yj9c5Ou9F9
	 /x/1ssrCs7l0iD5YD/FsJFPgAwEwuu1XjxVIK/U6O4LGnJRzJSySrsC/mc2iodSDf9
	 jyQEC4Slbpw4q7QTbdVVdxbMO7sjlTHYRe6NOTOvrWenbf8rRniIrUH5WKnn2lPCHY
	 xXQRNC2Y6s9Og==
Message-ID: <6fb840de-401d-4e19-ace0-66fde70610c7@kernel.org>
Date: Tue, 23 Jan 2024 14:29:42 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] loop: pass queue_limits to blk_mq_alloc_disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-15-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Pass the max_hw_sector limit loop sets at initialization time directly to
> blk_mq_alloc_disk instead of updating it right after the allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

