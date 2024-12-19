Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077C216E00
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587724; cv=none; b=dc/5ri68KaNM46NRMTl8ol3Lf6935E2O0oigN+STsvcjqj0wNLTN4IOh8DM9Gj/ZDlawwu5q1kDDAseNRKC++XUyxZbGWbFC+tAx1CnJqSW5JxhpIZ78QTqJGQyDkWcksEO0Cfxqi3nFkhMTazemkyi72PVTB7sGG79wQx19oMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587724; c=relaxed/simple;
	bh=vCX7k/9M31zbWJGWfXmYysFPQNy1h8qyCVgEiBpqajE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+ILvUwo5b2Gc2/PbX0t0d1QDZDXik0G/Bu+WP5DdkhTMhsIWKpHv60KPjplsAPFdH47A2pWmIOwAhC4hQLy0DJWaj73qZX3sMIvGrBqCI/BWzE/Ie7LPBzLXam1Y63EDtmIMOs6yCfZWBJK6UKng1kFdW9msHvkxaN0OVZE9Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 016D968AFE; Thu, 19 Dec 2024 06:55:18 +0100 (CET)
Date: Thu, 19 Dec 2024 06:55:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: Zoned storage and BLK_STS_RESOURCE
Message-ID: <20241219055518.GA19133@lst.de>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org> <ed186d84-1652-4446-8da1-df2ed0d21566@kernel.org> <ba8caf98-8b09-4494-add8-31381b04cd33@acm.org> <3bc4b958-73ea-47d4-9b94-299db1f7ee3e@kernel.org> <955aacae-7dde-41a2-8eb9-3bbeae8c3d18@acm.org> <5534fce5-4fe3-4979-bb04-5cbddf613d0d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5534fce5-4fe3-4979-bb04-5cbddf613d0d@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 17, 2024 at 06:56:16AM -0800, Damien Le Moal wrote:
> On 2024/12/16 13:22, Bart Van Assche wrote:
> > On 12/16/24 12:54 PM, Damien Le Moal wrote:
> >> Yes. But I am still confused. Where is the problem ?
> > 
> > Here: 
> > https://lore.kernel.org/linux-block/95ab028e-6cf7-474e-aa33-37ab3bccd078@kernel.org/. 
> > In that message another approach is
> > suggested than what I described in my previous message.
> 
> OK. So you are talking about an issue that potentially can happen *if* you
> modify zone write plugging to issue more than one write at a time per zone. This
> issue of reordering cannot happen today as there is always at most one write per
> zone in-flight.

Let me throw in the reminder that every experiment at forcing order
has failed and I'm still more than just skeptical of Bart's hack.

