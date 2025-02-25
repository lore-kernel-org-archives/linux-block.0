Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3605021ABC2
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496336; cv=none; b=HeWY05lbZwRBIR3ttLFeEw60mRNu/CoFcwgtzWo1JREAzacVyxQ7Dv0oKcIO45uksRrZ2NE84zBn8tT7yUWR/YA2XZqJhG/OjMi47IbBKtwvVGogrpgy3ioE/sOL9ylwW/Aq6u4rbJ3CxUVm7YSbmGFndwPyuuN7uqVd5dvDgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496336; c=relaxed/simple;
	bh=BzmEzmpjpcd7ca9yDcmcC++KHE1IcbwzhKQMsxl8hZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyXCe50d+sB2UsnRwd/VAuEksP8d8xeTbTyI/MPUepWDjORNqXSec6/4UmHiCVylolv1T5cTpxpP8BYwR6ierNgL0tMxozlM3HHFQDeE/JJM/xi9tpE74KlUNPHtutMzntVs6O6skf/LmVVIUiBQZhHZRR09SFFHc7aT1C+Xfqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E245468D05; Tue, 25 Feb 2025 16:12:08 +0100 (CET)
Date: Tue, 25 Feb 2025 16:12:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv4 4/7] block: Introduce a dedicated lock for protecting
 queue elevator updates
Message-ID: <20250225151208.GA6455@lst.de>
References: <20250225133110.1441035-1-nilay@linux.ibm.com> <20250225133110.1441035-5-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225133110.1441035-5-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

This still has the capitalization of the first letter after the block:
prefix in the subject line.

> +	 * Attributes which require some form of locking
> +	 * other than q->sysfs_lock.

Nit: "other than" easily fits on the previous line.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
