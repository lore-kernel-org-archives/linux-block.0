Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553726FDBD
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604476; cv=none; b=lOkK9rKc0bCPcMCrrle0riKl7EL+twZqN+qSH+5MMfQKJWPz/MFMPLbRQgQBLOrZSNLRGUuX7v4GcgrEN0pRLDGr+cjBbeoz2Pwz7Kky2Oii0E1zdYinW03mfW38WjeZ2S5+iG0tHju7kCEP3iPhSwRW+HzOb1Ra840P7mWk+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604476; c=relaxed/simple;
	bh=tRsO6hGabKqGcBrI4S3kB79W1iNSD1ILnaFhoivZ548=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaJsc9Im7gjZbYznt4nxUXJdRJQiGbGpK5yX/1pBElT91MI7yYfx//T7Ub15875nP1kLndZBaZ1IjdxJXNR0J7M9j2xq/JnEroi49bHVO1sOglLrkW80Bq3FFS/QLlAaIeQvZUKqUegkkzOo3aemYOOtFDjIk/CtUYIB/9sTBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SenzTCR5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SenzTCR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEACC113D0;
	Thu, 20 Nov 2025 02:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604476;
	bh=tRsO6hGabKqGcBrI4S3kB79W1iNSD1ILnaFhoivZ548=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SenzTCR5U5quCvPgt038PpRmmhjfxGLnij5R/h4gp1mWInXeMK1JdsKhfIVdHCgTZ
	 i+2LGhgAHqYMVB8Uvb5bSWr7liTTirt7k0q4zVVPm233MbSdkNL/1KGIFIyZaRo9j+
	 MuP+58UWx7izSEaVT4umXHVk5g9w/PWgwyqys84wYcyd7SuPH/TpBSfSemW/uWu0eM
	 gA/Y/xlrCbVAmfAyYQgi+m8x2gSBufaoamhwsrjn6+VMs4bm+gX2+GYMAfQ6rRmb0T
	 L0Uh9CKXXOYb4kzGTmZ0/wINAZ3YwYDPp2FTdAIGZ2nXsmTKGROxRw3Xe18tMJw7Ra
	 EEoKed92Oi3tA==
Message-ID: <302602df-0fd6-4d76-983c-a065177d9b6a@kernel.org>
Date: Thu, 20 Nov 2025 11:03:50 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] loop: clear nowait flag in workqueue context
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20251119232234.9969-1-ckulkarnilinux@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251119232234.9969-1-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 8:22 AM, Chaitanya Kulkarni wrote:
> The loop driver advertises REQ_NOWAIT support through BLK_FEAT_NOWAIT
> (enabled by default for all blk-mq devices), and honors the nowait
> behavior throughout loop_queue_rq().
> 
> However, actual I/O to the backing file is performed in a workqueue,
> where blocking is allowed.
> 
> To avoid imposing unnecessary non-blocking constraints in this blocking
> context, clear the REQ_NOWAIT flag before processing the request in the
> workqueue context.
> 
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
