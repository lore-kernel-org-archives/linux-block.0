Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FFAC77B60
	for <linux-block@archiver.kernel.org>; Sun, 23 Apr 2023 14:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjDWOWo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Apr 2023 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDWOWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Apr 2023 10:22:40 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBAD211D
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2023 07:22:35 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f0968734f6so8524755e9.0
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2023 07:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682259754; x=1684851754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1g9B5TxeLmYEuXx75noV3icMXCyYnuMg3vM2+ed7Xz4=;
        b=C+GF7FgSCihB7rPiLAjOXIr/JFUldzv7kvUVoKJLjdWAhUyPbTEFLlomBlY+ikf+ld
         jl304WirnQ/PypZU2Uez2PWdI9THSNvUDbBC+q14UieHmMxdlQEswdYa2X2U7dA8MD+/
         zc87IkuMI5au2X53xXgNEAoGAvVWVGpu+1u87uoYzbh757QqMTxl9ibWznQZYTi31qcr
         gppRQT5qaxPXkvrlhAZMzuuu4BvJLktV01umeF2kGrpMDHs8G8eHvymeuRFtmOrjKH7L
         IPzhml9uO9Xn/YnExwsg55fW8dhZNoX1pI3RdTsC2Wn7zPubBbenNBj3Gqc8Duf0BlY9
         zn7A==
X-Gm-Message-State: AAQBX9fRH/2g4J7FXehJexVu9vJOeExsS4zZZ8OBZ/xC9JNhwgveplSF
        FYdd3ulnh2XzOCDaxUP/k4A=
X-Google-Smtp-Source: AKy350bb16P53Zc09oZAgTlBBcf+K5UYKXDEEbibuzZWEoENLyHXg7j1TDocNhKNEAruaYhhwvhsYg==
X-Received: by 2002:a05:600c:3d92:b0:3f1:8c5d:145 with SMTP id bi18-20020a05600c3d9200b003f18c5d0145mr8284903wmb.0.1682259753843;
        Sun, 23 Apr 2023 07:22:33 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003f182cc55c4sm9767406wmj.12.2023.04.23.07.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 07:22:33 -0700 (PDT)
Message-ID: <1084ccfa-c923-5f2d-b481-5016c320f1ad@grimberg.me>
Date:   Sun, 23 Apr 2023 17:22:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/2] nvme-multipath: fix path failover for integrity ns
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, martin.petersen@oracle.com,
        hch@lst.de, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
        oren@nvidia.com, oevron@nvidia.com, israelr@nvidia.com
References: <20230423141330.40437-1-mgurtovoy@nvidia.com>
 <20230423141330.40437-3-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230423141330.40437-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> In case the integrity capabilities of the failed path and the failover
> path don't match, we may run into NULL dereference. Free the integrity
> context during the path failover and let the block layer prepare it
> again if needed during bio_submit.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Tested-by: Ori Evron <oevron@nvidia.com>
> Signed-off-by: Ori Evron <oevron@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/multipath.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9171452e2f6d..f439916f4447 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -6,6 +6,7 @@
>   #include <linux/backing-dev.h>
>   #include <linux/moduleparam.h>
>   #include <linux/vmalloc.h>
> +#include <linux/blk-integrity.h>
>   #include <trace/events/block.h>
>   #include "nvme.h"
>   
> @@ -106,6 +107,14 @@ void nvme_failover_req(struct request *req)
>   			bio->bi_opf &= ~REQ_POLLED;
>   			bio->bi_cookie = BLK_QC_T_NONE;
>   		}
> +		/*
> +		 * If the failover path will not be integrity capable the bio
> +		 * should not have integrity context.
> +		 * If the failover path will be integrity capable the bio will
> +		 * be prepared for integrity again.
> +		 */
> +		if (bio_integrity(bio))
> +			bio_integrity_free(bio);
>   	}
>   	blk_steal_bios(&ns->head->requeue_list, req);
>   	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);

This looks good to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
