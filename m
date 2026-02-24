Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C83366DD2;
	Tue, 24 Feb 2026 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948805; cv=none; b=LErxzG2JkhsLYmepNajtokundx1Ei2dw82UI4mNFJf3F6kM8kgKY69CWPaNSoV3QgkmPs4Pb/LWEgF6HgT2z3jQpggKT0n9RWS91KjHwEOidSuptN4w59EBIuoo8zsvHncWx5fvcuzi71xSLl4zjQAuZsOWdTkIEta5/dCvzA3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948805; c=relaxed/simple;
	bh=CH8Ny/ohYd7uGlKBJG80LnTBkwyXykrGk0SvYhFlCTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7rjYJpNRZndWXjZ2BDq6je9DQ4M49rUJTIM+DW43bzJqd+1ceT/edBYGNdzrGst8IMiK7VZpqaFbCXRkmmi8+Fe8DiS3FZeIM6O0zn4YqFvBA1ChQN7Qfk3YSdveFrCBrGkDNciItRm+dGMfKYMwef/6e8RyQs0l3g9HPerkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlXUrILH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlXUrILH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADB2C116D0;
	Tue, 24 Feb 2026 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771948805;
	bh=CH8Ny/ohYd7uGlKBJG80LnTBkwyXykrGk0SvYhFlCTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlXUrILHLtkV5/lvMQEkVxuDZvY6mRir71P2KBjf4JJGOQ7mULwinvO8URyD2/zc5
	 3eIxqvKpzjBLJ20Et9wfHNacPuoj0X9h/rDKl5RQvcvO91yKpqxk/YRbCWSVTIDk1u
	 VwH1BYMqHlXvH+muO4eBYs4oaKWWozQ63qxhKoM073BpwJ2iAMulEe5UvCcUfyeAUn
	 gNbOQc3eq/zFtPriO2neKhPRFg6cS3SIJHz6B6zNPxMLsU1Mjp8km8x0oietug15qx
	 PsDwg5smlwTrL/I6JLDkW1jxQEE6HPpq4xLVOeaxHFcqGBgbBz//+ypnjXt9o9wxKW
	 vGON7Ow8p03xA==
Date: Tue, 24 Feb 2026 09:00:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7.1] ublk: report BLK_SPLIT_INTERVAL_CAPABLE
Message-ID: <aZ3LAzaSL2M1fpwF@kbusch-mbp>
References: <20260224155724.3142007-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224155724.3142007-1-csander@purestorage.com>

On Tue, Feb 24, 2026 at 08:57:22AM -0700, Caleb Sander Mateos wrote:
> The ublk driver doesn't access request integrity buffers directly, it
> only copies them to/from the ublk server in ublk_copy_user_integrity().
> ublk_copy_user_integrity() uses bio_for_each_integrity_vec() to walk all
> the integrity segments. ublk devices are therefore capable of handling
> requests with integrity intervals split across segments. Set
> BLK_SPLIT_INTERVAL_CAPABLE in the struct blk_integrity flags for ublk
> devices to opt out of the integrity-interval dma_alignment limit.

Looks good:

Reviewed-by: Keith Busch <kbusch@kernel.org>
