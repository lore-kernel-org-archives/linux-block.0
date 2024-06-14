Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A30146A86;
	Fri, 14 Jun 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383666; cv=none; b=uOOzg6llWEm6ZyWfdT2hrEVFNWS5aDmW2NuJQsIquKfGgX39RAvg+tv3mDEfC6QfXfj2Ac2NKMJnN3foeDqjuJNFAa2aoNDvb56NjMQCRylQyirjJMTa1nUWD82C3ke41krXDVKCfFvv9fbWj1//LLtm14YRimgRw/1/oShASXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383666; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QILnh5E7AnvfEFpYMvIOV9DDQ8seSMJGWqukKeJORs7b4Kg6XDNTDOoPzkJ9h5lDlL7hN4Lfbkwiu6Y0x1yAv+Iaeg4+AnKZTWvg+y5/I+plzV1ShuUP/n9LtGTftHS5wFKM1zCUXo3kKLfsGkjcwU7woRmNdlHM0WZl443S86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D36568AFE; Fri, 14 Jun 2024 18:47:38 +0200 (CEST)
Date: Fri, 14 Jun 2024 18:47:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, paolo.valente@unimore.it, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, jiapeng.chong@linux.alibaba.com,
	hch@lst.de
Subject: Re: [PATCH 2/3] block: Drop locking annotation for limits_lock
Message-ID: <20240614164737.GA20338@lst.de>
References: <20240614090345.655716-1-john.g.garry@oracle.com> <20240614090345.655716-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614090345.655716-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
