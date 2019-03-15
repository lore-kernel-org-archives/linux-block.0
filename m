Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB835C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA66820854
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K9ZdrmUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfCOQju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:39:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40456 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfCOQjs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 12:39:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so6830036pgo.7
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4mz+ylSIlqICAal8h3K0TtTG87LIv/NBo2Pti8a7xbY=;
        b=K9ZdrmUerygXPE45fwfRYoSkH4CRrsq8Hglken/WCC+11t53cCEF+PvQd9AEE1pbab
         hJVTouUWEjjZnBC9FNFol/GlbZ1t1tRDCt1h1OcggzEHFHPUz4Am42bGETSVeeyxDbuz
         D4pTH1NG/vVoU7PtU0iP1EcnE6cSYg55bxrms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4mz+ylSIlqICAal8h3K0TtTG87LIv/NBo2Pti8a7xbY=;
        b=beKp17WoaEtdBtjqbUzzovD3MNJjFR8AnnNtJBOzBXVQ8X+MJkQBLfGPeYxNa90mM4
         FrVnuNhACJuLgSRpV2Mx5A7/D0biFLJCkakTQr1RiYUqC00kVt2R45CsU+XR6V4+Kkdz
         9Z3wRJHOC/avuexVMaSRsfpDdACw09MlQfPa2XkIcupBnIUlwLPmGvLRxYyloWC/84ID
         Qf9gZf7MLEotxGjv49U9Kl48ONaBIbQfjGfrvwtT9BWjnJaDZ8HPhaCuaDz+VUvNYDZv
         J4ybEPMa8XhDbMDMvA3mWVzFag9AEQ1KfnpZuenLC/+SeLsGB7i769+/7gzZSUIhdHx/
         A6Gg==
X-Gm-Message-State: APjAAAUulQw+bbAcrzJL+VBTXN4XPxJXCIRwgJ3qEHUkJcOsVY+jLxhP
        jp7SKvzgAB8H3eIHKTSXr4b1Og==
X-Google-Smtp-Source: APXvYqyG87T92MPk3iTyToQ7yH+kTfk3cppuoe7GoRV8a+l2SfdVNk/LXC60GG198c0OcCQBelVAMQ==
X-Received: by 2002:a65:6098:: with SMTP id t24mr4328362pgu.57.1552667987632;
        Fri, 15 Mar 2019 09:39:47 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f16sm7301418pga.71.2019.03.15.09.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:39:46 -0700 (PDT)
Subject: Re: [PATCH 7/8] nvme: use blk_mq_queue_tag_busy_iter
To:     James Smart <jsmart2021@gmail.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, sagi@grimberg.me,
        josef@toxicpanda.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, keith.busch@intel.com, hare@suse.de,
        jthumshirn@suse.de, hch@lst.de, bvanassche@acm.org
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-8-git-send-email-jianchao.w.wang@oracle.com>
 <62de99e8-0d8d-910a-bfdc-649f734b152c@gmail.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <f284663c-ad13-65ea-5ce0-9b305ca91d3c@broadcom.com>
Date:   Fri, 15 Mar 2019 09:39:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <62de99e8-0d8d-910a-bfdc-649f734b152c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/15/2019 9:33 AM, James Smart wrote:
> On 3/15/2019 1:57 AM, Jianchao Wang wrote:
>> blk_mq_tagset_busy_iter is not safe that it could get stale request
>> in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here. A new helper
>> interface nvme_iterate_inflight_rqs is introduced to iterate
>> all of the ns under a ctrl.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>   drivers/nvme/host/core.c   | 12 ++++++++++++
>>   drivers/nvme/host/fc.c     | 12 ++++++------
>>   drivers/nvme/host/nvme.h   |  2 ++
>>   drivers/nvme/host/pci.c    |  5 +++--
>>   drivers/nvme/host/rdma.c   |  6 +++---
>>   drivers/nvme/host/tcp.c    |  5 +++--
>>   drivers/nvme/target/loop.c |  6 +++---
>>   7 files changed, 32 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 6a9dd68..5760fad 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3816,6 +3816,18 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_start_queues);
>>   +void nvme_iterate_inflight_rqs(struct nvme_ctrl *ctrl,
>> +        busy_iter_fn *fn, void *data)
>> +{
>> +    struct nvme_ns *ns;
>> +
>> +    down_read(&ctrl->namespaces_rwsem);
>> +    list_for_each_entry(ns, &ctrl->namespaces, list)
>> +        blk_mq_queue_tag_busy_iter(ns->queue, fn, data, true);
>> +    up_read(&ctrl->namespaces_rwsem);
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_iterate_inflight_rqs);
>
> Hmm... so this aborts ios for namespaces. How about ios that aren't 
> for a namespace but rather for the controller itself.  For example, 
> anything on the admin queue ?   Rather critical for those ios be 
> terminated as well.
NVM - didn't look at which tag set.  but it does highlight - doesn't 
cover anything issued by core/transport on the io queues.

-- james

