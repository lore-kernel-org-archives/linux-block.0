Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C834D4F6;
	Tue, 20 Jan 2026 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928838; cv=none; b=lWosGfGMRPRhGybhcHhjGCGcTgY0yPeOGasRsoyeTJCsfOAH0qUAp08rolizdJMhXnY7AMOIJmgjpPxEipC1ge0HzW4wlIzEar8XM0joOquusTgs0I42XlISFJP6EngHojh32mUps6H9ZJIqxHRU4cvfHoPSDTvd01xTSSmf26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928838; c=relaxed/simple;
	bh=ZPfFdIK7v9EtBydOu/jnCLimg+X7OzRP2hKOXMJQGeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRxBRhuhjMsniXIZEKZMqYrBWEG6VZ1p2NxfFNJgAZaciltQC3JWE88Le4WBVxKN6iBRnm72DJ3xlrQ9+hRuZFVRe0gRmxtmBVFcdChQajmWC5dibawEOQPDK8E3kQnNCF84B5+QUD5CsPaY6PhVsqZN/WFtB0A/TDDEzPowKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm220QQE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm220QQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D5FC16AAE;
	Tue, 20 Jan 2026 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768928837;
	bh=ZPfFdIK7v9EtBydOu/jnCLimg+X7OzRP2hKOXMJQGeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xm220QQEAIGLnhBF0gVMlj9lJ+aHxgzq2jQTCVMcsjfBf3+QQfLkeprGCCoV1mOY2
	 cZ1ghn8M0K1uuhWqrW0ezxL97v7XSY6oUOyK+23vyIvhkMrDE6Rz5hHEScJQMoRm1F
	 N50fuiYEDQnHf/JwfkUECp79W7fzPU+C0CRooa2V8+3keGvyzAvtJEo17jrtRpxDHS
	 230WWqUia86hLvETM89/0oPzd0g0LVSMwO2qh2K6D44/IeH9fvJFFHO47tzodC7hhB
	 E+dRkqyuC0hZ0oGR6k7mSAddIynRD4V72cxMGWmk0gkt/kl6C0hTTeDISQ6FLYJ8Mt
	 IuHM8UOSoQKbA==
Date: Tue, 20 Jan 2026 10:07:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion for
 local ring context
Message-ID: <aW-2Q9Zv_UNX127Z@kbusch-mbp>
References: <20260116074641.665422-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074641.665422-1-ming.lei@redhat.com>

On Fri, Jan 16, 2026 at 03:46:36PM +0800, Ming Lei wrote:
> Hello,
> 
> The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.
> 
> The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
> context, and improves IOPS by ~10%.

Looks good to me. It feels a little unfortunate to have to add this
parameter to the callback just for this one use case, but maybe there'll
be new uses for it in the future.

Reviewed-by: Keith Busch <kbusch@kernel.org>
