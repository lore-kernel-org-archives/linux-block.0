Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005B49B458;
	Thu,  1 Oct 2026 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844714; cv=none; b=Rsm9U72e1KzkgchdTZMfqepoB18qPtc6zTYZVnSN5RcWb4sC0em8uBVD+XaO3Ha92T6ZsoRJmh2sZauS+u5Cw61aTLdfA86a+jjvhDgwIHpsV6ZJPONlvCuB4igd068/R2LOdjRQSJ7ge7WOqO3nI+03OEcV9EF5wukr8grHrug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844714; c=relaxed/simple;
	bh=20vxqPyJSRRLu9b2ZvPPeoQxUC6/G86+1VrsPASW06w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vowfcz1wauQ220iEL961Gwo8kXM3qy1T+sbuQ5WZBH9sQ2uf10/aKZDO6wbT2zS19vUNW/ofB8oHrm0lBxF+qfYY0NaK9YeJQ78Ata0PN+2FCN3GsuIQgBq9tH2VlZM0ozooEgq87g17ZaNSXqWGbQqKeoCK0X6d+aMaH/H3GHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy5Uwf3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy5Uwf3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956A71F000FF;
	Thu,  1 Oct 2026 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790844712;
	bh=VFmHqNJs/e1nltgkWcvpQVUCOuSiRU8X8wD2+ugwFhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hy5Uwf3wsXCio6yGPrRvZv8pybyLhRqoMs1tNdqOeN1NjlIC14rRiy9LavVIb+JKI
	 JN4bV8SLHisoNwmUHW0ZKP2n4E263WohbH2SnAaUlzluhXKGKnpXGr5xT7suXtH6IP
	 mf+1TNsRhKz1r/7vUkeOdpe0SZ0SEIZxFiyAg974agEG/P88v3W79FsWOOZWx6iN+w
	 87WrcIStEwG8UKNSPhLs1tXTptaN6JrxcrAclzF6OM95C1FE1TcUdXJxnel/b3kiPR
	 32gx+P3ChP2Y2efc9IY832ly+arLxJrS3RD77M6hHZ5rW+wJehNXtLGQ3i7sZybBU0
	 Qok+C0I/R3wGg==
Date: Thu, 1 Oct 2026 10:51:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, minchan@kernel.org, 
	senozhatsky@chromium.org, axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	djakov@kernel.org
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
Message-ID: <20261001-dramatic-hasty-pug-68ebfd@quoll>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>

On Wed, Sep 30, 2026 at 07:52:13AM -0700, Georgi Djakov wrote:
> Add a zcomp backend for the Qualcomm Page Compression Engine (QPaCE) so
> zram can expose qpace-lz4 as a selectable compression algorithm when the
> QPaCE driver is available.
> 
> Compress and decompress operations are handled via the QPaCE urgent
> synchronous path: each request DMA-maps the source and destination
> buffers, issues a blocking hardware command, and returns the result size.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
> ---
>  drivers/block/zram/Kconfig         |  11 +++
>  drivers/block/zram/Makefile        |   1 +
>  drivers/block/zram/backend_qpace.c | 134 +++++++++++++++++++++++++++++

So entire qpace should go here, no? Why did you create this entire layer
of indirection, singleton management under drivers/soc?

>  drivers/block/zram/backend_qpace.h |  13 +++
>  drivers/block/zram/zcomp.c         |  11 ++-
>  5 files changed, 168 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/block/zram/backend_qpace.c
>  create mode 100644 drivers/block/zram/backend_qpace.h

Best regards,
Krzysztof

