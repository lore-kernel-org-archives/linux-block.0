Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993834430
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438105; cv=none; b=twqKXA6BqgCn1BTxYLvlNd71cn5OAeCZxg3v/rzdfUHSfEVfBm205eLE7eteTJUftKG8TV5KqZJUk1F29JHVExLerejv2q50I6bluhL6eKg0IuMD0xhospOJUiQwa6qU60Mbc4bJKESFhYc96U5n2z0Je9dgZLYsSWVoWgqWK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438105; c=relaxed/simple;
	bh=ziMFDmcizVw/HKzX4CFbEQ+0h/nCHY1FKPAaX8g6rfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyO+GjKq6YSUj9FtWog64JWJs90ONeRAj6ZF0yP4fftYQunCiFcytt14kKRh+AyLALGHo1rV/kKVc4Dc9zy7+Lyoqr6wqw5BNftIGtPrIgTM8ldUAXdNWp73khtXmzJ5UzEbppWQsGXUcRmvAcUIrtT2OQZt18U2pvW8VJ8djMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5C27368C4E; Tue, 25 Feb 2025 00:01:39 +0100 (CET)
Date: Tue, 25 Feb 2025 00:01:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Subject: Re: loop: take the file system minimum dio alignment into account
 v2
Message-ID: <20250224230139.GA16542@lst.de>
References: <20250131120120.1315125-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131120120.1315125-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

ping?

