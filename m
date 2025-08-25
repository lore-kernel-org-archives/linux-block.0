Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895431F461D;
	Mon, 25 Aug 2025 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119424; cv=none; b=I7uOiuzHd6GZBxWOL7EXm/Lc9uOK8TBcQZJKyeAf50BtsTJKocUJU7B0udhtEljOkr31jZcOejn17x9SorDGB5336ZQTGi0wtTPT+xxjpiSc2MGvZMA2LMzOPFPxwgSbf3QsWyaRZvulTXexIr8zNIAnCanuPptL6KcY6ozDgWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119424; c=relaxed/simple;
	bh=35MhAoHiu7MIpB/ExWo2dwB356FS35wrYSoaNynDcw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS7OL+5bmQlOa1wus8I2RaHYO8Ixml4xNthpY6vdTeKPrXEfMjot6PLu+V4/1K2IVSMhVveEG5tQTbmubNxeKMozkugS+5H0D8JufZHC0JEQn3fo3Lt/6bPe4TsU0AZpAQJfcmd+hQS2/rRp5DXjOLFr4eorC8cSoJpRbz7irVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBLcC+8T; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBLcC+8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756119422; x=1787655422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=35MhAoHiu7MIpB/ExWo2dwB356FS35wrYSoaNynDcw0=;
  b=RBLcC+8Tn78BZ30welEe/ELopPQtqKZOh6blIWQ6W5KTRMRBUHu2RiTm
   JqdA5c1JppPwAzqm1NdjjekB94SrFl/62WfP/elN+D0TpVjpD2FogwBh3
   OOtfSMfjaicYgZUFJe8hQgxUCoJ8dnmTaFQgryzZBJgG3afw86NCMSlN6
   oiDBGCOIpmBJ6aiwajnApiXXnBAIFHW3NtFk+yd4t9Ifgl0aXQiYwC0Zk
   NsPfZbcFKhlRWIw47xO4+f8HsA8rvgPS3oTuOUTrGZcKH/Me1IlKbEWxd
   fEix6bFtVgNWYanQ0CkvtoZkvDpi/9WAsyJRALWfm09ipVNeTYEbZebpd
   A==;
X-CSE-ConnectionGUID: 5wXeGEdZTWireiIC1jdYqw==
X-CSE-MsgGUID: wEx7PtXIRzOOLSxAaJLSJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="45902335"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="45902335"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 03:57:02 -0700
X-CSE-ConnectionGUID: c+/S0nsdRNePn5wMFI8eZg==
X-CSE-MsgGUID: O9pyoXlqQOusP80PnhHcWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="200207613"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 03:56:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uqUsh-00000008TWO-486z;
	Mon, 25 Aug 2025 13:56:55 +0300
Date: Mon, 25 Aug 2025 13:56:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: axboe@kernel.dk, phasta@kernel.org, broonie@kernel.org,
	lizetao1@huawei.com, viro@zeniv.linux.org.uk,
	fourier.thomas@gmail.com, anuj20.g@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: mtip32xx: Prioritize state cleanup over memory
 freeing in the mtip_pci_probe error path.
Message-ID: <aKxBd1uFldjopX3T@smile.fi.intel.com>
References: <20250823083222.3137817-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823083222.3137817-1-zhangheng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 23, 2025 at 04:32:22PM +0800, Zhang Heng wrote:
> The original sequence kfree(dd); pci_set_drvdata(pdev, NULL); creates a
> theoretical race condition window. Between these two calls, the pci_dev
> structure retains a dangling pointer to the already-freed device private
> data (dd). Any concurrent access to the drvdata (e.g., from an interrupt
> handler or an unexpected call to remove) would lead to a use-after-free
> kernel oops.
> 
> Changes made:
> 1. `pci_set_drvdata(pdev, NULL);` - First, atomically sever the link
> from the pci_dev.
> 2. `kfree(dd);` - Then, safely free the private memory.
> 
> This ensures the kernel state is always consistent before resources
> are released, adhering to defensive programming principles.

...

>  iomap_err:
> -	kfree(dd);
>  	pci_set_drvdata(pdev, NULL);
> -	return rv;
> +	kfree(dd);

These two seems to me unrelated. How do you possible have a race? What's racy
there? (Yes, I have read the commit message, but I fail to see how it may lead
to anything here. My question in one of the previous patches was about needless
pci_set_drvdata() call. Do we even need that one?

>  done:
>  	return rv;

-- 
With Best Regards,
Andy Shevchenko


