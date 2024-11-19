Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C21D0E30
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034260; cv=none; b=K1VYumzMzZ5Icz1w8oh/0DmZUhxzQFZsvOTT3qZfvvDxwH9nhkq3OCETcR+kfWrCbzL3adMhwQpaRwbg40TDtUapyKyOlv08ggXmAeQLUQXZKptxIxSlkAaNxj/wElbGx7yxyIqdRgZWJsOidUAQMirsZ95fkmyhEK6zfXf4+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034260; c=relaxed/simple;
	bh=NP0EZrYQvEDSczSC2xxRj5bGCB1PJSTpRrXjLQlquz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRQvA1ARTt6Hi1QqRvxOGThg2tPbvHS9ceBTj6HosEmrC0MN2ycKrMPcIChqwBPHdbdkDnuY1jRwBcxau6MEwKlEFmf7HajC90VOX0+sckGv2ZS7TyQ0gXBu7g2GnygDZoLSmh+oZyefNwwC0Z+/Ffvx4hTlQSlSSDUt1Y6iZ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4762D68D8D; Tue, 19 Nov 2024 17:37:35 +0100 (CET)
Date: Tue, 19 Nov 2024 17:37:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 4/6] block: return bool from blk_rq_aligned
Message-ID: <20241119163735.GA16417@lst.de>
References: <20241119160932.1327864-1-hch@lst.de> <20241119160932.1327864-5-hch@lst.de> <572ce7e6-b742-40ad-afea-a3ef65c02bed@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572ce7e6-b742-40ad-afea-a3ef65c02bed@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 19, 2024 at 04:34:34PM +0000, John Garry wrote:
> On 19/11/2024 16:09, Christoph Hellwig wrote:
>> blk_rq_aligned returns a boolean condition, don't mascquerade it as int.
>
> I think that the spelling is masquerade. Well according to spellcheck...

Hmm, I thought I had fixed that up because the spellchecker noticed it,
but I guess I fumbled that up.

