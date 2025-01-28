Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838B768FC
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 05:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738043174; cv=none; b=I1uxTw+v1dqgYA+gYa+xCPiMXFhziioFl3M894PKSPtOdaaCNAlI5Y/4axdkutses9FCMXQSC8xbb52XBPnrgNY1N7EgKmawrDqDQB7JWMHRrsZ0xcJl9haHPATP/Aq4JUIo8HI1lIEsUl7Rm6u4mTVjPfhXybU+VFMpXkF6Iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738043174; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oj5Y9garVhDjDtPd+Q7II57ItylA/zfobeLVTyBshU7X2N+PVEpRZ0J7kIhtEFz68z5X33DrJwhaIwJKLNE/CocCyueWPMAk8oes7Rxca8B8kFj6dCDuAz8U8i4UjB+eX0KHoprmS0IP2u8uKtvOYsHRieY1CgUd5ZRH0UVjvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA63768D05; Tue, 28 Jan 2025 06:46:06 +0100 (CET)
Date: Tue, 28 Jan 2025 06:46:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [RFC PATCHv2 1/2] block: get rid of request queue
 ->sysfs_dir_lock
Message-ID: <20250128054606.GA19976@lst.de>
References: <20250123174124.24554-1-nilay@linux.ibm.com> <20250123174124.24554-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123174124.24554-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

