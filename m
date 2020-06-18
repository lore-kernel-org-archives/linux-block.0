Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABEAC433E1
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 10:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2FA62186A
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 10:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgFRK55 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:57:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:52713 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbgFRK5z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 06:57:55 -0400
IronPort-SDR: 4+0NEnxYGsiR4vWvUPp72kFa60hiU+xLv9qjRpkqOFYH83gFeczPRaY5duNdoQBRmc9nrq+s2O
 OdqAJIbQ0a5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="207765178"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="207765178"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 03:57:54 -0700
IronPort-SDR: Q1QqIZCIgj+9DsKUp3uro7fJoyR5AAuT3d/gV0zQD10apKVAqzt2Rj4jQY89kYWkcRZygsRUb1
 mov/1nSrkH3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="421463373"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 18 Jun 2020 03:57:53 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jlsF1-00EFar-O2; Thu, 18 Jun 2020 13:57:55 +0300
Date:   Thu, 18 Jun 2020 13:57:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1] lightnvm: pblk: Replace guid_copy() with
 export_guid()/import_guid()
Message-ID: <20200618105755.GR2428291@smile.fi.intel.com>
References: <20200422130611.45698-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422130611.45698-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 22, 2020 at 04:06:11PM +0300, Andy Shevchenko wrote:
> There is a specific API to treat raw data as GUID, i.e. export_guid()
> and import_guid(). Use them instead of guid_copy() with explicit casting.

Any comment on this?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/lightnvm/pblk-core.c     | 5 ++---
>  drivers/lightnvm/pblk-recovery.c | 3 +--
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index b413bafe93fdd..6d4523dbf2dbb 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -988,7 +988,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
>  	bitmap_set(line->lun_bitmap, 0, lm->lun_bitmap_len);
>  
>  	smeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
> -	guid_copy((guid_t *)&smeta_buf->header.uuid, &pblk->instance_uuid);
> +	export_guid(smeta_buf->header.uuid, &pblk->instance_uuid);
>  	smeta_buf->header.id = cpu_to_le32(line->id);
>  	smeta_buf->header.type = cpu_to_le16(line->type);
>  	smeta_buf->header.version_major = SMETA_VERSION_MAJOR;
> @@ -1803,8 +1803,7 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
>  
>  	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
>  		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
> -		guid_copy((guid_t *)&emeta_buf->header.uuid,
> -							&pblk->instance_uuid);
> +		export_guid(emeta_buf->header.uuid, &pblk->instance_uuid);
>  		emeta_buf->header.id = cpu_to_le32(line->id);
>  		emeta_buf->header.type = cpu_to_le16(line->type);
>  		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 299ef47a17b22..0e6f0c76e9302 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -706,8 +706,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>  
>  		/* The first valid instance uuid is used for initialization */
>  		if (!valid_uuid) {
> -			guid_copy(&pblk->instance_uuid,
> -				  (guid_t *)&smeta_buf->header.uuid);
> +			import_guid(&pblk->instance_uuid, smeta_buf->header.uuid);
>  			valid_uuid = 1;
>  		}
>  
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


