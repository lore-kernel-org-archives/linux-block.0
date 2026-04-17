Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97233B6D0;
	Fri, 17 Apr 2026 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444732; cv=none; b=fqcdzLAladnFhixnzElBu5ZYbWe1e4caXg2uoOorbKZdSwhyBza4xKhvUkMtLmI7fEUdB9OcIwXGpiucBc9eKF0uZ7MVHQIiJgTpQFlEaDdBajj50Ld9hzxC5fN5KJ7GbsYEJNfSTvyjw6ITQL/+JcnvtYrxojDFsqjjbklBTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444732; c=relaxed/simple;
	bh=EJCXGti++d7dAveLJJjPsDhxgriChXZ8c9dc9seZHYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAmDEIOoeBWoTjYoViYdxQq90NtQm5JXRrylSo7qMVDqviCBnFh8rvSjx68mj9ZI7Kj7HiV8ypOjl6vE/Mwnvq1roN/sDmnYhVnF+PIE8x9IVvxpmFIQuiCpLKLLl52UM/HBnWpOxKxvxJjVRo5G0oDIjH/i3ZT46RAGJW4mQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l49Vklyr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l49Vklyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9C9C19425;
	Fri, 17 Apr 2026 16:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776444731;
	bh=EJCXGti++d7dAveLJJjPsDhxgriChXZ8c9dc9seZHYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l49VklyrtRAmUfaYBewnEkyGGkDTrj+1SHb58fbPgMsxVn/A9/hunuaAaYNxMUv3j
	 MWg/84L2XRdMI6ffBZP+kUCKxFS1Tvyz6DozNku90gFuLLZZvtDIDkgbd5in1vNJfJ
	 6ftN+QUSciZYkC0X4oAsk3O71+KJCdAhkMRa0B8irVGbz6PNy1QnMVf8sStSqbdIkt
	 0oMK01NAKOUxHjreWDJXLsCnXXjWCkZ0L+vAxmEB3whIK5xBz3ovWx0q4lB3otBFgB
	 tV0OROLjibEACj/3o/fWEoCj8OwuUU2Howg8BoWgNHzoVdwZkMOU0v49AZtfQItUZA
	 jnQC4f3rjLbAw==
Date: Fri, 17 Apr 2026 10:52:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH v2] t10-pi: reduce ref tag code duplication
Message-ID: <aeJlOZ3OwyJH6iAw@kbusch-mbp>
References: <20260415210847.1730016-1-csander@purestorage.com>
 <aeBxOVmQ2bLli78f@infradead.org>
 <CADUfDZpcNG_GPpZYh9tWKEBjKHD53DVCmQGTrXKQvBpP7PCqsg@mail.gmail.com>
 <aeHnx2GcBmutcsBW@infradead.org>
 <CADUfDZqDz9a4yBOq77mTOjQzNEwra6eh6oZFng-mzjmC5ivD8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqDz9a4yBOq77mTOjQzNEwra6eh6oZFng-mzjmC5ivD8g@mail.gmail.com>

On Fri, Apr 17, 2026 at 08:34:30AM -0700, Caleb Sander Mateos wrote:
> On Fri, Apr 17, 2026 at 12:56 AM Christoph Hellwig <hch@infradead.org> wrote:
> > folks out there actually dropping not needed includes from headers as
> > it can significantly reduce compile time.  Now this is not a heavily
> > included header so it's unlikely to make a difference anyway.
> 
> Is a file being included by the preprocessor multiple times really
> that expensive? I would have assumed it would be cached the first time
> it was included.

Do modern compilers even incur a cost? They all have "multiple-include
optimization" features as far as i know. Not that we use "#prama once"
in kernel, but compilers look like they're smart enough to recognize the
#ifdef guards for the same purpose.

https://gcc.gnu.org/onlinedocs/cppinternals/Guard-Macros.html#The-Multiple-Include-Optimization
