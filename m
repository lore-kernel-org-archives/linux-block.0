Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561DB21ADA4;
	Tue, 26 Aug 2025 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756246039; cv=none; b=uQMgEDr3mTG1hT0tfWlfqXctfttI5yopejInYv/ghO6CzV1sqBJ/0FMF39cLGViTlCP4oQxG4eZWswl6u9b70ouP324A61Ip7X3j8LdD4CTsquJ+iHw44qyk25xY7jED7dZ1SW6r2TQDP8MwjRj0GuG4zcq8hRjreiN9a3ms7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756246039; c=relaxed/simple;
	bh=nLa6+7NbVgGFyg+MtulrSbyq42ubo4I0J2fY36o73dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMFPxYMhBMsRdkbsGuqFQ7bTQR0ENz/Ia52bZzYkzdun9LXwiw3fWhBWsKSf/58pEU+LAepuhsp+w8QMzCPvkeSRQLPAgecErPLLClEZMfI6Yq3itbMC3YeE5QZNSBbPpTjcmNqlXTiusPohiHgHjGXaS2OtJ6TU6rwQqM5RiEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPDCk5gq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPDCk5gq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8474C4CEF1;
	Tue, 26 Aug 2025 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756246039;
	bh=nLa6+7NbVgGFyg+MtulrSbyq42ubo4I0J2fY36o73dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPDCk5gqNQzfqnFd7KQSt3kdyPzBFbVu+g5BvBkV/5qCRV4WeBS7LqyZCE4qAyc81
	 rbRKHRRBXNNF10Lwobj2NrWWO99PD8o46Qo3PQhjjQEN94hSLj/QQqfXORBBqCHlWx
	 IXy1UbVsH7LFaGJPrDiTCa2q9PH+xVxdW8NFljoI0nZqqcqGQgQyfH2uJic/RSSS/b
	 WFjEwNkHcThXUaG1IWF0ThsrhFXUMMLfQn5Cj8W/IYveF74hTUan1yxmxIoHwLm0QN
	 6kNf1ZTX/dd3Gvm6mWaFM9KyCsr6vPRinqUJH9GkIAPUSKIdoMQrYvSJ69VmT6nZ+l
	 upf8jJrS8MD3A==
Date: Tue, 26 Aug 2025 22:07:17 +0000
From: Minchan Kim <minchan@kernel.org>
To: Richard Chang <richardycc@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com,
	liumartin@google.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] zram: refactor writeback helpers
Message-ID: <aK4wFZzd3cwbGFIL@google.com>
References: <20250731064949.1690732-1-richardycc@google.com>
 <20250731064949.1690732-2-richardycc@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731064949.1690732-2-richardycc@google.com>

On Thu, Jul 31, 2025 at 06:49:47AM +0000, Richard Chang wrote:
> Move writeback-related functions and data structures from zram_drv.[ch]
> to a new zram_wb.[ch] file. This is a pure refactoring patch with no
> functional changes, preparing the ground for the upcoming asynchronous
> writeback implementation.

Can we also move zram_writeback_slots and scan_slots_for_writeback(iow,
all the writeback related to sutff) into zram_wb.ch?
