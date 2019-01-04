Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EEFC43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9647621871
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 15:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfADP7X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:59:23 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34588 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfADP7X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jan 2019 10:59:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so40902093qtp.1
        for <linux-block@vger.kernel.org>; Fri, 04 Jan 2019 07:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrdtvR2p94y26cny7X7iEcKf5TCjTaisnK2kemASniY=;
        b=k58nhD0L0/BOPSg+GQblycu1PGZGpByyDTdHx6DRpgSDoEPn4L7oLtqeflN7rsorM+
         nFV9kYclwnQarvUPO2hw9mWi6ZJUtUB9c7GagS+GbQ30I2FtuMbp1RYSNii0Pcjr0qtU
         k0pi5lvIpDVBYqKVXhUNT8u3x/gLh3CoYb6ucWDk/tn5vbRQ1dG2qe5Bd4AdI+Vz9/wH
         SKt9N+ghc2nZBQwGwV5svS4KVPfI4t05d3mv6NV1+McPerlZ4W2ZdeXVcwvT8vs8ADAR
         rEVElWT+Cnm+P0K73VJY5wmdji4d+yG5UQ9AxuDReYpZ4UOnnZQ9cKG19nHnZW8DGmn1
         plFg==
X-Gm-Message-State: AA+aEWZdJt/0Bh3CAVl18vk4quWmSmb8zFEbYbeof2/bE1/NbDJQlYiQ
        YVDJBrBt6RVPmC/4dxQBpx2y8Q==
X-Google-Smtp-Source: AFSGD/Xy6vSgKL2Eg9N0J+Su5DikGS6GsyR0juvgUxiI4IqFIQvMSh+jVyq7rqWKFFN3KKTWjp9H9A==
X-Received: by 2002:ac8:5411:: with SMTP id b17mr49456603qtq.259.1546617562324;
        Fri, 04 Jan 2019 07:59:22 -0800 (PST)
Received: from 2600-6c64-4e80-00f1-56ee-75ff-fe93-2951.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-56ee-75ff-fe93-2951.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:56ee:75ff:fe93:2951])
        by smtp.gmail.com with ESMTPSA id a192sm6230166qkg.63.2019.01.04.07.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 07:59:21 -0800 (PST)
Message-ID: <1546617555.2666.3.camel@redhat.com>
Subject: Re: [PATCH] null_blk: add zoned config support information
From:   Laurence Oberman <loberman@redhat.com>
To:     John Pittman <jpittman@redhat.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Date:   Fri, 04 Jan 2019 10:59:15 -0500
In-Reply-To: <20190104154243.3538-1-jpittman@redhat.com>
References: <20190104154243.3538-1-jpittman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-01-04 at 10:42 -0500, John Pittman wrote:
> If the kernel is built without CONFIG_BLK_DEV_ZONED, a modprobe
> of the null_blk driver with zoned=1 fails with 'Invalid argument'.
> This can be confusing to users, prompting a search as to why the
> parameter is invalid. To assist in that search, add a bit more
> information to the failure, additionally adding to the documentation
> that CONFIG_BLK_DEV_ZONED is needed for zoned=1.
> 
> Signed-off-by: John Pittman <jpittman@redhat.com>
> ---
>  Documentation/block/null_blk.txt | 3 ++-
>  drivers/block/null_blk.h         | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/block/null_blk.txt
> b/Documentation/block/null_blk.txt
> index ea2dafe49ae8..4cad1024fff7 100644
> --- a/Documentation/block/null_blk.txt
> +++ b/Documentation/block/null_blk.txt
> @@ -88,7 +88,8 @@ shared_tags=[0/1]: Default: 0
>  
>  zoned=[0/1]: Default: 0
>    0: Block device is exposed as a random-access block device.
> -  1: Block device is exposed as a host-managed zoned block device.
> +  1: Block device is exposed as a host-managed zoned block device.
> Requires
> +     CONFIG_BLK_DEV_ZONED.
>  
>  zone_size=[MB]: Default: 256
>    Per zone size when exposed as a zoned block device. Must be a
> power of two.
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
> index b3df2793e7cd..cab4808f14bd 100644
> --- a/drivers/block/null_blk.h
> +++ b/drivers/block/null_blk.h
> @@ -97,6 +97,7 @@ void null_zone_reset(struct nullb_cmd *cmd,
> sector_t sector);
>  #else
>  static inline int null_zone_init(struct nullb_device *dev)
>  {
> +	pr_info("CONFIG_BLK_DEV_ZONED not enabled\n");
>  	return -EINVAL;
>  }
>  static inline void null_zone_exit(struct nullb_device *dev) {}

Looks good to me, useful change in my opinion.

Reviewed-by: Laurence Oberman <loberman@redhat.com>
