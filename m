Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFF3D170B;
	Tue,  2 Jun 2026 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393440; cv=none; b=hFSac+rhgUF3+tKDOpt6QdIRqUGGlO9RHgy5NzNX0WUOp6oFz0SjsG21xhOjde1qwt0saGZBgbZ5xTvFsEPt2WwMSzoSTCOhM9TT3pktXVpmJYnjzIeZTafloJdLT8rEnapojdgCfop+umSZFW2ERulzHgz949oLUcK3AEyAzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393440; c=relaxed/simple;
	bh=JaQKHMd+FU90o2L5hpnwr8Qo6a26qIiXcVLcsXoppBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5YTVh3GmI/AIkOCIR6ckAG4hNxSMtAocU8xR9S3WGwpJ1UgR+1KTzWUk1oHVWyG7LhAGzujZC25ETbgcC9KnoBmmORS5OToLZve83Qk5pWZfiK+HomwvlbvBn5mEPzMD5YRCsmjjeXlhZokMJ7TBWFPV+l2v2DBAGwWGE6v3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2HJyO+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2HJyO+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EED1F00893;
	Tue,  2 Jun 2026 09:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780393439;
	bh=gw0vgDXqPahTyjRldLraKnASsI4dcH3qANYQSDDdpF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M2HJyO+SQKwGa5wqBM8yhAJBgjPj2E7Oire1YLY6WZiUwjBX5oDy8lt/nUwgErizC
	 JpFzLRhIB0gMhlgbi52NHnAm9N9GbhQd0MoDKUHj4CC7H9liS2zeeKRZw5pVFT0nff
	 z8DZde91wbgz6o1mJN6OH7hRH/OwTz7xBbMHIcNpXDp5v0rHAqf7NPSnn0vsn1b17X
	 AoWa2619CUmdEwRsv1BMd5pS0tmjgsnJYAj1hb7lhmZUp0YvOFYyqhWAk/MSTlBOnE
	 1/UJWZbOJgIF4xO0w3u77eYkcKQPCmWGEui+hsnifooYxg6xMKI2sm8Ge87d2s+hKr
	 6EA/RwQZ0CQig==
Date: Tue, 2 Jun 2026 10:43:53 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: configurable block error injection
Message-ID: <ah6l2YOumsbOiPKu@kbusch-mbp>
References: <20260602054615.3788425-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602054615.3788425-1-hch@lst.de>

On Tue, Jun 02, 2026 at 07:45:32AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a new configurable block error injection facility.
> We already have a few to inject block errors, but unfortunately most
> of them are either not very useful or hard to use, or both:

Looks great! I just have some comments on patch 8/9, but for the rest:

Reviewed-by: Keith Busch <kbusch@kernel.org>
