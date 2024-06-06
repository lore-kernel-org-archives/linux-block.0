Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21F198A2E;
	Thu,  6 Jun 2024 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685575; cv=none; b=WvEI5kra6IofdfrrTFn89gormYXxzW1cJTCYXG4KapqCakbumsbGMSUbkPWwvMsyWSXq6MwttCeYyxAMjuEuNNniipgE78pZb0pBG74qgWvKhPYwZuWTg7VrX3IoNfaaTa3NMQclRe0PBQX2CdWo/gXZV+cl2CH3SoAbF8vTu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685575; c=relaxed/simple;
	bh=KLXH+KI7yI3uxBMA/JQDRrP+7Rcs98KHMwoZl9klMcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdRKpsjd6E6IiwDhG+Wq2u2MKq7lKgLC3vsLs4MjIeyvaRW8p3Pe437jMjrT6GYi7uTbttv5zrAwz9B6MbJcpoqZqK3OHFvkyX1dktgtUG1qcowCJixCi9FLhMlqvku7W5ygo8XHMZTU+HO83Yk+c22mM1H/tbzQedqQXyG5LNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mwDNnRDV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mwDNnRDV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O8GpG0KuWFomSMbvkTL0cP/NCyoCqvdU8XJn/qjoHJw=; b=mwDNnRDVs/rojIxBHHkoox0oeH
	jLJh+rEGcUE/A/68LanuuYwBbAqGutQXkQiNveE82IJoK5a0W9OqQqxKfrKNxVmsMmX/SMVvlKeC0
	ZA5IRIDAlGSPNIIE6/coS3qAZpb7eS7jt2zgPefvOSaJtLXArQH0C8oVEt6R59VfGckX3vXDpf9pe
	HtFTde242PoXxuyab2zpmqR/szLSAbQ8eojNJsjdjbvAHNHFabFJ3D6FLoACCEuwLS2rV5BVePmCz
	71dSuh9Qrq1of23PG1wDWsWt/YR6BeKC9I1x2VLh9gatB/51ycV3SsKqPsOxENhyVssT/dFYncL4/
	XkLtVskg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFETz-0000000A9Zf-3ZTU;
	Thu, 06 Jun 2024 14:52:51 +0000
Date: Thu, 6 Jun 2024 07:52:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: yebin <yebin@huaweicloud.com>, Christoph Hellwig <hch@infradead.org>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
	Zhang Yi <yizhan@redhat.com>, "Ewan D. Milne" <emilne@redhat.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Message-ID: <ZmHNQ56C6Ee01Kcv@infradead.org>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmFatW3BEzTPgR7S@infradead.org>
 <66619EB6.4040002@huaweicloud.com>
 <ZmHH7mW0M80RaPlj@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmHH7mW0M80RaPlj@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 06, 2024 at 10:30:06PM +0800, Ming Lei wrote:
> Yeah, that is one area queue freezing can't cover logical block size
> change, but I'd suggest to put the logical bs check into submit_bio() or
> slow path of __bio_queue_enter() at least.

We really need an alignment check in submit_bio anyway, so doing it
under the freeze protection would also help with this.

> My concern is that nvme format is started without draining IO, and
> IO can be submitted to hardware when nvme FW is handling formatting.
> I am not sure if nvme FW can deal with this situation correctly.
> Ewan suggested to run 'nvme format' with exclusive nvme disk open, which
> needs nvme-cli change.

.. and doesn't protect against someone using a different tool anyway.

That beeing said, nvme_passthru_start actually freezes all queues
based on the commands supported an affects log, and
nvme_init_known_nvm_effects should force this even for controllers
not supporting the log or reporting bogus information.  So in general
the queue should be frozen during the actual format.

