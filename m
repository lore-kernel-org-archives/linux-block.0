Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B844185F1E
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368288; cv=none; b=mUorwCdJsH+fPfl/RM+JPXdozYI1nrQy8WZsbAtugqFyKT3d0fiLq+Ukimk4mShlwwEEzynbWe2z0TEfj6mcF1rCzYEQ2IDVgvg2qE8NCskHS6Tns/PKi3o58686sRuxGr4RZ1UkK6Jcv9Q6exaM458lottNCa6hELZBrKymFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368288; c=relaxed/simple;
	bh=/0X400qwFTGF9UIcSFiQsNbtuW6H0hcxktCEq2j7qdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKiAqIvESE7qmpA036oQCcu/noeXNOzNoj08dXie6yWjjqxs1pDT0/i7Ixr7sjPtgpbiESL6Aarp/xZBppVUKRKYtrUY+PV7Pt6AC+1PG1Gw9AuqdrkETXrgIZoHgEPUKrLdg/xI6YrIdP9NEl0p+lS/JAruwfv7f0GEjA+GpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccMRnjCZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccMRnjCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1A2C433F1;
	Mon, 25 Mar 2024 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711368287;
	bh=/0X400qwFTGF9UIcSFiQsNbtuW6H0hcxktCEq2j7qdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ccMRnjCZPKiUznsK8XE5YuxgBcNLftGVkix7NTpRM3DIs8GFaqThRsNnZXh2it7og
	 yjpXdLb+bTHTYOm0GevsK0ClbEGv3yTAPvCybJMCLw0aSkwBQGxO05KceggKFQVVpS
	 zoYkPxetW+N/f6Ehx1ZHTsneKFLUkFtyo812m/Uie/nqv64TP/NW65eh0SHqd9cL2x
	 MQ2onJx/kShe6J3AnLKzJxDNj+zA0sqpHRKswMyltPKScBIijG0pBMK1TjvP1pfgpN
	 fBMh/FHHuxEDeoKL8pQjATZ5E8cQjoHE4DY4LmyhRiBLhzo0PTRdTEH8wokhK8q9Qr
	 jPUpsPC5vGq/g==
Date: Mon, 25 Mar 2024 13:04:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, 
	linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <20240325-ziehung-angetan-2703b0225ae5@brauner>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
 <3594bd44-4c6b-d079-1209-f069353ccd58@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3594bd44-4c6b-d079-1209-f069353ccd58@huaweicloud.com>

On Mon, Mar 25, 2024 at 07:51:27PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/03/24 0:11, Christian Brauner 写道:
> > Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
> > default this option is set. When it is set the long-standing behavior
> > of being able to write to mounted block devices is enabled.
> > 
> > But in order to guard against unintended corruption by writing to the
> > block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
> > off. In that case it isn't possible to write to mounted block devices
> > anymore.
> > 
> > A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
> > which disallows concurrent BLK_OPEN_WRITE access. When we still had the
> > bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
> > the mode was passed around. Since we managed to get rid of the bdev
> > handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
> > on whether the file was opened writable and writes to that block device
> > are blocked. That logic doesn't work because we do allow
> > BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.
> 
> I don't get it here, looks like there are no such use case. All users
> passed in BLK_OPEN_RESTRICT_WRITES together with BLK_OPEN_WRITE.

sb_open_mode() does

#define sb_open_mode(flags) \
        (BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES | \
         (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
