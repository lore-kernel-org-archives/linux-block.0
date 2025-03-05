Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE51A5BB7;
	Wed,  5 Mar 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198291; cv=none; b=LDycA0KUALhzwcKOMzdXM71xxJ1yaMSBC0ygR/clmb4RtDtq/aS9JqmhbPZI+gtsUekhQprCEW92vwF01C9nlulr5xV96AXNcFaF1ipveIrqeqcMYc1fVGdNuIcV+IpENNMT/VsdCvtS98fnA2tXqQmWpR1U/iFn/gbQD0SOQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198291; c=relaxed/simple;
	bh=UjuZLI/CRuzq8axOLFU8jtZRJlqW6/cs+40UdtoOgro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvI5UJnnd5FBi1UM1oOSPlxRWba0xqd5frKQSRfqzpnhtciLVDK0hL1wcuKzC8HJex0v8ykd1aEsltq79NVC2T288ZgfOycODpADcrvey6EnNbzLPjOv3eGEQmJK9ZHQnlHiv0ykJQgN/LYomdEndJHz/4hYs1PRmQcuNuXNW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IgSfPWUc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IgSfPWUc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F7TU3bjLM7Kk9wjHsOCNvuPzJqYTbP5q9iK8ewQzVcQ=; b=IgSfPWUcfV/nOKNGVnqs2/fVCy
	s7dYvyuf7GrdM2LlrzACrgBe5KNPB0fXPHNxfHP0C+aKXPzRgZrSLvZGb7ueo/dfMa1fmPivOHie2
	BRv5fC4REUKx0FFNE8GSVKE4gp9p/YMJQ6eO0QvaDhWredhqa7ZdDFjWmq+8EY+XmFsLg1VOfHtmC
	sZMRS6Dt1ySdNKExAzX/DaNZupo6eUwej0n5v41ErZfsi5D9Y8BaBRT5H2P8rlqzf4jRnMnLgtush
	fws/3jWYDIvOSn10BXc5Gbrc5fsaw8TYiI51R1FV1Y5ulwZoho820CotEXb0nQ3ClR62JhBoWsDMr
	UUZLX4eg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tptDI-00000005zFf-1Ztk;
	Wed, 05 Mar 2025 18:11:24 +0000
Date: Wed, 5 Mar 2025 18:11:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Hannes Reinecke <hare@suse.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Networking people smell funny and make poor life choices
Message-ID: <Z8iTzPRieLB7Ee-9@casper.infradead.org>
References: <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
 <Z8dA8l1NR-xmFWyq@casper.infradead.org>
 <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
 <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
 <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
 <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
 <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>

On Wed, Mar 05, 2025 at 12:43:02PM +0100, Hannes Reinecke wrote:
> Oh, sure. But what annoys me: why do we have to care?
> 
> When doing I/O _all_ data is stuffed into bvecs via
> bio_add_page(), and after that information about the
> origin is lost; any iteration on the bio will be a bvec
> iteration.
> Previously we could just do a bvec iteration, get a reference
> for each page, and start processing.
> Now suddenly the caller has to check if it's a slab page and don't
> get a reference for that. Not only that, he also has to remember
> to _not_ drop the reference when he's done.
> And, of course, tracing get_page() and the corresponding put_page()
> calls through all the layers.

Networking needs to follow block's lead and STOP GETTING REFCOUNTS ON
PAGES.  That will speed up networking (eliminates two atomic operations per
page).  And of course, it will eliminate this hack in the MM.  I think
we do need to put this hack into the MM for now, but it needs to go away
again as quickly as possible.

What worries me is that nobody in networking has replied to this thread
yet.  Do they not care?  Let's see if a subject line change will help
with that.
