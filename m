Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA851418357;
	Mon,  7 Sep 2026 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765006; cv=none; b=DLLMK6JgjzsJHgzY30qbPkkWXlU5WMOPSDli8/bRBlSyVWt80ESk6m4gXpkO2+Dm/PgEeR562evOpOsvlVnGsi0rRNYlB8+pkBJaGrPp26B8wb3zpL3pAAye6fq3oKmM0iUHzbHYn3Ma25Gw3y5S55xnk4qjMGtOiHNpb3XI+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765006; c=relaxed/simple;
	bh=fbF+O/a4bXcRH9CELM9PQhC1Zz4tY16JRDzKoUXprJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kjkq6uOPbLFYnfO2r6hFhMRDptdjq5irEFWtle1yAMP/HJF9NXQBtzw5BuDRkOQ5CeHgE1pMyYDoSqmY2MwKDCpdS4SvirJH2MYgXafkt2frkn52RKchH6YqfxGBB3l4tWeN3LsMiEfS0AeYkDK8DYD8VQuyjObrqdhh3m5cUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 72E7A68BFE; Mon,  7 Sep 2026 09:10:01 +0200 (CEST)
Date: Mon, 7 Sep 2026 09:10:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] block: take i_rwsem for the splice read path
Message-ID: <20260907071000.GB934@lst.de>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu> <20260828-blkdev-fixes-v2-3-32f3f40cebed@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-blkdev-fixes-v2-3-32f3f40cebed@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 28, 2026 at 09:49:52AM -0400, Tal Zussman wrote:
> Splicing from a block device while toggling the block size between 512
> bytes and 64K with BLKBSZSET hits this within seconds on a
> CONFIG_DEBUG_VM kernel:

Can you wire this up to blktests?

The fix looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
