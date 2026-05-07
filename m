Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1740DFCC
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778132989; cv=none; b=hFJ8YjLrKfqb0nPkGVRwGG3/csJ6uFecexC3Doo3ZUiYBXF5ql0+cmWq9gKlBdzhAYuzeg5lVTxdPD1rsJKc4B9jGE0Sn7zdjBOXvTI3zNoulXpzLOTHu82C1+dx2zNSYcUqNfZJHjH1ilKFgzkO2yjNNHQTrz5hRtBtyf2YntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778132989; c=relaxed/simple;
	bh=XaezZRsD4odueNUHVjVkcjJKs7ISj2ACmBs4kqyq6G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+2sLOyVYHcJGWAtSM4jg8k9oCfqQhB/ukdk/5mkpA3+zk/PlvmvvrfW+aV9gyCDIl2iEf9s4ry5R6cv+bwQbrQW9iLGjzR8eFQFXExTweHBqxUyOcmfz/SOPrr8Dcjpbu5aTs1a9Z3egJuidoV4od8U84ufXBgsaIy2xaM5rN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC58E68BEB; Thu,  7 May 2026 07:49:44 +0200 (CEST)
Date: Thu, 7 May 2026 07:49:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 2/2] nvme: set integrity metadata size for EXT_LBAS
 non-PI namespace
Message-ID: <20260507054944.GB19796@lst.de>
References: <20260427003457.1264511-1-coshi036@gmail.com> <20260427003457.1264511-2-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427003457.1264511-2-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Apr 26, 2026 at 08:34:57PM -0400, Chao Shi wrote:
> +		/*
> +		 * For PCIe EXT_LBAS non-PI namespaces the block layer sets
> +		 * capacity to 0 (we return false) to prevent block I/O, but a
> +		 * cached-rq bio may bypass bio_queue_enter freeze serialisation
> +		 * and reach nvme_setup_rw() with head->ms != 0 and no
> +		 * REQ_INTEGRITY set.  Populate bi->metadata_size so that
> +		 * bio_integrity_action() returns non-zero and bio_integrity_prep()
> +		 * sets REQ_INTEGRITY on any such bio, preventing the WARN_ON_ONCE
> +		 * at nvme_setup_rw() (addressed by patch 1/2).

This sounds like the Bug Keith is trying to fix in the block layer
("blk-mq: check for stale cached request in blk_mq_submit_bio") ?

