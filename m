Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E121FE451
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756790866; cv=none; b=qIKuFpORUFUb2KhHTnnUzmXiqm7bSwJubJcKlDUZqjSkYaqP3g71DZavGDNnC6jwatpJQuxxl7xZIk1lhy8du/t2lYZbe9zjxWXY2EhqaVeG1HFR6pVylILyoIm+JDywqwGi2MQilW08mYdEMPr5fZVeivrqqT6V1oDybsnC5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756790866; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIXbL73Q1VnzmBAFZTwZWLTVuvMhi7wbOUSiO9CXMqNSh5L16xxmYQkz7jeaEyETlh9028On/4aTogcWTpeDDvece4rRkEoA+ZUZ30r+TVEJk4Z5gXaOguLH+zJNg0qtTtoGuMzF1bDCzHJRjclhkLSUj2abKCcZdHxODZZ9WGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C33EC68AA6; Tue,  2 Sep 2025 07:27:41 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:27:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, martin.petersen@oracle.com, jgg@nvidia.com,
	leon@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] blk-integrity: enable p2p source and destination
Message-ID: <20250902052741.GA11204@lst.de>
References: <20250829142307.3769873-1-kbusch@meta.com> <20250829142307.3769873-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829142307.3769873-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

