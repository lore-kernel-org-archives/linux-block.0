Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAB1F4183
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011264; cv=none; b=rCqGckFz3EvvDhxDVNIKDGx5ZN96GPq9ivNEyv4DEzJcxYl9J331QtYT2ngzSlS8s6cra5VKoveW+nP+flVwlVJX2oi16bKUOlxyp86f6CpX5+/hvziIyUqpjqYGpyv48MRjD0Ic6SCTuEx88evJ3iKq4ENFTWQVlrJSowh7rl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011264; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9b2mU/VNjioDZz1yph1PJ0S8olWNk0F0GWCvz+my4JQnrHEbd0hvYjqn9oD54GaIdvfbMgAwHxQ8njF9EDR0xxx5V3o1t+Jl3+Mwdip6bzeBOwhOeSGek9xPj2FO/YTjZBjJv1rAPXOVWoLpS3WGtB6o1A6+UL7zsW0uJxznWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61FD068CFE; Mon,  3 Mar 2025 15:14:19 +0100 (CET)
Date: Mon, 3 Mar 2025 15:14:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
	hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv5 6/7] block: protect wbt_lat_usec using
 q->elevator_lock
Message-ID: <20250303141419.GD16268@lst.de>
References: <20250226124006.1593985-1-nilay@linux.ibm.com> <20250226124006.1593985-7-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124006.1593985-7-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

