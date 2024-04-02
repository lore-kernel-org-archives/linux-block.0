Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A912BEA7
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070293; cv=none; b=NhxjOGrEhs018K8ybIVJNJ1A4mGxGQP2NhLjk2nrLzylWPTp3u3luZmXsHuOZkLr0lYH48TYFKvDt0+fE8RMOKQ7kWVM65ou06ZlRjKrLSAefWKvO+m71EBrQ1Q/WTCuOddYZJTsjw/jnt4AePhKOwJ1MOYaNJtduSfOMLFVPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070293; c=relaxed/simple;
	bh=OverSyRm45LhoP3RXv5L769EuyForOU1Ym9D1QDYXNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adXFkKZdsVTKPzxqHjV7/05GF/9ItY2pVBclDvdtNG5dZt4g6yJ+ObeX87YjFsoZj03cFqVgfxFDCBUAKErn2QS1607YkkdiGsEuzBH7OVuoAkaZmRg0EBYeir+M9A/R5K32b4fVQLOHWwG4OEWppDxJzF9nstjT68MWr69MuQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 76CA268BFE; Tue,  2 Apr 2024 17:04:46 +0200 (CEST)
Date: Tue, 2 Apr 2024 17:04:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@fb.com, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node
 and print error
Message-ID: <20240402150446.GB1916@lst.de>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Nilay,

can you see if this patch makes a different for your weird controller
with the listed but zero capacity namespaces?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3b0498f320e6b9..ad60cf5581a419 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2089,7 +2089,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (id->ncap == 0) {
 		/* namespace not allocated or attached */
 		info->is_removed = true;
-		ret = -ENODEV;
+		ret = -ENXIO;
 		goto out;
 	}
 	lbaf = nvme_lbaf_index(id->flbas);
