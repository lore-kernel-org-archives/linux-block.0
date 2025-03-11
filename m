Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD225D8FF
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704835; cv=none; b=ifvgzz5UVAadlqMuhIC20NyQpT6aKfZUHrYPg7MBFkGCcyMROD12EXh9kwMWihOjOQMkj55bU6HRWik6mIiwllR/ST6dvS2iJDC1rNCtoP91OJS3LE6XjOqyZJDAyYv2Jhsbt3uT5gh5ZiHKA3zjRWFwK2vVnZWP6Ip8gfUyDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704835; c=relaxed/simple;
	bh=jGc0c44TNz+dK4aEQEITOYZFGcpttDrh6/aAm6vWU5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5KCa+UwBA477Ur7FyC1ESwuc1ioX7ON6HYMhsDeAYd1VeR2VTDpu/WeRm05slZRBmhgITOXnVhCcMsWfn4tu4c/Tp8HCTTno2IBOTvbj9nh1GT6NvnVk6gBlB+HPFtRjEZ4V1lQdZpqtapIcwiJDC/60s+WeLgdWSZYVkcOJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDvPl9vt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDvPl9vt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D0BC4CEEA;
	Tue, 11 Mar 2025 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741704835;
	bh=jGc0c44TNz+dK4aEQEITOYZFGcpttDrh6/aAm6vWU5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDvPl9vtm4GpwjkAwst8WYkHpgTHURhSQB0ZwZC3OTzqHsGMVwRyBGOmZzBrAMPWq
	 3+HVLwC9PPapZPGzyp2tz272n5sbtw+UI7AA62xlmJpbQxfXV3OOUiL3qmF+ysfUdi
	 g/Xbhvtj8sQK9jlstTqvWOlpNPX+LN7/9kp+d0l7QUW8SoSnN2y/Tt9QZ5BTJzjfQv
	 MIX98TyYYB8s4QrixoeOlC0hnWSpd2pRP08ivmaLd6m5kwxojtD9fphQWEeQY+ABOb
	 VlIz02QgCASZTamQzNV9RbyYzQgQAuR69GXuHS9+geOqfVAtmTdUyq0saYNLvMbvYg
	 XyHn8F0emU2Cg==
Date: Tue, 11 Mar 2025 15:53:51 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] block: Allow REQ_FUA|REQ_READ
Message-ID: <Z9BOf7WljNX-Rnl7@ryzen>
References: <20250311133517.3095878-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311133517.3095878-1-kent.overstreet@linux.dev>

Hello Kent,

On Tue, Mar 11, 2025 at 09:35:16AM -0400, Kent Overstreet wrote:
> REQ_FUA|REQ_READ means "do a read that bypasses the controller cache",
> the same as writes.
> 
> This is useful for when the filesystem gets a checksum error, it's
> possible that a bit was flipped in the controller cache, and when we
> retry we want to retry the entire IO, not just from cache.

Looking at ATA Command Set - 6 (ACS-6),
7.23 READ FPDMA QUEUED - 60h

"""
If the Forced Unit Access (FUA) bit is set to one, the device shall retrieve
the data from the non-volatile media regardless of whether the device holds
the requested information in the volatile cache.

If the device holds a modified copy of the requested data as a result of
having volatile cached writes, the modified data shall be written to the
non-volatile media before being retrieved from the non-volatile media as
part of this operation.
"""

So IIUC, at least for ATA, if something is corrupted in the volatile
write cache, setting the FUA bit will ensure that the corruption will
get propagated to the non-volatile media.


Kind regards,
Niklas
