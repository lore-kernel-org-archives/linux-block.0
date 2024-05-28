Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC554276
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878082; cv=none; b=euA2sbcFAh80GlVpQnGzCg4Zv3gWcmn3qKJVeQUv3LXHFUdaE2oh9IckYgPes4WaGjHeTQFOqe4woxYUKGH6zGUNUfnSESa3KbPNh/+RKGU4aoY0RAXB+05dNzcWG4amItrJ//k2f/FV5Gv14uujHvq4wfcdTuvZQNe/ZprNI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878082; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmD7NMcDds+CzA2bcCaamgY0mturhtn33/UZZQTdRbcCmJ220VpOMRcc4rGRGpmjdTxxTKReua+6Qcw20rVIdO7P9D2XSAUXI4URzRD6WOtMqcpcOfQQYNB77YpJINg8jCkldL0SS/F34h1eCDhaFuU8vs7Drgy1yJTqdi727p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47A0068BFE; Tue, 28 May 2024 08:34:34 +0200 (CEST)
Date: Tue, 28 May 2024 08:34:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>,
	Anuj gupta <anuj1072538@gmail.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2 v4] block: change rq_integrity_vec to respect the
 iterator
Message-ID: <20240528063433.GA30133@lst.de>
References: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com> <49d1afaa-f934-6ed2-a678-e0d428c63a65@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49d1afaa-f934-6ed2-a678-e0d428c63a65@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
