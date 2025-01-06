Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77A136E09;
	Mon,  6 Jan 2025 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177845; cv=none; b=D4dyugLsMav8YBrgNnOQCBpzyBinnYneZa6GXuiW8dHuIV5X8C78jhse5h8+RsDHIHNH7YDfkl2RlmBOF7ZY/MC+MkXweOlOOK6+hfzZRdQPGK2Byg6k4GKVBqDT0XjFSO39PxnaxQv7LRG7nmKD5XbdPkhQr3Y6I5v/UdWiD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177845; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da5ifCsF1yPjtcI6Dcm+Zn3KUkzKmegxXPIC/cUHMafc0Gb5I43QOPDnmIcDcpxH6/E3Eq0eZFSeM14FQTKqa24lpJNy7SOZcs8Z/I/fibNNYEmhKb/8vAhzyWroDmi8PHJzlI9mhYQ3D5FkMRRGKzx22HGKxAaV122zBAY04Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BEDD568C7B; Mon,  6 Jan 2025 16:37:19 +0100 (CET)
Date: Mon, 6 Jan 2025 16:37:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, hch@lst.de,
	mpatocka@redhat.com, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/5] block: Change blk_stack_atomic_writes_limits()
 unit_min check
Message-ID: <20250106153719.GB27864@lst.de>
References: <20250106124119.1318428-1-john.g.garry@oracle.com> <20250106124119.1318428-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106124119.1318428-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

