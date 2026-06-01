Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005EE32B10A
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298889; cv=none; b=fUQtM0wPZKGoEiJjJDxtFQ19SE6Nl0LutZ43VULmzBUKWBfdv54WJkYmWwkL3U62buXErYw8yt8S0eqVQxBlEsYlA14wJ2dTpaAD4WizPLkTfoMnfsO9v7MjuTzGDyiSHSPqDhRj4bjYVWc8C3Whope7xLy0/yiVGQ2FZ1WRupY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298889; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFLUR3kgPzQz0rhaQwZ5TTJxPI6TSLBUVsBPWgnN2RKGVuSkg/XdXeV/NiO2wWx71Rfy9tWqpzqKQ6UjreJQpskupi+PPgXJS4YqnVhfNd2UZaDnqSHvC622QieNcEWJX1rKOgGQtb7u6oqRCawVlv/dd+7LhlWlvhkmXT7qgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 194E668B05; Mon,  1 Jun 2026 09:28:04 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:28:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v5 02/12] block/bdev: Annotate the blk_holder_ops
 callback functions
Message-ID: <20260601072803.GA7799@lst.de>
References: <cover.1779997063.git.bvanassche@acm.org> <b0541615a41fc06f1c0636575db48dd3d7f30e64.1779997063.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0541615a41fc06f1c0636575db48dd3d7f30e64.1779997063.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
