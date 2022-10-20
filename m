Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C04C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 06:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJTGLT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 02:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJTGLS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 02:11:18 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFA5176B84
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 23:11:11 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id a3so32560574wrt.0
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 23:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwEt8fk765yCadxOA2QUAT3mutQPxT3s1Nt0+aiBzsk=;
        b=RRoXzgv7X2pp9K8/IqR2NDAOpAMWF8/AGoMXc56cQmhtXr+xmV22gwPyYW7THd7HsN
         PEOBD5fTPckzB92Ub4ZN8ZF7ApF0RT+yfz5oIlpl7VdL5uSGj1IFq3KYtLXAEvwk1IU3
         Z0iZ0wXw4+ckjhBAGiL/9b1ttzMbj7hVfGSJiSw0jVLKorDtHZ07P238UYw+gj01MtBe
         UCIs/5ueDeLmUbjD4xdKZDLIUgS4Bx+998zQebmCBKsilKXlrUiD8jPNX6c6btqEx0H1
         /lx4J1Gr7xIWJyLm3uHDpmAwt/SVRGd7w3XLKJERm8r6CQN1LgPulD1Orb9bxo+Hvjg0
         ERYg==
X-Gm-Message-State: ACrzQf0JEPQxyraxOeHpRNsWYOsIBHLZkvJvJi4OpJ6w2S7fYMIO50Cg
        9poF3XtkxOSKCnCP4gwvk8iii/Wy89w=
X-Google-Smtp-Source: AMsMyM4p3vnlvE9kiAcKZNaixcRib/7SSZ3+QL5Vcm68SlFhrqmMcVepSOKWjBwzQbhsCido5VqoWw==
X-Received: by 2002:adf:fb43:0:b0:22b:64:8414 with SMTP id c3-20020adffb43000000b0022b00648414mr7436837wrs.70.1666246269453;
        Wed, 19 Oct 2022 23:11:09 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c3b0e00b003b4fe03c881sm1800757wms.48.2022.10.19.23.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 23:11:08 -0700 (PDT)
Message-ID: <13088882-2d1b-ca71-8420-84bb47760cff@grimberg.me>
Date:   Thu, 20 Oct 2022 09:11:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/2] nvme: use blk_mq_[un]quiesce_tagset
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
        ming.lei@redhat.com, paulmck@kernel.org
References: <20221020035348.10163-1-lengchao@huawei.com>
 <20221020035348.10163-3-lengchao@huawei.com>
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020035348.10163-3-lengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/20/22 06:53, Chao Leng wrote:
> All controller namespaces share the same tagset, so we can use this
> interface which does the optimal operation for parallel quiesce based on
> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
> 
> nvme connect_q should not be quiesced when quiesce tagset, so set the
> QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.
> 
> Currntely we use NVME_NS_STOPPED to ensure pairing quiescing and
> unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
> invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
> In addition, we never really quiesce a single namespace. It is a better
> choice to move the flag from ns to ctrl.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/core.c | 57 +++++++++++++++++++-----------------------------
>   drivers/nvme/host/nvme.h |  3 ++-
>   2 files changed, 25 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c1..c7727d1f228e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4890,6 +4890,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   			ret = PTR_ERR(ctrl->connect_q);
>   			goto out_free_tag_set;
>   		}
> +		blk_queue_flag_set(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, ctrl->connect_q);
>   	}
>   
>   	ctrl->tagset = set;
> @@ -5013,6 +5014,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
>   	mutex_init(&ctrl->scan_lock);
> +	mutex_init(&ctrl->queue_state_lock);

Why is this lock needed?
