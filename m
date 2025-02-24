Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23F1632D3
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414688; cv=none; b=kvyegxQ7BVnK+kONWksnlr2OYH1fyO2juq04bkdRlWYHgyZtpc1w8nXJ76R18x2qO17VOmAoMLBtq6QU7ixvrzPjyUH83IZJMW5T4MLLTXFq6mnB8uODRG2CUtNFjF9w/ks0z6x4/bHuKHqK6LRI0xghC2p7rF6xepyMOzCn4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414688; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKCkkj+RXxcHI0A7hD6QoBHTN8p3va/4ssXfGranZ2VibCxAYJECKcw3O9gcbMsxQgJWexqMI8ad92aMV5uYcRtCWX7nDEZKoOMwYeZ9JmPInFnmMEPS+cIGX1e3zz2921YPiK3dkoZcfbxQ66yNrM+G75/5nSJXFtUB5YLC/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 299CA68BFE; Mon, 24 Feb 2025 17:31:22 +0100 (CET)
Date: Mon, 24 Feb 2025 17:31:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv3 2/7] block: move q->sysfs_lock and queue-freeze under
 show/store method
Message-ID: <20250224163121.GA5560@lst.de>
References: <20250224133102.1240146-1-nilay@linux.ibm.com> <20250224133102.1240146-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224133102.1240146-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

