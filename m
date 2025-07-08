Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319622332E
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987974; cv=none; b=KPtSPly0JC2uEd+o/C4k73aL/yOB5zg8tPWuBXBCN+p75pRDk8GaJ+Xtl4WiJ3ne4s7ky7bW04sBDSaZz3EKpIOhP53B+H499llczJiqBU+Vftz7XaDQPwZD5M5E7sEG0q8UEAVo/c+Go5K+rwROUXN+9WpCTQU/CQFWiMfl+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987974; c=relaxed/simple;
	bh=8DQsrgvQi7kSBbdxmjyQivePr825j0lx1nkfT/q8/a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cB62swF5Exddpm6O5FjFdmGHOtLgx85uKJjWxBRj7CKxZQGzESNs8Y5QcyBpjY/gbklhFFGb3Q9RksG8JALwr56lmEVbWz7UR2ZYDeRXDDRkpJFK2b2FRkI/+IDK0vh5+Qt9qih1bFyV0F4W/tbrAv+9TxXQ+Ooe5+CAPeZHZLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9CnsbrP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9CnsbrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E232C4CEED;
	Tue,  8 Jul 2025 15:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751987974;
	bh=8DQsrgvQi7kSBbdxmjyQivePr825j0lx1nkfT/q8/a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9CnsbrPXZqNEd7AFivWGneCYJczJJ3d484wQkrWGdji8N4Mr8v3pB7dIMLgBIpGK
	 yDh7QtVsY2VwqESKRjjNShxxVXZFThupqg1xPCGcpT4MZ6zUKh4NhyjHvFer+oBqVY
	 fjGkBqTxONx340cZz6/mYwOeWtTzugzBNdLzKckAxZ9dlqhKgZukSeOBETFrX1xXHX
	 mhAIaadtdxKIlEcFKGH8kbxb736KrwjrzZ4pcKJV/JmWy3tSzoUXxfAgcSVhGM8h5f
	 wj0QFPS/JwSHsuinoKZXFBO5fY6nZ3hE9jzJcPXGnuI4hc7StPEGvIZRSx2ISjQqiR
	 9TeZRlZyhImEA==
Date: Tue, 8 Jul 2025 09:19:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aG03BKRk7O5JfVtN@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
 <aGvYnMciN_IZC65Z@kbusch-mbp>
 <b2ff30b5-5f12-4276-876d-81a8b2f180c1@suse.de>
 <aGvuRS8VmC0JXAR3@kbusch-mbp>
 <20250708094748.GB27634@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708094748.GB27634@lst.de>

On Tue, Jul 08, 2025 at 11:47:48AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 07, 2025 at 09:56:53AM -0600, Keith Busch wrote:
> > Just to throw AWUPF a lifeline for legecy devices, we could potentially
> > make sense of the value if Identify Controller says:
> > 
> >   1. CMIC == 0; and
> >   2. OACS.NMS == 0; and
> 
> What is NMS meant to say?  namespace management support?

Right, namespace management support. The spec calls this field 'NMS' now.
 
> >   3.
> >     a. FNA.FNS == 1; or
> >     b. NN == 1
> > 
> > And if those conditions are true, then the controller and namespace
> > scopes resolve to a single namespace format, so the values should be one
> > in the same. The only way it could change, then, is a format command,
> > which means there couldn't be an in-use filesystem depending on it not
> > changing.
> 
> We could.  But are there many controllers where that would be the
> case and where people want to use atomics?

Maybe not. I still have a lot of 1.0 compliant devices where this might
apply, but I don't have a use case explicitly needing the atomic write
features anyway, so it doesn't matter to me if the driver doesn't report
the limits for them.

So I guess no need to work with such devices at this point, but maybe
just something to consider in the unlikely event someone complains.
