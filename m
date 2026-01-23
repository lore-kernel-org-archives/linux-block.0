Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379382E8B9F;
	Fri, 23 Jan 2026 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200641; cv=none; b=YJ7wzdfElkzGgpa8wms7rv8qHVhyZPRUbyNROP4PkKnaxRHaoWpMma3Sy9vxLanGFOR4gvFzAxOUNjIQo604p8lNwMFRV7WNEZg+DK/h2/zHwWaHocddCTE2g1sVyRKYx287ytVeH1InUuoLv4slEGkh8+DDTTE0jw+YdujUUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200641; c=relaxed/simple;
	bh=J3uIrIsI3rDKrre8O5bOnE8gVqwa7R70GzDdw+6sFgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWA0PHf2ubTGvmiMe2YsfboMZY7uU4p7uDaHTqLpe8LOeGdc/eIYr1P0dlVltY13oQymD/6krdQ5On11iaxXJcpL9Ju1dN/SsUbalKjiaGcYWOQ+6Rsq7oKgl3Wcfdg6iWlGQLjm26sA936O4UqQ10spkaEpqUm1DTM4DVCw5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rMzzr48Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMzzr48Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jIvepI9acMMMk9EyKKutMt3xnmNKtmyd0L+HCslVMZQ=; b=rMzzr48ZEZwxWMtRrKDYd5siJh
	aH5MXe97U3+/lggnM1s+cCvnK5QyDgtQqX/Ou9/z0+/TICygzTWr316AA58osp/yT8PJnYjsni60L
	HKyMZEwSibLYWoIbObsv1RVKbPMn9eGPjhxH7lXyrtcCq9H7cHIaS9WteSwHg+XjouAhHvn9JQZS8
	yCQLEhyl7ZGPx3NS8rQWO7WrSxTAM7+vbpu+v8sKpOwUmzk0X/GX8ofdd4hXTVGqStFeJ11wXrcY2
	mqTA9SJF3XAKqI4Gn757O/GLxH8ZaSzJaG/Yqs85MAyL2mgXCKSgXiLIAdqqga5ylsEpiLGQn4Osc
	EXBZEEqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjNu6-00000002Fay-1Ftx;
	Fri, 23 Jan 2026 20:37:14 +0000
Date: Fri, 23 Jan 2026 20:37:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "qian01.li@samsung.com" <qian01.li@samsung.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>,
	Patrick Donnelly <pdonnell@ibm.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Data placement policy for FDP SSD in
 Ceph and other distributed file systems
Message-ID: <aXPb-tehcuOvSC9V@casper.infradead.org>
References: <b4bbba0993d4c1abd6566d8d508bbb47aacd7671.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4bbba0993d4c1abd6566d8d508bbb47aacd7671.camel@ibm.com>

On Fri, Jan 23, 2026 at 08:13:49PM +0000, Viacheslav Dubeyko via Lsf-pc wrote:
> I think we need to elaborate much better approach for FDP SSDs in the case of
> distributed file systems. I believe that it needs to execute accurate
> benchmarking of above mentioned use-cases with analysis of peculiarities of
> distributed file systems case. Finally, we will be able to analyze these results
> and to elaborate a vision of proper solution for distributed file system case
> (like Ceph, for example).
> 
> So, I suggest to meet at LSF/MM/BPF and to discuss the benchmarking results and
> potential vision of the solution.

Is this proposal for an I/O track discussion, an FS track discussion or
both?  (I see nothing in this proposal that would suggest that MM or BPF
people should be involved).
