Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93B1B0108
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735610; cv=none; b=aiGeJHCdZelV0wRzwkjKFUx5PG30m45+NCUlEQMMl+7qua/9Svlc7NKayknJtNxDRk3W9o7UFyZkqdRxBDXVAgfZQjCJy1QYUErfq1awfNn4oQ32ih6uja2SHJhrD4ZEr28s5T8ZYiBfZdbyzRe/nKw4a0CAvTduD1jiMaAKzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735610; c=relaxed/simple;
	bh=Freq+YgyvIbFM6KR3xdMiTKBmoCxp6tDy+VannDuPVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvlo4vQw0nBrYNOcNMgTxIGwzGaL1SXkyA/HfVblqflpVuLdq+0CIAjk4/qvSikQBuspsrhCTnN59F0FwpiF6Uh8SUkMHjRkRgzqK1KpQs3qOtIL+CZ70cE79tPjFrhjGncQJ95/fT2iTaxj2uxDnqfQN19aqrRHmD5xRDhDe3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E3067227AA8; Thu, 15 Aug 2024 17:26:38 +0200 (CEST)
Date: Thu, 15 Aug 2024 17:26:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	kbusch@kernel.org
Subject: Re: [PATCH 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
Message-ID: <20240815152638.GA17618@lst.de>
References: <20240815082755.105242-1-john.g.garry@oracle.com> <20240815082755.105242-2-john.g.garry@oracle.com> <20240815124047.GA7803@lst.de> <3275afad-cb94-4c8e-b70f-3a7e8bacd89b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3275afad-cb94-4c8e-b70f-3a7e8bacd89b@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 15, 2024 at 02:29:46PM +0100, John Garry wrote:
> On 15/08/2024 13:40, Christoph Hellwig wrote:
>> On Thu, Aug 15, 2024 at 08:27:54AM +0000, John Garry wrote:
>>> +/*
>>> + * Pass bio_write_zeroes_limit() return value in @limit, as the return
>>> + * value may change after a REQ_OP_WRITE_ZEROES is issued.
>>> + */
>> I don't think that really helps all that much to explain the issue,
>> which is about SCSI not having an ahead of time flag that reliably
>> works for write same support, which makes it clear the limit to 0 on
>> the first I/O completion.  Maybe you can actually spell this out?
>
> Please just tell me what you would like to see, and I will copy verbatim.

Probably just what I just wrote.  Unless Martin can come up with
better language.

