Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6994F882
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4lpidyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5CCC433C7;
	Thu, 11 Jan 2024 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704989362;
	bh=ib510Zuax1YZdviZtByMupR4u5twA02E2PcJEw6qmjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4lpidylfHwUoPZJLKNTxtKTW1yk0cx2Bt6vWwwv+DFi13neDbHhs6PlvdshaFTL9
	 fhWtw8zpOARqEFfGDfWf4qFxGZS0B4xSsIW9HMRpoyTX5L53A4hokxHsXUz3Jt3hHJ
	 C6686dC5rMl7xfuXVDI8PvnxWVOB6IYYQeWe0NpfJlg9YtzIYz8N/46f01db14Cd5d
	 l0z/ui+KCVpHPKSlKEQEYeRpAN0ApszId3pb9lJFzXoDdfdn4uzvAd62bHIKVI3syy
	 4P/ofqFfqCUvkRI4WxxBQMNyg1ez9EVwxztX9sYYz0XpbObc5kzLJAfLkqH+OHrYCC
	 SGbG3lh7fJgcQ==
Date: Thu, 11 Jan 2024 09:09:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 1/3] block/integrity: make profile optional
Message-ID: <ZaASr3HWWZM_DWve@kbusch-mbp.dhcp.thefacebook.com>
References: <20240111160226.1936351-1-axboe@kernel.dk>
 <20240111160226.1936351-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111160226.1936351-2-axboe@kernel.dk>

On Thu, Jan 11, 2024 at 09:00:19AM -0700, Jens Axboe wrote:
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
> -	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ)
> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> +	    req->q->integrity.profile->complete_fn)
>  		req->q->integrity.profile->complete_fn(req, total_bytes);

Since you're going to let profile be NULL, shouldn't this check be
'integrity.profile != NULL' instead of 'profile->complete_fn'?
