Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B7B40911C
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736366; cv=none; b=hc1eI0s5qbD2FfnW0wOivYepvxP1AZNEiEY1nKeJiWYQ7TODgZj0djzM8SUTiUTkd0RGBdwR6XoI2OFkZkMfNDmaCmkNb0PjYI+LxciPttKQS+qLemsgihnVELdKZSwwioPnzpSqtfqOYCX8HGdXRt6rCChRnOMTDaBKdpfyKss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736366; c=relaxed/simple;
	bh=vNNVWHLkR1H8cS9QqWDG/CAfGv79uaLnFgnlvpayW4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXd28iHsMnmuO7bFwEvI+aOi+kjz+OtZL+KTgX4zjneZ+0Q2tCbmjUPsGN9BdxZ5G9Ns9YFFZ94+0N3PMwzVR+UGKm+RSJEFvjbKNbgjNB12W1TGqs58Ivfz8Yi3sFGwLT3sBHbIpMuxK+APvquk7eJOvR7/EVs8N2nWflElxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5C56E68C4E; Mon, 29 Jun 2026 14:32:43 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:32:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/044: basic block error injection sanity
 test
Message-ID: <20260629123242.GA22317@lst.de>
References: <20260622160808.1552568-1-hch@lst.de> <ajzJiWqsQc2EgR3I@shinmob> <20260625115422.GA18348@lst.de> <aj3_nKfmUFj67jX6@shinmob> <20260626045650.GA8752@lst.de> <aj9KzVlDI29qvLWe@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj9KzVlDI29qvLWe@shinmob>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jun 27, 2026 at 01:06:29PM +0900, Shin'ichiro Kawasaki wrote:
> On Jun 26, 2026 / 06:56, Christoph Hellwig wrote:
> > On Fri, Jun 26, 2026 at 01:31:06PM +0900, Shin'ichiro Kawasaki wrote:
> > > > > Nit: Majority of the blktests test cases have GPL-3.0+. If you do not mind,
> > > > > I suggest GPL-3.0+.
> > > > 
> > > > Well a mix of licenses is obviously bad, although I hate the GPL 3 with
> > > > passion.
> > > 
> > > I see, I respoect author's choice.
> > 
> > Well, if the common bits are GPLv3+ we can't actually legally combine
> > them with test that have a pure GPLv2 license.  So I need at least
> > GPL-2.0+.
> 
> I see... I read back GPLv2 and v3. My understanding is that:
> 
>  - GPL v3 adds additional restrictions on top of v2, such as section 6
>    "Installation information" or section 3 "Legal Rights from Antci-
>    Circumvention Law".
>  - The v3 additions conflict with the GPL v2 section6, that says:
>    "You may not impose any further restrictions on the recepients'
>     excercise of the rights granted here in."

Yeah.

> Thanks. I will list up original authors and contributors of the test cases,
> and then bring up license fix up discussion.

Thanks.  And I'll resend this test case with your fixups.
