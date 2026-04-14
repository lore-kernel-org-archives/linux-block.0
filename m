Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6321822CBE6
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192994; cv=none; b=ANkm5sjXU4JfvycHlGyJd0vMBhaZQ/+rqH9jbGFror9ELjALc/U2bk96poKW+nFb9ssSlVMtkrT8UdwedQ4umYHJHuuq4BQ0tdQ2+4p2aTgAF85t1euk2u+z+jqb3Cd5f+b/0SA5zLLRV8Xy5y5xJGDsg67420Q3LIQzpmG3AN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192994; c=relaxed/simple;
	bh=CziN8jkMcsO+q53oiUUyUlteeqR1tbu553QbpQ5ijIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce3MWsbsOTPSMoZfEBZBJXio/xsCn4cA3E7tCNKHoY9qVypn6XWArneKyEyA5rRfD9oMJKLi70m3frfZyJBKDWgI+wbgSz4AaIyR+eQTCJ8kAHhW3ZVM++cXj/9o84lRVrA1fjioKwCUfNPqsoWCVRg6O5Ev7BmfGy/xIPoVByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeGcK5GU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeGcK5GU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F053FC19425;
	Tue, 14 Apr 2026 18:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776192994;
	bh=CziN8jkMcsO+q53oiUUyUlteeqR1tbu553QbpQ5ijIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JeGcK5GUPYOC6SduI6eT/JyIlVudK24puPNXkf2jwB6qTZdLRuxql54PTBhNfFjdd
	 as5JL4pbuIXscKHqt2vhGL8TTpdBPqxcJ7bpXc2qOkNc/dGO8Tk2qqQ9dSyaYLuVw8
	 i5bQCqNynAPY+tj95wBVd8WGNnYAaL+mb9m5rJgMuY78UoNlw869l5KwMT0PxcQ8Xm
	 wWqjRDmMOxpeFxur/j237KdrUrn8LKg4otmmdivrHqJ/m+CVjYaTpOfSBidD2jPtc/
	 9k8GqwrcpUnBVvANMWAUA29zB76vQENtT427A4dXhdToKi7hT6eNAuoQFpLTat+XyI
	 Ybd2KBTuFXswQ==
Date: Tue, 14 Apr 2026 12:56:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v2 00/10] ublk: add shared memory zero-copy support
Message-ID: <ad6N4JWaeSGgt7Mr@kbusch-mbp>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260331153207.3635125-1-ming.lei@redhat.com>

On Tue, Mar 31, 2026 at 11:31:51PM +0800, Ming Lei wrote:
> Hello,
> 
> Add shared memory based zero-copy (UBLK_F_SHMEM_ZC) support for ublk.
> 
> The ublk server and its client share a memory region (e.g. memfd or
> hugetlbfs file) via MAP_SHARED mmap. The server registers this region
> with the kernel via UBLK_U_CMD_REG_BUF, which pins the pages and
> builds a PFN maple tree. When I/O arrives, the driver looks up bio
> pages in the maple tree - if they match registered buffer pages, the
> data is used directly without copying.

I feel if you have the ability to change an application to cooperatively
share memfd's with a ublk server, then why wouldn't you go one step
further: use vhost-user-blk and skip the kernel entirely?

The value for the existing ublk zero-copy setup was that original/legacy
applications didn't need to change. Of course it has the limitation of
what the ublk server can access, but if you're trying to get around that
with cooperative clients, then why not go all the way? What is ublk
providing here?
