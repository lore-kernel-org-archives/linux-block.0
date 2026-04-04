Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A017736;
	Sat,  4 Apr 2026 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775314610; cv=none; b=Emh5nmFRwt6FvyQxuNEceIG+9dcB5q3qO9ALTSTn3uefsX/gDnT2OPRYNZcv/CVq+ujeqOZSy/3w2kHE1zZslKHtnG8kqx3eiYvfUgzGXIuLIJmvL4ZjtQlfZIgJe2PKVnSxseHVNnZ+QPKWklcYBoDJxkdRyxVLutx29iwax3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775314610; c=relaxed/simple;
	bh=dYGShZFkY7WMvCEQOprEXlZRljUzeHsaXKf543GVGxY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CG/IxNI4vVqWnUQMoC/osqmrUNWexzsNXFiq0rBiM5pqeFLyVXTtyYBDhZD51Pdqfupf04d3lBTJSUBHCvccOOIkEBG21kGtcMWytJOazS75deiUGsG1M7TGdDup7SvcVkGmHATKZouSYgDuSVqE6KSFJT+Kbzdv8/toOG0B7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LiKAVH0U; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LiKAVH0U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775314609; x=1806850609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=to+dCsiAJOn5NKrXIabvJMaSZFa+wgsrBFDn7UWxqFI=;
  b=LiKAVH0UdprAFx7dmiCzhW2XKi7GPXhGWCXAiqhkkSJGc/e9aLgYwn/K
   k11U0NmcQZk8NDVDHf2lJEgWuV+dPwfzpk7lGbxsobqtSLkT+xE4P6Ydq
   Lme7J2ZVz9ewy7jfiHbwo1QPgB/KfGYm+zZo3clpa69O9VAbCnTWrx+cm
   8YNmHxhAOpgPTbjzZyPsbsIth6G1mp2fObvw3lvAPWiqm3PKPrEPNrUS7
   daE+9Uv0CHvnGKhSNvnZjsLLgAhYqRdYKGXO9tbFVfa89fZQrwTHCEDgU
   Nse9Yqj0v6CJXsJZztlPpnnfQ/kk6i/u8M1GIxvgv0NsaMlkuURH+0y/Q
   w==;
X-CSE-ConnectionGUID: +5ZFlH5tTeGrFKw0KaZtMg==
X-CSE-MsgGUID: Nrn4LLaGQ9m91P3Cd2aPOQ==
X-IronPort-AV: E=Sophos;i="6.23,159,1770595200"; 
   d="scan'208";a="16069985"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2026 14:56:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:18493]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.226:2525] with esmtp (Farcaster)
 id 2cc671a3-973e-46b3-abcc-ff6ca43b5fae; Sat, 4 Apr 2026 14:56:45 +0000 (UTC)
X-Farcaster-Flow-ID: 2cc671a3-973e-46b3-abcc-ff6ca43b5fae
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sat, 4 Apr 2026 14:56:45 +0000
Received: from c889f3b07a0a.ant.amazon.com (10.106.82.24) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sat, 4 Apr 2026 14:56:44 +0000
Date: Sat, 4 Apr 2026 15:56:41 +0100
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Yu Kuai <yukuai@fnnas.com>, Nilay Shroff <nilay@linux.ibm.com>, Ming Lei
	<ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] blk-wbt: remove WARN_ON_ONCE from
 wbt_init_enable_default()
Message-ID: <adEmqQWgtJmZy27u@c889f3b07a0a.ant.amazon.com>
References: <20260316070358.65225-2-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260316070358.65225-2-ytohnuki@amazon.com>
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, Mar 16, 2026 at 07:03:59AM +0000, Yuto Ohnuki wrote:
> wbt_init_enable_default() uses WARN_ON_ONCE to check for failures from
> wbt_alloc() and wbt_init(). However, both are expected failure paths:
> 
> - wbt_alloc() can return NULL under memory pressure (-ENOMEM)
> - wbt_init() can fail with -EBUSY if wbt is already registered
> 
> syzbot triggers this by injecting memory allocation failures during MTD
> partition creation via ioctl(BLKPG), causing a spurious warning.
> 
> wbt_init_enable_default() is a best-effort initialization called from
> blk_register_queue() with a void return type. Failure simply means the
> disk operates without writeback throttling, which is harmless.
> 
> Replace WARN_ON_ONCE with plain if-checks, consistent with how
> wbt_set_lat() in the same file already handles these failures. Add a
> pr_warn() for the wbt_init() failure to retain diagnostic information
> without triggering a full stack trace.
> 
> Reported-by: syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=71fcf20f7c1e5043d78c
> Fixes: 41afaeeda509 ("blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter")
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
> ---
> Changes in v2:
> - Add pr_warn() for wbt_init() failure as suggested by Yu Kuai
> - Link to v1: https://lore.kernel.org/all/20260315143137.13547-2-ytohnuki@amazon.com/
> ---
>  block/blk-wbt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 33006edfccd4..dcc2438ca16d 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -782,10 +782,11 @@ void wbt_init_enable_default(struct gendisk *disk)
>  		return;
>  
>  	rwb = wbt_alloc();
> -	if (WARN_ON_ONCE(!rwb))
> +	if (!rwb)
>  		return;
>  
> -	if (WARN_ON_ONCE(wbt_init(disk, rwb))) {
> +	if (wbt_init(disk, rwb)) {
> +		pr_warn("%s: failed to enable wbt\n", disk->disk_name);
>  		wbt_free(rwb);
>  		return;
>  	}
> -- 
> 2.50.1
> 
> 
> 
> 
> Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284
> 
> Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705
> 
> 
>

Gentle ping on this patch.
 
It has a Reviewed-by from Nilay Shroff and Yu Kuai.
Please let me know if there is anything else needed for this
to be applied.
 
Thank you in advance,
Yuto 



Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705



