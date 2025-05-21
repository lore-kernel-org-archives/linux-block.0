Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48E22FAC3
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747807373; cv=none; b=KTW3KcBCByBF/ogiLHykFXVpLMhb94URsW4t7G4rCQoCl3TAvG2BWbpWM9NJjRCXwIMVD4gwbHQuiQw+hgV8Y+Qwmo4Rn31S8hnC2eELtA0zMh++6u20TptrdOIsV2GAgcamHJNNC7XeRsHHG+xDJOK96wbuv0Yq+lfDmXHzGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747807373; c=relaxed/simple;
	bh=J3oSzq8CTlly4lZ+RDtL9dsdLKOXPvE5D6sJV8oA7pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCDPTKAabh/SlQrFwnAVKy+g4uSDpXjSrQXoF406KBBCsK/kwScXRoYxnKMeEkLoUJRPbBrtVhTxFx8opeqZjiPM+eRh0A1C1bwuyRAwMV5sA3GUb110ZFdsSgiWASV+tH+sJu4AMbYcKWVAQBZ4y2oh/Hik9ubcKPRO8QQAuGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D71468D31; Wed, 21 May 2025 08:02:46 +0200 (CEST)
Date: Wed, 21 May 2025 08:02:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 3/3] blk-zoned: Do not lock zwplug->lock recursively
Message-ID: <20250521060245.GD3109@lst.de>
References: <20250521000626.1314859-1-bvanassche@acm.org> <20250521000626.1314859-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521000626.1314859-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 20, 2025 at 05:06:26PM -0700, Bart Van Assche wrote:
> If zoned block devices are stacked and if a lower driver reports an I/O
> error, this triggers nested locking of spinlocks. Rework the zoned block
> device code such that this doesn't happen anymore. This patch fixes the
> following kernel warning:

Please explain the issue instead of just dumping lockdep output that
needs a fair amount of effort to decipher.  From a quick looks this
seems to be about the problem that the BIO_ZONE_WRITE_PLUGGING is
interpreted by the lower layer while it is owned by the upper layer,
which we've discussed just yesterday.

We need to fix that instead of working around it.

Also please help creating a reproducer using null_blk or scsi_debug
so that we can verify the fixes and have a reproducer in blktests to
avoid reintroducing issues here.
