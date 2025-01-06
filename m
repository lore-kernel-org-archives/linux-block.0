Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD31DD9A6
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178280; cv=none; b=Iq34zERuV33r9Ygx1S8DdEE+sUj4f6kOoPm+oTpxs4RpGtZFSs+F2S3dO/dePudD5ZtsuUhpemq76KYlgu66zQU3MifYSrxsdLzb5GSli7JCPP0aiRBV9u7Cqst4+icKS8b34gmTUSzUmgzSntdGSshTlH3WplrZMzv2OjvWZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178280; c=relaxed/simple;
	bh=v8Ef+U1R1/5YQnlfM/dblD7MoqV2+VaURZw5Ike1PtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gtb8qYbSMV+zkovpP9F7cnVg564SJp0dH7LQLupfQXJ2aelwtj/2S1YwqMm6VPBmp/RcpB8BuhlVzgffIWNNK/d61fOeJ3pn5+S9U5QnGbU5IHxBswX0C0DOZSg/gO9L+g3nAQYaAJclr6tmLZ08d9QCgHUH2NJOAprxFIHzaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27FF668D05; Mon,  6 Jan 2025 16:44:34 +0100 (CET)
Date: Mon, 6 Jan 2025 16:44:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <20250106154433.GA28074@lst.de>
References: <20250106142439.216598-1-dlemoal@kernel.org> <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk> <20250106152118.GB27324@lst.de> <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk> <20250106153252.GA27739@lst.de> <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 06, 2025 at 08:38:26AM -0700, Jens Axboe wrote:
> On 1/6/25 8:32 AM, Christoph Hellwig wrote:
> > On Mon, Jan 06, 2025 at 08:24:06AM -0700, Jens Axboe wrote:
> >> A lot more code where?
> > 
> > Very good and relevant question.  Some random new repo that no one knows
> > about?  Not very helpful.  xfstests itself?  Maybe, but that would just
> > means other users have to fork it.
> 
> Why would they have to fork it? Just put it in xfstests itself. These
> are very weak reasons, imho.

Because that way other users can't use it.  Damien has already mentioned
some.

And someone would actually have to write that hypothetical thing.

> >> Not in the kernel. And now we're stuck with a new
> >> driver for a relatively niche use case. Seems like a bad tradeoff to me.
> > 
> > Seriously, if you can't Damien and me to maintain a little driver
> > using completely standard interfaces without any magic you'll have
> > different problems keepign the block layer alive :)
> 
> Asking "why do we need this driver, when we can accomplish the same with
> existing stuff"

There is no "existing stuff"

> is a valid question, and I'm a bit puzzled why we can't
> just have a reasonable discussion about this.

I think this is a valid and reasonable discussion.  But maybe we're
just not on the same page.  I don't know anything existing and usable,
maybe I've just not found it?

