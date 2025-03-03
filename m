Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ABF213255
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011284; cv=none; b=sii8OlRivv874gwU96ZiO755UbyigL1rKDBWsHn55eNPhuHFQCObvO63A7KRoUEO9avQl7/jorYc8k50IwZC0th6fjQMs3MSH39saMZYLhZg85oAXpSZxF6HldIRqD4/jmGUemKrtqUdoTRveKLc7nM/hkJ3VD9Oki5Aqzqh8wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011284; c=relaxed/simple;
	bh=3hSADfF3VAb/lbvQd8nKkPYXEqU+lBy3nYYt9FwB09Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rugZ+FRAyyPUwqwKORc+6zkBYui3G8pIiIngJb7QLhUEPAB4CWFSHFcSn1gfr/D0LrBeKktv9pvo7MBfjCCBx+6aeVa4uL0+7t6ojGTy3ViBL844461BQDqnVNMlyISTg5gBU4j1Zp6K/AtxOjJ4Wfok1tauOjHHUv2sTykCtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B4A368CFE; Mon,  3 Mar 2025 15:14:39 +0100 (CET)
Date: Mon, 3 Mar 2025 15:14:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
	hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv5 7/7] block: protect read_ahead_kb using q->limits_lock
Message-ID: <20250303141438.GE16268@lst.de>
References: <20250226124006.1593985-1-nilay@linux.ibm.com> <20250226124006.1593985-8-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124006.1593985-8-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 26, 2025 at 06:10:00PM +0530, Nilay Shroff wrote:
> The bdi->ra_pages could be updated under q->limits_lock because it's
> usually calculated from the queue limits by queue_limits_commit_update.
> So protect reading/writing the sysfs attribute read_ahead_kb using
> q->limits_lock instead of q->sysfs_lock.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

