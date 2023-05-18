Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DD1C7EE23
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 17:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjERRvP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 13:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjERRvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 13:51:15 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED4ED
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 10:50:52 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1aaea43def7so17437695ad.2
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 10:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684432251; x=1687024251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRsmI3n5nU8K3OWhL7xS+cowC4C0InozBxvqV/VrSSY=;
        b=NvkSNHQXnidwLWyECbB1B/nystBdjI/FMxiC1G6Pw04eQe6iI//AUxp4B4lMqPBOCK
         WYn2s+dd45Z9ZJLUVZRFUxkES91AfWdFVKvJhVBmipjmLNFq7rfFBsm/WOkwDoMqunAB
         27HTdM2xvqSrG7mKyIY+ruSYk/nZdjnAk+wju3ktreilc7Kzv35SXyRO3W1SJ+hz8wR/
         r+55bEKSZmTnwSO5bxS7KS4FIedWBpgnptxlEwaSM+lM/gtCDQ32tEmtWqp3lZY099oa
         TqUNg92dhKYxRsrL2vq6IYEAYfxiNeMtq6NYzfSTA2S48EOonEECBEaL2hpFizDohwKY
         k3Dw==
X-Gm-Message-State: AC+VfDy6x6VfwxXt7b3RHcnC0c/v6x4Uu6iq8kekODSjofeXUX5zB4aw
        rZK2Prx/mS9AntBCbvfo7SE=
X-Google-Smtp-Source: ACHHUZ4ZazJOzYIM/uAXv3ooYR04KKPtIoPgCGWjSXtVizaiGpuQQ+nc4BbXEHiuzSP2+GvCYcEdiw==
X-Received: by 2002:a17:902:e74f:b0:1ad:df75:45e0 with SMTP id p15-20020a170902e74f00b001addf7545e0mr3865114plf.39.1684432251394;
        Thu, 18 May 2023 10:50:51 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001ae5d21e95csm1736956plw.117.2023.05.18.10.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 10:50:50 -0700 (PDT)
Message-ID: <091dd83f-14e9-ab63-6a35-4d4daba75e9e@acm.org>
Date:   Thu, 18 May 2023 10:50:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] blk-mq: don't queue plugged passthrough requests into
 scheduler
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
References: <20230518053101.760632-1-hch@lst.de>
 <20230518053101.760632-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230518053101.760632-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 22:30, Christoph Hellwig wrote:
> Passthrough) request should never be queued to the I/O scheduler,

Passthrough) request -> Passthrough requests

> as scheduling these opaque requests doens't make sense, and I/O

doens't -> doesn't

> schedulers might required req->bio to be always valid.

required -> require

> We never let passthrough request cross scheduler before commit

request -> requests

> 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging"),
> restored this behavior even for passthrough requests issued under
> a plug.

The above sentence needs to be edited for clarity.

Otherwise this patch looks good to me.

Thanks,

Bart.
