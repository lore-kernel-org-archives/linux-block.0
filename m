Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F739C04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 23:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E4D2081C
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 23:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfE0XaX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 19:30:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfE0XaX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 19:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBF053092652;
        Mon, 27 May 2019 23:30:22 +0000 (UTC)
Received: from [10.10.120.180] (ovpn-120-180.rdu2.redhat.com [10.10.120.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 867F75D9DE;
        Mon, 27 May 2019 23:30:22 +0000 (UTC)
Subject: Re: [PATCH 1/1] nbd: add netlink reconfigure resize support
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
References: <20190526214918.9495-1-mchristi@redhat.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5CEC730E.20003@redhat.com>
Date:   Mon, 27 May 2019 18:30:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190526214918.9495-1-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 27 May 2019 23:30:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/26/2019 04:49 PM, Mike Christie wrote:
> If the device is setup with ioctl we can resize the device after the
> initial setup, but if the device is setup with netlink we cannot use the
> resize related ioctls and there is no netlink reconfigure size ATTR
> handling code.
> 
> This patch adds netlink reconfigure resize support to match the ioctl
> interface.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
> 
> V2:
> - Merge reconfig and connect resize related code to helper and avoid
> multiple nbd_size_set calls.
> 
>  drivers/block/nbd.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 053958a8a2ba..d75b67c12392 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1674,6 +1674,21 @@ nbd_device_policy[NBD_DEVICE_ATTR_MAX + 1] = {
>  	[NBD_DEVICE_CONNECTED]		=	{ .type = NLA_U8 },
>  };
>  
> +static void nbd_genl_set_size(struct genl_info *info, struct nbd_device *nbd)
> +{
> +	struct nbd_config *config = nbd->config;
> +	u64 bsize = config->blksize;
> +	u64 bytes = config->bytesize;
> +
> +	if (info->attrs[NBD_ATTR_SIZE_BYTES])
> +		bytes = nla_get_u64(info->attrs[NBD_ATTR_SIZE_BYTES]);
> +
> +	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES])
> +		bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
> +
> +	nbd_size_set(nbd, bsize, div64_u64(bytes, bsize));
> +}
> +

I'm sorry. I do not know what I am thinking. Ignore this patch too. It
is bad. It will always be called in the reconfig case.


