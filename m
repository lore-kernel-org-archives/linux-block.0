Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05057183CDD;
	Wed,  9 Oct 2024 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459842; cv=none; b=csEqf3QGkcVjx8mG0Q1b9g2ZzPTxepcU5cCG1KAnfcoa16n8nEQG6vIs32ChrZM+ValtWK5SO4sMaK7bdbQ/J8RuJhjQuA5S1QwBuoliUw7eeheZvhkLSEkah7neL1E3taM08rjhDZ6BzCTwFHHtw2wjbsEbEAVLM9r27PRYfnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459842; c=relaxed/simple;
	bh=z0mM7iJuPSSVkyxgxz7dUYOvQlNLD9yi/Qpc7RmYsIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+S9bdVB471gHQjE8hYvYqqY50gxCBjP0i92whm/sb+7lZmpnMI8CM8XAHme/yntxZV2+tFyWvVOSD5HBzBezFo9ezV492uncrs+XqkuBcRCc/1FPDmSZf9LXstLQ1IvkZ4gna8U5GtZYX4pAP/mKb6TXNrXi4ZiAuHmOHQsIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 803BC227A8E; Wed,  9 Oct 2024 09:43:56 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:43:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
	Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH 0/2] nvme: add rotational support
Message-ID: <20241009074355.GA16181@lst.de>
References: <20241008145503.987195-1-m@bjorling.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008145503.987195-1-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 08, 2024 at 04:55:01PM +0200, Matias Bjørling wrote:
> From: Matias Bjørling <matias.bjorling@wdc.com>
> 
> Enable support for NVMe devices that identifies as rotational.
> 
> Thanks to Keith, Damien, and Niklas for their feedback on the patchset.

Hmm, the only previous version I've seen was the the RFCs from
Wang Yugui, last seen in August.

What the improvement over that version?  Note that it also came
with basic nvmet support which is kinda nice.
