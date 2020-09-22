Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309B2C2D0E2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 12:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC76F2396D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 12:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jaFs8q2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIVMLg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 08:11:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgIVMLf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 08:11:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600776693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5SAy2ca2q3L9EB+unO167nKo1fIg4hrYmsfk4Zg1pow=;
        b=jaFs8q2xDCD9SVtqdDERHGzFf/DLQqfUWQxyKAdZtU46tzLG3E0u0MuYOIWseAzbuZ0vGO
        asz2z7MgJtLCrXknt9zxubRAGffXzHd9ctK6Dh8ffDARFZH8nI+BwA1bw04Pt4FN0KwjXy
        6RhgSwWDPoMWaJky8MiX4GqGKwhIpNA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 584FCB330;
        Tue, 22 Sep 2020 12:12:10 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] xen-blkfront: add a parameter for disabling of
 persistent grants
To:     SeongJae Park <sjpark@amazon.com>, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, axboe@kernel.dk,
        aliguori@amazon.com, amit@kernel.org, mheyne@amazon.de,
        pdurrant@amazon.co.uk, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200922105209.5284-1-sjpark@amazon.com>
 <20200922105209.5284-3-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <fdbaf955-0b92-d356-2792-21b27ea1087d@suse.com>
Date:   Tue, 22 Sep 2020 14:11:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922105209.5284-3-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22.09.20 12:52, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Persistent grants feature provides high scalability.  On some small
> systems, however, it could incur data copy overheads[1] and thus it is
> required to be disabled.  It can be disabled from blkback side using a
> module parameter, 'feature_persistent'.  But, it is impossible from
> blkfront side.  For the reason, this commit adds a blkfront module
> parameter for disabling of the feature.
> 
> [1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>   .../ABI/testing/sysfs-driver-xen-blkfront     |  9 ++++++
>   drivers/block/xen-blkfront.c                  | 28 +++++++++++++------
>   2 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkfront b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> index c0a6cb7eb314..9c31334cb2e6 100644
> --- a/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> @@ -8,3 +8,12 @@ Description:
>                   is 32 - higher value means more potential throughput but more
>                   memory usage. The backend picks the minimum of the frontend
>                   and its default backend value.
> +
> +What:           /sys/module/xen_blkfront/parameters/feature_persistent
> +Date:           September 2020
> +KernelVersion:  5.10
> +Contact:        SeongJae Park <sjpark@amazon.de>
> +Description:
> +                Whether to enable the persistent grants feature or not.  Note
> +                that this option only takes effect on newly created frontends.
> +                The default is Y (enable).
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 91de2e0755ae..49c324f377de 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -149,6 +149,13 @@ static unsigned int xen_blkif_max_ring_order;
>   module_param_named(max_ring_page_order, xen_blkif_max_ring_order, int, 0444);
>   MODULE_PARM_DESC(max_ring_page_order, "Maximum order of pages to be used for the shared ring");
>   
> +/* Enable the persistent grants feature. */
> +static bool feature_persistent = true;
> +module_param(feature_persistent, bool, 0644);
> +MODULE_PARM_DESC(feature_persistent,
> +		"Enables the persistent grants feature");
> +
> +
>   #define BLK_RING_SIZE(info)	\
>   	__CONST_RING_SIZE(blkif, XEN_PAGE_SIZE * (info)->nr_ring_pages)
>   
> @@ -1866,11 +1873,13 @@ static int talk_to_blkback(struct xenbus_device *dev,
>   		message = "writing protocol";
>   		goto abort_transaction;
>   	}
> -	err = xenbus_printf(xbt, dev->nodename,
> -			    "feature-persistent", "%u", 1);
> -	if (err)
> -		dev_warn(&dev->dev,
> -			 "writing persistent grants feature to xenbus");
> +	if (feature_persistent) {
> +		err = xenbus_printf(xbt, dev->nodename,
> +				    "feature-persistent", "%u", 1);
> +		if (err)
> +			dev_warn(&dev->dev,
> +				 "writing persistent grants feature to xenbus");
> +	}
>   
>   	err = xenbus_transaction_end(xbt, 0);
>   	if (err) {
> @@ -2316,9 +2325,12 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
>   	if (xenbus_read_unsigned(info->xbdev->otherend, "feature-discard", 0))
>   		blkfront_setup_discard(info);
>   
> -	info->feature_persistent =
> -		!!xenbus_read_unsigned(info->xbdev->otherend,
> -				       "feature-persistent", 0);
> +	if (feature_persistent)
> +		info->feature_persistent =
> +			!!xenbus_read_unsigned(info->xbdev->otherend,
> +					       "feature-persistent", 0);
> +	else
> +		info->feature_persistent = 0;
>   
>   	indirect_segments = xenbus_read_unsigned(info->xbdev->otherend,
>   					"feature-max-indirect-segments", 0);
> 

Here you have the same problem as in blkback: feature_persistent could
change its value between the two tests.


Juergen
