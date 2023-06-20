Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9026CEB64DB
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 13:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjFTNZk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjFTNZ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 09:25:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560EB1728;
        Tue, 20 Jun 2023 06:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687267492; x=1718803492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WcFZ4/tRnJKwxlpGE9cxvnBgRWirStOXaEKgqBUM2Fc=;
  b=b/XzDVfWsIuqVF+NZPQzShlZh6DF8aTUI2hM6zDVsTMT6gIKRow/ouZo
   rGFX+SE8GIYD/zbOHJqBYLTogemGAexVRVIKN+TyTY3Xe1jHI+nQsB0xp
   wGZR0bgiXca01H2Nv4QSqe9Kw/S7ZVaUBl5+RxYdx7jRm64nHerzvleW4
   8IcHc3AcP93gty5fQ3Z2HJ1QFdfEkaO9BuOQY2YfD7K/k4O2gxVe/MIM4
   yG/gQFSx6hPPd+DczWarM+8mnHGYaZ31XMIrEzIjS40mcM9gTXFzEnr6b
   2ZTeNN2sU1DoKqFjn6wVelIOY7A8uhg9VsoB3txS80lHp6Yi1Ts3EKr7x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446230259"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="446230259"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664284550"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="664284550"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 20 Jun 2023 06:24:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBbLk-005ExW-1m;
        Tue, 20 Jun 2023 16:24:48 +0300
Date:   Tue, 20 Jun 2023 16:24:48 +0300
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] pktcdvd: Use clamp_val() instead of min()+max()
Message-ID: <ZJGooPbZQq6G2BjI@smile.fi.intel.com>
References: <20230616142614.36206-1-andriy.shevchenko@linux.intel.com>
 <9258be5d31104805b63bb1a64317a448@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9258be5d31104805b63bb1a64317a448@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 20, 2023 at 12:06:49PM +0000, David Laight wrote:

...

> > +		*hi = clamp_val(*hi, 500, 1000000);
> 
> (standard rant about minmax.h)
> 
> clamp_val() is pretty much broken by design.
> It MIGHT be ok here but it casts both limits to the
> type of the value being compared.
> In general that is just plain wrong.
> 
> Like min_t() it is generally ok because the kernel only uses
> unsigned values between 0 and MAXINT.
> 
> If min/max were ok, then using clamp() should also be ok.

Submit a patch to fix it, if you think you can make it better.
Obviously your comment can be addressed separately if we even
need that.

-- 
With Best Regards,
Andy Shevchenko


