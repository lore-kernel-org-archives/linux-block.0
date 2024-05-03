Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDAC148313
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724188; cv=none; b=bUkybabqq8qFez4nVFtMLUiAiN/Yt92R0sm1ZHe4C0r2PWKHF/absVozv/U4rtLO24ugDcheT4MtkqSPPfLl0DArDvDgwWR0hhJYW+J3xPXgRyni1XrPqVD86tArCKUvDiHX+nwAy4tD0KjlC4nC3+LkuK3FBvjIrgjp/822YR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724188; c=relaxed/simple;
	bh=yfAhLE9UDrdFj9UrO8Jw4oDVhNPtz2GEcy2TPJdg7uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaD4myIkx7ZVsaBRPFbDeBTYzmUFOGuuczLl1vkzmMT8bgfj5EjLHNP2uR1EWGzh4UHRpGFG4Yh0wfQJ4d3niTQOYhApguiRklXreY+rNK8ZSQizv+CEcg9wcyCesnTXowHv/s/lmeHhIiqybCChZjbMJ/j33Whg5UzRwViXizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 805D9227AAC; Fri,  3 May 2024 10:16:13 +0200 (CEST)
Date: Fri, 3 May 2024 10:16:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: add a partscan sysfs attribute for disks
Message-ID: <20240503081612.GA24407@lst.de>
References: <20240502130033.1958492-1-hch@lst.de> <20240502130033.1958492-3-hch@lst.de> <6e70dd3f-381c-4435-a523-588ce2fafb39@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e70dd3f-381c-4435-a523-588ce2fafb39@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 02, 2024 at 11:05:54AM -0600, Jens Axboe wrote:
> On 5/2/24 7:00 AM, Christoph Hellwig wrote:
> > This attribute reports if partition scanning is enabled for a given disk.
> 
> This should, at least, have a reference to Lennart's posting, and
> honestly a much better commit message as well. There's no reasoning
> given here at all.

I'm not sure I can come up with something much better, feel free to
throw in what you prefer.

> Maybe even a fixes tag and stable notation?

This is definitively not a Fixes as nothing it doesn't actually fix
any code.  It provides a proper interfaces for what was an abuse
of leaking internal bits out.
