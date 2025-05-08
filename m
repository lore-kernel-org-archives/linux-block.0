Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9462F210F59
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680694; cv=none; b=A/+5w8DDlMuvdqFZnHHVZZI9wPI+KQSTXTcvLLChdzRvHVt38SW5qIQtY/9qqviRq3v6xzXrrtHZvcVLM1Hj6yjE+MsAvo6eHDjyp+Ks1mg5jq08R6ef6AdrO0mbERL9yIeHkx+nsp/s8g0Pi9JZxbPUcDFGdflqBiekUgP4Dxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680694; c=relaxed/simple;
	bh=6uE7cfEGzP5vqlKRawPL3McOmXUmzX/Ry/Zc9/gEH+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxKOy3PgNsmOscEDpx/t18ib5GLcivDIf6/YVOwyN73q1+se4AR+JM4mMZnEUafNjUnN8LNzMytzrew3D19cU939gsWWGP/W567Vsu19uGlaKr9vc18a79yUZB8HrZHfoJiomsGtUPlb/7xUiQPTd1GW/4ljw6A2hikELYUe7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBCDF68B05; Thu,  8 May 2025 07:04:48 +0200 (CEST)
Date: Thu, 8 May 2025 07:04:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 2/2] block: avoid unnecessary queue freeze in
 elevator_set_none()
Message-ID: <20250508050448.GB27049@lst.de>
References: <20250507120406.3028670-1-ming.lei@redhat.com> <20250507120406.3028670-3-ming.lei@redhat.com> <20250507135450.GB1019@lst.de> <aBwrlQuvlBVPGb5Y@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBwrlQuvlBVPGb5Y@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 08, 2025 at 11:57:09AM +0800, Ming Lei wrote:
> Not sure if I get your point, do you want to avoid freeze queue for the case
> of disk owning the queue? I think it can't be done, because someone may
> still open the bdev and submit IO to it even though del_gendisk() is
> in-progress.

Isn't the disk marked dead at this point and there should be no
pending I/O submissions?

