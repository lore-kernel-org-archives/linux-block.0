Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E131CC4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB4B20C09
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m0iLyt7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIVO0A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 10:26:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgIVO0A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 10:26:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600784758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m55LpYIPz2/gLR7XJJbmS3D3fw3yA3M+76SUekukJQk=;
        b=m0iLyt7iNT74lbvJnYoorfut2vAzNlJWmpgI3g8z8olHVRy7M4zUcJIm0uyB/KSHHY53JR
        kRGyxfTp56noVOvVliW4GFTKSB8DG7W4jGQlFBY/tc74I14diYmS6Cok3KLioMRe1PaT9m
        UwoTjhai2MFkTtZlUXqyNuLYslIA4BY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28970ACC2;
        Tue, 22 Sep 2020 14:26:35 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] xen-blkback: add a parameter for disabling of
 persistent grants
To:     SeongJae Park <sjpark@amazon.com>, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, axboe@kernel.dk,
        aliguori@amazon.com, amit@kernel.org, mheyne@amazon.de,
        pdurrant@amazon.co.uk, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200922141549.26154-1-sjpark@amazon.com>
 <20200922141549.26154-2-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <5d0f75f1-636e-e485-c616-bca47bd6932f@suse.com>
Date:   Tue, 22 Sep 2020 16:25:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922141549.26154-2-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22.09.20 16:15, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Persistent grants feature provides high scalability.  On some small
> systems, however, it could incur data copy overheads[1] and thus it is
> required to be disabled.  But, there is no option to disable it.  For
> the reason, this commit adds a module parameter for disabling of the
> feature.
> 
> [1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability
> 
> Signed-off-by: Anthony Liguori <aliguori@amazon.com>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>   .../ABI/testing/sysfs-driver-xen-blkback      |  9 ++++++++
>   drivers/block/xen-blkback/xenbus.c            | 22 ++++++++++++++-----
>   2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> index ecb7942ff146..ac2947b98950 100644
> --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
> +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> @@ -35,3 +35,12 @@ Description:
>                   controls the duration in milliseconds that blkback will not
>                   cache any page not backed by a grant mapping.
>                   The default is 10ms.
> +
> +What:           /sys/module/xen_blkback/parameters/feature_persistent
> +Date:           September 2020
> +KernelVersion:  5.10
> +Contact:        SeongJae Park <sjpark@amazon.de>
> +Description:
> +                Whether to enable the persistent grants feature or not.  Note
> +                that this option only takes effect on newly created backends.
> +                The default is Y (enable).
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index b9aa5d1ac10b..f4c8827fa0ad 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -474,6 +474,12 @@ static void xen_vbd_free(struct xen_vbd *vbd)
>   	vbd->bdev = NULL;
>   }
>   
> +/* Enable the persistent grants feature. */
> +static bool feature_persistent = true;
> +module_param(feature_persistent, bool, 0644);
> +MODULE_PARM_DESC(feature_persistent,
> +		"Enables the persistent grants feature");
> +
>   static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
>   			  unsigned major, unsigned minor, int readonly,
>   			  int cdrom)
> @@ -519,6 +525,8 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
>   	if (q && blk_queue_secure_erase(q))
>   		vbd->discard_secure = true;
>   
> +	vbd->feature_gnt_persistent = feature_persistent ? 1 : 0;

Just assign the value instead of using the ternary operator?

With that changed you can add my

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
