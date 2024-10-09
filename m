Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167DA84E18;
	Wed,  9 Oct 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459977; cv=none; b=HvcXMv/gOmlCi2Lauirmc+ExbiKKQXFnVk9e4kihe16M2y7dWPlF4JWqbwYLfyHRYSd2yia9okZSLF41QMP0zwYMqI2Hi6Iu5WfEsc138qGJBZP1VYU3GNT/DqKyYxqIq+dJl7HQpo4P7mslJH1FRfsr6u33vt1izGBDRa/uTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459977; c=relaxed/simple;
	bh=0gWpvJtYwJY4aOHobwqk/4eSiQwUbEqirChpc/zBJX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osU07wnB7FJKmhtCEflAvRaVrWScnGc1YM1qcRV16OtRaUQBhLtvLhJO/qgPNWgsDW6VPk/sSaFzl/SDDZ4zvqb8KUTtb9JmHbm3zRfSxhbgpsOw08MW5/1VLhmLwEDMp8AOS65tSTYWKuWvhw6kzaI0jNE822V8R8SOXk/QxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45002227A8E; Wed,  9 Oct 2024 09:46:12 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:46:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
Message-ID: <20241009074611.GB16181@lst.de>
References: <20241008145503.987195-1-m@bjorling.me> <20241008145503.987195-2-m@bjorling.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008145503.987195-2-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 08, 2024 at 04:55:02PM +0200, Matias Bjørling wrote:
> However, the independent namespace data structure
> is mandatory for devices that implement features from the 2.0+
> specification. Therefore, we can check this data structure first. If
> unavailable, retrieve the generic attributes from the NVM command set
> identify namespace data structure.

I'm not a huge fan of this.  For pre-2.0 controllers this means
we'll now send a command that will fail most of them time.  And for
all the cheap low-end consumer device I'm actually worried that they'll
get it wrong and break something.

