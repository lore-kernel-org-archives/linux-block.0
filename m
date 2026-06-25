Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49DA374A17;
	Thu, 25 Jun 2026 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375502; cv=none; b=VGFcQaazey8z3ld+C0lXdFJu6uo+zA/+N8I6/FzxwkqwjGF7ihxDDbckPIzayVvnpkjzkZQlLcorV+b0jEqbF1fbeYiIWzW65wROAr7oD63cxfjS97XklCe98zShqkqUqZpYN+vGJwfsZb2L4nBcrldbtUKHH+hd/VfGjBKi0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375502; c=relaxed/simple;
	bh=PGF7rc7WAMMkprfuJLyR4MRE2GHNSb8PCviVLiFyURc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lo8B/R6RvWy9vD+1sUwwK6BcwOYLUWmZYDf6ijAZZ3BFL8Mi7vbddPJ6SIHIXDIbSZf0byjcqKP6fZBoerzfomlbR/gWFAvY1VcZFiMVzilvvfM2piVMbynPGMFoYdKoPr87VZK9uTnsb4wDK+uhsiQmXdocSft9URulHJRoVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5r+Dmj7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5r+Dmj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782375500; x=1813911500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PGF7rc7WAMMkprfuJLyR4MRE2GHNSb8PCviVLiFyURc=;
  b=c5r+Dmj7lMMqWa+ro6PfK7u9dxf13aktTGQ4sHzPLGfWhx9f4+Q4jCMA
   I7q3hAwGpucgOksEWVmUd9IAr+jLfinkdmtIQSunugTorVjh66idpGi6Z
   ieM5sfXMW/t7sxxf23kZRPkzCyZKCUV9IgJFWZtbhiWEiwUsxtgpAlofF
   4Z++1Sf5X5la5kHwFrmPD2PudHUE/SAbEUxY2z9yqswqjHthZ34avIBwb
   8A3zLPzj3XoyfOug39DbviIZco/ZVn6IA7CyXXuRRtiY9xO99ozhuUQR7
   dOHFni28KTqb6wwdSXJXX4tXaFw+y6dazHvEGZqXBFD/cQHUO6gDrr/92
   A==;
X-CSE-ConnectionGUID: MqIhkuCeSmei00PJE4/Pnw==
X-CSE-MsgGUID: SaLQWEk5Q8eEvfTaLXotqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93750312"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="93750312"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 01:18:19 -0700
X-CSE-ConnectionGUID: +BvIoKn1QHSPpkSseyThiQ==
X-CSE-MsgGUID: FjpjC4zCQo6N5WiClMNcdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="249453488"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 01:18:15 -0700
Date: Thu, 25 Jun 2026 11:18:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Josh Law <objecting@objecting.org>, Kees Cook <kees@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
Subject: Re: [PATCH] block: partitions: Use seq_buf_putc() in
 cmdline_partition()
Message-ID: <ajzkRM_RFKBpp0i5@ashevche-desk.local>
References: <59dfd2ef-2fda-4dd0-a288-52c35613e778@web.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59dfd2ef-2fda-4dd0-a288-52c35613e778@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 10:08:01AM +0200, Markus Elfring wrote:
> 
> A single line break should be put into a sequence buffer.
> Thus use the corresponding function “seq_buf_putc”.

“seq_buf_putc()”.

> The source code was transformed by using the Coccinelle software.

...

>  	cmdline_parts_set(parts, disk_size, state);
>  	cmdline_parts_verifier(1, state);

> -
> -	seq_buf_puts(&state->pp_buf, "\n");
> -
> +	seq_buf_putc(&state->pp_buf, '\n');

Why did you remove blank lines?

>  	return 1;

-- 
With Best Regards,
Andy Shevchenko


