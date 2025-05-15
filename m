Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF43C00;
	Thu, 15 May 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747293552; cv=none; b=fWBquiQP9anGu+1DJKWnUw4WcEPE1Q7mp2ZyB+Eju7cClRJ30e7XRH4Cr2ZvAcAGPZOnKdk/flcMt8ETiUWvWKvKNmvDCNjJwcbP16EQbr850HQCdhTebsXkV4fH7wDvqS1z6z+fVWHJNCqpGvnXMfr6dRa3rqrFxHQnQmAct7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747293552; c=relaxed/simple;
	bh=NkLBdrijFJswBxzpyufasT+pKXDbScVm9q2E/Qb0UZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cheGim2ysDljUSupXz/4wB1NNvPxeRqCoVDsS1jAfDPPRK9p97tM5G2G/u7ihU0RCNhRG0BydJAPJ1F1ZRs5xwy8ePLIX1iGQw/0Pc1vE3Mnfp750eDv+RjeM+itOO3HXNhfr2BL04s8Sd9yMW2vqX4NixeBBr/OdVhrPf7jtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnBjGATk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnBjGATk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B34C4CEF2;
	Thu, 15 May 2025 07:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747293552;
	bh=NkLBdrijFJswBxzpyufasT+pKXDbScVm9q2E/Qb0UZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnBjGATkzALgMw3pOGBMm1sdR0zCN42fpzszIvO6MSd5rgeJTr9p8XsFQsPWRI2/Z
	 eCmPweF6o0t4um9xhH8kjtUriOUh5vPDQTwGNtDLSnLv3D7qfL7/4On02Bi0IWrlzV
	 94XupcNb0RFyO57+DGNgswboERDyUu/mZBskoMPKCypMb7w7oGJICqwH+5s3moMSyx
	 m9GGEYxXR0++8xkntDAC1f68PgmWh00k3gdj6KnUlYp/zzNQpRbT6D1/KffnOjLJ/X
	 pVBjOwQ2oqN48F+626lEbTfgg9tkBBsjVOWop5A4O0xWwuQkJDuiLYvjubiF/HyZ1C
	 jm4WJSClcfvOg==
Date: Thu, 15 May 2025 09:19:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <aCWVa68kp9vXTqHb@ryzen>
References: <20250514202937.2058598-1-bvanassche@acm.org>
 <20250514202937.2058598-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514202937.2058598-2-bvanassche@acm.org>

Hello Bart,

On Wed, May 14, 2025 at 01:29:36PM -0700, Bart Van Assche wrote:
> submit_bio() may be called recursively. To limit the stack depth, recursive
> calls result in bios being added to a list (current->bio_list).
> __submit_bio_noacct() sets up that list and maintains two lists with
> requests:
> * bio_list_on_stack[0] is the list with bios submitted by recursive
>   submit_bio() calls from inside the latest __submit_bio() call.
> * bio_list_on_stack[1] is the list with bios submitted by recursive
>   submit_bio() calls from inside previous __submit_bio() calls.
> 
> Make sure that bios are submitted to lower devices in the order these
> have been submitted by submit_bio() by adding new bios at the end of the
> list instead of at the front.
> 
> This patch fixes unaligned write errors that I encountered with F2FS
> submitting zoned writes to a dm driver stacked on top of a zoned UFS
> device.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Yu Kuai <yukuai1@huaweicloud.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: stable@vger.kernel.org

Here you add stable to Cc, but you don't specify either
1) a minimum version e.g.
stable@vger.kernel.org # v6.8+
or
2) a Fixes tag.


Kind regards,
Niklas
