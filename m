Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B359C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 03:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C859764DEE
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 03:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhA2DiU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 22:38:20 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51679 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhA2DiT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 22:38:19 -0500
Received: by mail-wm1-f42.google.com with SMTP id m2so5808683wmm.1
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 19:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+GUZp5hSfEjRyNkiPxvry5RPpSZTyVCM6nuEpV8Qk4s=;
        b=XFra7gwxouHdOzgvZzUjBnmwfLesKi5evVDHqLG0hWOobJ2X1OFu7aTPmS6L0Xbf5Y
         1vCBIYiTwO7mpn9vR+gXotwTILaEv/e6lRVPoMdg2taQEiU2d0cVuDdw+dXXntwyvgPU
         oEUZ4XYy2idZKDtWcUBbDZuZuaKwF+25BFt/n0JLQtYfviGogXIZCpT85PSULNrspZZi
         Q//WvpTPsYGyeSRUvwAhcray6usr3wzbTYlXRlq5FONyE8pf/KYrMHIJH1H1Xrzdcwla
         zq9I5/2W+GHYLwc+AQRuGkHYRy+6bPa3yf6JodZJdRnr83xJv3nK+uvMRfQo73gOVauw
         MMFQ==
X-Gm-Message-State: AOAM531aj9WrBdvGNdGcq0cDa98EXG/kNmKKOqgbgm4rNjGlaN0dakxf
        O9TnsMCEie0onlRf1pHCDRk=
X-Google-Smtp-Source: ABdhPJxw4gqn0vyNpaRTkc697bKa9yxgvTtEMJ35xjfd/nEAxKx5vzFDdjxhd7jsAWteXbP4IGes1g==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr1882346wmj.148.1611891458226;
        Thu, 28 Jan 2021 19:37:38 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578? ([2601:647:4802:9070:3d48:4849:d506:e578])
        by smtp.gmail.com with ESMTPSA id l11sm9461111wrt.23.2021.01.28.19.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 19:37:37 -0800 (PST)
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native
 multipath
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org,
        hch@lst.de, axboe@kernel.dk
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
 <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
 <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
 <1651456a-3251-77db-42c9-fc1a2d2c5c13@grimberg.me>
 <b5b70392-d4f7-6f0c-d337-a6023dc4b992@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a55689cc-0925-c3a3-b7bf-e155cc3d4fe9@grimberg.me>
Date:   Thu, 28 Jan 2021 19:37:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b5b70392-d4f7-6f0c-d337-a6023dc4b992@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>> index b7ce4f221d99..66b697461bd9 100644
>>> --- a/drivers/nvme/host/rdma.c
>>> +++ b/drivers/nvme/host/rdma.c
>>> @@ -2084,8 +2084,13 @@ static blk_status_t nvme_rdma_queue_rq(struct 
>>> blk_mq_hw_ctx *hctx,
>>>
>>>          err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>>>                          req->mr ? &req->reg_wr.wr : NULL);
>>> -       if (unlikely(err))
>>> +       if (unlikely(err)) {
>>> +               if (err == -EIO) {
>>> +                       nvme_complete_failed_rq(rq, 
>>> NVME_SC_HOST_PATH_ERROR);
>>
>> I was thinking about:
>> -- 
>>          err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>>                          req->mr ? &req->reg_wr.wr : NULL);
>>          if (unlikely(err)) {
>>                  if (err == -EIO) {
>>                          /*
>>                           * Fail the reuqest so upper layer can 
>> failover I/O
>>                           * if another path is available
>>                           */
>>                          req->status = NVME_SC_HOST_PATH_ERROR;
>>                          nvme_rdma_complete_rq(rq);
>>                          return BLK_STS_OK;Need to do clean. so can 
>> not directly return.

The completion path cleans up though

>>
>>                  }
>>                  goto err_unmap;
>>          }
>> -- 
>> .
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
