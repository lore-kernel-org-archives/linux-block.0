Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE539A072;
	Mon, 18 May 2026 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141124; cv=none; b=NCp1oRpDovSd9+nc/fUSAln0ioE1108qBQnpXaQhM7jpKH86qfpFornH3jrR9tRFF5wrCSlBmE4oHChslp4FUmKx5XgsGJsggzT+gK63y3ibmVbEOL7DQpsbiNj9V7NN/uN9KTxZjOW2DcG9cDMLHRkp9SfFpvVYWHwgA4yk0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141124; c=relaxed/simple;
	bh=B+rmSHdIPdeug5qRLJRDMAIugwCK3bIGeOPxEOwXk9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7MSLP9Cr/aijOcYjywgu9JGpjQOCYxDuSAjvZHMLc2LetfHniD1XDS+kIrlM9RWY1aD5DJaFKe/XAefCc/BNVWMxgY7TIoI0KXOd8u1qaG7WjAc/uL+VpNCkPyBPpyBR8GBVZwnLj6H4kUWZ2QlvJ7alQzlDl8+VsE737otDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vkjf8Fmf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vkjf8Fmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18B6C2BCB7;
	Mon, 18 May 2026 21:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779141124;
	bh=B+rmSHdIPdeug5qRLJRDMAIugwCK3bIGeOPxEOwXk9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vkjf8FmfZnGE3WYJOznYFtF73/GemvAXzS/awb4nmgxtd8qk4yUmQG1mePeh+5tD8
	 9JczKUSxAcjrIiyxnMDm8y8OoJ3Dgfov+Cq8bDplIvixCIAAHdCcxWL0Y1gTZ5CRkS
	 qHZ2NskAgx4kqMOpLiVZZ0zAj0+4vU/cro6TyayaK9FEP5oHmC3W9BaPNhu7/zvsJT
	 JP+EWgCP9cCZ9G1MCPykXNCcc748Cg2dHTFzjCbUExPA6dS9MsnQvnLnFZNNKc7DOr
	 PySbklQl7ESdb2fvQkSi7xfmnij4+Z9TA4obcCLeT5flgyjMyKRWbE4wsR2HRZd58s
	 yPFpOmF3NE2LA==
Date: Mon, 18 May 2026 15:52:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <aguKAgkCUOVL2pVk@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <agtnJb5a5uIqH-65@kbusch-mbp>
 <MW5PR19MB5484B015B6B1D739D8C5CA2FFD032@MW5PR19MB5484.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR19MB5484B015B6B1D739D8C5CA2FFD032@MW5PR19MB5484.namprd19.prod.outlook.com>

On Mon, May 18, 2026 at 08:59:09PM +0000, Achkinazi, Igor wrote:
> - submit_bio_noacct_nocheck is block-internal and not exported, so using it
> from NVMe would require a block-layer API change just for this.

That is not a valid reason to not do this. We often export and unexport
APIs as needs evolve. I'm not saying you have to use this API, but I'm
just not yet seeing why we shouldn't.

> - it bypasses more checks than I see we need here (throttling, RO, crypto,
> op-type), I prefer bypassing only the EOD check.

I do not think we need any of those on the hidden device either. The
stacked limits should have caught any problems or handled any policy on
the first pass.

Though I am aware of certain limit checks that go through here are not
done under the queue's entered reference count so there's some racy
things possible, but that's a pre-existing issue and doing
submit_bio_noacct a 2nd time doesn't help.

> - BIO_REMAPPED propagates to split clones, so it covers all resubmissions,
> not just the initial one.

Submitting split clones already uses submit_bio_noacct_nocheck() so the
BIO_REMAPPED flag doesn't come into play there either.

And BIO_REMAPPED applies to when the bio's bd_part is a partition. The
multipath layer overrides the block device with the part0 of the path,
so there is no partition (and we may not have been dealing with a
partition in first place), so this patch is introducing a new implicit
expectation on what this flag means. Consider a real failover going
through the requeue_list using the submit_bio_noacct() again. If you've
already set BIO_REMAPPED, then it skips the checks, but that could have
happened across a controller format change that modified all the limits,
so you probably want the eod checks to happen again on this scenario.
Your suggestion would skip it because you're using BIO_REMAPPED as a
proxy to skip "eod" checks.
