Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F591E2838
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967494; cv=none; b=dnd1Ft61RKD+4ho5cmzUNJGRdSkCqH3Dp04KIvrdnvPGV7DtcVtfy/25hdk4TVxNhWB5tt+T3ebAjUusHzvw3jCMWSWLyBudlZvrl6YS+jDPqqzBiSylsxHJwGXAiL1WOX4HlrZ5AGfe6HqEK4uC8ZqZLNtA6KckS8YSNTA5e+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967494; c=relaxed/simple;
	bh=eGSqzBlgJtyGwKfHlLMl/4aUgIxMeyvHHU67qG1cZKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqL+DWTDKH+bhjcwdp74N7KQ5e1bQK+P6A7uAHG0h2vzPhA8C5UStYWnpdHNFnTVs/ho0gT0g2M7SAvt2UfgM+X2w7Z7Qw+AbcOeamR1Y0WYnBBtbiOUxT5IBYNl/td7ReLqpFji7ZKWEi5cjNjW7U0jmu4mzzs8L0P7Q/ousBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlBvHc0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlBvHc0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0955C4CEED;
	Tue,  8 Jul 2025 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751967493;
	bh=eGSqzBlgJtyGwKfHlLMl/4aUgIxMeyvHHU67qG1cZKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlBvHc0ePW+GsEM4s1HqYb1AXGKJqczxyp/O2dKo1T/q2DmqKJZFIeRBt0AfAflno
	 2Ss/Lpdz9s5AbKV7rQCbnJt3ZptOohf1Kbz+QKx7I3XG26kvWf54tefTETCWpUYqie
	 XBLZIdfv4g/n++W5I8rp2ssAZ8gyODMLIKVCzj1doomadtkLJQgS3a1j4eCCcv9JuI
	 Vew3hLnWrSGi4/tggZp914KVc9j85wgcr/rrmkKIejOxnjf/6vs8X7ysSeEHFoPYYG
	 vNpaOGXL9pTJCTeBtFSN2tw/tetr+cxugLfMAox4ODMyhpLkI9UXC3YaakO7sesE47
	 nH/3KrDk1Z4xQ==
Date: Tue, 8 Jul 2025 11:38:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGznAUVxSl5_Xa3E@ryzen>
References: <20250707141834.GA30198@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707141834.GA30198@lst.de>

On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> 
> As a short reminder the main issues are:
> 
>  1) there is no flag on a command to request atomic (aka non-torn)
>     behavior, instead writes adhering to the atomicy requirements will
>     never be torn, and writes not adhering them can be torn any time.
>     This differs from SCSI where atomic writes have to be be explicitly
>     requested and fail when they can't be satisfied
>  2) the original way to indicate the main atomicy limit is the AWUPF
>     field, which is in Identify Controller, but specified in logical
>     blocks which only exist at a namespace layer.  This a) lead to
>     various problems because the limit is a mess when namespace have
>     different logical block sizes, and it b) also causes additional
>     issues because NVMe allows it to be different for different
>     controllers in the same subsystem.
> 
> Commit 8695f060a029 added some sanity checks to deal with issue 2b,
> but we kept running into more issues with it.  Partially because
> the check wasn't quite correct, but also because we've gotten
> reports of controllers that change the AWUPF value when reformatting
> namespaces to deal with issue 2a.
> 
> And I'm a bit lost on what to do here.
> 
> We could:
> 
>  I.	 revert the check and the subsequent fixup.  If you really want
>          to use the nvme atomics you already better pray a lot anyway
> 	 due to issue 1)
>  II.	 limit the check to multi-controller subsystems
>  III.	 don't allow atomics on controllers that only report AWUPF and
>  	 limit support to controllers that support that more sanely
> 	 defined NAWUPF

I like III.

But NVMe should probably push to deprecate AUWPF, and introduce a new field
that is like AUWPF but which is specified in a fixed unit, e.g. bytes or
CAP.MPSMIN. (I'm thinking of e.g. Zone Append Size Limit (ZASL) which is also
a per controller limit, but the value is specified in units of CAP.MPSMIN,
just like the Maximum Data Transfer Size (MDTS).)


Kind regards,
Niklas
