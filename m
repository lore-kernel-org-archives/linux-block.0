Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1964CB28
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508991; cv=none; b=Z0aVpsLLF0yUmv/BDC3PP63Y/PU/AD+Xy88pYacvxZPxrwG+TBPo1DULC8PU/CRzv0qppI2FQ+qTO3cNC5RvjXN4iKV8p+E8qXfgai8AKNZyln8g2gM6jDxdVBAa9nmKBH5u5uVLRNdZ2uTBP+QmjW9rDJpChUZ6cOXbEM+72bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508991; c=relaxed/simple;
	bh=OF0sJltC44PyE9cdFwZFEGux4PkfWITdIsqJkeFEOHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbsgOuDHzuGXt9jx/s+yl4nJEE5Cl61piU3tQOS8X4Jse/+Xqt6sfiXC/NsJfkcX9YDaE+DlPe/qDuwFUnMMtOU9wsPvDW7xKoaCsr6OT/TxQrATcHcJKUAEvq3jDR+3G0hMJ2Q8B32lQBMJj0QtcF2FaHv7Rp9cUKL9E1kxbFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBDDC68B05; Mon, 29 Jan 2024 07:16:26 +0100 (CET)
Date: Mon, 29 Jan 2024 07:16:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 02/14] block: refactor disk_update_readahead
Message-ID: <20240129061626.GB19581@lst.de>
References: <20240128165813.3213508-1-hch@lst.de> <20240128165813.3213508-3-hch@lst.de> <df263948-07e0-4aab-a645-ea401d4d413b@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df263948-07e0-4aab-a645-ea401d4d413b@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 28, 2024 at 06:59:31PM -0800, Bart Van Assche wrote:
>> +	/*
>> +	 * For read-ahead of large files to be effective, we need to read ahead
>> +	 * at least twice the optimal I/O size.
>> +	 */
>> +	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
>> +	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
>> +}
>
> Would this be a good opportunity to change (PAGE_SHIFT - 9) into
> PAGE_SECTORS_SHIFT?

If I have to respin for some reason I'll include it.  Otherwise feel
free to send a trivial follow on patch.

