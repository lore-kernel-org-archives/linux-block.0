Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A319D893;
	Sat, 15 Jun 2024 04:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718426728; cv=none; b=m+3aTxZplbtMrBVK8o0P0fPQahGjF9l49DQefIKceKxnVECL6vWrSdUhVCqU0c0MB/BgYxWn7qMLBgue2t6W9yQvAdUBaIjCnWo12YyaNMfS5wziQw6sFaSEXOnxF0oRHHTJV/idHsi993kysVHMa8gcRPGglYzL95fnR6oV3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718426728; c=relaxed/simple;
	bh=pOAUtE5rhzpplHPWbDDk/GW7LxWvFe11lO88k15jHf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq/+7a5FC0zDs1s4HaQ7cjNelyI1c5lXskUSNcAIQFjwGHBHFnlePcSVey7yBYPys0qC6aVDLDy177iD0tb7WLDJoOaPQnjmT7tQneHYR9YmHwKkooZ1uPegvqNH4+5dylSkDdrlkiqAQgG1RJGHo8oSnl1FedvRdK2VFwQOvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CAC0A68D07; Sat, 15 Jun 2024 06:45:19 +0200 (CEST)
Date: Sat, 15 Jun 2024 06:45:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH V5 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Message-ID: <20240615044519.GA28679@lst.de>
References: <20240615012138.120364-1-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615012138.120364-1-gulam.mohamed@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Umm, so this is back to not just doing autoclear all the time?

What I suggested was to go to my RFC patch that still does the
unconditional autclear, but which sets rundown when there was
just a single opener.  
