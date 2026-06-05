Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB9410D26
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642144; cv=none; b=hrbNCFn2eBhDyTFHQan8lIQekyTneDKGb02DGazeOmDSGNeFX1TG300dougUuM1pw07I2OxuKBMuhDLpSNZ8A5yItnPFrwQ7XSys9kZE31Egzopct0YVR3bQHM8nNEqWuq6FVvBbEXpwbEVH9dfTC3PjF3xGsqv/3mcv4E1NxW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642144; c=relaxed/simple;
	bh=wI5/q9FqBBj1Ai3bZFwhW94Ts7kV0vB73isRL4ezVYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tENPKR8fcerJHpSTvSMnO2TYw4tFwBGJZmCoTesWMG70k3aexiuynx5Nwp5YzEamewO08U5cd66HOhRoNY6JY/7Jb8ysUtL4ntaHPokrUb9uLYvse6KjO6wfNmh5S0rMkCRzDgnYP/cvmD/58AiDJmJsVjmxo7du3Nes9Ay//Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C18B268AFE; Fri,  5 Jun 2026 08:48:58 +0200 (CEST)
Date: Fri, 5 Jun 2026 08:48:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v6 06/14] block/blk-iocost: Combine two error paths in
 ioc_qos_write()
Message-ID: <20260605064858.GA26230@lst.de>
References: <cover.1780419600.git.bvanassche@acm.org> <fe85b8a3117486e3d1fe40b16d7c9621a070499a.1780419600.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe85b8a3117486e3d1fe40b16d7c9621a070499a.1780419600.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Not a huge fan over the missing middle argument ternary operator,
but the logical change otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

