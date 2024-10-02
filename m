Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DB412CD88
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898052; cv=none; b=CH3UpfeyxzA14D8X3zMFF2yYD9B6a7MiuB8AcCZdZMfhIGq71Jc4ebvMPvSZcv0VjNldKhClhH2NZdlsxJSzkD943/dy1Pqa9Mc+1uqwXd603aiKlkcaxeUnGVLD1beMmsLSPI2vEMoXc7GbGrKvWd9ekbHeIEiDWAp7X4KGfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898052; c=relaxed/simple;
	bh=K3XFhKDuhhdlMxL3MPb5XqjHcs6EIlONAuNIeoquX14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkzmhkXReecinrRyiq9xJ+2dv7M3jk+5DrLNju5mHbz7kcCR8OG3NtJ8/n6kzToeR8VteljsdQ2CTbIjWR5ma1gwpkX4ABerAYioODWW4X8233WLDG5iVrS9UwqvMN+FyQ9sLFS9pMTUWl7tffyZdp13qHuSA6E6XDtYmwaFDDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUfc8htw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUfc8htw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB85C4CEC2;
	Wed,  2 Oct 2024 19:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727898052;
	bh=K3XFhKDuhhdlMxL3MPb5XqjHcs6EIlONAuNIeoquX14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUfc8htwPT+hvqqI1LIWlHIo0TeGWAz8CCnaGTduzNu61xT7cbcuxXD71etHI5JO3
	 8s3CUm0s0qTKxs3WOmFvFhz3VG03dqIQPDJXfwJ6wvcfxUiW4tVMUjLDNKCmpDk2mW
	 PodIMcQ+6haka/0Vehs9SxmAPUKYcXVupYkBRQJ+Ke3GRRGgbWTC84xA3PY58YhHVn
	 19DePbABFWAfYiFzUiOjKuG9/v39rZ7TGAXxhoMzZ7ZP1c/deCv1mmkeQ4g+GG6gVn
	 +Nee/8k93ToXIS1E6FUwp1YyW8h7AlVzRDHJQ3fSuPt7PiDDv0BtXylOP9w8dARz9c
	 N9s04fseWyBoA==
Date: Wed, 2 Oct 2024 13:40:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: move iostat check into blk_acount_io_start()
Message-ID: <Zv2hwm7EGvXA8mu5@kbusch-mbp.dhcp.thefacebook.com>
References: <550fc8a0-3461-49ac-879e-32908870f007@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550fc8a0-3461-49ac-879e-32908870f007@kernel.dk>

On Wed, Oct 02, 2024 at 01:26:08PM -0600, Jens Axboe wrote:
> Rather than have blk_do_io_stat() check for both RQF_IO_STAT and whether
> the request is a passthrough requests every time, move both of those
> checks into blk_account_io_start(). Then blk_do_io_stat() can be reduced
> to just checking for RQF_IO_STAT.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
