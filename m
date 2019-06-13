Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1C1C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BA62084D
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 17:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="WgUlkome"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbfFMRBI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:01:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43517 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbfFMRBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 13:01:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id z24so10151861qtj.10
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DGIXjOYJSPSRoOc0HrEhJQsu6k+Vrj/MGxQy+ykTMP0=;
        b=WgUlkomeXOHwP8B1+jzMsRS5eFVbqN8cWLJix0JqSpPJak+lO1ryqLVQv/l4WSkVlI
         H9u/G3kJWe5/HlBePJ4Zw1J+OM2/JJnAE7qRDUg4Yo2s7124t4zRYSmOmeXXQurQ5/b8
         lOEs8SYE2ceyMtcISlz7vyXnGP7ZCWSl2YCPjyyTwx7uf8EQEB5z8g/2hLkFSiAwcnR/
         Uk3HTjI6UQUqFlIEPwhA3swPfz3cxlXITJOwTS2IuVX7aP2kARQAVIIQFKDsakRlEYtq
         4J7/zHGj6vFiRdD+EZTIcg2BV/Bb5k30oFuDO2pU2Bfp/vi1geNdFEvsLj6/ba1N7Jq2
         wNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DGIXjOYJSPSRoOc0HrEhJQsu6k+Vrj/MGxQy+ykTMP0=;
        b=hSVMYJceyNSvTmSCsyxGon22IDA7L54lxjHfAin0WI7yKfFQVglIC4V8lNqpiM97c0
         cT2A1Pli5qYBU9VtrQnV1zRLrfpevH0mCHWjQ1dEeVoFRsQxG2qhMVK/v5N5hF6gH0hx
         RFf6XZHwMTehiAlMQdETFxukQe+JwqGvTvB8RoW+EITwsMq+bQFeyibe9a3yrNUVIEYG
         the2gTevWRpntHZPRRqhRFnlZahQqkM1l2W2masfPNJ4uU4IkVCom9/ECTdgCvWjVrrR
         RWmUsPzJI+4pxRmzQa7ecNpff+hEOwwQEWl2IUkKqu/zNLEri2sAPUo0UrJhd6Iv0bbD
         GU8w==
X-Gm-Message-State: APjAAAUiLF84WSPJzLQmZPqyVTNjNLP9AzCE3yE4H767qoDgmGxkeD44
        GyA4unidnD8kpd4EQnLKfUrl2w==
X-Google-Smtp-Source: APXvYqxNkT7CVy/VnjJ3J5fysoYB6DI9Z6bt+aiAA9ZmE2RtsxLaVQ/hqcXL6yawuuriyMocPJeZoA==
X-Received: by 2002:ac8:82a:: with SMTP id u39mr20405723qth.370.1560445266501;
        Thu, 13 Jun 2019 10:01:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d1])
        by smtp.gmail.com with ESMTPSA id g10sm68272qki.37.2019.06.13.10.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 10:01:05 -0700 (PDT)
Date:   Thu, 13 Jun 2019 13:01:04 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nbd: add netlink reconfigure resize support v3
Message-ID: <20190613170103.pludlfrz2jtkzwij@MacBook-Pro-91.local>
References: <20190529201606.14903-1-mchristi@redhat.com>
 <20190529201606.14903-3-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529201606.14903-3-mchristi@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 29, 2019 at 03:16:06PM -0500, Mike Christie wrote:
> If the device is setup with ioctl we can resize the device after the
> initial setup, but if the device is setup with netlink we cannot use the
> resize related ioctls and there is no netlink reconfigure size ATTR
> handling code.
> 
> This patch adds netlink reconfigure resize support to match the ioctl
> interface.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>

Sorry I missed this too, but I think there's a problem with this actually.

> ---
> 
> V3;
> - If the device size or block size has not changed do not call
> nbd_size_set.
> 
> V2:
> - Merge reconfig and connect resize related code to helper and avoid
> multiple nbd_size_set calls.
> 
>  drivers/block/nbd.c | 48 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 236253fbf455..9486555e6391 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1685,6 +1685,30 @@ nbd_device_policy[NBD_DEVICE_ATTR_MAX + 1] = {
>  	[NBD_DEVICE_CONNECTED]		=	{ .type = NLA_U8 },
>  };
>  
> +static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
> +{
> +	struct nbd_config *config = nbd->config;
> +	u64 bsize = config->blksize;
> +	u64 bytes = config->bytesize;
> +
> +	if (info->attrs[NBD_ATTR_SIZE_BYTES])
> +		bytes = nla_get_u64(info->attrs[NBD_ATTR_SIZE_BYTES]);
> +
> +	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]) {
> +		bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
> +		if (!bsize)
> +			bsize = NBD_DEF_BLKSIZE;
> +		if (!nbd_is_valid_blksize(bsize)) {
> +			printk(KERN_ERR "Invalid block size %llu\n", bsize);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (bytes != config->bytesize || bsize != config->blksize)
> +		nbd_size_set(nbd, bsize, div64_u64(bytes, bsize));

This part won't actually update the bdev if there already is one because
nbd->task_recv is NULL for netlink related devices.  Probably need to fix that
to update the bdev unconditionally, and then just see if bdget_disk() returns
NULL in nbd_size_update.  Also I hate myself for how many size update functions
there are.  Thanks,

Josef
