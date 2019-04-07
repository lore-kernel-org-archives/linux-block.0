Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6128C282DA
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 00:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EA12171F
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 00:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="kXodR83I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDGAKu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 20:10:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45816 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDGAKu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 20:10:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so11505226qtv.12
        for <linux-block@vger.kernel.org>; Sat, 06 Apr 2019 17:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nAcHuzKOp7Og35xJ9qkPg9RRl0wfwnr6s1xFaxaVBMk=;
        b=kXodR83I85F2t6TrJ7lK5pPAb96V3ezu7UA6bktNZhLq/xWKFzioOv38hC6xnBFNPj
         BdJwvdXIcnZJ7PUefFAvoZsPOcmLwDt0o8/uCKAmuWh36/1oBfyyI2Nnp8yAfhd86a6p
         WHELMN8i4fjqF0lg09a6+Tx4r8Xwpyx7PNd57P9EbxjE9JbLK/cOkM27TgSsRA6JLhpF
         NhoHkTA10ZYhDR4C48WsN17PIbD5Igk7mjLhzIAxGtQWtWkjwVRli7Ag5M516ELmOqZ8
         VjPPhy6uMfNwm0RGLaRSpoWuOSjibZgJvgAxGJ/+tWSQcCKjJ6SNqosuz+Zmskot9BZA
         OFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nAcHuzKOp7Og35xJ9qkPg9RRl0wfwnr6s1xFaxaVBMk=;
        b=EyiMnw9ZQ0/o+dtagleh2pnw/wpXEgINLHCn9lv3mzgPjf1MwI90x/tGi2eINhA9GW
         awmBfoUzyd2thQbkLegzUlYfWv9vwkuNryArmVNXwqI4SO1k5W0kn3Jt4OH+5yFRBvWC
         SoMmEb48wktbiIVPOuHWn+MLjhl4DHCe6X8TEQoJlm0tVHMs8VYIAizqBKNT29nIjEGX
         6S8LPgRQi0HQ1ZO7JDcoJ+MCtW6l6cmonqEEErIf48lsngL9hfKjVaGGvpkPDIZaPMAg
         gjeD6pzT7WudBfbsFh+QEafcSn3UCnfeNFP9gjAywFvT+ez6bp4TSIUA2GTOm6x1IHfC
         sVhg==
X-Gm-Message-State: APjAAAWhtcdLBDA7Lviau1TupgNUWaz6Bh6gz1O+sO4lnKswrsAnqERx
        kS8FrJQeQddVABtp5Y85+FF3wg==
X-Google-Smtp-Source: APXvYqzXsZh8KCRoI7R2RZs557hK5hF2yV1neb48tC1BvCuuHnU4855yDnQu6Y1TgAr+3zsif8h3NQ==
X-Received: by 2002:ac8:2413:: with SMTP id c19mr18040488qtc.348.1554595848871;
        Sat, 06 Apr 2019 17:10:48 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k89sm3016349qte.33.2019.04.06.17.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 17:10:48 -0700 (PDT)
Date:   Sat, 6 Apr 2019 20:10:46 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Matt Mullins <mmullins@fb.com>
Cc:     hall@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH bpf-next v2 2/5] nbd: trace sending nbd requests
Message-ID: <20190407001045.vbmwrzaokqb4ufww@MacBook-Pro-91.local>
References: <20190405235506.29236-1-mmullins@fb.com>
 <20190405235506.29236-3-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405235506.29236-3-mmullins@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 05, 2019 at 04:55:03PM -0700, Matt Mullins wrote:
> This adds a tracepoint that can both observe the nbd request being sent
> to the server, as well as modify that request , e.g., setting a flag in
> the request that will cause the server to collect detailed tracing data.
> 
> The struct request * being handled is included to permit correlation
> with the block tracepoints.
> 
> Signed-off-by: Matt Mullins <mmullins@fb.com>
> ---
>  MAINTAINERS                |  1 +
>  drivers/block/nbd.c        |  5 ++++
>  include/trace/events/nbd.h | 56 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>  create mode 100644 include/trace/events/nbd.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf70b548..6db583d2b0ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10737,6 +10737,7 @@ L:	linux-block@vger.kernel.org
>  L:	nbd@other.debian.org
>  F:	Documentation/blockdev/nbd.txt
>  F:	drivers/block/nbd.c
> +F:	include/trace/events/nbd.h
>  F:	include/uapi/linux/nbd.h
>  
>  NETWORK DROP MONITOR
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 90ba9f4c03f3..7393d04d255c 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -44,6 +44,9 @@
>  #include <linux/nbd-netlink.h>
>  #include <net/genetlink.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/nbd.h>
> +
>  static DEFINE_IDR(nbd_index_idr);
>  static DEFINE_MUTEX(nbd_index_mutex);
>  static int nbd_total_devices = 0;
> @@ -526,6 +529,8 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
>  	handle = nbd_cmd_handle(cmd);
>  	memcpy(request.handle, &handle, sizeof(handle));
>  
> +	trace_nbd_send_request(&request, nbd->index, blk_mq_rq_from_pdu(cmd));
> +

Just use the handle, not the pointer.  Thanks,

Josef
