Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E634D3A7
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297258; cv=none; b=hNR6nqB/vlPfgfywIIo87lyjlrbcfJTC3SQ2xc5fWnqCjK+d2cyWTsLPLQX6mKMFo/HmRNWF/q13R+NnrVjmoasmwcBgH1kFlObkJjuX35TkQ40pf01Z4BtQQZmPP4kJ+n19PF+POnUEATroT58pN5TXGlYiis3JQr3EUTWDE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297258; c=relaxed/simple;
	bh=jvOGFBcZtmj0o/kU+NH12xbIbRwMWynb9wLsN8izqH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnHXtLdwgaz5in50L/l1zprxznRpo/FcJgJBQj53cRPoD7wiIhO282XUDGTyQ6aFOC4rhfMBwPCxGdo5QAXebp4uTRkKn+8ss1a6rzQPzFD2qpNWPRq0Qfek5CJjWu/CFKdqQldBW+PW3b4dLb0wCxxzkLYNVn8NoubxbrhKqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9tM7hqJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9tM7hqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F712C4CEF7;
	Tue,  4 Nov 2025 23:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762297257;
	bh=jvOGFBcZtmj0o/kU+NH12xbIbRwMWynb9wLsN8izqH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9tM7hqJMGeHJkPqSpduxY2zQ3wvrIixH16kvT/lGeNhFRkBAmWnVLdQJdW5XCIU+
	 YIYvrtaSxmrZf05CjdlmjzMtV988xSv5oN7xzHRuJGDOhfvchL4APfjS5/bmzWC4SX
	 p4JslFr0gbncr0JjrCsTWn7QxTe9l53bxoDkU684hCPwWWM2IYiNPy9Dq+V2SDxjQ1
	 heVhAjfdV+BlVU2zf30/NaksmC+jGB/GTzcrJ9eaWgSnzhh8yff46koX07nM491gRq
	 rtLBhm18GG80uvTRC4nri3WV+dpBAQ23iev5KgqquYdVKaa52vaRMKBwjr0THXM0Rn
	 28AXNXefi3row==
Date: Tue, 4 Nov 2025 16:00:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yzhong@purestorage.com" <yzhong@purestorage.com>,
	"sconnor@purestorage.com" <sconnor@purestorage.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"mkhalfella@purestorage.com" <mkhalfella@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Message-ID: <aQqFpwNzCWcvHiKN@kbusch-mbp>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com>
 <aQKzxpJp98Po_pch@kbusch-mbp>
 <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
 <CALCePG3Q9u-Mcj6qWqudip+JPVHMq=XBX2=QxJJrV1hELJrYDw@mail.gmail.com>
 <8015bde9-39eb-49e3-9102-7576b7b01239@nvidia.com>
 <CALCePG1oAs_gBW-YkBGKD_xG+ZEUpM66e9CS4MRrV-bOvY0ZkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCePG1oAs_gBW-YkBGKD_xG+ZEUpM66e9CS4MRrV-bOvY0ZkQ@mail.gmail.com>

On Tue, Nov 04, 2025 at 02:39:47PM -0800, Casey Chen wrote:
> Hi Keith,
> 
> Could you make a patch based on this ? So we can backport upstream
> patch instead of keeping our own patch. Thanks

Sure, just sent it out. Wasn't sure if you were planning to do a v2 or
just use what I proposed.
