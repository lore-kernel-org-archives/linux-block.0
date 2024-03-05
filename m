Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD44537F8
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645907; cv=none; b=pmah07xlT9kgJrGD36kt1E7AJsHkveCaFZmKyaldN7QGB547kWYo13jYGmho/4ZK7q91KxnH1J9BKP7S2mCan8TKLv02YfOASgDwvv0E3XnptoKunVq37G7kYS+w83hnIWhP+oVK81uCZNAsXknbTg4jYh3/7PTN7Qlt78muztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645907; c=relaxed/simple;
	bh=HRTDo3YTOjNYxUYE9kfF0aUTx7bTnnuzdnYbe3GKqgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6j1zgJvdyxcbyufoCqs+ARc5oe+PixetoBzLUHGFOj9NZNNexQiniX6LJkulyukBmYCL2HfD2AQ85XSKW4qN03NiVxaBq/obQfNjROAExpCkwA6kO6rA/Ca/2YfTanTh+bdTWaya9aW8J2ElqJ+UGN6SD5qPIjGV20am+1oCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 546B468D07; Tue,  5 Mar 2024 14:38:13 +0100 (CET)
Date: Tue, 5 Mar 2024 14:38:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: Re: drbd queue limits conversion ping
Message-ID: <20240305133812.GA1345@lst.de>
References: <20240226103004.281412-1-hch@lst.de> <20240226103004.281412-11-hch@lst.de> <20240303151438.GB27512@lst.de> <CADGDV=XqJ_3biGx-rX0jMMue4-dTg=J8NjyHOU-Ufonv4QiJ-A@mail.gmail.com> <CADGDV=WJWZHj89rebvNJ2BOhuqG=_Nr5S3+QXp6LTEGGKyzuKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGDV=WJWZHj89rebvNJ2BOhuqG=_Nr5S3+QXp6LTEGGKyzuKQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 05, 2024 at 10:39:55AM +0100, Philipp Reisner wrote:
> Christoph,
> 
> we are fine with the queue limit conversion as you did it. Lars and I
> reviewed it, and Christoph ran the tests. All fine.

Can you provide formal Reviewed-by and Tested-by tags?  I'll resend the
patches standalone, maybe reply to those.

