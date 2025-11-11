Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A13370FE
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870465; cv=none; b=D4CHn2Shx5qDmTYnRL8g5n4PAqzSioyYgfooqxh9BVeCTIaHWvZfZ7U7DRRzdukH88ehRWGB9DBouvfdBPDZsFvaCkIRH5PN0zT+9YdAhOyE5HHbJgOPC21WV+u8Mro7ev2a5BfMX7qkw69E2+VJIRTdQXIZFRFhiyhPWPDBL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870465; c=relaxed/simple;
	bh=NafSRWZZavkVwKG46SDREt0gTORXk8gX5N5PbEGKvdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEB6iXcyVwna0ZQ/idWv+ooMTVWTlQ1TRpVUH3MVqcp/v5JTZnDBh5NM+famT08DBDYtvDAA5pkWh4DWlmRY5K/E+O+6ujZoFFOu5G84ERkTn/GHrKQPdhgjoTzU312D/Kvb5K2bgsbR/AGy92gJPuSao6PvIrHUP+PBfjYNa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C11F7227AAA; Tue, 11 Nov 2025 15:14:19 +0100 (CET)
Date: Tue, 11 Nov 2025 15:14:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCHv3] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251111141419.GA3378@lst.de>
References: <20251107232358.1324461-1-kbusch@meta.com> <yq1y0ohjk5a.fsf@ca-mkp.ca.oracle.com> <aQ9tuPo7XLEAIc5i@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ9tuPo7XLEAIc5i@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 08, 2025 at 09:20:08AM -0700, Keith Busch wrote:
> > To my knowledge, no SCSI controller can handle PI split across segments
> > and the PI tuples are required to be naturally aligned in memory. SCSI
> > controllers probably can't handle split data segments either since the
> > design constraint is one PI segment per protection interval sized data
> > segment.
> 
> There are not many nvme controllers that can handle split pi segments
> either. Anything setting ID_CTRL SGLS.MSDS can do it, but it's a rarely
> advertised capability. For everyone else, metadata buffers have a single
> segment limit.
> 
> As for interval data split across segments, that's totally fine for any
> nvme that supports PI formats. That kind of data was mainly what I was
> initially trying to handle here since that's sufficient to reinstate the
> lower dma_alignment limit. It wasn't much more work to support split pi
> though, unlikely as it is to have hardware capable of it.

I guess we'll just need a flag to distinguish the SCSI vs NVMe
(or HBA vs integrated) semantics here.
