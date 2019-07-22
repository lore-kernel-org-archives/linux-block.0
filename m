Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8155C76188
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 15:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DC02084D
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 15:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfGVP1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:27:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40403 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfGVP1f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 11:27:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so17530650pfp.7
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 08:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bJ+hIj4Y9QJhpTQc3+TpDT68ao/BoySPbCAzPxaem4o=;
        b=TCvM6VIlgcrVUTfJX5rwCqlFqiuzzLYF47CSkuyW30KHzMsfB02h2mQpzIWIxRzBKG
         U71I9SLpYWj8yHQ4A3gTaITL6Kst/bGj2Igfqml16tyD+B68rAOOxi2bvBmaW5kQq1mR
         w3xtw44eaKKYZiFWSoWpmmmLOO5UZe2lX2JQbREIJxDoatFbWo/9T6Lbio/ukw2MUKeb
         soVXTzWZyIlIwrZwxyRnk5rXiqFvLIhMy6dXC8/yxqjecmFR6lbq48E5FpJ3Cu4LZOXj
         EM/4ElVESSZMf0MZxgBXGDt3qDMqsmbv8i8xPZB1rgEAaCu4jIJQkU8MlAq7KLwSUoJy
         pYvg==
X-Gm-Message-State: APjAAAV57b8JHKE0XSVXTQV3g1JL6By4MIqomEe4thcPdTgyZ7ieRloi
        XQXM9AJJTt2QXIIBvL5sSMw=
X-Google-Smtp-Source: APXvYqwaIPITBAqkMMf1XkJ0whlJ7sj6/TsqWVn+Y5F9jvgoKFHYxsdpNaSCwxP/G5hk4jKNKfoinw==
X-Received: by 2002:a63:d301:: with SMTP id b1mr64649702pgg.379.1563809254163;
        Mon, 22 Jul 2019 08:27:34 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 135sm39308543pfb.137.2019.07.22.08.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 08:27:33 -0700 (PDT)
Subject: Re: [PATCH 3/5] nvme: don't abort completed request in
 nvme_cancel_request
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-4-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d82ead02-c893-4d14-307e-70a6d4596439@acm.org>
Date:   Mon, 22 Jul 2019 08:27:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190722053954.25423-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/19 10:39 PM, Ming Lei wrote:
> Before aborting in-flight requests, all IO queues have been shutdown.
> However, request's completion fn may not be done yet because it may
> be scheduled to run via IPI.
> 
> So don't abort one request if it is marked as completed, otherwise
> we may abort one normal completed request.
> 
> Cc: Max Gurtovoy <maxg@mellanox.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cc09b81fc7f4..cb8007cce4d1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -285,6 +285,10 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
>   
>   bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>   {
> +	/* don't abort one completed request */
> +	if (blk_mq_request_completed(req))
> +		return;
> +
>   	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
>   				"Cancelling I/O %d", req->tag);

Something I probably already asked before: what prevents that 
nvme_cancel_request() is executed concurrently with the completion 
handler of the same request?

Thanks,

Bart.
