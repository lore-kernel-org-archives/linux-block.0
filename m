Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F537C90F;
	Thu, 25 Jun 2026 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397663; cv=none; b=F9jGwQ6Lc4KIBRCP4Y8kUHrYw/rjHHN7OoaZJPLvx9tQh00+b6ltzuVpIOyYQTC4f5eyP8UsYgvKVA5LwS74c/VZ2G8Q8iOnOBMM5lpxKvqAQ2OXqbu5ggZedZgAQayVhnl9gqpdfO2hoZLPLRfVczx7ybhPs1rhDSoA3ZY5AaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397663; c=relaxed/simple;
	bh=ZFW4dosBLC8dvONtD3Jd4AFRVI1ZPKVh5AOiqICXAIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQuswLoJgCizz+UNXnfqdr5p/1Ik4543GEt3kx50vpkaP2Lnk9VIgXqTarsBkn5uc8P0OA9kekR8bzvf6kKYvUMsl9dp/jfFFNN8LG/o0trHzHJ2D13GNdwpQU8QggRvkM9xno+eH36eqMED7T5NgKZXZXGVUrhUR/LnSyhZCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJHdVEtG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJHdVEtG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782397660; x=1813933660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZFW4dosBLC8dvONtD3Jd4AFRVI1ZPKVh5AOiqICXAIw=;
  b=GJHdVEtGQT7pHzFHTOh0fNObeKgfE9a3NQgXWJtoFgVATtEcsxL8TXwt
   WdHDZMSyr4xqinQGj0w02JG9PhufiZ8rU77qnwv7trGC8qHGqMkyFDvdq
   gsBLyWh8nlriA7fSIICytsZlQg5bNKTA75adVkpRQ6xIMksr6cy5cOH+p
   PAIeIZ+HRH+aB7X68OIb8/2L01ChmEEpOWqnhXuwK2fbUdy5uczVcW9OV
   jvoF9GGJt8hLD+e7q83Gw+KlSUBMuGHs0VF5dBYoDaYufdH6EbOHQeLg4
   z3n6EhgVv+6CSqAaEFBCxhQAlCEsvJjhlDeASL7LL1joosPi2m0JdKVcG
   Q==;
X-CSE-ConnectionGUID: ZO/TOjGbTeWS56XOEf2cNg==
X-CSE-MsgGUID: xesoJDjyRbCKf57GzukY4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93530928"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="93530928"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:27:39 -0700
X-CSE-ConnectionGUID: 5uyRYw1zT0uxyuQepMfsgQ==
X-CSE-MsgGUID: WbTJHjhUQ32wp+nmwlGAtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="280929872"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:27:37 -0700
Date: Thu, 25 Jun 2026 17:27:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Josh Law <objecting@objecting.org>, Kees Cook <kees@kernel.org>,
	Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] block: partitions: Use seq_buf_putc() in
 cmdline_partition()
Message-ID: <aj061omzs5WN5ar6@ashevche-desk.local>
References: <59dfd2ef-2fda-4dd0-a288-52c35613e778@web.de>
 <ajzkRM_RFKBpp0i5@ashevche-desk.local>
 <7de415a7-457d-4dd2-aebb-8e179fa0bbcd@web.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de415a7-457d-4dd2-aebb-8e179fa0bbcd@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 02:18:49PM +0200, Markus Elfring wrote:

...

> >>  	cmdline_parts_set(parts, disk_size, state);
> >>  	cmdline_parts_verifier(1, state);
> > 
> >> -
> >> -	seq_buf_puts(&state->pp_buf, "\n");
> >> -
> >> +	seq_buf_putc(&state->pp_buf, '\n');
> > 
> > Why did you remove blank lines?
> > 
> >>  	return 1;
> I imagine that this source code place can become a bit more succinct.
> 
> See also:
> efi_partition()
> https://elixir.bootlin.com/linux/v7.1.1/source/block/partitions/efi.c#L694-L756
> 
> Do you insist to preserve two blank lines here?

Yes.

-- 
With Best Regards,
Andy Shevchenko


