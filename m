Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361A0C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 17:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA0C2175B
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 17:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ZS9Itpur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfFMRof (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:44:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45506 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfFMRof (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 13:44:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id j19so23518940qtr.12
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+8qNMHAeNUM3HqL7D4SiY9L8AH0ApKxbZrwrMyPSpg=;
        b=ZS9Itpur0ufzA+1YBgJZmHVN+Pa6LgWZpDnLmVQd/0PkjUCMwyQeku0o2dpI7LaSVI
         y1IDluA/merakGWfZzBq80kTx/JC/1CL0Hu79NZxY5Bn4Dl2NSG1iePj6GtFqCrMiwd3
         FNzGP1cLzPPeszZU6f374jVq4Cqta8GqKmZH6e5WtSFHZ26Dqj3ZqnqYQ2KgEQ+eMSnk
         CUpyMUXoRfx2MutZ+r+v7Ej2yWY9vmK/tDpod8Vxiepb7M0bwpEklzcTanPxlEiYd8sT
         flr/pOXh7KRp+FlkJMdvhc8HKxMklUrXrmAlNkJ8g8x9r46fqNf3AFEBxVPkUA5T0e8v
         1Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+8qNMHAeNUM3HqL7D4SiY9L8AH0ApKxbZrwrMyPSpg=;
        b=Gp26V5meV1CIBpyuMwHcik68Mh71IlGEwP5eWnzAYOhzvz+yn7Ur7Gojq8Jp12wDL2
         j0BQeq5rChVmwiY5JmBM8JxnZZxv6PXcm/W+x72WunYAzuJanY4G1Hwbj7a+G0uIFUtc
         7qjZjtiSK9vl1qZP6OZq4oB1+VzhD5vEqcrPhvjt982LAG5kMngKkHvvRX1n/R01fqJv
         5Yz/3EGWlaXJfBt2zAJMAihKNSehblW0k63nx4iLrW16lRi/M6JtSQAPQC8hsqGVTpdD
         9PmlzJfhtyMqE5Ga/Lf4RgxQ/nSeEE2RW4skHos5KN4eaCkQq0OdhCBy3n4b/UZKfq5/
         r7Aw==
X-Gm-Message-State: APjAAAUrgtprgRwoVoC/FDyj9mTLs9YaDOEarySqNLF5Ta7X6nuORXy7
        G8DqRyGT4WS6BLgRqxuF+MWsO/c0MxFwOk2h
X-Google-Smtp-Source: APXvYqzwoxN9bnwnLVt7I6rw0ZKo+sZfg8YRxq5n3L49mp5MsC12PEzGbSruNO61iQrR6Ra8YzAHBQ==
X-Received: by 2002:ac8:28ee:: with SMTP id j43mr76350461qtj.248.1560447874278;
        Thu, 13 Jun 2019 10:44:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d1])
        by smtp.gmail.com with ESMTPSA id h185sm168863qkd.11.2019.06.13.10.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 10:44:34 -0700 (PDT)
Date:   Thu, 13 Jun 2019 13:44:32 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nbd: add netlink reconfigure resize support v3
Message-ID: <20190613174432.toklqw5cuht4xekb@MacBook-Pro-91.local>
References: <20190529201606.14903-1-mchristi@redhat.com>
 <20190529201606.14903-3-mchristi@redhat.com>
 <20190613170103.pludlfrz2jtkzwij@MacBook-Pro-91.local>
 <5D02895F.5000205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D02895F.5000205@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 13, 2019 at 12:35:27PM -0500, Mike Christie wrote:
> On 06/13/2019 12:01 PM, Josef Bacik wrote:
> > On Wed, May 29, 2019 at 03:16:06PM -0500, Mike Christie wrote:
> >> If the device is setup with ioctl we can resize the device after the
> >> initial setup, but if the device is setup with netlink we cannot use the
> >> resize related ioctls and there is no netlink reconfigure size ATTR
> >> handling code.
> >>
> >> This patch adds netlink reconfigure resize support to match the ioctl
> >> interface.
> >>
> >> Signed-off-by: Mike Christie <mchristi@redhat.com>
> > 
> > Sorry I missed this too, but I think there's a problem with this actually.
> > 
> >> ---
> >>
> >> V3;
> >> - If the device size or block size has not changed do not call
> >> nbd_size_set.
> >>
> >> V2:
> >> - Merge reconfig and connect resize related code to helper and avoid
> >> multiple nbd_size_set calls.
> >>
> >>  drivers/block/nbd.c | 48 ++++++++++++++++++++++++++++++---------------
> >>  1 file changed, 32 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> >> index 236253fbf455..9486555e6391 100644
> >> --- a/drivers/block/nbd.c
> >> +++ b/drivers/block/nbd.c
> >> @@ -1685,6 +1685,30 @@ nbd_device_policy[NBD_DEVICE_ATTR_MAX + 1] = {
> >>  	[NBD_DEVICE_CONNECTED]		=	{ .type = NLA_U8 },
> >>  };
> >>  
> >> +static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
> >> +{
> >> +	struct nbd_config *config = nbd->config;
> >> +	u64 bsize = config->blksize;
> >> +	u64 bytes = config->bytesize;
> >> +
> >> +	if (info->attrs[NBD_ATTR_SIZE_BYTES])
> >> +		bytes = nla_get_u64(info->attrs[NBD_ATTR_SIZE_BYTES]);
> >> +
> >> +	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]) {
> >> +		bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
> >> +		if (!bsize)
> >> +			bsize = NBD_DEF_BLKSIZE;
> >> +		if (!nbd_is_valid_blksize(bsize)) {
> >> +			printk(KERN_ERR "Invalid block size %llu\n", bsize);
> >> +			return -EINVAL;
> >> +		}
> >> +	}
> >> +
> >> +	if (bytes != config->bytesize || bsize != config->blksize)
> >> +		nbd_size_set(nbd, bsize, div64_u64(bytes, bsize));
> > 
> > This part won't actually update the bdev if there already is one because
> > nbd->task_recv is NULL for netlink related devices.  Probably need to fix that
> 
> I'm not sure I understand this part of the comment. For netlink we do:
> 
> nbd_genl_connect -> nbd_start_device:
> 
> nbd_start_device()
> {
>     .....
>     nbd->task_recv = current;
> 

Sorry, I can't read apparently.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
