Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E1251793
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499468; cv=none; b=VS9J8GVZIYzVCzmBTDc98c0Pl6p8uypzUiA+sfrIsImlAJ1Ev4diSHejPDvAcgVJFrOHTSpi9/2gLibdUHusfBRhHoLoxgo990X3hHoaDRXv+rUVIbGFpvXOJYJkNDB6g0xnbt+759DNzYnDk9E220iGpiQkBMVwE0zR1h6ByN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499468; c=relaxed/simple;
	bh=wh56+5NSQldtgWh3JEdDK2PAfE+A0U78RdObXirV5ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zblv8izE6hS3c65fcK5eVL47DAczYB4tIZ0/Zint0zxg2igMMqmNh9ga12xuhI7BvCb/a2MH10dWl9pX11MzM/nCui4/L+4tc4EEqBnC08h75Ac2KO7PLpTiqRXwr2NnLfnWKScWCw1b56Ci6VCzt70K6cpH3W9OGzvinC5+ZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DoHGCDv+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DoHGCDv+"
Received: from trampoline.thunk.org (pool-108-26-156-88.bstnma.fios.verizon.net [108.26.156.88])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56EDO7e7018267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 09:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752499449; bh=Yortp8DQM9h5jDV4ktt5QS/yckQSk8w9yRRz0+aBy+M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DoHGCDv+9rVd2QhBf+0OhoGjwL2U2lmnZSH52o3YUvcZ6qr3TxSlyLmoBycjlgtuB
	 WNc6hlhXqqdKC1c7/Xk3EYFyXXY9y1ynDrLeYfMd4PilNwa2R39BiTv4Qculs5q0Fg
	 p27zYogMsXy3Hwx/WvnXUKsfcnwZ589FnCVrxUvuFyO3LR3LRCVRTaaLusvekH95i4
	 1whCZhhWHetpFI9k/JHoiX4IPhT52CP0Jr/LCkEfMz+99ORY5C6lDnXIFPd9YSNqUX
	 Bjh8wr8NByRGkVFNm+oOxa5tZEFg5j++MBNNjAT+OSPFa9Fd0MIxsA/E67iaVq5c2v
	 6XMnJA7EKO9Xw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 30C412E00D5; Mon, 14 Jul 2025 09:24:07 -0400 (EDT)
Date: Mon, 14 Jul 2025 09:24:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250714132407.GC41071@mit.edu>
References: <20250714131713.GA8742@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714131713.GA8742@lst.de>

On Mon, Jul 14, 2025 at 03:17:13PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> I'm currently trying to sort out the nvme atomics limits mess, and
> between that, the lack of a atomic write command in nvme, and the
> overall degrading quality of cheap consumer nvme devices I'm starting
> to free really uneasy about XFS using hardware atomics by default without
> an explicit opt-in, as broken atomics implementations will lead to
> really subtle data corruption.
> 
> Is is just me, or would it be a good idea to require an explicit
> opt-in to user hardware atomics?

How common do we think broken atomics implementations; is this
something that we could solve using a blacklist of broken devices?

It used to be the case that broken flash devices would get bricked
when trim commands would get sent racing with write requests.  But
over time, the broken devices died out (in some cases, when the
companies selling the broken SSD's died out :-).  It would have been
annoying if we had to explicitly enable trim support in 2025 just
because there were some broken SSD's existed a decade or more ago.

	       	  	      	      - Ted
