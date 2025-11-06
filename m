Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669B280035
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427003; cv=none; b=ShYC6ndthk7FvZ4Usv89iKF4mU6w/jGlO2DnPgtAIRDYLurHUVg5xWfXkYocflPlTfffcNs/SpRbqhc93MmGUnZuByWup2Cok38jZ9rmvokToHBK6c/SlcaLdT63yh2glcn03wfxhTTSksz7xDGe64EDmah3w2qEvdQCxfVI1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427003; c=relaxed/simple;
	bh=+xzh3DrZalez2EfYpa3Wr7FVx4Qom89QL2q2kENjQ5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b11HoCPQgq9Tqe1dDl9YCZ5aSFGH7usiDL2CyWJkYiUg0+mEp0OTKw4BhietZhgblTnJGGf7+d8TBLR1zr9kuDgQhvJPV1WgrM7ydeSovm+vToFYcuzFGt9oJvdwmAB1A/4uj82DvPFJkTNnf6DPDZXGgJMsGQPIKOjo+PUWiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C80B8227A87; Thu,  6 Nov 2025 12:03:16 +0100 (CET)
Date: Thu, 6 Nov 2025 12:03:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] block: remove blk_zone_wp_offset()
Message-ID: <20251106110316.GB30278@lst.de>
References: <20251106070627.96995-1-dlemoal@kernel.org> <20251106070627.96995-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106070627.96995-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 04:06:26PM +0900, Damien Le Moal wrote:
> The helper function blk_zone_wp_offset() is called from
> disk_zone_wplug_sync_wp_offset(), and again called from
> blk_revalidate_seq_zone() right after the call to
> disk_zone_wplug_sync_wp_offset().
> 
> Change disk_zone_wplug_sync_wp_offset() to return the wp_offset it used
> for updating the target zone write plug to avoid this double call. With
> this change, blk_zone_wp_offset() can be open coded directly in
> disk_zone_wplug_sync_wp_offset(). This open-coding introduces 2 changes:
> handle the BLK_COND_ZONE_ACTIVE case, and return UINT_MAX as the
> wp_offset for a full zone, since the write pointer of full zones is
> invalid.
> 
> For the case where a zone does not have a zone write plug,
> disk_zone_wplug_sync_wp_offset() does nothing and returns 0. This in
> turn leads to blk_revalidate_seq_zone() to immediately return, which is
> exactly what we want (because there is no need to attempt removing a
> zone write plug that does not exist).

I like the use of disk_zone_wplug_sync_wp_offset in
blk_revalidate_seq_zone, but having the switch on the zone conditions
in a separate helper seems nicer than open coding it next to the
write plug handling.

