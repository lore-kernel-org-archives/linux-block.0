Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9639531B80E
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063836; cv=none; b=uZjw5aB7bv8vs7DniY80/2FQpnWbjvbCPP5J6gDyeZGL231ThrQ/uRBZxv84+7tla+3OqEI6At0h+bLqZ/wkbkg7Zrk1g03j24QM5qFCIScICNX+FvX48MYcvSp2H1eZmffQf7QTrgH4ogH6VPZrxkAyRhvvEQmRSmGOcQM0g0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063836; c=relaxed/simple;
	bh=nNEJPepne5vo/Km41q7xMClCHnXdqahflL44Je+Zj08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO5HqdYm/+6UpgxqlK+AS56d0ADBYJrIZ0ldjmJFMYxgYkk/JD4O8/Ot47Qwrg6I3VB6Bb+UnEE+57MVPyccdQo9EdgrXi+P05Oqy9KOcyZg0ietBNT4rq2d/sM6iqInMVJqVpnm6szb5HV4sjXn7ram8V9qKHKU2K8b3KRhJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MytsXkUC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MytsXkUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CEEC4CEF7;
	Thu, 13 Nov 2025 19:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063835;
	bh=nNEJPepne5vo/Km41q7xMClCHnXdqahflL44Je+Zj08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MytsXkUCYzigtmfhEnAyghO/BhmqHW8T5GCbaHEFmzfky/WFJFcOtDm6Zq4ZdNZs7
	 ud2t+lGyUrpzeSingmtLdjJtvxbBxMx4eaHO6QEgVUiZ/VC9WjqS9MBqqJosSpGjzI
	 kNmK+YCp9pvEHL3LTI8Bblba1rWDPnBOMPnKtlSDPZlPm7rVoyL/0M8Ybr1dq/HUag
	 KCaAmfVuuJqEJ/sBiiJEs1CQrCvSTCcmSQcsWppo39ZNit5CFdEcVoCX20uzR4Yv+G
	 U2WyUIGVj8+0cS/D1ADUEl5nR6nmv/5M423rERt+ve0pyi7aDfD5croYFqomY7M0Pr
	 9giOG1dNvD3Ww==
Date: Thu, 13 Nov 2025 14:57:12 -0500
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCHv4] blk-integrity: support arbitrary buffer alignment
Message-ID: <aRY4GGA9adVhecvh@kbusch-mbp>
References: <20251113152621.2183637-1-kbusch@meta.com>
 <20251113173135.GD1792@sol>
 <aRYf9S-UuJqa37fi@kbusch-mbp>
 <20251113192022.GA3971299@google.com>
 <aRY2G6xEgEVqLBgb@kbusch-mbp>
 <yq1pl9ld7y1.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1pl9ld7y1.fsf@ca-mkp.ca.oracle.com>

On Thu, Nov 13, 2025 at 02:55:55PM -0500, Martin K. Petersen wrote:
> 
> Keith,
> 
> > Like on real hardware? I'm a bit at a loss as to how, I've never seen
> > anything subscribe to this format, not even in emulation.
> 
> # modinfo scsi_debug | grep guard
> parm:           guard:protection checksum: 0=crc, 1=ip (def=0) (uint)

Awesome, thanks for the pointer. I'll give this a try.
