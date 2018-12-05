Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0EAC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 14:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDB720879
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 14:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UMjGtga6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDB720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeLEOkI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:40:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEOkI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 09:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+A7P5rqdhT9nnA/7gyM4moUeF06yzmk9GwPnNkPNg3I=; b=UMjGtga6EcpgMVPKaWEzrVpwWD
        7hzqWW6Omuxil8pXaT7H6MFOj4E15IDmCwS6YHwjDYwvwAyySWI4EzxNPnwzOw1iHhbyPRZpn6aV5
        pQJ6eogymwnFZDcyed9eHoZJjyhBeb8COCVK/hJBIytkQJ1nt03I3nI9/UkIxyw35+LZ/4saHuRsN
        3VWNw71pH4xJLqIlotswJPzONP5UCdtQmLrXs8/HfBmPl66oXEmMEp3tdbUEHzCksRiuACfs/YQhI
        J+249pD4Ya5DD8DV0EP7EwpY61BTH2mXpImV5ERKzYNndxDH58aRN9UA1DqU7g7ndw5zxlx3wyfHY
        G1JJvZGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUYLP-0005Nd-4y; Wed, 05 Dec 2018 14:40:07 +0000
Date:   Wed, 5 Dec 2018 06:40:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk, bvanassche@acm.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3] block: add documentation for io_timeout
Message-ID: <20181205144006.GA18123@infradead.org>
References: <20181205141701.GA33910@192.168.3.9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205141701.GA33910@192.168.3.9>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Can you please also send a patch to not show this attribute for
drivers without a timeout handler?  Thanks!

On Wed, Dec 05, 2018 at 10:17:06PM +0800, Weiping Zhang wrote:
> Add documentation for /sys/block/<disk>/queue/io_timeout.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>  Documentation/ABI/testing/sysfs-block | 10 ++++++++++
>  Documentation/block/queue-sysfs.txt   |  7 +++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
> index dea212db9df3..f254a374710a 100644
> --- a/Documentation/ABI/testing/sysfs-block
> +++ b/Documentation/ABI/testing/sysfs-block
> @@ -271,3 +271,13 @@ Description:
>  		size of 512B sectors of the zones of the device, with
>  		the eventual exception of the last zone of the device
>  		which may be smaller.
> +
> +What:		/sys/block/<disk>/queue/io_timeout
> +Date:		November 2018
> +Contact:	Weiping Zhang <zhangweiping@didiglobal.com>
> +Description:
> +		io_timeout is a request’s timeouts at block layer in
> +		milliseconds. When the underlying driver starts processing
> +		a request, the generic block layer will start a timer, if
> +		this request cannot be completed in io_timeout milliseconds,
> +		a timeout event will occur.
> diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
> index 2c1e67058fd3..f0c9bbce73fd 100644
> --- a/Documentation/block/queue-sysfs.txt
> +++ b/Documentation/block/queue-sysfs.txt
> @@ -67,6 +67,13 @@ If set to a value larger than 0, the kernel will put the process issuing
>  IO to sleep for this amont of microseconds before entering classic
>  polling.
>  
> +io_timeout (RW)
> +---------------
> +This is a request’s timeouts at block layer in milliseconds. When the
> +underlying driver starts processing a request, the generic block layer
> +will start a timer, if this request cannot be completed in io_timeout
> +milliseconds, a timeout event will occur.
> +
>  iostats (RW)
>  -------------
>  This file is used to control (on/off) the iostats accounting of the
> -- 
> 2.14.1
> 
---end quoted text---
