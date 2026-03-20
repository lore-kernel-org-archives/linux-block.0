Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301236073E;
	Fri, 20 Mar 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001592; cv=none; b=GAz+Pf+6IYoNGUpGCn+fmxiAWpbKrNst2VNUORXDLEm5bwpAa2c0YnemiG0D+qOoVdfwD0992RIcFJFkqMq1+Ryxwq3PcVft7JEuzX3JVSVj5xztLzpEVtOKndCOQcCqbqlz4PyxPun/fmQD7FrceibjG8iZ6ovL+f8MCjlZdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001592; c=relaxed/simple;
	bh=dX+eT7xvufDx1jKCPAj5RDUzINyOG4OSSznMMJIff9c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjebQmpgy67+LnYvjJJWy28JoI6wAqMDpR6zjB1u8zuLf4d72J05WNunPhMBRwNj2XIpSqZylpoKCzylwTqyKw+yz0JscgP1PxMuLTQcIiiMLz0zr9dcNfdbN5mWufYM5TSWj6ioPQDZ5hcDDmoLA1e9FDtnu9S9/aGIIU8Av3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LMZXOl7K; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LMZXOl7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1774001591; x=1805537591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TlMYjIuu/LHL8EiAYGeh75q8FapIgkSOCVkmR5FeWfo=;
  b=LMZXOl7K1NFJmtvVr1OjXnw4vRTAA8726IlmXovQMNQsfFtjB1PDwESb
   qQvt0CrsplyJMWHA16Cg7qXomONIXLTTlziufC0XXpc7F2e+geQcH4dcL
   oMG6S7Tu89FqKch/wrDWE/RmCsFpQa05pYOr0ao8DdaVIGPy/39Y+Qnuo
   hnINGOps9hBF9LDckXYvyAIW/PG5sCgn3cU3ssvcGqIyMyQwFlT31lcFe
   tt6sJJRrzv9KVAiksK5JEY20o+5maB3ihIi3yuMmO6TcUen5UntoMKO3S
   QuzpNT/0aHPi8u7Z50fFaEVuwjID80ADJCNNPMrCHPWIyWwco8nAMGsGC
   w==;
X-CSE-ConnectionGUID: OsL1spoJSlCWOquU4ifXsg==
X-CSE-MsgGUID: 81koqMNuTMO2Qf8d91a+iA==
X-IronPort-AV: E=Sophos;i="6.23,130,1770595200"; 
   d="scan'208";a="15233012"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:13:06 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:30292]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.27:2525] with esmtp (Farcaster)
 id 6358c2a7-38f7-4912-88b8-933743ac20ff; Fri, 20 Mar 2026 10:13:06 +0000 (UTC)
X-Farcaster-Flow-ID: 6358c2a7-38f7-4912-88b8-933743ac20ff
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 20 Mar 2026 10:13:06 +0000
Received: from c889f3b07a0a (10.106.83.32) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 20 Mar 2026
 10:13:04 +0000
Date: Fri, 20 Mar 2026 10:13:01 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] fs: remove stale and duplicate forward declarations
Message-ID: <ab0drSuEZJ2WC_RJ@c889f3b07a0a>
References: <20260226201857.27310-2-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260226201857.27310-2-ytohnuki@amazon.com>
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, Feb 26, 2026 at 08:18:58PM +0000, Yuto Ohnuki wrote:
> Remove the following unnecessary forward declarations from fs.h, which
> improves maintainability.
> 
> - struct hd_geometry: became unused in fs.h when
>   block_device_operations was moved to blkdev.h in commit 08f858512151
>   ("[PATCH] move block_device_operations to blkdev.h"). The forward
>   declaration is now added to blkdev.h where it is actually used.
> 
> - struct iovec: became unused when aio_read/aio_write were removed in
>   commit 8436318205b9 ("->aio_read and ->aio_write removed")
> 
> - struct iov_iter: duplicate forward declaration. This removes the
>   redundant second declaration, added in commit 293bc9822fa9
>   ("new methods: ->read_iter() and ->write_iter()")
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512301303.s7YWTZHA-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512302139.Wl0soAlz-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512302105.pmzYfmcV-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512302125.FNgHwu5z-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512302108.nIV8r5ES-lkp@intel.com/
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
> ---
> Changes in v2:
> - Add forward declaration of struct hd_geometry to blkdev.h to fix
>   build errors reported by kernel test robot.
> - Verified with allmodconfig build and all configs reported by 
>   kernel test robot.
> 
> v1: https://lore.kernel.org/lkml/20251229071401.98146-1-ytohnuki@amazon.com/
> ---
>  include/linux/blkdev.h | 1 +
>  include/linux/fs.h     | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d463b9b5a0a5..0b5942e08754 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -38,6 +38,7 @@ struct blk_flush_queue;
>  struct kiocb;
>  struct pr_ops;
>  struct rq_qos;
> +struct hd_geometry;
>  struct blk_report_zones_args;
>  struct blk_queue_stats;
>  struct blk_stat_callback;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8b3dd145b25e..75c97faf8799 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -55,8 +55,6 @@ struct bdi_writeback;
>  struct bio;
>  struct io_comp_batch;
>  struct fiemap_extent_info;
> -struct hd_geometry;
> -struct iovec;
>  struct kiocb;
>  struct kobject;
>  struct pipe_inode_info;
> @@ -1917,7 +1915,6 @@ struct dir_context {
>   */
>  #define COPY_FILE_SPLICE		(1 << 0)
>  
> -struct iov_iter;
>  struct io_uring_cmd;
>  struct offset_ctx;
>  
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

It has a Reviewed-by from Jan Kara.
Please let me know if there is anythins else needed for this
to be applied.

Thanks,
Yuto 



Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705



