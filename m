Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593F19D07B;
	Fri, 11 Oct 2024 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634940; cv=none; b=R7VUUUTQxC7oORLiSIr9+H11qa62qi06vk2mnpg+qgZalDvyObu1kJBpKfFIe6EFvzxHj64rpQvJzk3zRBr+9QSB4n1AWhhg8JyV0E77bazJF/+0hlEqTtXkKfObXsEhPhsKR9xGOPH9ocWIBIYFaauS62ilFVTwua/aNy4JJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634940; c=relaxed/simple;
	bh=SI9XvgsmIkbBdrw/t5Q5qvaZtgY2aCQBTpr/JLnTjKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nehaeryI5ccRHvfEeDNrNPkwuqzz5sLyn4LMEtk9Jjkx8ibY9GjSVmnvu7X5P1wEzCQ9B0uo1lrTHmlzL/ZJNRuoxBbA4C/WVT+kRwe8ZpWtiJlSUEG+L+nAY7Djv9f75sQa3NbF6s7vCzA8RZXWNvQwPwjfrWHC/dllbOeeGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D06D4227AB3; Fri, 11 Oct 2024 10:22:12 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:22:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
	martin.petersen@oracle.com, hare@suse.de
Subject: Re: [PATCH 3/3 v2] nvmet: add rotational support
Message-ID: <20241011082212.GC3337@lst.de>
References: <20241010123951.1226105-1-m@bjorling.me> <20241010123951.1226105-4-m@bjorling.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010123951.1226105-4-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 10, 2024 at 02:39:51PM +0200, Matias Bjørling wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Rotational block devices can be detected in NVMe through the rotational
> attribute in the independent namespace identify data structure.
> 
> Extend nvmet with support for the independent namespace identify data
> structure and expose the rotational support of the backend device.

Most of this patches looks fine, but what it really is, is just an
implementation of the I/O Command Set Independent Identify
Namespace data structure.

NVMe actually requires more for rotational media support (quoting
from section 8.1.23 in the NVMe 2.1 Base Specification):

A controller that supports namespaces that store user data on rotational media
shall:

 a) set the Rotational Media bit to ‘1’ in the NSFEAT field of the I/O
    Command Set Independent Identify Namespace data structure (refer to
    the NVM Command Set Specification) for any namespace that stores data
    on rotational media;
 b) support the Rotational Media Information log page (refer to section
    5.1.12.1.22);
 c) support the Spinup Control feature (refer to section 5.1.25.1.18);
 d) support Endurance Groups (refer to section 3.2.3); and
 e) set the EG Rotational Media bit to ‘1’ in the EGFEAT field in the
    Endurance Group Information log page for each Endurance Group that
    stores data on rotational media.

So we'll need to implement a bit more here.  Most of this should be
pretty trivial stubby code, though.

> Signed-off-by: Keith Busch <kbusch@kernel.org>

This also needs your signoff if you pass it on.

