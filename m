Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB97BC6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 07:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCVHQZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 03:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVHQZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 03:16:25 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5EC12F04
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 00:16:24 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id l12so15946520wrm.10
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 00:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679469382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kNtGCTny/m1P4ujMq1z9tejn6dfAoxCg6tnjm73VBE=;
        b=sXwdDR9n9/PtFk66wPKbLTaIlxS/tzonzaDj9H1WCoYL+vH5+9LtVP8p56pEtVhNu0
         97fy5nmblfbkxMRbK5kEwkdjut6Pr0v67qWgRvMW7kL0THnkaGTeIds4QfhU2iQMExgE
         7Sz9uwWe27tuLBBnca3QF8Yn59r7xSA0fw9g5Bk1SvL1mX767v6+jz0+bfjJA2W3/moR
         AQCPzeboIEJSyeqTUqex8N+gE0TrxuendKF7+MGQQS+6JTb/VtRdpfmYk5Uop3tc1aw6
         R2pDnFVcFtRk+bxCroIV12DrRuvObLHI7nOC8pIJjqI6G2MPocwtt4oQHbDo6GbAwhMm
         d/EQ==
X-Gm-Message-State: AO0yUKUJ3AgeLgMYprFXQ9WAP80N3k+Y2HNC7xiVCGDHoN0rvh3ccjIJ
        Q6hgXdxRy+AuuJT6tCm6REs=
X-Google-Smtp-Source: AK7set9VQ+80DTV0U2L8AHnRJ6Dqc1MD36VGfvFAGxaZNR9a5JWBpZXc4XFlbh3mSVwaucE8ylSH5A==
X-Received: by 2002:a5d:6043:0:b0:2cf:e73b:3ff3 with SMTP id j3-20020a5d6043000000b002cfe73b3ff3mr3496435wrt.7.1679469382523;
        Wed, 22 Mar 2023 00:16:22 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x2-20020a5d60c2000000b002cfe71153b4sm13125250wrt.60.2023.03.22.00.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:16:22 -0700 (PDT)
Message-ID: <7510afd5-829a-aee0-2fc2-0e425f78ccee@grimberg.me>
Date:   Wed, 22 Mar 2023 09:16:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] blk-mq: fix forward declaration for rdma mapping
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>
References: <20230321215001.2655451-1-kbusch@meta.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321215001.2655451-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> From: Keith Busch <kbusch@kernel.org>
> 
> blk_mq_rdma_map_queues() used to take a 'blk_mq_tag_set *' parameter,
> but was changed to 'blk_mq_queue_map *'. The forward declaration needs
> to be updated so .c files won't have to include headers in a specific
> order.
> 
> Fixes: e42b3867de4bd5e ("blk-mq-rdma: pass in queue map to blk_mq_rdma_map_queues")
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   include/linux/blk-mq-rdma.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blk-mq-rdma.h b/include/linux/blk-mq-rdma.h
> index 53b58c610e767..d7ead42f1c6ad 100644
> --- a/include/linux/blk-mq-rdma.h
> +++ b/include/linux/blk-mq-rdma.h
> @@ -2,7 +2,7 @@
>   #ifndef _LINUX_BLK_MQ_RDMA_H
>   #define _LINUX_BLK_MQ_RDMA_H
>   
> -struct blk_mq_tag_set;
> +struct blk_mq_queue_map;
>   struct ib_device;
>   
>   void blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,

BTW, afaik this is dead code because no rdma device exposes
.get_vector_affinity. I'll send a patch to remove it altogether.
