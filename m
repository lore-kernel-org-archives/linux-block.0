Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046D1E522
	for <linux-block@vger.kernel.org>; Sat, 23 Mar 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711209588; cv=none; b=GW6ZHMkFIcG4pBD9SchILwD4OsugmRNXQu7NaqPNOnT0bapu1/9mhjhp85bpAnFumNM8K2g4+gOeXoJ3/i9HUwkTtnj8WgqIR/WM/XfQJVHXILgXbec6cIkPBEtIUGZgd9Dck1J021Wug6WIW0s0IzKS/fuM2n23GTyqeVtiBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711209588; c=relaxed/simple;
	bh=Er8Zorsu3yznwKL+BOHYNWy2+y4yjMnWFV4xNCpSdDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVxOLc4q/HawI2B9/YIachQOyfOXa5JES+BTzFWOsVaaaNkmrGR7HULsojOgcrB7zwPWBpnyqLc/3y7ROkl06yVpXhUFmJRURqSXrYcym1jOmWf/JbFELXoN37st/oE1fN+NyeQk0xAnsZyzahGt79VwI6piJWCGIUcJwDPsC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/n8YbDS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/n8YbDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16386C433C7;
	Sat, 23 Mar 2024 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711209587;
	bh=Er8Zorsu3yznwKL+BOHYNWy2+y4yjMnWFV4xNCpSdDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/n8YbDSCtijPEt1KNBnVlPaZN0XitYNNourUJd7yfseiEkYfQtLAP1Rlkc+dKqqu
	 ZzQmgyM9v3s9y9mWdLg6zP1vNpCtO6Rf6xcNaOWRFA4S705D+xfDeVrEmaXm1+OOtI
	 4osYauuNrpdRlslpEyxG7+w0WoH0FUXts3n1qAazwHhBSIHPn3q8BCyw/zlp5sjevD
	 oTD8hF1hKNVqglBSj/Wq2xU4ewoYW7VrHifTOndoITDBH/4JCyXHONRWrFuj45Nyy3
	 7SOY6C/ScEkU9F+aFpCBlv6YMbY1Kk4NkR2rT7QnamgKp5V2BXh03ngtupA4VG2Ab0
	 PX1z4CxegiZ+Q==
Date: Sat, 23 Mar 2024 16:59:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <20240323-hingabe-burganlage-ae4a22611a71@brauner>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240323-seide-erbrachten-5c60873fadc1@brauner>

> +	/*
> +	 * If this was an exclusive open and writes are blocked
> +	 * we know that we're the ones who blocked them.
> +	 */
> +	if (bdev_file->private_data && bdev_writes_blocked(bdev))

This doesn't work because this will unblock BLK_OPEN_RESTRICT_WRITES
when the block device has been opened read-only but exclusively, i.e.,
when e.g., userspace requested read-only access and we use the file as
the holder. I have an alternative fix.
