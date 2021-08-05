Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7B2C4338F
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 15:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F9C60E78
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 15:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbhHEPuY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242394AbhHEPuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Aug 2021 11:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628178609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cBq22qCt0vTioV8uoJVFfE3aNxsV4C6kvXFGv17EYKo=;
        b=DrBPEMUqNE7GNbOvI3wRYD/BRfn7+yBe0CUYVDOumUok1TfxaR1GjYVhxEMgqLF8XSOCVV
        ViFJ5WcZjoOA7HibUrFVRHcmepDY3vuTSmPT7zf0h6C10KwblE8GWmW1p/TtmQJtR+REzs
        KjobqhKJgOK8Ft8G0oDv9mvQoGb0fOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-FtQ83V1CPNGdAYXpQsBiyQ-1; Thu, 05 Aug 2021 11:50:08 -0400
X-MC-Unique: FtQ83V1CPNGdAYXpQsBiyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B35FD107BEF6;
        Thu,  5 Aug 2021 15:50:06 +0000 (UTC)
Received: from redhat.com (ovpn-112-138.phx2.redhat.com [10.3.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01F755D9DE;
        Thu,  5 Aug 2021 15:50:05 +0000 (UTC)
Date:   Thu, 5 Aug 2021 10:50:04 -0500
From:   Eric Blake <eblake@redhat.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH] nbd: call genl_unregister_family() first in nbd_cleanup()
Message-ID: <20210805155004.6l4gxrniih6vxisr@redhat.com>
References: <20210805021946.978686-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805021946.978686-1-houtao1@huawei.com>
User-Agent: NeoMutt/20210205-687-0ed190
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 05, 2021 at 10:19:46AM +0800, Hou Tao wrote:
> Else there may be race between module removal and handling of
> netlink command and will lead to oops as shown below:

Grammar suggestion:

Otherwise, there is a race between module removal and the handling of
a netlink command, which can lead to the oops shown below:

> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  drivers/block/nbd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 9a7c9a425ab0..0993d108d868 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2492,6 +2492,12 @@ static void __exit nbd_cleanup(void)
>  	struct nbd_device *nbd;
>  	LIST_HEAD(del_list);
>  
> +	/*
> +	 * Unregister netlink interface first to waiting
> +	 * for the completion of netlink commands.

Grammar suggestion: s/first/prior/

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

