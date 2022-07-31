Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E13C00140
	for <linux-block@archiver.kernel.org>; Sun, 31 Jul 2022 10:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiGaKXo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 06:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiGaKXn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 06:23:43 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23DE0D7
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 03:23:40 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso4324737wms.2
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 03:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bDJBVdCs0+Lkcsh+eqsSjWB2X6vyVGxKkU/1SIgk/yg=;
        b=BI5kmBwPNwkMFLBkt22JSw2zSknJyWz9+5AlAfxFNph96/n2cTPSGncQgdu3yMqSHf
         yDPTypU8u6oprmZmpJLsJutuecEsJWGJEAZ5lTTR3o77DCyqiRTRMPWaaKWT7pPf+BEB
         gQwmHiE9YRtWH84rEkZs3H7+OwtMGWtTx/r7qz3y7FLMA/fj0s0NFsbRMY+2fRGmExpA
         L3hqF9ofKMk8uIMjw9nVynzE5+2VWyHoG0aX6dAjS/jEzpVw9792oZ7S1X/4bA4XhDMG
         3e1JNSxHeMhRnN1APMGT5xHe68OveOWxVreek3GS5w1jn3DIDP1G3VvUsGzoSE5UqXrc
         VDiQ==
X-Gm-Message-State: AJIora9KnziahOoqHMciVl2XA9U1ltv1XA6Q+KHE/ldjSClTH/ARvBls
        1HxW8BVmYNYx6H3yRugMW50=
X-Google-Smtp-Source: AGRyM1smIWdFLBeC22+ja52UBqgctV3T6np7Y5H2dchVlIkebia3ASdi3vEAq+v6Wzp4qk2wnC2/Jg==
X-Received: by 2002:a05:600c:5128:b0:3a3:2160:7a7b with SMTP id o40-20020a05600c512800b003a321607a7bmr8099305wms.204.1659263019052;
        Sun, 31 Jul 2022 03:23:39 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d51c2000000b0021badf3cb26sm10032484wrv.63.2022.07.31.03.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 03:23:38 -0700 (PDT)
Message-ID: <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
Date:   Sun, 31 Jul 2022 13:23:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@kernel.dk
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
 <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Why can't we have a per-tagset quiesce flag and just wait for the
>> one?  That also really nicely supports the problem with changes in
>> the namespace list during that time.
> Because If quiesce queues based on tagset, it is difficult to
> distinguish non-IO queues. The I/O queues process is different
> from other queues such as fabrics_q, admin_q, etc, which may cause
> confusion in the code logic.

It is primarily the connect_q where we issue io queue connect...
We should not quiesce the connect_q in nvme_stop_queues() as that
relates to only namespaces queues.

In the last attempt to do a tagset flag, we ended up having to do
something like:
--
void nvme_stop_queues(struct nvme_ctrl *ctrl)
{
	blk_mq_quiesce_tagset(ctrl->tagset);
	if (ctrl->connect_q)
		blk_mq_unquiesce_queue(ctrl->connect_q);
}
EXPORT_SYMBOL_GPL(nvme_stop_queues);
--

But maybe we can avoid that, and because we allocate
the connect_q ourselves, and fully know that it should
not be apart of the tagset quiesce, perhaps we can introduce
a new interface like:
--
static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
{
	ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
	if (IS_ERR(ctrl->connect_q))
		return PTR_ERR(ctrl->connect_q);
	return 0;
}
--

And then blk_mq_quiesce_tagset can simply look into a per request-queue
self_quiesce flag and skip as needed.
