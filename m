Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC23D171F;
	Fri, 28 Aug 2026 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911579; cv=none; b=JBzJpqEhe/VsAFxiBCggdtl+UIOHjIl9exs8XDdXHnreGlnU70pV3sJi7XfzaS4OfPLIPWcg3FV+WtSGqaXatmK3k0LICynigtVuKc8BCT+ze7ABAZLig5X3dlWNVYTXtguOVk5AFmFSVKcc2joPASiczcNqF2xX7ufNc18EOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911579; c=relaxed/simple;
	bh=OaO6TtSgKMKtM7XlnUya1blR0HzTbAXnHE0uz3g71UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGEt3gSQSjWNBIeJbsfeg3pbkPt22/TI+145vqUiLrHeMgfP/PaMNLrF4cRaokZ8qaAyI9MvPkbAZO6JeyfgTjEN8pjo7HDBaz+y9EE3l6VP5JDk4W5faA4O9W2w6C715ev5TN8nNio9/zW6UEWyb/p5ku46XXCm5J7X7f1HuQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org; spf=pass smtp.mailfrom=xenproject.org; dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b=2stE97Zp; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenproject.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b="2stE97Zp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=V42N1s76PU9hlOX8CkrzYvjBpNAXKMnOiAvs6hvwk5Y=; b=2stE97ZpSlB1WB16qSo8yN4U12
	Y3m9II9uWSkUWkiZ2AoapVAxY3yjz2Y1gFnsBntmfroafVuK45ien498c+y3YPIAiQvue9Odm963b
	AZV9jXAUuNbvB5PfGnRWzkEZdlkzt/0mfC4bVhC4ecfryUoQtPPKAO07pYaVnEN16s8c=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1wzt26-009zoV-1B;
	Fri, 28 Aug 2026 09:37:58 +0000
Received: from 224.pool85-54-217.dynamic.orange.es ([85.54.217.224] helo=localhost)
	by xenbits.xenproject.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1wzt25-00G23P-2Y;
	Fri, 28 Aug 2026 09:37:58 +0000
Date: Fri, 28 Aug 2026 11:37:48 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger@xenproject.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: xen-devel@lists.xenproject.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, konrad.wilk@oracle.com,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] xen/blkback: Prevent missed completion when draining I/O
Message-ID: <apFW7CH1aZasMKiV@macbook.local>
References: <20260730084000.3305702-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730084000.3305702-1-hanguidong02@gmail.com>

On Thu, Jul 30, 2026 at 04:40:00PM +0800, Gui-Dong Han wrote:
> xen_blk_drain_io() sets drain before checking inflight.
> xen_blkbk_unmap_and_respond_callback() decrements inflight with
> atomic_dec_and_test() before checking drain.
> 
> The pre-wait condition check was added to avoid missing a completion, but
> atomic_set() is unordered. With one I/O in flight, the drain path can set
> drain to 1 and read inflight as 1 before the completion decrement. The
> completion path then decrements inflight to 0 but can still read drain as
> 0. It skips complete(), so the drain path waits until the timeout despite
> no I/O remaining.
> 
> Add a full barrier between setting drain and reading inflight.
> atomic_dec_and_test() already provides full ordering on the completion
> side.
> 
> Fixes: 6927d92091df ("xen/blkback: Fix two races in the handling of barrier requests.")
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>

Sorry for the delay, this slipped through the cracks:

Acked-by: Roger Pau Monné <roger@xenproject.org>

Thanks, Roger.
