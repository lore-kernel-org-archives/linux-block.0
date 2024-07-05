Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358A814A619;
	Fri,  5 Jul 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181914; cv=none; b=CZ7R8rvQOB0Tbfz11mz+GuvmTqtnHX59DiRd9osS9rfJHiZU+MttXLK90w9pci9SzhQzRldFLfdHL9hCCP45pMijjZKIfLKgpdxrj0yUwoC8IhssQ94ZQYHsYBpLrR87kAh3TAd6y+7Hz/cNnegbKfDU9EAc7ETuNqkpkdgdSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181914; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpiKYF72RBbzv9c/CepRQfK+zALr2JSRcimXpHhruOLLzeLUR2xXwUxTNr4NcVit2y0oMDkhmKsEBG5+u1+8Z1JAXoc82nJJ48GsqqvCcBb1QjQAPkii5FO7VUxGrAckiWS3IaUPJ0pFJYrDF8KW9KnFxHRBuHX0wRAFQ2eW+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53A9E68BFE; Fri,  5 Jul 2024 14:18:30 +0200 (CEST)
Date: Fri, 5 Jul 2024 14:18:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de,
	kbusch@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 5/5] loop: Don't bother validating blocksize
Message-ID: <20240705121830.GE29559@lst.de>
References: <20240705115127.3417539-1-john.g.garry@oracle.com> <20240705115127.3417539-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705115127.3417539-6-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

