Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03465C28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D580A206D5
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 12:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgEFMnr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 08:43:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:32028 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgEFMnr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 08:43:47 -0400
IronPort-SDR: 2ZnYWWAgDoxlmTcF60RbCUjsi0aKBAj/n6XhIf14sUDRrhPwkNeCBglEWgmwZtBOcNRbss6Kym
 dCGWSCCwKWJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 05:43:46 -0700
IronPort-SDR: M9eOgZJzZ/J4P76EYMkGXjFfpxcUo7zT5zEXeEJIk67tGToXfA8ch2W4wSnnxYikJbHeBo8fAq
 AZEttApJmZrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="295323523"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 06 May 2020 05:43:42 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jWJOr-0051Js-Nc; Wed, 06 May 2020 15:43:45 +0300
Date:   Wed, 6 May 2020 15:43:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1] zcomp: Use ARRAY_SIZE() for backends list
Message-ID: <20200506124345.GI185537@smile.fi.intel.com>
References: <20200323175008.83393-1-andriy.shevchenko@linux.intel.com>
 <20200415144747.GK185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415144747.GK185537@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 15, 2020 at 05:47:47PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 23, 2020 at 07:50:08PM +0200, Andy Shevchenko wrote:
> > Instead of keeping NULL terminated array switch to use ARRAY_SIZE()
> > which helps to further clean up.
> 
> Any comments on this?

Should I do anything about this?

> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/block/zram/zcomp.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> > index 1a8564a79d8d..e78e7a2ccfd5 100644
> > --- a/drivers/block/zram/zcomp.c
> > +++ b/drivers/block/zram/zcomp.c
> > @@ -29,7 +29,6 @@ static const char * const backends[] = {
> >  #if IS_ENABLED(CONFIG_CRYPTO_ZSTD)
> >  	"zstd",
> >  #endif
> > -	NULL
> >  };
> >  
> >  static void zcomp_strm_free(struct zcomp_strm *zstrm)
> > @@ -67,7 +66,7 @@ bool zcomp_available_algorithm(const char *comp)
> >  {
> >  	int i;
> >  
> > -	i = __sysfs_match_string(backends, -1, comp);
> > +	i = sysfs_match_string(backends, comp);
> >  	if (i >= 0)
> >  		return true;
> >  
> > @@ -86,9 +85,9 @@ ssize_t zcomp_available_show(const char *comp, char *buf)
> >  {
> >  	bool known_algorithm = false;
> >  	ssize_t sz = 0;
> > -	int i = 0;
> > +	int i;
> >  
> > -	for (; backends[i]; i++) {
> > +	for (i = 0; i < ARRAY_SIZE(backends); i++) {
> >  		if (!strcmp(comp, backends[i])) {
> >  			known_algorithm = true;
> >  			sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2,
> > -- 
> > 2.25.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko


