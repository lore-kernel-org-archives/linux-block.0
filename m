Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4B6C433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 10:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36668208D5
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 10:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgFRK5l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:57:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:23989 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgFRK5i (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 06:57:38 -0400
IronPort-SDR: 0EQH5mH4SK8CxXbCql65aQRIAuZMSQ9LlgjGchvWjTArJ8ydiLWgHg5rglKkXbRsTQ+Kd7yY6R
 b8twL+02h7gA==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="160624922"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="160624922"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 03:57:37 -0700
IronPort-SDR: KQ0bRVV6HMcoWi2oVOho9W59xLvJCUtlMWa9SSzfZ+ITr8bmhv6m0O4wBNRwxQjb5qkoFSOWK5
 nMwo/yjuT+lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="263568748"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2020 03:57:36 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jlsEl-00EFae-68; Thu, 18 Jun 2020 13:57:39 +0300
Date:   Thu, 18 Jun 2020 13:57:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH v1] partitions/ldm: Replace uuid_copy() with
 import_uuid() where it makes sense
Message-ID: <20200618105739.GQ2428291@smile.fi.intel.com>
References: <20200422130317.38683-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422130317.38683-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 22, 2020 at 04:03:17PM +0300, Andy Shevchenko wrote:
> There is a specific API to treat raw data as UUID, i.e. import_uuid().
> Use it instead of uuid_copy() with explicit casting.

Any comment on this?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  block/partitions/ldm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
> index 6fdfcb40c537b..d333786b5c7eb 100644
> --- a/block/partitions/ldm.c
> +++ b/block/partitions/ldm.c
> @@ -910,7 +910,7 @@ static bool ldm_parse_dsk4 (const u8 *buffer, int buflen, struct vblk *vb)
>  		return false;
>  
>  	disk = &vb->vblk.disk;
> -	uuid_copy(&disk->disk_id, (uuid_t *)(buffer + 0x18 + r_name));
> +	import_uuid(&disk->disk_id, buffer + 0x18 + r_name);
>  	return true;
>  }
>  
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


