Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62C376468;
	Tue,  2 Jun 2026 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418986; cv=none; b=ExGOYwhvFoCmD+9sHu4XyhDFMtDit/cZa9zDDQXjASY6x/t69/fkZTMBtc4/UXQVnxPWukPblwRqugR4+zn6GL86hhcxCpbrtz5z4quU2SAbrZ2Wdr5f6EL2EoiG5jKugUXUGg3ra8MxXt9j90dFHVVGQdTZ7Lrzlc7CWM0ExEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418986; c=relaxed/simple;
	bh=aqFvoE9hj8BvmJnehot4qd2tDnwZKiFiwwLMKoBx8kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bExuC4/qTcW/5hDQaE12Va4ycjSV6mIEsSnsd07chOryZAtbAKLNDZa5qZWMFNO+cZR9IsHSUqplLzfu7Eir5wLKUrCSB2M5GkIX3bDCRvLSEQ4E+jH1fb7LKxwW8bugWdkQC2iny0Hn/4DOCME2QmHDhrsltCDt+VH/2ovU+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMy7eoqA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMy7eoqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB28C1F00893;
	Tue,  2 Jun 2026 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780418984;
	bh=LdlfwciUy5zxDlngmBsZIWpCJidRz5t7CPiWFeSRcMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nMy7eoqALrYWLNLriaMLm1pw4FmwYmd33+b1M3nDSdWjh+iT39nYHnBPF9BvU1Xxg
	 wRbjznaNphh6y+Sl1no1OoRhh55ML8Cx4VKsfCSOZ4AgILGXwmCb+stEqoR+wu80zz
	 b2mEbYFTlQgcPEHFE3mXHX6OHoErnuTWD3RhiR1H8F5xE1eLG/nLiJAH4/1xuNlzjH
	 /Ir6u97qpyzUIrfxgP7yq+P1j8YTfL326Zh6yO7PDRKo071unsH1jsn1uuHxtgINqI
	 x4nvlPrvPOS0trYjWianpapn1gt5laZiODStQLrwu4zzn9MR5GuFV7bbzSRH0IhN9g
	 Y6Mq0rfy4KBJQ==
Date: Tue, 2 Jun 2026 09:49:44 -0700
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Josh Law <objecting@objecting.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/partitions/acorn: use min in
 {riscix,linux}_partition
Message-ID: <202606020949.E58E5157@keescook>
References: <20260602160757.973736-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602160757.973736-3-thorsten.blum@linux.dev>

On Tue, Jun 02, 2026 at 06:07:57PM +0200, Thorsten Blum wrote:
> Use min() to replace the open-coded implementations and to simplify
> riscix_partition() and linux_partition().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Seems good.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
