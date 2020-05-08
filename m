Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B439C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322F920661
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 10:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEHKIe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 06:08:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:35165 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgEHKIe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 06:08:34 -0400
IronPort-SDR: W20gp/riMGD4vez1C3/idvLi1dDqe4I7JtKhDqZRZ61hOrXwYeILlSiete8lGEk57qlyv5YK0J
 MzccxMaLf0dA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 03:08:34 -0700
IronPort-SDR: LaBEY99wZfqPVTRQxfwLX78cziVA688u783dmdABXX016TuJX1PxIsiMcAAIistPVFwVD6KxoO
 S2grdGyJKz+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="285334655"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2020 03:08:32 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jWzvn-005OZK-Kh; Fri, 08 May 2020 13:08:35 +0300
Date:   Fri, 8 May 2020 13:08:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1] zcomp: Use ARRAY_SIZE() for backends list
Message-ID: <20200508100835.GE185537@smile.fi.intel.com>
References: <20200323175008.83393-1-andriy.shevchenko@linux.intel.com>
 <20200415144747.GK185537@smile.fi.intel.com>
 <20200508053040.GB197378@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508053040.GB197378@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 10:30:40PM -0700, Minchan Kim wrote:
> On Wed, Apr 15, 2020 at 05:47:47PM +0300, Andy Shevchenko wrote:
> > On Mon, Mar 23, 2020 at 07:50:08PM +0200, Andy Shevchenko wrote:
> > > Instead of keeping NULL terminated array switch to use ARRAY_SIZE()
> > > which helps to further clean up.
> > 
> > Any comments on this?
> 
> Acked-by: Minchan Kim <minchan@kernel.org>

Thanks!

> Sorry for the late. I lost this patch in my mail box. Could you resend
> this patch with Ccing Andrew Morton and Sergey Senozhatsky with me?

Done.

-- 
With Best Regards,
Andy Shevchenko


