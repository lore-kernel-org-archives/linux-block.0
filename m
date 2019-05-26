Return-Path: <SRS0=4mJT=T2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68D7C282E3
	for <linux-block@archiver.kernel.org>; Sun, 26 May 2019 20:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA9A2075E
	for <linux-block@archiver.kernel.org>; Sun, 26 May 2019 20:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfEZUnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 May 2019 16:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfEZUnu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 May 2019 16:43:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F9B8356CD;
        Sun, 26 May 2019 20:43:50 +0000 (UTC)
Received: from [10.10.120.84] (ovpn-120-84.rdu2.redhat.com [10.10.120.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17E4D5D707;
        Sun, 26 May 2019 20:43:49 +0000 (UTC)
Subject: Re: [PATCH 1/1] nbd: add netlink reconfigure resize support
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
References: <20190516003800.28373-1-mchristi@redhat.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5CEAFA85.5000304@redhat.com>
Date:   Sun, 26 May 2019 15:43:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190516003800.28373-1-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 26 May 2019 20:43:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ignore this patch. I had copied nbd_genl_connect, but there is no need
to do 2 nbd_size_set calls if both attrs are set. I am going to resubmit
a new patch.

On 05/15/2019 07:38 PM, Mike Christie wrote:
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
>  drivers/block/nbd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 053958a8a2ba..68b9d4b2d1be 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1939,6 +1939,15 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>  		goto out;
>  	}
>  
> +	if (info->attrs[NBD_ATTR_SIZE_BYTES]) {
> +		u64 bytes = nla_get_u64(info->attrs[NBD_ATTR_SIZE_BYTES]);
> +		nbd_size_set(nbd, config->blksize,
> +			     div64_u64(bytes, config->blksize));
> +	}
> +	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]) {
> +		u64 bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
> +		nbd_size_set(nbd, bsize, div64_u64(config->bytesize, bsize));
> +	}
>  	if (info->attrs[NBD_ATTR_TIMEOUT]) {
>  		u64 timeout = nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]);
>  		nbd->tag_set.timeout = timeout * HZ;
> 

